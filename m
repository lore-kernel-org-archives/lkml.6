Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE975C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10AA21A39
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV9a+g8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10AA21A39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeHQUWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:22:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40360 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeHQUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:22:12 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so15215184oie.7;
        Fri, 17 Aug 2018 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D6EWdwzkWZh9H8Cxjgaw/oum9PgAlhqZ1tiNy5a16E0=;
        b=QV9a+g8g27YsbU5HiZn2kMHAGu2cBRgkFSOZdSJEQmdFbW8fWSrna5dRk3/JqvdBJb
         fTUyVsZKqzH9YO4gIPubXlcY/8tKIN1uyfLkO/34Dh4lItzsCYtcDUQHL10fzMaJfGtF
         gh9TVIcKNI3KKeUm0IK9iOYywXYga5reQR2A0K+PAuOvLfs//l1gyGwF8vGjtlCfOBge
         q2q6PFb7UzfmOZlyWs7BUn9/QuefKuoVVyNPGUibfOO6jSpy93Rx9XG6fLJPP3nxFNTZ
         FeP/gpnrptaRtgqernmzssP1Iv/cFaV+TIEYDs3YA0noTQN4LY/7MbtlKuKDWuRiJ0/s
         nz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D6EWdwzkWZh9H8Cxjgaw/oum9PgAlhqZ1tiNy5a16E0=;
        b=mI9Y8yJpEb8zTM5tbfMiiDPFh0Of83YGZ54aseeQeZ4ZaYnoLd3w1jrvv4PMobkcTA
         /n6sDe9Qd2y2aS8CIGOpqK5UBwZQeyLrXGNoV+mq0TMwnH4AEm3D9RaEqspvNn1QdQ5w
         kWyl4wMKYzq2ruzGkvCx3xMCVOF+iSk4KYBTsJA7Kp18GDlIPCsSzc5Vk8CusgY7TgKJ
         exqvVGYvIHXmfIUGspQRbY2kSxI7f7yJCVFKGsqqb27sIFht65YO6IcyKZ7HR+0VxYd2
         /XPbKTnyEkeq1yXzSPPc0vw4l07fLm6/vqIF/F+yT3UUGUMFM+N9Si74MgIlGf/fm1rR
         ocDw==
X-Gm-Message-State: AOUpUlGu9oXarJB8i37PnIhe/zczqzl6TUZzU+De/E8e29DQuvvYTwsN
        leSH6D0zdTFmpuJvwVHMpm/ZMt+l
X-Google-Smtp-Source: AA+uWPwDI6pkjip31kfuijSeSVKUulMhSOH7F17rOHRb8TTuzEN1sAGbWsIgpolx+ZkLVtLhziIa7w==
X-Received: by 2002:aca:5545:: with SMTP id j66-v6mr3180249oib.291.1534526280050;
        Fri, 17 Aug 2018 10:18:00 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o206-v6sm2539635oif.7.2018.08.17.10.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 10:17:59 -0700 (PDT)
Date:   Fri, 17 Aug 2018 10:17:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/22] 4.14.64-stable review
Message-ID: <20180817171758.GD11442@roeck-us.net>
References: <20180816171622.831964729@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816171622.831964729@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 08:45:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.64 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 18 17:16:07 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 299 pass: 299 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
