Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A92C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE025246D6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mApbgdU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE025246D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeGDCrU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:47:20 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33206 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932254AbeGDCrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:47:19 -0400
Received: by mail-it0-f67.google.com with SMTP id y124-v6so5396153itc.0;
        Tue, 03 Jul 2018 19:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njyHRkvOy51Uw+qrFrTAKxpVpQSvYAYH3v7BtZ2BbxE=;
        b=mApbgdU3xNikKZBH67H21EfVGahxL56udFDUoz4eo+iCm7aJZ54tUYcP+KYRp29OT4
         Qaahpabz/HfxR5nZ5RE78LV7oT0zyR0sQfcfG1ZlvIwgsUwNwClG/PHqaMF1axR7tBo7
         S+g6bMKVLCNCQ5uiTq70+n/4Ch8PT2mdwC/bM7gQJATQ474LfBAkqsvmJ6mxBrEeVQVf
         WzuS+PLyv5uiTrkcVHFP5wxTmrjo2xjV4/Xc4Ecv89sgfOU0JXVqD2fIuSlyi34S8lFA
         5tJkLHXjhnTLy8i7OpODSQGwe4Zbvf7v2LQwV4DyzaOcnwW0eNhb08hy9XN3nApyZWCP
         yOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njyHRkvOy51Uw+qrFrTAKxpVpQSvYAYH3v7BtZ2BbxE=;
        b=jWZ7CAesGlpka30Lu1OF5H/LG0Uqh9MBk85JM3lC4oD0NNPDjFa0X6T2FbKKJwkYRz
         /mitEEHb8lyOSo+bTSp6Eycu8YpAMKUD2Db4lWVqh7xSEaZSXfLDe0YYK0d9B63MX/np
         IE8KLl8i48qImsbF79L/7IAGypugEdLgcg9ywl3mM9hSOabxFEm0/4qGTKEljQnUxDm8
         1sy1TMpmWOOmv319mkOdJt1VjEnREgClSA3jSDA/cwdNuXG5je444gx3OheyPhVv40/Q
         oPxKVv8G05mkZTQwbD1IGWk5Y1fB47NaeTcpDps4LGub+9r3mLTQF+QNchPeatsgTkLV
         Oirw==
X-Gm-Message-State: APt69E2yFuyOcZJ915dB10nnNZL5Y9vX7NNIcTfbFBERKP6wDi9aN/WP
        CbygQY1yf3qTIlj1U8wl9Ox9qWTUmCPa/KiOE+AI
X-Google-Smtp-Source: AAOMgpc3D3vs30tYr8f3QEcNDkzL1yL++YJaCKcazAKFgS/8MlwkZUW27RiPmvYfiRyYsi2BxFVA5HSa7XMrXrCaPL0=
X-Received: by 2002:a02:a407:: with SMTP id c7-v6mr167060jal.16.1530672438681;
 Tue, 03 Jul 2018 19:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com> <4685360.VNmeYLh0dQ@aspire.rjw.lan>
In-Reply-To: <4685360.VNmeYLh0dQ@aspire.rjw.lan>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 4 Jul 2018 10:47:07 +0800
Message-ID: <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To:     rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 10:36 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, July 3, 2018 8:50:38 AM CEST Pingfan Liu wrote:
> > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > places an assumption of supplier<-consumer order on the process of probe.
> > But it turns out to break down the parent <- child order in some scene.
> > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> > have been probed. Then comes the bridge's module, which enables extra
> > feature(such as hotplug) on this bridge.
>
> So what *exactly* does happen in that case?
>
I saw the  shpc_probe() is called on the bridge, although the probing
failed on that bare-metal. But if it success, then it will enable the
hotplug feature on the bridge.

Thanks,
Pingfan
