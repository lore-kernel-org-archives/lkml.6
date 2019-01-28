Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D782DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B212147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfA1SYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:24:38 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:48775 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1SYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:24:38 -0500
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 886FDC0003;
        Mon, 28 Jan 2019 18:24:33 +0000 (UTC)
Message-ID: <7e289e6b3410a3fdea99d7d6becfe5180a69f0c5.camel@hadess.net>
Subject: Re: [PATCH] input: goodix - support Goodix gt5688
From:   Bastien Nocera <hadess@hadess.net>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Mon, 28 Jan 2019 19:24:33 +0100
In-Reply-To: <20190128170310.GA305@bogon.m.sigxcpu.org>
References: <20190128170310.GA305@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-28 at 18:03 +0100, Guido Günther wrote:
> From what I've seen in vendor trees it's fine to treat this as gt1x¹.
> 
> [1]: https://github.com/TadiT7/android_kernel_mtk-4.4/tree/master/drivers/input/touchscreen/mediatek/GT5688

Can you please point to the exact line of code that makes you say that?
I'm not saying it's not compatible, but it's not the same driver that
the current goodix.c was based on, or even goodix.c.

Can you please elaborate?

Finding that data in the specs would also be fine:
https://github.com/hadess/gt9xx/tree/master/specifications

Cheers

[1]: original driver:
https://github.com/hadess/gt9xx/commit/82b141220e8bce00060e0de697735d0a70af2678

> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
>  drivers/input/touchscreen/goodix.c                             | 2
> ++
>  2 files changed, 3 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index f7e95c52f3c7..57d3d8870a09 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -3,6 +3,7 @@ Device tree bindings for Goodix GT9xx series
> touchscreen controller
>  Required properties:
>  
>   - compatible		: Should be "goodix,gt1151"
> +				 or "goodix,gt5688"
>  				 or "goodix,gt911"
>  				 or "goodix,gt9110"
>  				 or "goodix,gt912"
> diff --git a/drivers/input/touchscreen/goodix.c
> b/drivers/input/touchscreen/goodix.c
> index f2d9c2c41885..47b1ced41576 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -216,6 +216,7 @@ static const struct goodix_chip_data
> *goodix_get_chip_data(u16 id)
>  {
>  	switch (id) {
>  	case 1151:
> +	case 5688:
>  		return &gt1x_chip_data;
>  
>  	case 911:
> @@ -942,6 +943,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
>  #ifdef CONFIG_OF
>  static const struct of_device_id goodix_of_match[] = {
>  	{ .compatible = "goodix,gt1151" },
> +	{ .compatible = "goodix,gt5688" },
>  	{ .compatible = "goodix,gt911" },
>  	{ .compatible = "goodix,gt9110" },
>  	{ .compatible = "goodix,gt912" },

