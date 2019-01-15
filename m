Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348ECC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC020205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547584494;
	bh=alMrYl9IchIOqG4uNE4E+0ArKr2WnPphh0BWak1p6LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bixQ5N4mbcLP0v54rxzQKS+deNflelCQVvgcT1jEKQlxRV5XhtDL5hfVj/CN9uolr
	 5nigWeros6BXQ+Tac7gK5d7WS+PO9evP5JsMLObPh4QYnPzPedxNm7DB+e6GCHQW8V
	 O7KrTTJYEgTrlxrmHX8H4ccVnN0BddnySRx/GcKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389889AbfAOUew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:34:52 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43374 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389809AbfAOUeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:34:50 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so3771339otr.10;
        Tue, 15 Jan 2019 12:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JxGJ8WIrivTOKu7G6KSxTIjfw48mIyER7kkQ5n6dG3g=;
        b=LuJMHkAsLjn5Yn0lsc4RNrtjr33/LrZx1eJO5YYKoi8NABRE22bdkZAC2ES0Oqtzps
         +kMOtkweuDU5xbwuhtwXrAdkXck2dGRj/JSUprpG69XAWOxChcFVYvWQ5+TOnqlu/Fu/
         tf+MAzmN81DdZCCLzIzJWUiuNSXZn0cQXs//6GFaLggUBnjxXGB73MTf1LC9XYdMeA6r
         MtuFXvJffgNxHS0LY5Kxz44PiJMQLyauqqVUFEIUGBDAfwOSJcZYQpKoup0SNOvMHPdK
         oo+nZQRboQRzVSGAXPD1m+MTFAAELEJlZ+tGMJc5Trx+bg3iLJ/CxlqKMF8JUNEftJd/
         nNoQ==
X-Gm-Message-State: AJcUukfJhtwKaKRwmuTveJS7+8M830fUMlcR5WnC+DQkHtd3iVr3Vzpc
        h02ulP4qoLCvlC5OxcZ6dQ==
X-Google-Smtp-Source: ALg8bN4DoJn8M4S21JX9OqLUFAVohRX6SxwOyrp+uJmmQDNwCjbOhgQH4esWE/JFmQlB5oOT15ss6A==
X-Received: by 2002:a9d:39e5:: with SMTP id y92mr3503469otb.233.1547584489976;
        Tue, 15 Jan 2019 12:34:49 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id a21sm1748990otr.3.2019.01.15.12.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:34:49 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:34:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Erin Lo <erin.lo@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2 1/6] dt-bindings: Add a binding for Mediatek SCP
Message-ID: <20190115203448.GA32546@bogus>
References: <20190108052606.59426-1-pihsun@chromium.org>
 <20190108052606.59426-2-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108052606.59426-2-pihsun@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 01:26:01PM +0800, Pi-Hsun Shih wrote:
> From: Erin Lo <erin.lo@mediatek.com>
> 
> Add a DT binding documentation of SCP for the
> MT8183 SoC from Mediatek.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
> Changes from v1:
>  - no change

No answer to my question on v1?

> ---
>  .../devicetree/bindings/remoteproc/mtk,scp.txt         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> new file mode 100644
> index 00000000000000..b07e5c4ca9af1d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> @@ -0,0 +1,10 @@
> +Mediatek SCP Bindings
> +----------------------------------------
> +
> +This binding provides support for ARM Cortex M4 Co-processor found on some
> +Mediatek SoCs.
> +
> +Required properties:
> +- compatible		Should be "mediatek,mt8183-scp"
> +- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
> +
> -- 
> 2.20.1.97.g81188d93c3-goog
> 
