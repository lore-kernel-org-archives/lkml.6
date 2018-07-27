Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D2AC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF7520891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="lsTTNLsA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pFUdkWNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF7520891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbeG0J5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:57:30 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:52499 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729420AbeG0J53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:57:29 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4FE205D0;
        Fri, 27 Jul 2018 04:36:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 27 Jul 2018 04:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ojHTtjDoizu7YPiWwoOJ0+/7cE6JWYxbhiov2V938rY=; b=lsTTNLsA
        7uyPYtmtDB7JhAuN6gFNmJ333A5yDGrE9Jej7JgtHhrqMFG/ICNKpShAfyitFXlI
        2McU9GPbgzuvj6nW6NHNQyIb474jA50GFU7nujmu41a62T880dfst0lhbwn8znAg
        aWfZdtWuAabCAIIQxj1DCWfrz1dysUZQt7JBi2R7Kdnke1kQx65osTM3jOuli1Ef
        VmFMcoBBwIxaKcXVdwWguaEZuuj+Y4K8Whb7QBjsJmgxEgR5WIwRbZXh3tYmOaiu
        Kedrb4pdB52y4HLDhT/lreF1UElQ6B1ckzG/+FXrPPKITqu+HYnT8+CXGJo4WPw3
        0EoxdYkKOTIrOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=ojHTtjDoizu7YPiWwoOJ0+/7cE6JW
        Yxbhiov2V938rY=; b=pFUdkWNk9QBxqFY+3U3LQWmboOWjmFOk8Ic3q/8K6qHEy
        0M4qTnoGJdIZW68RdxNRPt9MJdS6kgFp1+SRkCMWbERic2KpZ91FC9IJkFtMg3L2
        WM7QItSlApiMRXJxBudcgbIIDuL123/oubDQ7JEPaAsvkXBdybgj9jD+GkFMLspp
        okIaOG+rR7HNrzS3K/m8eSsU5ONiCWL12+nI9u43PPiZUhaw/FhKFxVGBDtt9BJX
        Yl4Gz/IMf+dZ8wGyl4PfEHQ8QgO8rsyrka7D8WGCodqzlOkDQe3mrCTTBZfu6SEz
        6HOqIK6y6DgT+1LWplYPacuFDf/U2l0aP/qxiuKbg==
X-ME-Proxy: <xmx:ltlaW57BhhEp9c6AMXpr2MBYoGrYxnZ0OraPMPuaVo0XEYCu7R1-kg>
    <xmx:ltlaWzqOYag4dr1CWepO_rYu6xfMr6qeSIfQ4p66Lbao2weWJDHo2g>
    <xmx:ltlaWwB164hBTZBvdLuEa6dHabh5wc3gyUqDyqUV9Py_Ql8S6EHsIA>
    <xmx:ltlaW6wrw4aIWrEd-wVx5cx-RxQSIRmJ5LKYqCHGBlCtKDHmB0q0KQ>
    <xmx:ltlaWxaDUKxk2xwc_QVmejCkbi2RpRFBZJlrfD6-wIxtO_EXQM9dKQ>
    <xmx:ltlaW2M8ylrM2Et-fjyV31n8HjgXl1zAsDGSAZ8tTR7IcWHQxmj1Og>
X-ME-Sender: <xms:ltlaW4GZk82Twom0XHNseJR9FDxq8IVGrZs_OLynk-n1YA-Ni6odiA>
Received: from localhost (unknown [89.188.5.116])
        by mail.messagingengine.com (Postfix) with ESMTPA id 49D42E4511;
        Fri, 27 Jul 2018 04:36:38 -0400 (EDT)
Date:   Fri, 27 Jul 2018 10:36:36 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Herring <robherring2@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: linux-next: manual merge of the staging tree with the devicetree
 tree
Message-ID: <20180727083636.GB17942@kroah.com>
References: <20180727175300.0a1fb512@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727175300.0a1fb512@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 05:53:13PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> 
> between commit:
> 
>   791d3ef2e111 ("dt-bindings: remove 'interrupt-parent' from bindings")
> 
> from the devicetree tree and commit:
> 
>   d2b863baf1c7 ("iio: pressure: bmp280: remove unused options from device tree documentation")
> 
> from the staging tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> index 5498b0688b6f,abcab02504fb..000000000000
> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> @@@ -8,10 -8,7 +8,6 @@@ Required properties
>     "bosch,bme280"
>   
>   Optional properties:
> - - chip-id: configurable chip id for non-default chip revisions
> - - temp-measurement-period: temperature measurement period (milliseconds)
> - - default-oversampling: default oversampling value to be used at startup,
> -   value range is 0-3 with rising sensitivity.
>  -- interrupt-parent: should be the phandle for the interrupt controller
>   - interrupts: interrupt mapping for IRQ
>   - reset-gpios: a GPIO line handling reset of the sensor: as the line is
>     active low, it should be marked GPIO_ACTIVE_LOW (see gpio/gpio.txt)


Looks correct to me, thanks!

greg k-h
