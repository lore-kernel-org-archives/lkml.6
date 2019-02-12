Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DACC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10780222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TCDbjJmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbfBLUy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:54:56 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43161 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732127AbfBLUyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:54:52 -0500
Received: by mail-vs1-f65.google.com with SMTP id x1so37851vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1nrYSRbB45H+369z6vZFSrjEaahox2ezp5NLLs2OLo=;
        b=TCDbjJmQ8hAwvc2HdCsNp1Sbucf0DGWb9lkWwY4lAE6HzcSID3GYhQ/UHIcMJGSQAy
         FJdIJTu/ZHbaagFYDwLf17rPnt973KCFAK6IBcSi8DEwviToTYK2kXkNu2B9dO/qhAcC
         GpeHUaUUdUyxXocmUKfKgN85vLfxkaqYLBJ7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1nrYSRbB45H+369z6vZFSrjEaahox2ezp5NLLs2OLo=;
        b=XjDBsAKAoFl9yhgU4vxdVKreJOVqFKJn9dFM0ooF4MLasArDZLTXnbOk7xoe+fIUnu
         GtMkpLWvIQRv3waxTHwmM9Ssht0h1mMu24dPL2kkwKy8/BVAw+ipVr9H2jRcDdoNBtjC
         m3DW/cQWjvxcxzGqPndqMoUohp4s6YrP1FRMhM4+/pmxnhRwtDB41GGted77aETpBEqD
         m71s6nH3HWd/sreWAOyctFk78pybYZteun7U7A0ppQqeHBaAe3jyAY7n455+cRUFtARR
         JFX7Vkr50vaXkApM2uR7zK6453xgON8guTmoqJTpRbhmeyW2UxPMmSSNqQM5lD3D+qzX
         uGgA==
X-Gm-Message-State: AHQUAuY7Q7RGQR0mWdZPHn65mbnR2NmVG8Md1auQctHyH5PB5CY0jSS7
        07AeJ2n1fPsGmTkQ/+WKhNGgwTk8fLg=
X-Google-Smtp-Source: AHgI3IaqsZXJJHukjioxd14+vZKQZUPSRiTT+cVXpGUMUPRVjymSuGgObnVOdT4gtsuRPxUtvdr1Nw==
X-Received: by 2002:a67:f756:: with SMTP id w22mr2446659vso.30.1550004890655;
        Tue, 12 Feb 2019 12:54:50 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 30sm11330329uag.18.2019.02.12.12.54.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 12:54:48 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id z18so49075vso.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:54:47 -0800 (PST)
X-Received: by 2002:a67:848a:: with SMTP id g132mr2350886vsd.222.1550004886900;
 Tue, 12 Feb 2019 12:54:46 -0800 (PST)
MIME-Version: 1.0
References: <1548245116-6360-1-git-send-email-liaoweixiong@allwinnertech.com>
In-Reply-To: <1548245116-6360-1-git-send-email-liaoweixiong@allwinnertech.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Feb 2019 12:54:35 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLE8dr4+G6fFmwcbm8YAs=RB+OiupyPCX6COhVu6av__w@mail.gmail.com>
Message-ID: <CAGXu5jLE8dr4+G6fFmwcbm8YAs=RB+OiupyPCX6COhVu6av__w@mail.gmail.com>
Subject: Re: [RFC v7 0/5] pstore/block: new support logger for block devices
To:     liaoweixiong <liaoweixiong@allwinnertech.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 4:06 AM liaoweixiong
<liaoweixiong@allwinnertech.com> wrote:
>
> Why should we need pstore_block?
> 1. Most embedded intelligent equipment have no persistent ram, which
> increases costs. We perfer to cheaper solutions, like block devices.
> In fast, there is already a sample for block device logger in driver
> MTD (drivers/mtd/mtdoops.c).
> 2. Do not any equipment have battery, which means that it lost all data
> on general ram if power failure. Pstore has little to do for these
> equipments.
>
> [PATCH v7]
> On patch 1:
> 1. Fix line over 80 characters.
> On patch 2:
> 1. Insert a separate patch for DT bindings.

This is looking good. Can you address the DT bindings review concerns,
and send a v8?

Thanks!

-- 
Kees Cook
