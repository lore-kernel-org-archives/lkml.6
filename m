Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCCBC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4FB20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4FB20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJaBh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:37:59 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:41276 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeJaBh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:37:58 -0400
Received: from [109.168.11.45] (port=36330 helo=[192.168.101.125])
        by srv-hp10.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1gHX7E-00ASkR-87; Tue, 30 Oct 2018 17:43:40 +0100
Subject: Re: [PATCH 1/7] dt-bindings: mfd: ds90ux9xx: add description of TI
 DS90Ux9xx ICs
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sandeep Jain <Sandeep_Jain@mentor.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-2-vz@mleia.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <fd0a91c9-6e38-5a18-12e5-955fbf81bfce@lucaceresoli.net>
Date:   Tue, 30 Oct 2018 17:43:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181008211205.2900-2-vz@mleia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On 08/10/18 23:11, Vladimir Zapolskiy wrote:
> From: Sandeep Jain <Sandeep_Jain@mentor.com>
> 
> The change adds device tree binding description of TI DS90Ux9xx
> series of serializer and deserializer controllers which support video,
> audio and control data transmission over FPD-III Link connection.
[...]
> +Example:
> +
> +serializer: serializer@c {
> +	compatible = "ti,ds90ub927q", "ti,ds90ux9xx";
> +	reg = <0xc>;
> +	power-gpios = <&gpio5 12 GPIO_ACTIVE_HIGH>;
> +	ti,backward-compatible-mode = <0>;
> +	ti,low-frequency-mode = <0>;
> +	ti,pixel-clock-edge = <0>;
> +	...
> +}
> +
> +deserializer: deserializer@3c {
> +	compatible = "ti,ds90ub940q", "ti,ds90ux9xx";
> +	reg = <0x3c>;
> +	power-gpios = <&gpio6 31 GPIO_ACTIVE_HIGH>;
> +	...
> +}

Interesting patchset, thanks. At the moment I'm working on a driver for
the TI FPD-III camera serdes chips [0]. At very first sight they have
many commonalities with the display chipsets [1] you implemented. Did
you have a look into them? Do you think they could be implemented by the
same driver?

The camera serdes chips lack some features found on the display chips
(e.g. audio, white balance). OTOH they have dual or quad input
deserializers, which adds complexity.

I'm commenting on the details in reply to the following patches
documenting the DT bindings.

[0] http://www.ti.com/interface/fpd-link-serdes/camera-serdes/overview.html
[1] http://www.ti.com/interface/fpd-link-serdes/display-serdes/overview.html

Bye,
-- 
Luca
