Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1ECC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5706E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="iUFm6s2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfANJac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:30:32 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:57515 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANJaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:30:30 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 96A1525BE67;
        Mon, 14 Jan 2019 20:30:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1547458227; bh=j4JFhV3pxWURz99ocXqXiMYP+8fJvIXct1+I4EAFh4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUFm6s2+EqPALEPDNlBU2t1GyxlNiS7Bkg6YuZk8pZ9wSVlV/1AwNTSsEqog+X1fe
         R07AAIkVVZ/RnyB7+vGyXiVC8T4YfqWbuS2pqYL6qL06KM1mmD9NQd5jnpMfeiEJQ/
         JYNNLEL/Q+gZlrf3/oensr+dJTiwoEaXngRey+zE=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id C21A79404C7; Mon, 14 Jan 2019 10:30:25 +0100 (CET)
Date:   Mon, 14 Jan 2019 10:30:25 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: serial: Move renesas,rzn1-uart into the
 snps-dw-apb-uart binding
Message-ID: <20190114093025.ntshd3oioqacvkm2@verge.net.au>
References: <20190110222017.6390-1-robh@kernel.org>
 <20190110222017.6390-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110222017.6390-2-robh@kernel.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 04:20:17PM -0600, Rob Herring wrote:
> The renesas,rzn1-uart binding only differs in compatible string from the
> snps-dw-apb-uart binding. Move it there, converting it to json-schema in
> the process.

This confused me slightly as this patch removes renesas,rzn1-uart.txt
but doesn't add the renesas bindings elsewhere. I now see that is done
in patch 1/2, which is fine. But it might be worth rewording the changelog.

That notwithstanding:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/serial/renesas,rzn1-uart.txt   | 10 ----------
>  1 file changed, 10 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt b/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt
> deleted file mode 100644
> index 8b9e0d4dc2e4..000000000000
> --- a/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -Renesas RZ/N1 UART
> -
> -This controller is based on the Synopsys DesignWare ABP UART and inherits all
> -properties defined in snps-dw-apb-uart.txt except for the compatible property.
> -
> -Required properties:
> -- compatible : The device specific string followed by the generic RZ/N1 string.
> -   Therefore it must be one of:
> -   "renesas,r9a06g032-uart", "renesas,rzn1-uart"
> -   "renesas,r9a06g033-uart", "renesas,rzn1-uart"
> -- 
> 2.19.1
> 
