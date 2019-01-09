Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4319DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA5C206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="X7eNtg/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfAIOME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:12:04 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15991 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbfAIOMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:12:03 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3601260000>; Wed, 09 Jan 2019 06:11:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Jan 2019 06:12:02 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Jan 2019 06:12:02 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 9 Jan
 2019 14:12:00 +0000
Subject: Re: [alsa-devel] [PATCH v1 3/3] ASoC: soc-core: fix platform name vs.
 of_node assignement
To:     Mark Brown <broonie@kernel.org>
CC:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-tegra@vger.kernel.org>, Matthias Reichl <hias@horus.com>,
        <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel@ziswiler.com>
References: <e25a7463-9ce0-d7f9-e77b-2bbaab2e0b25@nvidia.com>
 <20181021112301.GC8554@sirena.org.uk>
 <20181218174040.k7u26vnnoplllnwb@camel2.lan>
 <952471da-b355-6471-6c19-5120d6704f81@nvidia.com>
 <87lg3vuc7p.wl-kuninori.morimoto.gx@renesas.com>
 <b5164c93-8be8-1c3d-9415-c895da6ad622@nvidia.com>
 <d1e41ed2-da7c-b46c-bc6d-64cf3e536771@nvidia.com>
 <865d2a3e-bf6b-1f30-1179-7e922c0d0641@nvidia.com>
 <87k1je38w7.wl-kuninori.morimoto.gx@renesas.com>
 <0660a471-3698-2059-4494-ad146518a4ed@nvidia.com>
 <20190109125340.GD10405@sirena.org.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <52f5f2cf-9260-f9c5-f73d-3c3d5debc86b@nvidia.com>
Date:   Wed, 9 Jan 2019 14:11:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109125340.GD10405@sirena.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547043110; bh=zsySDOXZegvri66REc8I2oTN8V4qOblcG4iumMoQxpY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=X7eNtg/4t6wwYonKSGXrMvHNVy7LCUYBM/FL8AlqZ/SB53Zx6DzIQ2P49kBMSFVas
         B/GGra8MMwOATb6mtaYJ/E/9PO5bPM696ufFe2T13ih2/1TQfPoTXyIIB2TeVIcTSi
         Qsi6L4IQnxicPjSlQ2Xji8I9HHGXDljdqBWGy7K+KogVGqUf5EukumcjNzgM5XOyOe
         fFdmuF7PWVwdDzmKUuc3x12AQ78C3wWqlr6z9W1y6DMflu8fQBetwkKMiMPY3MeVBg
         QNRsbuV2ISa3tOZC4gkhMxhNk2A6WXez2WpxmEi0qPPHzM00V6fgOzruxFwlpYK0Lc
         zdlWkvgY56bkw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/01/2019 12:53, Mark Brown wrote:

...

>> Yes that is an alternative and I can convert all the Tegra machine
>> drivers to use this now. However, that will not solve the problem for
>> non-Tegra devices and everyone will have to do this.
> 
> We're going to have to go through another round of conversions that
> touch everything at some point no matter what :/

Do you have a preference here? Do you think that we can fix-up the
soc-core or should I go ahead and migrate the Tegra machine driver to
workaround this issue now?

Cheers
Jon

-- 
nvpublic
