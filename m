Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60281C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EF120839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 04:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="P0AB4NLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EF120839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeILJ7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 05:59:32 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50687 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeILJ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 05:59:32 -0400
Received: by mail-it0-f68.google.com with SMTP id j81-v6so1351535ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 21:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fy/z3tEAqrDFNU7LEqwYFvyvZ96032VgcxuU3wXugJY=;
        b=P0AB4NLslTMrHQu+uo1ceSoq7zTaiYa9KYi1aMBlKD6xJVCCbeffnPbKrjkgD9Xb0d
         xNL0yQkAxxJ3YyuzSjg1TzJNOi7qFdgMqcXjsn4JfeiedAHf2PYxqZ5mXQndHWRTaCzL
         HnsKnc+iebmWd0HzHo1sUOsqMR12uk07PYKxTZKv8xT2qIojIyWCRoRLMg33G0YiFca6
         63x+AqOV7ff3EZJiQqbWV0LIu+0gsk+yuYk9PAAp8Z0V+j7BraqPfJyUubyyW0qrKr55
         VJwyyuucb4tmRPYbmq6PnfeGhobJFvliDXAEO1unDwMMYAyltBGoabKM7mRhB5PP+Oa7
         brqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fy/z3tEAqrDFNU7LEqwYFvyvZ96032VgcxuU3wXugJY=;
        b=DFhlcAEzNqKSGRsl8oI8EHWI/dp0KgCAZ15SZMOshcFXtLwW1r0OyOrzgZ6E3mnEnR
         3kzWsEu8XXWE0OrSoo86beUQ7/w8JYt6p/WZNygTjXxOm/EBv/3HklgCVvh5y87Xly0T
         7u9EYW0HKBuRIb7o0WMIwTMCdlISRH1sLSGcKrAXD4rGv5WQqoiRH+pGjVpUazU2LNhc
         GtcZhApKGPKj3uTzkHItQCr1Pou0ztp0FkMMa/1tSo9/ybjVDlfhFAms7AJRQinS5jlA
         HTIYCfyNDM5VHMMLpbmPp453j+YcvC6hKw2oztDGWGkBwSMA8j2zhD2leFO0m89ITLJn
         EhEw==
X-Gm-Message-State: APzg51DfgJusXwdR4DuNBtJ7LcGq9WEYq236BB4K43lbTYL/nvG1E1l6
        ITWgSnKXFLf/vOL4D0Oh4WOouJXKFZp0tQLYdRhw9g==
X-Google-Smtp-Source: ANB0VdaFwnPVIHevXwf84Dcjbtqfo1fAkY9IdGTyLUWBpDNp2KrSv2OXEcgTlkLki8IgyeI/oNJjMlHBfM2MZ73T7Po=
X-Received: by 2002:a24:75d0:: with SMTP id y199-v6mr400935itc.4.1536728209103;
 Tue, 11 Sep 2018 21:56:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:1505:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 21:56:08
 -0700 (PDT)
In-Reply-To: <5D685053-1A33-4553-8678-A50C542466FD@canonical.com>
References: <5D685053-1A33-4553-8678-A50C542466FD@canonical.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Wed, 12 Sep 2018 12:56:08 +0800
Message-ID: <CAPpJ_ecuPysq2SE7=X7ip-3M=4yOcwuu6m_2292WgYA8j6gqjw@mail.gmail.com>
Subject: Re: Regression caused by commit 7bb05b85bc2d ("r8169: don't use MSI-X
 on RTL8106e")
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-12 11:42 GMT+08:00 Kai-Heng Feng <kai.heng.feng@canonical.com>:
> Hi Jian-Hong,
>
> There's a Dell machine with RTL8106e stops to work after S3 since the commit
> introduced.
> So I am wondering if it's possible to revert the commit and use
> DMI/subsystem id based quirk table?
>
> It's because of commit bc976233a872 ("genirq/msi, x86/vector: Prevent
> reservation mode for non maskable MSI") cleared the reservation mode, and I
> can see this after S3:
>
> [   94.872838] do_IRQ: 3.33 No irq handler for vector
>
> If the device uses MSI-X instead of MSI, the issue doesn't happen because of
> reservation mode.

Interesting!  Opposite symptom!
Could you help try the patch
https://marc.info/?l=linux-pci&m=153629858601668&w=4 with and without
reverting the commit?

If the patch does not work, another suggestion: You can try falling
back to only PCI_IRQ_LEGACY.

Regards,
Jian-Hong Pan

>
> Hi Thomas,
>
> Is it something should be handled by x86 BIOS? Because I don't see this
> issue when I use Suspend-to-Idle, which doesn't use BIOS to do suspend.
>
> Kai-Heng
>
