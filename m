Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4460CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DD02080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qhz2KClP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DD02080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeKAHse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:48:34 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34653 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeKAHsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:48:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id n26-v6so12930147lfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 15:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XXaehmS/sRCuVAge6bpnZfBDStBs4RzT/GW10eLQBA=;
        b=Qhz2KClPXopDWXWizn0vqi80t2NRzcl/YtdlKzLTLa3BjPt2x/ewL6hTDgvgPG+IRX
         ryEMaCfyHr8It8V1HuGo9IPYpQRkRIiDf30P5veIJQ3MdKHKD+b5hnzCurBfe6q62qqP
         2zS8jg0DbaSksoRGNf+Ba4esHS0mBr4es1zoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XXaehmS/sRCuVAge6bpnZfBDStBs4RzT/GW10eLQBA=;
        b=Y83/4tDet2+6S7ihBDF3mbNG0vyAsaVbXJldlPeviyKgIFcsCZD1itku+oLdxxx29a
         y91tbpW9rLpvXxWRxyt+I2dnzAeCeOnjKhMmBUhd1MA7C4dh0NeSfoP8SM6GosTtI1od
         x5MSKV/AeXTrsZ9DGWXyjU8xJ8oABJfEaDQZoIjXPZHiltk8+zPI1z43/JN/MBfF35gH
         m0Z/JNQSj3W4IrGB1duxiyEjQXHEJbfHQSn0DJu8Zoo6QKspDQMTUQUkBB3D6tbJcmBJ
         QbMClOM+Ydnt7O+obOOElvNR9OdVDU+xiJLX9G6VRzT0T2nJemLd3htSC7XB1jysHah6
         0gLQ==
X-Gm-Message-State: AGRZ1gJrqKmS7XMK+PoZIwljFM/j3zT+sJWQrh6LkRn0D/LiLHLJTjk6
        jItlGsaJLI7Sr/YBZ4E37wnGvIBCtm+AvQ==
X-Google-Smtp-Source: AJdET5dqzucjU0GHyW03DxAxCil5TnE7ztAwcQMTigTLa+Se4iV+kobakLnWQxL0TPOHgrdRRfBnjA==
X-Received: by 2002:a19:aace:: with SMTP id t197mr2964036lfe.7.1541026105425;
        Wed, 31 Oct 2018 15:48:25 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id y16-v6sm444755ljd.3.2018.10.31.15.48.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 15:48:24 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id c4-v6so16376815lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 15:48:24 -0700 (PDT)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr3561802ljj.6.1541026103700;
 Wed, 31 Oct 2018 15:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <1829585.6m1bt7BjAO@blindfold>
In-Reply-To: <1829585.6m1bt7BjAO@blindfold>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 15:48:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjw8qra+SYDDjvSnZ=APsn9aFG9WiJGSLD94A0Q_+BZWg@mail.gmail.com>
Message-ID: <CAHk-=wjw8qra+SYDDjvSnZ=APsn9aFG9WiJGSLD94A0Q_+BZWg@mail.gmail.com>
Subject: Re: [GIT PULL] UML changes for 4.20-rc1
To:     richard@nod.at
Cc:     linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 2:22 PM Richard Weinberger <richard@nod.at> wrote:
>
> - Removal of old and dead code
> - A bug fix for our tty driver
> - Other minor cleanups across the code base

Pulled. I may not like recent rebases, but I do like this:

>  11 files changed, 19 insertions(+), 456 deletions(-)
>  delete mode 100644 arch/um/include/shared/aio.h
>  delete mode 100644 arch/um/os-Linux/aio.c

Thanks,

                Linus
