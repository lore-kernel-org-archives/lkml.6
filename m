Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276B3ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54E3214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="efhpXrYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54E3214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbeIRVVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:21:09 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:56344 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbeIRVVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:21:08 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 118E910C12AE;
        Tue, 18 Sep 2018 08:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537285679; bh=6eG++huu2l18NqImreRiZ+CRBE+RaGU18qhaFSFpW7Q=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=efhpXrYiJiyWOCd1GAXdbyW/loT4ZdgaHx8tlQO2JiJrJ3YWxSK2m8gxVeq7FDzyt
         rBWpDg9vV9mhmhIz9p+DpV+5OCIHoubVjwH8EZP83vWIsQWOyV97EgKU6Mm9oECgS+
         G4OnaQ3R31bEp+5pc6/ZNJir6I0qpG7FFnyjWwPPLdvzvLWsjoHVb/26GENdkIC5FK
         uHKkPWyXZZkIKZPBQr3nm1/cMrm/Bc9VKTfPl+ExpPoN1DeVzbziXpRGmFz5OY6G9e
         Dpj/uNalashGATE4zMHciJzDm1p//0zO2EMabQFc2E7SK6Zwkfhy/jAo/UX+cAG+Cz
         bE1vep1O310+w==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id B36573A30;
        Tue, 18 Sep 2018 08:47:58 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 18 Sep 2018 08:47:56 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 18 Sep 2018 17:47:54 +0200
Received: from [10.0.2.15] (10.107.19.14) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 18 Sep
 2018 17:47:53 +0200
Subject: Re: [PATCH 0/2] add Ethernet driver support for mt2712
To:     biao huang <biao.huang@mediatek.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Andrew Lunn <andrew@lunn.ch>
References: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
 <20180917152441.GD5458@lunn.ch>
 <a8c0a091-6bee-6504-04cd-36e214e805aa@synopsys.com>
 <1537241087.7058.6.camel@mhfsdcap03>
CC:     <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>,
        <davem@davemloft.net>, <robh+dt@kernel.org>,
        <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <sean.wang@mediatek.com>, <nelson.chang@mediatek.com>,
        <matthias.bgg@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
From:   Jose Abreu <Jose.Abreu@synopsys.com>
Message-ID: <ff1ddad8-8f27-2e10-1b3e-09d17915779e@synopsys.com>
Date:   Tue, 18 Sep 2018 16:47:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1537241087.7058.6.camel@mhfsdcap03>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.14]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biao,

On 18-09-2018 04:24, biao huang wrote:
> Hi Jose, Andrew,
> 	Thanks for your comments.
> 	Synopsys ip version in mt2712 is 4.21a, and followed ic will use 5.10a.
> it seems GMAC4+ is a good choice. I'll try to  extend STMMAC to support
> mt2712.
> 	Any tips about extend STMMAC? or anythings I should pay attention to?

STMMAC already supports 4.21a and 5.10a. You only have to make
sure that your regbank and descriptors matches.

Thanks and Best Regards,
Jose Miguel Abreu

> 	
> On Mon, 2018-09-17 at 17:18 +0100, Jose Abreu wrote:
>> Hi Andrew, Biao,
>>
>> On 17-09-2018 16:24, Andrew Lunn wrote:
>>> On Mon, Sep 17, 2018 at 02:29:21PM +0800, Biao Huang wrote:
>>>
>>> Adding in the STMMAC driver maintainers.
>>>
>>>> Ethernet in mt2712 is totally different from that in
>>>> drivers/net/ethernet/mediatek/*, so we add new folder for mt2712 SoC.
>>>>
>>>> The mt2712 Ethernet IP is from Synopsys, and we notice that there is a
>>>> reference driver in drivers/net/ethernet/synopsys/*. But
>>>> 1. our version is only for 10/100/1000Mbps, not for 2.5/4/5Gbps.
>>>> mt2712 Ethernet design is differnet from that in synopsys folder in many
>>>> aspects, and some key features are not included in mt2712, such as rss
>>>> and split header. At the same time, some features we need have not been
>>>> implenmented in synopsys folder.
>>> In general, we don't have two very similar drivers. We try to have one
>>> driver. If the problem was just missing features in the stmmac driver,
>>> you can add them. I doubt not supporting 2.5/4/5Gbps in your silicon
>>> is an issue, since very few STMMAC devices have this. By split header,
>>> do you mean support for TSO? That seems to be a gmac4 or newer
>>> feature, but the driver supports not having tso support in hardware.
>>>
>>> Giuseppe, Alexandre, Jose: Please can you look at the proposed driver
>>> and see how much it really differs from the STMMAC driver. 
>> Thanks for the cc Andrew, indeed this looks very similar and the
>> register bank matches, by what I've seen, GMAC 4+.
>>
>>> How easy
>>> would it be to extend stmmac it to support the mt2712?
>> Very easy, as I've just done with XGMAC2. If Biao wants to expand
>> stmmac functionality I'm all in favor!
>>
>> Thanks and Best Regards,
>> Jose Miguel Abreu
>>
>>> Thanks
>>> 	Andrew
> Best Regards!
> Biao
>

