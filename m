Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ECDC4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D333920989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMC/i7Tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D333920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbeKTWIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:08:32 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39508 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbeKTWIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:08:32 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so1627244edt.6;
        Tue, 20 Nov 2018 03:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K9SkrxLCu8b8jI9l3LbnByruUDtxn3AoInCSQqssVaA=;
        b=dMC/i7Tmp7wpNWSPcQeJfCmkXEnMWbIH9bLSKiy1mI2zY+0++kgNWBhYgbrIo8snli
         V28a0BSR7VGDYAg1Z3cvSVWpdz4vlaM5p6TX0zlS2ejBUZW+FGFhWcgAVfOSGVacEZxW
         whfVC04+FF2egM7D+znqpSYjCB7xRy9CV98VSFZIvaGQV90w7ryAHd5SA4uAPCh5rR/D
         rp7IOaEt9xTMUOYX9L/Kc1o3HqOYQgQ13HFZ8mvZD6gFGHzkEXBSae2iV9snpXujGwgu
         iPOf2ojuG2VUbOFDUWS3lVqWPiztrqEpaR4DP80UBwFohfWDzdGKG04ecrRWszD5SaE5
         HRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=K9SkrxLCu8b8jI9l3LbnByruUDtxn3AoInCSQqssVaA=;
        b=IZa/5zkS8wl1Rx+UtpU2/uOTjy0W/yfff27k5kg9z6+6R0t2zPwMaA5kbiKwW+XMuC
         iZAvwhAY1umvJxJbrkZiuDq5l+8QgDtWLfFThnfjh+/I9aOANU0TDZ2PDJXSg089reUG
         nSuhcQGdLwBTGVko5X9dWLkbbIUq1MSy5x/LHYFsYwNfUQPVPR5WJrxhKvRSUDx1K5zh
         CCEmechTBGhbmP/GtvjHFSIZTpcW30MG3ctcgKTPW9yLkpsxWdECoKtZanWP2pYOmYQd
         Q5vcnw2JoFgLFFIgZp6nep6NIOG/eKbpCXbL8nvF7WuaiLzdRDToYl15B1jaPte9JSow
         MkoQ==
X-Gm-Message-State: AGRZ1gK6AAblMG++JDQjyi3uaJbx3R1Y9dD6QsKfTU40CaweCqtVEA/i
        bPLia13a+44SOaNiX3qPHIM=
X-Google-Smtp-Source: AJdET5eOVqbW9V7urFv3JBrz0M835wzBf5vekAO8t+L2y+mFEhOfQpTKT/iWuK3UvGXWYCanWqfuaA==
X-Received: by 2002:a17:906:118c:: with SMTP id n12-v6mr1686212eja.199.1542713986455;
        Tue, 20 Nov 2018 03:39:46 -0800 (PST)
Received: from ziggy.stardust ([37.223.147.230])
        by smtp.gmail.com with ESMTPSA id n29sm8716203edd.40.2018.11.20.03.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 03:39:45 -0800 (PST)
Subject: Re: Aw: Re: Re: [PATCH v5 05/12] drm: mediatek
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     CK Hu <ck.hu@mediatek.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, sean.wang@kernel.org,
        Matthias Brugger <mbrugger@suse.com>, airlied@linux.ie,
        mturquette@baylibre.com, sean.wang@mediatek.com,
        sboyd@codeaurora.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, wens@csie.org, robh+dt@kernel.org,
        rdunlap@infradead.org, laurent.pinchart@ideasonboard.com,
        p.zabel@pengutronix.de, matthias.bgg@kernel.org,
        ulrich.hecht+renesas@gmail.com, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-6-matthias.bgg@kernel.org>
 <1542605939.32082.12.camel@mtksdaap41>
 <0a02edf9-78da-dde9-4b69-38c4719b711b@gmail.com>
 <1542686700.9073.15.camel@mtksdaap41> <1542686982.26483.1.camel@mtksdaap41>
 <trinity-8f0fde8e-5ef3-4272-b009-49e180c934eb-1542702383860@3c-app-gmx-bs39>
 <1192d203-fcd1-47b0-00bc-9d513e5ffc3e@gmail.com>
 <trinity-cbebb6c8-0084-49a7-b07a-8ea3dbd13e6e-1542710054258@3c-app-gmx-bs39>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <4745c3ab-e6af-309e-d1c4-f07d937fb9af@gmail.com>
