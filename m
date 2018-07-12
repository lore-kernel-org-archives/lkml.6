Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3A6C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1F42147D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svPsdcI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1F42147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbeGLNrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:47:24 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44831 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeGLNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:47:23 -0400
Received: by mail-oi0-f68.google.com with SMTP id s198-v6so55797516oih.11;
        Thu, 12 Jul 2018 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9Wy2kw3qwckxSf7P9AK+fZacIPiI/0tOxSJGqIBX3RY=;
        b=svPsdcI4z3NtAcfik7wvPtZeoPI5CMHbzNknKjMm7tHCGZI6EUrFR61i4hdFXA9AOx
         G+SLciBcGqBKQikwxeGlPeIFqDzGihXclGYQGknTuQYcBbHgGIBI+4X2cn4O/ruI/9PS
         n/H9pY6fUN8/gN8B+8RFqireJxkYUB/tbEfb7n4VRjlAaVRVqlhhZTHwk45GRSJqM3A3
         A3mR6mFsTnjousOgZiIwLGNRw+WGZwe+mSTmoC6WcL+Mt05EFw+FOJ6QkF5GXMpVTW8s
         F9edbEYfTVaYYQIiRVSDTk+cM24FBimCY0NQN1z9VjO9lRShXVY9uFoMF4FZeIA3JvCC
         ReTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9Wy2kw3qwckxSf7P9AK+fZacIPiI/0tOxSJGqIBX3RY=;
        b=tvceuE9OiizsOdNaFz7zH89mHYSi+9asmDS5sIQLX904eJFl4/aYnEH0qP0HABCi4G
         +YXdBnjmNBlLacGIlj8GDndtd1q+VG/vqwD/TisDrdGJ8mSC/c7ZoYwGLn+yXz3Jb3g4
         UdtaNkttYXV7plUm2Jj9ueGRvHKxVn93Uzthl+67jw0L+JG/2fx2vmobDBkFQ/M+WoEY
         rfVQ0ZSN2fZlb3+vVbloh9eSKFy+UeWD+3sQq9Q13ZG0Mu183UvvxPXDAzrlixc0CA22
         3IQy9CVE8zbDaXoZ6FjfdesG7eu2zQOrugA8HeBho/yBDZT/na+8/yv7hGry0wb1XTkW
         pikQ==
X-Gm-Message-State: AOUpUlH9SwqA7UsurEOGxBTobxZN1refUTS0P8mm4jrgCMpDv9sfxm6p
        WP6OwETcpyuD0Iv7WgZIaqUttbPsJ0Jy1x3y1ss=
X-Google-Smtp-Source: AAOMgpfoKVEQlXPwW62jhA+FdBAQi2GMcKvVP6xa5T8Yqy0rvG4JmnQWvWc/Q5Ozyinv7JCjMglZMI3ADbGBayFgC58=
X-Received: by 2002:aca:b3c5:: with SMTP id c188-v6mr2540687oif.9.1531402667622;
 Thu, 12 Jul 2018 06:37:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 06:37:47
 -0700 (PDT)
In-Reply-To: <20180712023337.30112-2-andrew.smirnov@gmail.com>
References: <20180712023337.30112-1-andrew.smirnov@gmail.com> <20180712023337.30112-2-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 12 Jul 2018 10:37:47 -0300
Message-ID: <CAOMZO5DfHqKjF6xykJtoC-aA-ATWM6mCZR0VzPVpSDOt-Fs6bQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line
 pinumx config
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Wed, Jul 11, 2018 at 11:33 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> +       pinctrl_switch: switchgrp {
> +               fsl,pins = <
> +                       MX51_PAD_AUD3_BB_CK__GPIO4_20           0xc5

The i.MX51 Reference Manual states that 0xa5 is the default reset
value for the register IOMUXC_SW_PAD_CTL_PAD_AUD3_BB_CK.

By reading your commit log I had the impression you wanted to provide
the default value explicitly.

Please clarify.
