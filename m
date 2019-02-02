Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0CAC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEC120869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549122853;
	bh=M5S+D8tyHjab/TFZJYnTpRhqk8vxh0Dt4uIOYbV0eo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tG87KabZD/ysYUFVFUe3Bx4xu9nEUuC6TDwiC2G1Dra7dAA3ec1nntBWrWWtxPcyV
	 2Y3IXLkQk79BpAGdwGRwExEoGqM5o4pZKOUw4AJ6X7b9TINHX+dNmyygIABEbYS5/g
	 iL/c82l1Y8w4N86Ep7093nLUrFH1yyTaWn3uZdQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfBBPyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:54:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbfBBPyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:54:11 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9CFF205C9;
        Sat,  2 Feb 2019 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549122850;
        bh=M5S+D8tyHjab/TFZJYnTpRhqk8vxh0Dt4uIOYbV0eo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JzUSOGuclL7bieYNzMlEgFDwTqo8pJeACtBdO7bFJF4QQkQkzDlt0XWo6Lm27+S0T
         oVhygkspMoPOyzWK8r6Hq0fDmFAZDLMJV+Hw0sA+RPElxpc/g6oVcJ2LNx5SZmGgOK
         8n35nkd+LjF6jLCdDcFOmBpnwsG2/c8t8b+DekfQ=
Date:   Sat, 2 Feb 2019 15:54:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: light: Add max44009
Message-ID: <20190202155405.6c9fb5ca@archlinux>
In-Reply-To: <b36579acc3031a28657b6f2e143e9ea4051d7c46.1548947951.git.bobbyeshleman@gmail.com>
References: <01f62d9d67110fd2c2f34e7835973fc6874a9fe8.1548947951.git.bobbyeshleman@gmail.com>
        <b36579acc3031a28657b6f2e143e9ea4051d7c46.1548947951.git.bobbyeshleman@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 07:49:16 -0800
Robert Eshleman <bobbyeshleman@gmail.com> wrote:

> Adds device tree bindings for the max44009 light sensor.
> 
> Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>

Still time for Rob to comment if he want's to, but I think
with few tweaks as below this matches what he asked for.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes to v4:
> - Add subsystem to subject line
> - Change node name to be 'light-sensor' 
> - Clean up style
> 
> Changes to v3:
> - None
> 
> Changes to v2:
> - Clean up style
> 
>  .../bindings/iio/light/max44009.txt           | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/max44009.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/max44009.txt b/Documentation/devicetree/bindings/iio/light/max44009.txt
> new file mode 100644
> index 000000000000..557297c86fba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/max44009.txt
> @@ -0,0 +1,25 @@
> +* MAX44009 Ambient Light Sensor
> +
> +Required properties:
> +
> +- compatible: should be "maxim,max44009"
> +- reg: the I2C address of the device (default is <0x4a>)
> +
> +Optional properties:
> +
> +- interrupts: interrupt mapping for GPIO IRQ. Should be configured with
> +  IRQ_TYPE_EDGE_FALLING.
> +
> +Refer to interrupt-controller/interrupts.txt for generic interrupt client
> +node bindings.
> +
> +Example:
> +
> +max44009: light-sensor@4a {
The label is only useful if something is going to cross reference it.
Can't see that happening so dropped it. Above now reads.

light-sensor@4a {


> +	compatible = "maxim,max44009";
> +	reg = <0x4a>;
> +
> +	interrupt-parent = <&gpio1>;
> +	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
> +};
> +
Cleaned up extra entirely blank line at end of file.
