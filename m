Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3C6C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777B5208B6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Awv2USmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777B5208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbeGDLZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:25:19 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45356 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbeGDLZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:25:17 -0400
Received: by mail-lf0-f68.google.com with SMTP id m13-v6so4099184lfb.12;
        Wed, 04 Jul 2018 04:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IiDhYVc7Rmo412CNv+JxJNOBh+TxrAOAaZP6Wc5buJE=;
        b=Awv2USmQyShrIrpCXsSQOTr01hj3nF/ooCK/J683NU0ppxXk2TRX7iTL3Qr9eTdOvD
         mZXYjZik+h3IgJnM829m0ILNT55RY8ZlnpT2DoyrLpLFdgR4h2XbEBil6fSmblG/pMH0
         5yNBMVn/er5CUb/HgeALhoo2RXwpi/NNlsF5HH1CR0GstHirTUvaxY5YyJiV+i9RkDL7
         kPK175YVV745oYbtnFC53t1jFaai4kJsz4zZcbolF6zWq9F210UlHXSAJRH/JhT4NL8p
         zKM5wlCNBbCRFwQZjRcYSz/wASt5iPqCHIwpjrvPlvCB9sRZBR9D9urFRzrrBMRqe8Pl
         hmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IiDhYVc7Rmo412CNv+JxJNOBh+TxrAOAaZP6Wc5buJE=;
        b=PYP3PjATZ/lrcmYC8Pzo43+6oFfK+ngkeRZ5/qp0ydTI5G32GQ/9z9hJJr8P3XLFzo
         DalbH5k8b8mAd5t5TAMnmZPWhvEsqWkxAvo/NM+F4f4ulg3fUPWhrerb35tzLZCpskOM
         Cn7AJYdQpIsc+Rx9YJlCKn2d9GfdPdyZshqk4DNcCHoLyXceDh0tUg2cbZg9MgwBGyIT
         zrI2V2ivqvGIHkCSMJo9MYcC88jtUpYNmVjnxhWJMaGskViTO02ExlNGDsrFwt+wEISL
         UdDWU7BEpKS/Qli05aUTKIzJxvJgAhNbcSAoAySWgnbeZSegqutZG9/EW78vIDuzZBAo
         +OKQ==
X-Gm-Message-State: APt69E10BjkATXLKDbzgcLIi1XxuGYTzNWVGgs879I1vt2sS9YP1yxJW
        fSwSLUp4PjZqoMRPQXtAvbZinN8Q
X-Google-Smtp-Source: AAOMgpdqiqn+j3yhlDDNnDNUD8d6Aocufy8KTFqGybatHVFhh7+cmVE567RkDsfHrLO24SRreSXrOg==
X-Received: by 2002:a19:cf95:: with SMTP id f143-v6mr1284334lfg.101.1530703515348;
        Wed, 04 Jul 2018 04:25:15 -0700 (PDT)
Received: from dimapc.localnet ([109.252.91.84])
        by smtp.gmail.com with ESMTPSA id o19-v6sm759137lfk.65.2018.07.04.04.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 04:25:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v2 0/5] Initial support of Trusted Foundations on Tegra30
Date:   Wed, 04 Jul 2018 14:25:11 +0300
Message-ID: <1635370.HnqPZmo3Ue@dimapc>
In-Reply-To: <5c47ef70-b90e-6e81-39dd-fbcfad2b93e5@gmail.com>
References: <20180619110027.16935-1-digetx@gmail.com> <11534185.70fb5jbPr6@dimapc> <5c47ef70-b90e-6e81-39dd-fbcfad2b93e5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 2 July 2018 21:53:08 MSK Peter Geis wrote:
> On 07/02/2018 10:48 AM, Dmitry Osipenko wrote:
> > On Friday, 29 June 2018 22:37:02 MSK Peter Geis wrote:
> >> Good Afternoon,
> >> 
> >> I have tested these patches on the Ouya T3 device.
> >> They work great to enable the L2 cache controller, however they do not
> >> respect explicitly disabling the L2 cache controller via the kernel
> >> config nor device tree.
> >> 
> >> With CONFIG_CACHE_L2X0 disabled, but CONFIG_TRUSTED_FOUNDATIONS enabled,
> >> the L2 cache controller is silently enabled and allows all four cores to
> >> boot.
> > 
> > I don't see how cache could be enabled with CONFIG_CACHE_L2X0 disabled,
> > there is no code to do that. Could you elaborate please?
> > 
> > Secondary cores do not depend on the cache state, disabled cache shouldn't
> > prevent them to boot.
> 
> On the untouched mainline kernel running on a Trusted Foundations T3
> device, I observed the following indications:
> With the L2 cache controller enabled, all four processor cores were
> enabled, but it would immediately panic for writing to a secure register
> from insecure mode.
> With the L2 cache controller disabled, only the boot core is detected,
> but it successfully boots.
> This is the issue that I inquired originally to you about.
> 
> With your patch running on the same device, the following is observed:
> With the L2 controller enabled, all four cores are active, and the cache
> controller appears to function.
> With the L2 controller disabled, but trusted foundations enabled, the L2
> controller enabled kernel message is missing, however all four cores
> still enable.
> 

This is the correct behaviour.

> After looking through the code a little more deeply, I see you modified
> the reset handler for handling offline cores.
> I am wondering if you fixed an additional issue inadvertently.
> 

CPU will fail to boot if it tries to apply erratas via accessing the secure 
registers. I've changed the reset handler to skip erratas on T20/30 if trusted 
foundations present, see "Don't apply CPU erratas in insecure mode" patch. 
This is an intentional change.

> The reason I discovered this is I am working with kexec as a bootloader.
> On a device without trusted foundations, kexec works without issue.
> On a device with trusted foundations and your patch, I found that
> disabling the l2 cache controller and trusted foundations allow kexec to
> occur.
> I haven't tried an either/or scenario, though now you have me thinking I
> should.
> 

Secondary cores are dying in the reset handler in a case of disabled L2 + 
disabled TF. Looks like there is something wrong in regards to stopping 
secondary CPU cores / flushing CPU caches, the suspend-resume isn't working 
right now because of it and likely that kexec is suffering from the same 
issue.

> >> One must also disable CONFIG_TRUSTED_FOUNDATIONS to stop the L2 cache
> >> controller from spinning up.
> >> 
> >> Tested-by: Peter Geis <pgwipeout@gmail.com>

Thanks for testing!



