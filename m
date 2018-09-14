Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D9CECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3F620861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUIqF+ED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3F620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeINUJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:09:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45584 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeINUJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:09:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id x26-v6so4508131pge.12;
        Fri, 14 Sep 2018 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e5TtNz+ET8auSeJtlbR47dASBvkLEywO5G8/YI8T3ws=;
        b=KUIqF+EDaoJLjP6RJ+JJq1NtrxmTMMQfooN2GktiOPw9LEI6pEY/LVndUMyarixKYz
         v/Ksa/PBJWtJd3PK09YocsleU0er8bpfZtFflSRBJQzJ1NW+Pcj+9Lw1LGMZejzIKQTM
         b6zjHRBpl6Hmi8sJQoK02pilV4kA3VuYj6u/6cwsXUPSSuWeUdB3N2A1o4VJgRlM/A9/
         pZhGzVF04K+irvTvU+8q/tinOtMalJCsHRIv7PiXhtkI4OCvKFZVSf9ZU9NAcykyo2EQ
         LzbEz2LKBHI/q48oWnG26G6A7G+q7sBL7EFkRGei8XK6+TVTvKBEUaHlDPOcapfrP+zh
         FXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=e5TtNz+ET8auSeJtlbR47dASBvkLEywO5G8/YI8T3ws=;
        b=NUfK64nAHxl/DaPuu5f3bizivlakanhBYvIdPdqPkh/3bmQvCrXhj/A+5ceUj9Knch
         RbdNmoywjaMI0xs1rgSSyWiMnhsih4hQVzuMtPv6R880ANtHERW3Acy1aS2YBXHIf7pV
         qGJJ8EPHXbMrKa1+Zi1a1yq69i6lighLo+TWeAcYYtPA4jOxmHFQaMNoBKZYz+HRqsUI
         Ykeq7+/VxF4Xy2zgTFKsv5m8Uebz64t9NYDM3Xm+rAEAutyAayKQM93sCPROotI2iYGA
         17aOL8ynXALrbv6D1Wi5a07NXPoO5nJkv+AiRnphSoCTWWTvI3dytma8QNHACP8Qlj74
         ShOQ==
X-Gm-Message-State: APzg51AUcMhPgBSEC2r7no/EkotmxlXD4A2wyg0Skb/6sEA/cEpmBXRa
        KeH6KmZfPpUz4jr7scMRdtxXSl7N
X-Google-Smtp-Source: ANB0VdYYUhhReH40u2kxLZpOsdHsX5UI2l8qoIeM2ZG4tgnF5yrcvovSJcShVlypGiVLuUSIEu96HQ==
X-Received: by 2002:a63:115f:: with SMTP id 31-v6mr12297825pgr.53.1536936858308;
        Fri, 14 Sep 2018 07:54:18 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r12-v6sm12858222pfh.79.2018.09.14.07.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:54:17 -0700 (PDT)
Date:   Fri, 14 Sep 2018 07:54:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/115] 4.14.70-stable review
Message-ID: <20180914145416.GB19599@roeck-us.net>
References: <20180913131823.327472833@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:30:20PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.70 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 15 13:17:48 UTC 2018.
> Anything received after that time might be too late.
> 
Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 315 pass: 315 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