Date:   Tue, 20 Nov 2018 12:39:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <trinity-cbebb6c8-0084-49a7-b07a-8ea3dbd13e6e-1542710054258@3c-app-gmx-bs39>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/11/2018 11:34, Frank Wunderlich wrote:
> right this branch based on rc1 with some other commits, but v5-patches are applied on Oct 3rd (listed in Oct 5th)
> 
> frank@frank-N56VZ:/media/data_ext/bpi-r2-kernel/github
> [11:29:10]$ git checkout 4.19-hdmiv5
> Already on '4.19-hdmiv5'
> Your branch is up to date with 'origin/4.19-hdmiv5'.
> frank@frank-N56VZ:/media/data_ext/bpi-r2-kernel/github
> [11:29:13]$ make kernelversion
> 4.19.0-rc1
> frank@frank-N56VZ:/media/data_ext/bpi-r2-kernel/github
> [11:29:19]$ git log --oneline
> ...
> fc14b8c515de drm/mediatek: add a error return value when clock driver has been prepared
> 0dc856306aaf drm/mediatek: implement connection from BLS to DPI0
> 3d0a6749bfe3 drm/mediatek: add hdmi driver for MT2701 and MT7623
> b03e1b353b28 drm/mediatek: add support for SPDIF audio in HDMI
> c5564966272e drm/mediatek: separate hdmi phy to different file
> dee3954828db drm/mediatek: add dpi driver for mt2701 and mt7623
> a838ae8b415c drm/mediatek: convert dpi driver to use drm_of_find_panel_or_bridge
> f7f9f7c080ae drm/mediatek: add clock factor for different IC
> be1a5447330f drm/mediatek: adjust EDGE to match clock and data
> fec4504ea318 drm/mediatek: move hardware register to node data
> db992e429b9c drm/mediatek: add refcount for DPI power on/off
> ...

This patches are not part of this patch series.

> 
> compared with 4.19.0-release there is merge https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/mediatek?id=53b3b6bbfde6aae8d1ededc86ad4e0e1e00eb5f8 which seems to break v5-patches
> 
>> Gesendet: Dienstag, 20. November 2018 um 11:14 Uhr
>> Von: "Matthias Brugger" <matthias.bgg@gmail.com>
>> An: "Frank Wunderlich" <frank-w@public-files.de>, "CK Hu" <ck.hu@mediatek.com>
>> Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, sean.wang@kernel.org, "Matthias Brugger" <mbrugger@suse.com>, airlied@linux.ie, mturquette@baylibre.com, sean.wang@mediatek.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, wens@csie.org, robh+dt@kernel.org, rdunlap@infradead.org, laurent.pinchart@ideasonboard.com, p.zabel@pengutronix.de, matthias.bgg@kernel.org, ulrich.hecht+renesas@gmail.com, linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
>> Betreff: Re: Aw: Re: [PATCH v5 05/12] drm: mediatek
>>
>>
>>
>> On 20/11/2018 09:26, Frank Wunderlich wrote:
>>> Hi,
>>>
>>> i got v5-patches working on bpi-r2 (mt7623) with a Patch from Ryder.lee and 2 from Bibby Hsieh on 4.19-rc1
>>>
>>> https://github.com/frank-w/BPI-R2-4.14/commits/4.19-hdmiv5
>>>
>>
>> I don't see the patches applied to this tree. Apart from that this tree has a
>> lot of other patches applied. It differs greatly from mainline, so nothing we
>> should discuss on this mailinglist.
>>
>> Regards,
>> Matthias
>>
>>> but after i tried to include them on 4.19.2, i got a strange behaviour (stretched and pink font instead of white/grey)
>>>
>>> see here for detailed info:
>>>
>>> http://forum.banana-pi.org/t/kernel-4-19-rc1-for-testers/6618/75
>>>
>>> there are some patches between rc1 and final which i tried to revert, but no luck till now (cannot revert, no effect on the issue or no output). Had informed Bibby Hsieh...
>>>
>>> is there any idea, why this happen?
>>>
>>> regards Frank
>>>
>>
