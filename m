Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE50ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ABA2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZtJSqZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46ABA2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeINUDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:03:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35054 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeINUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:03:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so4427379pfh.2;
        Fri, 14 Sep 2018 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NI+/aJLNom/klB1tCbRWpxMCYv6b+Cx5vh8nuBun7po=;
        b=ZZtJSqZnR40cv31yF8f14bZaFqEzqZq6fcK2k83rK3AdI9aNdoZal4/y7xQVx9cS7r
         k/D66DUfo4VyYxBAwaprCpQV2uwHbI1R1n8Qi+73ge6K0eZd5x72oGXNBClkZHX1bpA2
         qAnvJxGQyM2o2Lwp/+wXbMG0WylUMm2fEsXhSqSv3x0PO59bafVTygZx4gi5tve4meHB
         Hknn2wHFfgOMhCJZP4gEnRPZpCq2Qy6vcGvOodbxcRfQDMbY9FtHM6UrLeO0kb/eE7c5
         3tKxRoHA1Mu8PMaxBznZWg47wxnHzPJHSKGRNwY/1vJVHnQzOfoFA4NFroILVxl+JXGk
         yVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NI+/aJLNom/klB1tCbRWpxMCYv6b+Cx5vh8nuBun7po=;
        b=trGmbMy30nqn9bU7J2MCW6bYuqIwrRVzdK1RHf0kCjadGcCP74cGfZH7qluzSvfNeq
         IaXrHrGTQy6RebyL0lYXre8LPCGErAf75+zq7vgsKEd0wKymmrLaMNCwI3ZJSTsbHqNh
         6Z7M2MmWs7KNJwKIj1ULX5hFxDJaqiRy4vF3dfmti6QuGrdNw5U6cfTj4Lf1LFUp3prI
         TPb5UcsakhpE4Q4NToKLCcceRSibhsXk2AuLXuCJpw38SZfeC+yrfW/f/oI0xxG+jEPs
         TtKCzNzDkCUTQ8lfjHDJ5pRykceU04w1BLCW46F4fV+cimel5JXvZgG9vRyXJuCwL5s+
         uNwQ==
X-Gm-Message-State: APzg51Ddl/RY0mfasOcfFHbVA4xBxbP5ZDfd5TfiBftYpFsvbkWvevbS
        4/g0jTjIzslq7i3Xyach/qxIYDgE
X-Google-Smtp-Source: ANB0VdY8ALAkMCTNkJXNttAveNKVVr+zkCrpxMzAVO0Y4prtQm6O0Ki9cMEd0ujtbZ831+1s3juWdg==
X-Received: by 2002:a63:455d:: with SMTP id u29-v6mr12077101pgk.342.1536936530812;
        Fri, 14 Sep 2018 07:48:50 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d132-v6sm12821887pgc.93.2018.09.14.07.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:48:49 -0700 (PDT)
Date:   Fri, 14 Sep 2018 07:48:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/197] 4.18.8-stable review
Message-ID: <20180914144848.GA19364@roeck-us.net>
References: <20180913131841.568116777@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:29:09PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.8 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 15 13:17:57 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 221 pass: 221 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
