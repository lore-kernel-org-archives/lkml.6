Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE45ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA7E20831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA7E20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeJYImh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:42:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36442 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYImh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:42:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id x4so6904104otg.3;
        Wed, 24 Oct 2018 17:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=57BwhvJgAONqp86MA65flk7liXcHcEV4roLBN+EJKsk=;
        b=GWR8E+J1o9cIRw00K9fsPrjlDzMjLQIwBrX+4Cxoc0tNaz0PQO61KXYg8eqiU8p7LR
         v0Snbdx/c9lFC3DtuesnBmNWKndvtHN4npC2bwjuTZDyw3DhkKubIbf6frohs4L+jXI2
         ve21bJrSjRZ0+bS55Fzaw7rxZCZl6r2Kg+YSuGii3Rmfb2k6nytiODIPUrKTh127nnlk
         Um/2xyKAbqPwu7nzArXjT2jfjfAgKSf17GowqMey+JGvsKQQ3IsaTnHYtsRKlZ1WSeEy
         N3RlSJqe7Nu4D6vpZBEmAuqbHyKoYJECcSm3Dj7Gh9Kw7U2mrr8tdqnTO/ZeBH4rqgKG
         15Ng==
X-Gm-Message-State: AGRZ1gIZpeAZT8wMsIb7BqH/wmYPmhwllGi4EPwprXTPkH8Y2ZR9fOfE
        SfIqsZejvClsXTmBwk6QfAlmngs=
X-Google-Smtp-Source: AJdET5dydwMCBP493ClTHIOKB/4FBJJULoftOnSyAD+O/xmJ41IwwQNdBvnd0BeEruncEJ1qHyLrjw==
X-Received: by 2002:a9d:2607:: with SMTP id a7mr3189941otb.283.1540426343138;
        Wed, 24 Oct 2018 17:12:23 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c29sm1799912otj.58.2018.10.24.17.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 17:12:22 -0700 (PDT)
Date:   Wed, 24 Oct 2018 19:12:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Ofir Drang <Ofir.Drang@arm.com>,
        Yael Chemla <Yael.Chemla@arm.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] crypto: ccree: add dt bindings for ccree 713
Message-ID: <20181025001221.GA12740@bogus>
References: <1539696935-4433-1-git-send-email-gilad@benyossef.com>
 <1539696935-4433-3-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539696935-4433-3-git-send-email-gilad@benyossef.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 02:35:32PM +0100, Gilad Ben-Yossef wrote:
> Add device tree bindings associating Arm TrustZone CryptoCell 713 with the
> ccree driver.

"dt-bindings: crypto: ..." for the subject.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> ---
>  Documentation/devicetree/bindings/crypto/arm-cryptocell.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> index 999fb2a..880de07 100644
> --- a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> +++ b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> @@ -1,8 +1,9 @@
>  Arm TrustZone CryptoCell cryptographic engine
>  
>  Required properties:
> -- compatible: Should be one of: "arm,cryptocell-712-ree",
> -  "arm,cryptocell-710-ree" or "arm,cryptocell-630p-ree".
> +- compatible: Should be one of: "arm,cryptocell-713-ree",
> +  "arm,cryptocell-712-ree", "arm,cryptocell-710-ree" or
> +  "arm,cryptocell-630p-ree".

Please format 1 per line.

>  - reg: Base physical address of the engine and length of memory mapped region.
>  - interrupts: Interrupt number for the device.
>  
> -- 
> 2.7.4
> 
