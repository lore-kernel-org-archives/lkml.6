Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AA5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B202063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAWJuuy+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbfAHTnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:43:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36994 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731824AbfAHTnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:43:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so5301434wrt.4;
        Tue, 08 Jan 2019 11:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NGhmqtwpW09+58wJoPUk4sUkN4/4hC9lANeaIGoHhmw=;
        b=BAWJuuy+VMMMxDyiA6bZBotyYFndDRzKQSl/+/Zl3HAu3xjVGBG7ePayiV55wVrQ6W
         kof7CFd+cb/r8BuxV7Uj0aJFGhCUg9LaYWKyp+OmJ/YtP3OrdWCLGKBohEaTJmSdJPo6
         FSNcmzCSORVE9g89xgTMzCWoD9FX+aJxL2m+POTCjIBzfz7sJsBB9NpndA5yaSfACCaA
         +Yz6BVJr5jwv8Ld9SqS9ED7ZMaEDtAaKJR+Li7RNeUSMyXqjYqZV/dbyl30gYF/wgirn
         BuNwqd2ur7LUUX4r0n9ZLtIcNsUjJ8ziJcOft0jAwbs3izjlkvBw6MqiCqLglYVoxqcL
         ov5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NGhmqtwpW09+58wJoPUk4sUkN4/4hC9lANeaIGoHhmw=;
        b=fZg0iZUis3PeJE9iUvW77Ef0aHFGCFyKbLGJBs2Imw/od343qe5BJnQYiWOAecqova
         pss/V5RkO7Aqc4g7tlkSjMcS66+reRxjo/5ZOIhu3pkHlZ0O+O48aAWllSNmIhiQqmiU
         8fQOFWz095uuDhTfaOyzQH380jzEkBrT0haKCAL3AEGuqMprRnV5A5AXgiwtFMcOqVCI
         aXhCxcU6dI9dtpJE8JBW6RtJORGSWlxZ3FknftDYxpdfW3RVIhvMNenapRX88cWEHyeK
         NI9RJWmR52x8RgcV29vmlkVNDVq5OgVceBbPapDe6HQVnOtNuancfXIRtIbSWiI406U1
         YpKQ==
X-Gm-Message-State: AJcUukfVLI8OryKTJRKt1M1MrktPwhMt6WiVfyBud7fALB4F6HiCftEY
        0C+X67wwgcOjaBWODzb9onPm/u3F
X-Google-Smtp-Source: ALg8bN4ko+R3ZR1sJxtv68ES5ZQ+eMFiSrQvreP1TJLCvt5Tuag+caHf4y6qbkkcGauQKP1cNGBGlg==
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr2295302wru.316.1546976580875;
        Tue, 08 Jan 2019 11:43:00 -0800 (PST)
Received: from ?IPv6:2003:ea:8be2:e400:50e8:fa09:6b66:e3da? (p200300EA8BE2E40050E8FA096B66E3DA.dip0.t-ipconnect.de. [2003:ea:8be2:e400:50e8:fa09:6b66:e3da])
        by smtp.googlemail.com with ESMTPSA id g9sm10429472wmg.44.2019.01.08.11.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:43:00 -0800 (PST)
Subject: Re: [PATCH] net: ethernet: mediatek: fix warning in phy_start_aneg
To:     Sean Wang <sean.wang@kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>
Cc:     Felix Fietkau <nbd@openwrt.org>, John Crispin <john@phrozen.org>,
        Nelson Chang <nelson.chang@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190108160526.18928-1-frank-w@public-files.de>
 <7acce775-4ab7-c867-c801-25ee004f6b38@gmail.com>
 <trinity-4ceb1d55-424f-46b8-b8e7-989770b249a2-1546974413848@3c-app-gmx-bs35>
 <CAGp9LzrUK=QWJsDwiTVG7vD7v8=jFp6bAm9ZiOh3c2dQk029uA@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <8f58fd47-f7ff-399d-4c20-76fe4d72ba9a@gmail.com>
Date:   Tue, 8 Jan 2019 20:42:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGp9LzrUK=QWJsDwiTVG7vD7v8=jFp6bAm9ZiOh3c2dQk029uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.01.2019 20:29, Sean Wang wrote:
> On Tue, Jan 8, 2019 at 11:07 AM Frank Wunderlich
> <frank-w@public-files.de> wrote:
>>
>>
>>> In mtk_phy_connect() I would say this complete block can be removed.
>>> All this is handled internally by phylib.
>>>
>>>       dev->phydev->autoneg = AUTONEG_ENABLE;
>>>       dev->phydev->speed = 0;
>>>       dev->phydev->duplex = 0;
>>>
>>>       phy_set_max_speed(dev->phydev, SPEED_1000);
>>>       phy_support_asym_pause(dev->phydev);
>>>       linkmode_copy(dev->phydev->advertising, dev->phydev->supported);
>>>       linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
>>>                        dev->phydev->advertising);
>>>       phy_start_aneg(dev->phydev);
>>>
>>> Could you please test this?
>>
>> seems to work well, no warning in dmesg
>>
>> traffic 940Mbit sending, 900 receive
>>
> 
> The change to phy initialized valve determined by phylib looks good to
> me and simplify the mac driver a lot. You could have it in v2.
> 
>>> And a further proposal:
>>> Instead of the open-coded dev_info() in mtk_phy_connect_node()
>>> you could use phy_attached_info().
>>
>> have not tried this yet...because it's only an info-message and needs different parameters...have to look how i can convert it
> 
> I think it can be done in a separate patch
> 
>>
>>> Calling phy_start() in the ndo_open callback is fine, you can leave
>>> it there.
>>
>> have it re-added
>>
>> pushed to my repo: https://github.com/frank-w/BPI-R2-4.14/commits/5.0-rc
>>
>> regards Frank
> 
When talking about improvements: Also this

if (dev->phydev->link)
		netif_carrier_on(dev);
	else
		netif_carrier_off(dev);

in mtk_phy_link_adjust() isn't needed. It's done by phy_link_change() in phylib.
