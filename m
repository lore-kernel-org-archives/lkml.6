Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1900C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA0A206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JjbBsR1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA0A206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeJXO21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 10:28:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46070 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeJXO21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 10:28:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so3566535ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 23:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkDD3i4pQa+e6YmVHIxaVY7vyZqRvpToKAX9kgnqL0w=;
        b=JjbBsR1phA3Qyug+tVTXSMu4LWcXeGcNsCmCyT/WI7jGHldlEqodly/QyBeFQe63EP
         2JZVa3QCDgTHxgal1HhHm4r6UB/ejrHLeT0kUlzIjK3PVZFDJqf2qax8NiEnYlnWcBJe
         Mf4Jib3FU1atkKMSu2v2/FtH1FaZqQLogB1uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkDD3i4pQa+e6YmVHIxaVY7vyZqRvpToKAX9kgnqL0w=;
        b=nYinR6UeTjQQHWiLyWSGig7ONta+tkckKz5KrOrgi8JY+G/et6cEJM4g9OuIUSX56f
         GnobeICKTic8QBKF5jX4k/mi40TDVAD0OSyp+z2MxCsOIJUQuLeOXwtL3a4yBCVV2tLV
         2biN0zyfgPFigAkt19iL7VMu1+Sl2xjYVn86a78yStG6wHsv0bKhg+wkcavHS0CkncmR
         p3is5E6G2FzbTHj+mOZebHIoRsXc52Ku2j1KPxsQki1ZfBqcC4I/UbXiEdFy31lppGXl
         ZYpd7eTOQx6I4ueIoU6zA92s7FgZrgd0A2Iu+4rhO7j4i9Ohqad6CdLxMUydbqDCelBZ
         h7yA==
X-Gm-Message-State: AGRZ1gIhuhwEVuGMnpoUl+KQmRhcEPcUSEEr//79TNSqXXEiFNt0VXhz
        ZXUGNX/TfJU0wM4058UyaHZKYVwV9ivEcP8f
X-Google-Smtp-Source: AJdET5dOqnrg4Y+g6/1/YYly1v0JpPA3rD7Q92VtJRjLgcFiAwOR/vW/6/wgI3OKlkfsOW1wg9v5TA==
X-Received: by 2002:a2e:5819:: with SMTP id m25-v6mr678490ljb.177.1540360909082;
        Tue, 23 Oct 2018 23:01:49 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 18-v6sm482382ljo.74.2018.10.23.23.01.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 23:01:48 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id d7-v6so3010388lfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 23:01:48 -0700 (PDT)
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr14743259lfc.147.1540360907606;
 Tue, 23 Oct 2018 23:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181023.202921.1185045750138652543.davem@davemloft.net>
In-Reply-To: <20181023.202921.1185045750138652543.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 07:01:31 +0100
X-Gmail-Original-Message-ID: <CAHk-=whuhCGujWKO8JObGQaSdWOpJBXdkM-B-vD80QZifveScw@mail.gmail.com>
Message-ID: <CAHk-=whuhCGujWKO8JObGQaSdWOpJBXdkM-B-vD80QZifveScw@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     davem@davemloft.net
Cc:     Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 4:30 AM David Miller <davem@davemloft.net> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

Hmm. Tentatively pulled, but there's something wrong with the Kconfig rules.

Doing "make allmodconfig" (not even the build itself, just the config
phase), I get

  WARNING: unmet direct dependencies detected for QCOM_QMI_HELPERS
    Depends on [n]: ARCH_QCOM && NET [=y]
    Selected by [m]:
    - ATH10K_SNOC [=m] && NETDEVICES [=y] && WLAN [=y] &&
WLAN_VENDOR_ATH [=y] && ATH10K [=m] && (ARCH_QCOM || COMPILE_TEST
[=y])

because I'm obviously not building on ARCH_QCOM.

I suspect that QCOM_QMI_HELPERS needs to have

        depends on (ARCH_QCOM || COMPILE_TEST) && NET

or similar. I'll see if this builds for me at all despite the Kconfig warning.

                     Linus
