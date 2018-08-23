Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7EBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5538320684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faH7u+SU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5538320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeHWXmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:42:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44583 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeHWXmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:42:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so3362332pff.11;
        Thu, 23 Aug 2018 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ClxgKb9qZDN9k63pkskcDYCLXViWuOle6RjpgEZ38Yw=;
        b=faH7u+SUI6yM74vNKq5nLJfm75Ahl17qg2fTJyxuF8KQbxxtCt3YpCG/ptRKXxnOxO
         mdtT4WxHUajsoBi804F+xDa/0dKNT2gRfLb3lwVGFU1YcAL6iCymEhMSzxrBNwAVDXvG
         uRPlXMUt9eIbm1nw72FwNVsXzr9USjCyoFB2cab0QQKGf7n/fa6QEfzLgVcOk/+LrY+D
         B89nFbCGQ2Er96x9xzmOug6z2PBj6YYUUTMxgtY6Rkm23VJvf2+LjewqZY/mX4zUuKwW
         9tugUaPiDAnYcBIwR4XA1qNaPf1GrY9+HOqHkFwoe5aZwZGHpSPSizNy2zcC/NfFFraG
         L/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ClxgKb9qZDN9k63pkskcDYCLXViWuOle6RjpgEZ38Yw=;
        b=FcL2hUpNNIMMl8aphDesKdV6k+CDbFMsn8Jr7e8XH9Y9iRQ7pGiVaVlhl44RpvFWdx
         EV6HIAOIzjYuiLRRk7oZrrNVSALHRExiDzr/ANGpAXoVBqtf8LlzntMd2l8PNwH5mae0
         nJRDChVgeKlR/5jRAOydLDbJO6CPwTPOYvxIuqy9Mt0u58WNGuKQrP+cnXR64FFzBLh4
         rdRA4MJd1vyIUi3m8OnxXejCzseRbQeHnbEk4QRBaQGtBtGag0nUTWZZpFZcSV/nIBiM
         GZeshZhMCM0/czwt+WNN20qkXxZp40/oTBgtQ98b9Kr3VqpR+xsbZx+bPf0Tw4FRFOOZ
         kBCA==
X-Gm-Message-State: AOUpUlEy2OfLokx61etWhMswc9SzZW2BLp3jy8xMxNfR7WP3/0NsK5BW
        OkBi1dcod0PhR6WXtdWMC7s=
X-Google-Smtp-Source: AA+uWPwhfQj8ylRuFPaASqNjkYYDgiyFOji5t/rRYLh8RqzA69em6bVWZduFa7tQ+bG0UYiyX2GtFA==
X-Received: by 2002:a62:1815:: with SMTP id 21-v6mr63996335pfy.227.1535055096575;
        Thu, 23 Aug 2018 13:11:36 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id l70-v6sm2216528pge.36.2018.08.23.13.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:11:36 -0700 (PDT)
Date:   Thu, 23 Aug 2018 13:11:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/217] 4.14.67-stable review
Message-ID: <20180823201135.GD9368@roeck-us.net>
References: <20180823075505.090246914@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 09:51:53AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.67 release.
> There are 217 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 25 07:54:25 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 299 pass: 299 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
