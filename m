Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDABC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D587D2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeNsbqJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D587D2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbeKMLxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:53:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38489 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMLxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:53:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id v76-v6so2376153pfa.5;
        Mon, 12 Nov 2018 17:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qb73POOrgaB5UhySf5s6xuPHbNlZZvvCBcBNTBUwKDI=;
        b=WeNsbqJwIJYkKDJPK1+1OORgDxQKmY1e64SCiCUN78emZACxYqJ+LvDWUmZj+I3ldO
         0oarU4GyhvNgkKWKUe3v+Nf+az+OcdkMcMfe0zbSNX8sTxbJ6i1b8dBx++nWc86roSx8
         W8SMcxiFpMh25CSh9TXS2gBif/Rn8HHa5JetgTtLUVASJAA5NzD/NH3tEzeMfuDeMmKN
         cr/lNHjDon5+5SP/1K1TpV/1f940mWh80N/JTpgDE/Qzm9Jj5pJujemSot45XYIY1mym
         TvZ8z0vHFKXO5fpO68UC1dk44raMxqPTMzRDRsibYKVmkQwU37fedIsaKFIbNNwjLW+F
         N2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qb73POOrgaB5UhySf5s6xuPHbNlZZvvCBcBNTBUwKDI=;
        b=KMCIlagDfI4h7dmiC417EqIMmw8elJi+KIciWOQp0VEiUPDq7meEEf2i9sCOx13SV0
         QdUPr1qd2WEoc0fPtcQiWp5GNCUl1KbWl1NWl2HrmnSD80OIe8DvaSJK2nL/R+Ek0BUR
         Z1gWE05bE0mQUCpnRKIphddyrATVlz0d1gpNlxUPMqGM5hjGZuMRVVmMQe3ol5MKt12P
         sr9Tbx432mclzRcm1s412pCVFUFpwNh3eokkbjMgfjmeecSIRlZ1DWp5NwbC7DUfKqKs
         F+xm1/gFRAmjcUPLQcXsRgee2gKA5ERx3LrVWDYkLdP+SJkx3DMFSNucvseBjFfMW1Hf
         8y5Q==
X-Gm-Message-State: AGRZ1gL64ubV93QZ888+d48gkB6wh9DL9cgCDB+V7HWqX2/nqEYDhcAp
        mkOBBf7s9oiOFvfkAIlN6uv3xdUwqH0=
X-Google-Smtp-Source: AJdET5fcuZrD1nEDq0HmPqUkzyqTCByUdLAiUWCdq86yVUYMtY7FIrEOudl3rPYN5MHmbxA9yQITRw==
X-Received: by 2002:a62:c20b:: with SMTP id l11-v6mr3260826pfg.251.1542074229451;
        Mon, 12 Nov 2018 17:57:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 79sm17571967pge.66.2018.11.12.17.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 17:57:08 -0800 (PST)
Date:   Mon, 12 Nov 2018 17:57:07 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3.16 000/366] 3.16.61-rc1 review
Message-ID: <20181113015707.GA5984@roeck-us.net>
References: <lsq.1541965744.387173642@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 07:49:04PM +0000, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.61 release.
> There are 366 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Nov 16 18:00:00 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 140 pass: 139 fail: 1
Failed builds: 
	i386:tools/perf
Qemu test results:
	total: 217 pass: 217 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
