Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FC4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975772086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NTaRqw77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975772086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbeLMMhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:37:04 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:46320 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbeLMMhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=hT0m26R4vKY2hSuvgd9syT4EEIE8+/YSCvxwL6QL8B4=;
        b=NTaRqw77Qmr0rEnqKLjduHMMGWxPGXkgI1/a+rNtD7XW1s8oMe0RQ6U7MsGjUITrn9+RauUdo8nkDbCDYzpVInKy8wkEWrP0FD7j4AW8lcSwEvA2AmagbCcbYkf+yZJCvtr7jLiIUicnbfwwDGCKZKUkkv46jnUIeCQWkSuDuTA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gXQEc-0002u0-Jh; Thu, 13 Dec 2018 13:36:58 +0100
Date:   Thu, 13 Dec 2018 13:36:58 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org,
        honghui.zhang@mediatek.com, yt.shen@mediatek.com,
        liguo.zhang@mediatek.com, mark.rutland@arm.com,
        nelson.chang@mediatek.com, matthias.bgg@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, joabreu@synopsys.com
Subject: Re: [v7, PATCH 2/2] dt-binding: mediatek-dwmac: add binding document
 for MediaTek MT2712 DWMAC
Message-ID: <20181213123658.GG1605@lunn.ch>
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
 <1544666173-5121-3-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544666173-5121-3-git-send-email-biao.huang@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +- mediatek,rx-delay-ps: RX clock delay macro value. Default is 0.
> +	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
> +Both delay properties need to be a multiple of 170 for fine-tune rgmii,
> +range 0~31*170.
> +Both delay properties need to be a multiple of 550 for coarse-tune rgmii,
> +range 0~31*550.
> +Both delay properties need to be a multiple of 550 for mii/rmii,
> +range 0~31*550.

You see "need to be" here, but the driver does not care. It will round
down. Please either make the driver check, or change the text to
rather say it will round down.

       Andrew
