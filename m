Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA78C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECE82084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYFpsqr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECE82084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbeJ3DTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbeJ3DTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:19:01 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55E272080A;
        Mon, 29 Oct 2018 18:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540837751;
        bh=DmmkJElWMtcW2iNLRLdHlRZL6/ceYGta53SwvJwN/YA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=qYFpsqr2NpbhGTufc0SAYl8xsZQik7rA4f8sGJQG92w4V9kyPciDvLI/lGNIWLLLG
         IEqpr1ZAM4Dr4Zcq5wCQf4DgUHu+GH5dlrKGWTPpCx/n4oz96RHMTbtPpPYUrDb9Tm
         5CjeQFrZQnnHbFAx4CGvMqVL3kSc02nVpOGTLEv0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     geert+renesas@glider.be, horms@verge.net.au, jiada_wang@mentor.com,
        magnus.damm@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181025072349.15173-3-jiada_wang@mentor.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        jiada_wang@mentor.com
References: <20181025072349.15173-1-jiada_wang@mentor.com>
 <20181025072349.15173-3-jiada_wang@mentor.com>
Message-ID: <154083775062.98144.11157403961171783929@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH linux-next v1 2/4] clk: renesas: Add binding document for AVB
 Counter Clock
Date:   Mon, 29 Oct 2018 11:29:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting jiada_wang@mentor.com (2018-10-25 00:23:47)
> From: Jiada Wang <jiada_wang@mentor.com>
> =

> Add device tree bindings for avb counter clock for Renesas
> R-Car Socs.
> =

> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  .../bindings/clock/renesas,avb-clk.txt        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,avb-c=
lk.txt
> =

> diff --git a/Documentation/devicetree/bindings/clock/renesas,avb-clk.txt =
b/Documentation/devicetree/bindings/clock/renesas,avb-clk.txt
> new file mode 100644
> index 000000000000..03bf50b5830c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,avb-clk.txt
> @@ -0,0 +1,19 @@
> +* Renesas AVB Counter Clock
> +
> +The AVB Counter Clocks are provided by avb_counter8 Clock Generator,
> +avb_counter8 has dividers which operates with S0D1=CF=95 clock and has
> +8 output clocks.
> +
> +Required Properties:
> +  - compatible: Must be "renesas,clk-avb"
> +  - reg: Base address and length of the memory resource used by the AVB
> +  - #clock-cells: Must be 1
> +
> +Example
> +-------
> +
> +       clk_avb: avb-clock@ec5a011c {
> +               compatible =3D "renesas,clk-avb";
> +               reg =3D <0 0xec5a011c 0 0x24>;

This is an odd register offset. Is this just one clk inside of a larger
clk controller?

