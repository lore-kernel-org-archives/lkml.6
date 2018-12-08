Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90543C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A6B21104
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544267364;
	bh=cK+/Xp04g6AdoMZS0Lyg5jiTviSj1lrxlqEqiuCbaOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ua8q5Uc3Ij5rheiSrzq2elqSXjr3Kc+CgchPjzUMVO8iv6bGOK5uZsubf812QjwKm
	 z1j3NTO7440gwsWE7RTJJXlQKSlPi0ihAxFi3YGDPTGwTIr03ztoFZXhkBm3RIJ+bD
	 /wB+05u9LhOabwae4r0cm8UWYgXXamw3ma9Z7c7A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A6B21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLHLJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 06:09:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbeLHLJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 06:09:23 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B6820700;
        Sat,  8 Dec 2018 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544267362;
        bh=cK+/Xp04g6AdoMZS0Lyg5jiTviSj1lrxlqEqiuCbaOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ug6DdJtnnUmkhCZJgQQKFIaJBMqsyICvqF7F2WfgKg5e+bALn9vuml2bkHbbrsOgW
         GmZv6Nm5HopvgR/maJtxnJGiER7t1UleWUe5RHn4OyyblXIF+9AeP3rTmq7rdKgoB2
         mEAwit/8L/DEI3cqUepA6lS0HG5FLplWR9Iw10T0=
Date:   Sat, 8 Dec 2018 11:09:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: accel: use a generic node name for
 lis302
Message-ID: <20181208110917.2dfc438f@archlinux>
In-Reply-To: <20181203114740.637091-1-lkundrak@v3.sk>
References: <20181203114740.637091-1-lkundrak@v3.sk>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Dec 2018 12:47:40 +0100
Lubomir Rintel <lkundrak@v3.sk> wrote:

> The example should follow the practice or using a generic node name
> instead of the precise programming model, as recommended by the DTSpec.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Applied to the togreg branch of iio.git and pushed out as testing
to be largely ignored.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/accel/lis302.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/lis302.txt b/Documentation/devicetree/bindings/iio/accel/lis302.txt
> index dfdce67826ba..764e28ec1a0a 100644
> --- a/Documentation/devicetree/bindings/iio/accel/lis302.txt
> +++ b/Documentation/devicetree/bindings/iio/accel/lis302.txt
> @@ -64,7 +64,7 @@ Optional properties for all bus drivers:
>  
>  Example for a SPI device node:
>  
> -	lis302@0 {
> +	accelerometer@0 {
>  		compatible = "st,lis302dl-spi";
>  		reg = <0>;
>  		spi-max-frequency = <1000000>;
> @@ -89,7 +89,7 @@ Example for a SPI device node:
>  
>  Example for a I2C device node:
>  
> -	lis331dlh: lis331dlh@18 {
> +	lis331dlh: accelerometer@18 {
>  		compatible = "st,lis331dlh", "st,lis3lv02d";
>  		reg = <0x18>;
>  		Vdd-supply = <&lis3_reg>;

