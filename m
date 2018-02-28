Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeB1JQS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:16:18 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33988 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeB1JQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:16:15 -0500
X-Google-Smtp-Source: AH8x226dWKdiUjBl0WKyyeH0kdH6dSR46uwNyGu0YnCWr3xL8B91B6BNJI3n/BIiy/9Zxqw53k2O0s0uOjY/9LUyhlE=
MIME-Version: 1.0
In-Reply-To: <20180228022714.30068-4-samuel@sholland.org>
References: <20180228022714.30068-1-samuel@sholland.org> <20180228022714.30068-4-samuel@sholland.org>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 28 Feb 2018 14:46:13 +0530
Message-ID: <CABb+yY2uueAK9kzXzU9DT2a4NtV3kK2dc_wtyFWTBn8=Z6Vi7Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
To: Samuel Holland <samuel@sholland.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ", linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream"
        <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 7:57 AM, Samuel Holland <samuel@sholland.org> wrote:
....

> +/*
> + * The message box hardware provides 8 unidirectional channels. As the mailbox
> + * framework expects them to be bidirectional
>
That is incorrect. Mailbox framework does not require a channel to be
TX and RX capable.

You should expose each channel as per its physical capability, let the
client configure it for direction (if its bidirectional) and acquire
separate channels for RX and TX if it needs to.

Cheers!
