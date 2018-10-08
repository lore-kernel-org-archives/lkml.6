Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BB8C6787D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306CC2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVzJHmKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306CC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeJHHp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 03:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725754AbeJHHp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 03:45:56 -0400
Received: from dragon (unknown [45.56.155.247])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551FE2086D;
        Mon,  8 Oct 2018 00:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538959011;
        bh=EE8rXBm+EB+rU8JUBhVDVLdQxdB8BfXebTyD6LzROBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVzJHmKVRMzKeG1gxFZ+pCKdpJxwDVNGEIrBRiqcS1Jav8ddyspLMUJLSBMIg8YfW
         t63y5NApWtgkOiopw81HAk1Ek7Ll9hFRTYvLaZW4ajyJ7gXoBcPEQ9CF8KSpDdkZNG
         Gv7Xf/lIEkg75eBJxD9XqPZkH1ytQwx8sG+/lhac=
Date:   Mon, 8 Oct 2018 08:36:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller " <davem@davemloft.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: crypto: Mention clocks for mxs-dcp
Message-ID: <20181008003630.GE3587@dragon>
References: <cover.1538507155.git.leonard.crestez@nxp.com>
 <46df329cbd78c7238531fa7949419f4cff7ed220.1538507155.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46df329cbd78c7238531fa7949419f4cff7ed220.1538507155.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 07:18:21PM +0000, Leonard Crestez wrote:
> Explicit clock enabling is required on 6sll and 6ull so mention that
> standard clock bindings are used.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  Documentation/devicetree/bindings/crypto/fsl-dcp.txt | 2 ++
>  1 file changed, 2 insertions(+)

DT list and maintainers should be copied on bindings update, which needs
to be ACK-ed by DT maintainers.

Shawn

> 
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-dcp.txt b/Documentation/devicetree/bindings/crypto/fsl-dcp.txt
> index 76a0b4e80e83..4e4d387e38a5 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl-dcp.txt
> +++ b/Documentation/devicetree/bindings/crypto/fsl-dcp.txt
> @@ -4,10 +4,12 @@ Required properties:
>  - compatible : Should be "fsl,<soc>-dcp"
>  - reg : Should contain MXS DCP registers location and length
>  - interrupts : Should contain MXS DCP interrupt numbers, VMI IRQ and DCP IRQ
>                 must be supplied, optionally Secure IRQ can be present, but
>  	       is currently not implemented and not used.
> +- clocks : Clock reference (only required on some SOCs: 6ull and 6sll).
> +- clock-names : Must be "dcp".
>  
>  Example:
>  
>  dcp@80028000 {
>  	compatible = "fsl,imx28-dcp", "fsl,imx23-dcp";
> -- 
> 2.17.1
> 
