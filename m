Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681F3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F93217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551278845;
	bh=xBKLKkha3fIOLrJq2ruP0e0YDcePEX0pL/Rf8UGo9gE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HNoisuoDimAf9p2Hs36QkgdfkbcaaRUAkomB9D/8x+Mdg3jnxFkFDs8hZuUBrX73v
	 cVPZodmP28+okeOUKzSF0TCtFxY6qDombJZNBrMYwEX/KOf5AxnDW0MdOMvwJRVXaV
	 26dLtPklRWJTvswXp0aFxiBWFMSLrqHnOHiLFbVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfB0OrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:47:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbfB0OrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:47:20 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA842183F;
        Wed, 27 Feb 2019 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551278839;
        bh=xBKLKkha3fIOLrJq2ruP0e0YDcePEX0pL/Rf8UGo9gE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t/gLR7lF5TRiUs/WZ5jMxevW4zY2CgxY4MNcjSsMI5JSX7MO8tllJ2parRhW10X2W
         ADbLSsnzw9WH4XSqvBbaqZ3tWVs/WuNgP+9/sAnMOEshSvLncOdbix9nSlOkGU38mn
         /4fIcY2S63QCHDtJaa2kJ6ARrZpCtrj9i5nmha3k=
Received: by mail-qk1-f182.google.com with SMTP id x9so9999748qkf.0;
        Wed, 27 Feb 2019 06:47:19 -0800 (PST)
X-Gm-Message-State: APjAAAW+sjWGdF4GRlP28q8WLL+umGaLdQ9RpCGW/EwoUoOz49VlQ/y/
        RqYyp66jt8Vg2hYtWuRrl+/XgvWkgnuPKo8UJA==
X-Google-Smtp-Source: APXvYqzda2Sw50spJHbBAFqS3wYj5i9U0/bTlVbJ7hYT80eh1S8U4ytd+wVjaxTnknI3bNU4QwUoIfWrWMXK4nDhjdo=
X-Received: by 2002:a05:620a:123b:: with SMTP id v27mr2325850qkj.29.1551278838828;
 Wed, 27 Feb 2019 06:47:18 -0800 (PST)
MIME-Version: 1.0
References: <1551243145-10635-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1551243145-10635-1-git-send-email-sugaya.taichi@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 27 Feb 2019 08:47:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJvKMCmV3aq4LX_n2xsMEUfSK41--VVU+aQqtqv4F5U=g@mail.gmail.com>
Message-ID: <CAL_JsqJvKMCmV3aq4LX_n2xsMEUfSK41--VVU+aQqtqv4F5U=g@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] dt-bindings: Add documentation for Milbeaut SoCs
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        soc@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:51 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> This adds a DT binding documentation for the M10V and its evaluation
> board.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../bindings/arm/socionext/milbeaut.yaml           | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
