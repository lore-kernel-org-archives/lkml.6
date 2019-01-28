Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60243C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFB22147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548699840;
	bh=wwF4P/+YTPiLR9mrP7tHgk5BSl12r3VGfZLXwRzAEG0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ywu8utzl036QXUtprKy+hGOuxOiQM6mBq9k8wQUvYGGLcAcio+n+Xj6zmzj89ImGJ
	 Rc6eyP0+m+wxsKZ3H7Yohf/yy9OS+BOT/MNAZstjHG9vqfkmXPGqZI64ZQkM7Yocod
	 RYPnj+8/VuLce1LTZ+okCOkzISUu+5SYga+d0z88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfA1SX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:23:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:32772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfA1SX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:23:57 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDF5321741;
        Mon, 28 Jan 2019 18:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548699837;
        bh=wwF4P/+YTPiLR9mrP7tHgk5BSl12r3VGfZLXwRzAEG0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TQz4bvm0NbGm8relDCwvrm4CgO/KoYlPhpba5I9DduvPvsbl6SWQ6xQ/0G+94oP0G
         K484Szvm1uNDL8Q4glf1KdEPh6t3DbIfh98OXrP6TMHWQ2fgR/78mIh6RQGveNuxpt
         bXKh7S8glyHppkxeN8LUkL9901U1zmzNADFrD7IA=
Received: by mail-qt1-f171.google.com with SMTP id e5so19293230qtr.12;
        Mon, 28 Jan 2019 10:23:56 -0800 (PST)
X-Gm-Message-State: AJcUukcLhChiuoMMl15XKM2MxFScbQMS6i9uT2BPws+BSGi975EdDXDl
        Ql2PRF0LNlGvPNOKqKJeJ6yAgDFWG9ynydo1HA==
X-Google-Smtp-Source: ALg8bN5iUeXzjuAU4AMlhWM03njPLDHd1n//0C11UtDI+Y7TNo3VijwQGkBDk9HhfhBU3dxfVO1uT5h3zsjckF+5jI0=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr22699276qtf.26.1548699836063;
 Mon, 28 Jan 2019 10:23:56 -0800 (PST)
MIME-Version: 1.0
References: <20190124145309.21698-1-ben.whitten@lairdtech.com> <20190124145309.21698-5-ben.whitten@lairdtech.com>
In-Reply-To: <20190124145309.21698-5-ben.whitten@lairdtech.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 28 Jan 2019 12:23:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLczDnQis5SkmfrFie+aj9pb+UfPyF4dfiKs7aomeRPXg@mail.gmail.com>
Message-ID: <CAL_JsqLczDnQis5SkmfrFie+aj9pb+UfPyF4dfiKs7aomeRPXg@mail.gmail.com>
Subject: Re: [PATCH v3 lora-next 4/4] dt-bindings: lora: sx130x: add clock bindings
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        David Miller <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lpwan@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 8:54 AM Ben Whitten <ben.whitten@gmail.com> wrote:
>
> From: Ben Whitten <ben.whitten@gmail.com>
>
> The SX130x family consumes two clocks, a 32 MHz clock provided by a
> connected IQ transceiver, and a 133 MHz high speed clock.
> It also provides a 32 MHz clock out to the radio in the TX path.
>
> In the example we connect the concentrator to a fixed clock providing
> the 133 MHz high speed clock, and we connect to a connected transceiver
> 32 MHz clock.
>
> A radio in the TX path is also connected to the 32 MHz clock out from the
> concentrator.
>
> The connected radios are both fed from a fixed 32 MHz clock, with only
> one being the clock source back to the SX130x concentrator.
>
> Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
> ---
> v2 -> v3:
> * Name input clocks specifically
> * Add output clock for radio in TX path
> v1 -> v2:
> * Fixed incorrect usage of clock cells
> * Fixed wording in commit and descriptions
> ---
>  .../bindings/net/lora/semtech,sx130x.yaml     | 52 ++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)

Other than the issue on patch 3 that affects the example here,

Reviewed-by: Rob Herring <robh@kernel.org>
