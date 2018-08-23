Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95983C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562D821557
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OB3CaCfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562D821557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeHWVOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:14:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbeHWVOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eQXniB4lFLL5t5xQ3rqVmzstEt4fjRVMF6Z4b0VhbWQ=; b=OB3CaCfBRq8/L+cEJzjEnFXWn
        jXnRNGTd4D4PRhFQTfdhPYN/+I7y4MAdLSkc5PWJoWxmfj+2Wvywvm8lR5BUYY5Es8o+GRJ7H9xWo
        dtMpMDg/Pu3ozbrPLQvUMBGxPOPzMEgiMrCakp4R2QXS6c+i8JbMdc6Axc1JbgyXaibX65TXdJgkG
        R0u1I3FxOj2esYTjKBBeMYv9Sn3VG3pX5x4Hwpje/EdvxYGkIfSL5X5XLF0Pfotgi582nmLB2SbbC
        HqzG136yngPGbW4kDh4rpS5XBh0lPT4/guJ84UUj0m4BABpf+dXy1ssJ7iBmeb6OL0aWrXm/c+rJ/
        xDhBubtcQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fstdX-00070H-PR; Thu, 23 Aug 2018 17:43:11 +0000
Subject: Re: [RFC 1/3 net] lorawan: Add LoRaWAN class module
To:     Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?Q?Konstantin_B=c3=b6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        "contact@snootlab.com" <contact@snootlab.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        Alexander Graf <agraf@suse.de>,
        =?UTF-8?Q?Michal_Kube=c4=8dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Pieter ROBYNS <pieter.robyns@uhasselt.be>,
        Hasnain Virk <Hasnain.Virk@arm.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Daniele Comel <dcomel@mipot.com>, shess@hessware.de,
        Xue Liu <liuxuenetmail@gmail.com>
References: <cover.1535039998.git.starnight@g.ncu.edu.tw>
 <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <30b75248-7589-fc98-819f-2b68844522f1@infradead.org>
Date:   Thu, 23 Aug 2018 10:43:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/23/2018 10:15 AM, Jian-Hong Pan wrote:
> diff --git a/net/maclorawan/Kconfig b/net/maclorawan/Kconfig
> new file mode 100644
> index 000000000000..741992b059c6
> --- /dev/null
> +++ b/net/maclorawan/Kconfig
> @@ -0,0 +1,14 @@
> +config LORAWAN
> +	tristate "MAC layer of LoRaWAN Network support"
> +	select CRYPTO
> +	select CRYPTO_CMAC
> +	select CRYPTO_CBC
> +	select CRYPTO_AES
> +	---help---
> +	  LoRaWAN defines a low data rate, low power and long range wireless
> +	  wide area networks. It was designed to organise networks of sensors,
> +	  switches and actuators, etc automation devices.  It could operate as
> +	  multiple kilometers wide.

There are several things that I would change.  How about this instead?


	  LoRaWAN defines low data rate, low power and long range wireless
	  wide area networks. It was designed to organise networks of automation
	  devices, such as sensors, switches and actuators. It can operate
	  multiple kilometers wide.

> +
> +	  Say Y here to compile LoRaWAN support into the kernel or say M to
> +	  compile it as modules.


-- 
~Randy
