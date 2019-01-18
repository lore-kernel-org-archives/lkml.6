Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB36C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA51B20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547798871;
	bh=iycJr6kMP0y8uo8Se6qfTNrgbB+LhAyuaI7z/89S51o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QtQPHZnmq7my46sKWz68kguoIDWygURF79V2gdObaK4N7gtiGSdm01f0jIX2QTrni
	 Nz5uXqoJWOYEpWnX1rn77iUXCMQwGh1rNzJSJmgHFGneWgPfuYO0XrMI6WaqgX9sXZ
	 w6cRXhndAKOIgvuXapCc6tAxXZHbXZmwXn46vFwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfARIHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:07:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfARIHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:07:49 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1737E20855;
        Fri, 18 Jan 2019 08:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547798868;
        bh=iycJr6kMP0y8uo8Se6qfTNrgbB+LhAyuaI7z/89S51o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oPOUqKMMPfNCqnbLw20NA61qi0SdMPmFMJH6DehB8UnC8dZxattVHb88ATKxDtHoU
         TLibIkiyd1fI3uBF7gSTsk5fZifycuAfgcGqEJFUi5PxKB7r1FfoGREs/oWP1edSdz
         S7yYSZ+lJh1Qd9LmSkggyrVT7qajrULBoptzlCkQ=
Date:   Fri, 18 Jan 2019 09:07:36 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 1/8] MIPS: DTS: CI20: Set BCH clock to 200 MHz
Message-ID: <20190118090736.6f1283bd@bbrezillon>
In-Reply-To: <20190118010634.27399-1-paul@crapouillou.net>
References: <20190118010634.27399-1-paul@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, 17 Jan 2019 22:06:27 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> This is currently done inside the jz4780-bch driver, but it really
> should be done here instead.
> 

I disagree with that statement. If it's a per-SoC constraint then you
can select the appropriate rate based on the compatible in the driver.
If the clock rate depends on the NAND chip it probably means it's used
to generate the RE/WE pulse and should depend on the NAND timings
passed to ->setup_data_interface(). In either case, this should not be
specified in the DT.

Regards,

Boris

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/boot/dts/ingenic/ci20.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
> index 50cff3cbcc6d..aa892ec54d0a 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -111,6 +111,9 @@
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pins_nemc>;
>  
> +		assigned-clocks = <&cgu JZ4780_CLK_BCH>;
> +		assigned-clock-rates = <200000000>;
> +
>  		nand@1 {
>  			reg = <1>;
>  

