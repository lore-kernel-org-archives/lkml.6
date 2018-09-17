Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D934ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE9E206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BM+T3EVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE9E206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbeIQVqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:46:25 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:55818 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeIQVqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:46:25 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7A54224E02BD;
        Mon, 17 Sep 2018 09:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537201101; bh=w3EBJgKQ94pa3Yndxpg/MZ/4IV8zOrMVHB40jREfFjs=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=BM+T3EVI262/Wzdczr4HLK3JAXOQI1PqLrZBPjNkqRxiegEgvGNMAxDQr2DeHkaRY
         CDXBPKudZWbahPBVAKYePmGZ+Y6crCld/bNFqD+EX5NZabQ+/erL+5JSgegQ0Luo0B
         QNOf5YeP5LKHjUwuEly6Ylcsyz6HUNVn3D4MeC/iNCFmcuRm9blLgA/yV/ifhAPQt2
         t2t732wGui1EZ/gKSaoVlPM4n7QW6OHbZbUsIxpf6WLn51ha8jwbNjPmbLWvThGPZe
         wrTpwREuWpV5X/2eTaCv2/lKNBuXXM0KY8N99wUYaDbJS8xSeuHIUJzuvrOKzAm2oM
         GsDtqA5sOfg6g==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 016353AED;
        Mon, 17 Sep 2018 09:18:20 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 17 Sep 2018 09:18:20 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 17 Sep 2018 18:18:18 +0200
Received: from [10.0.2.15] (10.107.19.14) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 17 Sep
 2018 18:18:18 +0200
Subject: Re: [PATCH 0/2] add Ethernet driver support for mt2712
To:     Andrew Lunn <andrew@lunn.ch>, Biao Huang <biao.huang@mediatek.com>,
        <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>,
        <Jose.Abreu@synopsys.com>
References: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
 <20180917152441.GD5458@lunn.ch>
CC:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <sean.wang@mediatek.com>, <nelson.chang@mediatek.com>,
        <matthias.bgg@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
From:   Jose Abreu <Jose.Abreu@synopsys.com>
Message-ID: <a8c0a091-6bee-6504-04cd-36e214e805aa@synopsys.com>
Date:   Mon, 17 Sep 2018 17:18:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180917152441.GD5458@lunn.ch>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.14]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Biao,

On 17-09-2018 16:24, Andrew Lunn wrote:
> On Mon, Sep 17, 2018 at 02:29:21PM +0800, Biao Huang wrote:
>
> Adding in the STMMAC driver maintainers.
>
>> Ethernet in mt2712 is totally different from that in
>> drivers/net/ethernet/mediatek/*, so we add new folder for mt2712 SoC.
>>
>> The mt2712 Ethernet IP is from Synopsys, and we notice that there is a
>> reference driver in drivers/net/ethernet/synopsys/*. But
>> 1. our version is only for 10/100/1000Mbps, not for 2.5/4/5Gbps.
>> mt2712 Ethernet design is differnet from that in synopsys folder in many
>> aspects, and some key features are not included in mt2712, such as rss
>> and split header. At the same time, some features we need have not been
>> implenmented in synopsys folder.
> In general, we don't have two very similar drivers. We try to have one
> driver. If the problem was just missing features in the stmmac driver,
> you can add them. I doubt not supporting 2.5/4/5Gbps in your silicon
> is an issue, since very few STMMAC devices have this. By split header,
> do you mean support for TSO? That seems to be a gmac4 or newer
> feature, but the driver supports not having tso support in hardware.
>
> Giuseppe, Alexandre, Jose: Please can you look at the proposed driver
> and see how much it really differs from the STMMAC driver. 

Thanks for the cc Andrew, indeed this looks very similar and the
register bank matches, by what I've seen, GMAC 4+.

> How easy
> would it be to extend stmmac it to support the mt2712?

Very easy, as I've just done with XGMAC2. If Biao wants to expand
stmmac functionality I'm all in favor!

Thanks and Best Regards,
Jose Miguel Abreu

>
> Thanks
> 	Andrew

