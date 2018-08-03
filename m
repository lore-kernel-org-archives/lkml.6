Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477D5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0994217AF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBplInGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0994217AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbeHCXw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729876AbeHCXw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:52:27 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B3A6217A2;
        Fri,  3 Aug 2018 21:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533333260;
        bh=fsTU3ffV5wdL4jiJNJAgz1I8E3L37xhhXHhsVZ0s0Jk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GBplInGjQp5V92rsD+549A85m32Kyn+ltqtX2hJ+wCgftu+jXizwBE5xvxVOd/gLu
         W1g3j4Y+z4la6ztdAsqyIYprfvs2XgFQlLbEX65S33+dPNLPgkevzni/2ujdStMVyD
         Psq4jFrnzUa7LOuedLRNnA6sQeKIEJ0BdHKoLRdU=
Date:   Fri, 3 Aug 2018 22:54:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH v3 8/9] dt-bindings: iio: tsl2772: add binding for
 avago,apds9930
Message-ID: <20180803225414.37cca479@archlinux>
In-Reply-To: <20180803001900.25371-9-masneyb@onstation.org>
References: <20180803001900.25371-1-masneyb@onstation.org>
        <20180803001900.25371-9-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Aug 2018 20:18:59 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch adds avago,apds9930 to the tsl2772 bindings.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
As before I'll pick up with the rest.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/light/tsl2772.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> index 4e7d98627cbf..1c5e6f17a1df 100644
> --- a/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> +++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> @@ -13,6 +13,7 @@ Required properties:
>  		"amstaos,tmd2672"
>  		"amstaos,tsl2772"
>  		"amstaos,tmd2772"
> +		"avago,apds9930"
>    - reg: the I2C address of the device
>  
>  Optional properties:

