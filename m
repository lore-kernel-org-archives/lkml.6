Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179AFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D3520879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uZkhceZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfAJM6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:58:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35711 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfAJM6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:58:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so11287653wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 04:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Ghyg2fTNZ6AJK2z+KTbcv4WJQiMtAvnC4S83tmSQRP4=;
        b=uZkhceZfR2py7d6JlA3P0T64RdjXetk+fy7ZlrB/rXbQM1ZqBQslgfCLQDudjuyZIQ
         NzgwTpP32zvzf0WLV4rOKvjxVBOtNL/r90R2A8QMQq92fZCAMeRijpyu+xUh5Qfo4D0m
         SHtucDgiaiGLhMnmexlAvsHqfmORbsxOMsBu215v575BibZeuIIq8QDzZmZPjQ2XWfbn
         tvggYsbWc+98qiQ9alJ/h8qhSqxA2+ygUNcqFKYg24mb9BfoVPkkuNKO+KMjvGy5RK4F
         GK/LDtZozttRlbdiWmhw0swd1IngtGQdbKx/FJw2V9iEBsCwpvxiU9VR86Qc0NcEfDmY
         ViTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Ghyg2fTNZ6AJK2z+KTbcv4WJQiMtAvnC4S83tmSQRP4=;
        b=R9DRnFwIZMUpOn9EHQ1c39Ma51J5qgXCphmJIEYqUkaz2RoyGTeCwAUYGXrd6WEwIN
         Em0XyPVYnZYSQjXUL1ag4pRT9jwVd5kij8t/9MhhzCi3LPryqDtLoeh1+AcGTQzSHLb4
         HBHoxn4BdK732JdE70fL9ZvFRjBymZmX8pYAUIuVCzykuNv0NMDFcXe8QPeB1Lb9UZaN
         q2n6EWqBhFZ0FHlQkGDAmTwQl/0p2Q1uPidbW7IOq13qahRkpPMwRDDlPGd7haPhZ0+P
         Mp+T43GnC0jhDMVQpT05sf6Hx72tdDTytTGlFiwvSxPO7W2N12WVrC76I6lTs6YKvKuw
         7iGg==
X-Gm-Message-State: AJcUukdGyo5g5oextQpRnwHiwu9GoBTnMzzJQmY44ajEUPO8seS45ePk
        bTToK4PMB4Bo6O+sQuvLphl9Sw==
X-Google-Smtp-Source: ALg8bN7ZvUqgP30iZI3R3hJE7O5uNU4561ChgR0QgZwSUBjUeUDw23zKFoy1+ebR3rzZufclLCwtsA==
X-Received: by 2002:adf:a58a:: with SMTP id g10mr9030831wrc.3.1547125118267;
        Thu, 10 Jan 2019 04:58:38 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:f5ef])
        by smtp.gmail.com with ESMTPSA id v16sm49800567wrs.75.2019.01.10.04.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 04:58:37 -0800 (PST)
References: <1547042198-17601-1-git-send-email-lollivier@baylibre.com> <CACRpkdbhVB7-Y9EBhBC6GAxqFt8zujS2QJ4CzGDJnDMDjj2Ptg@mail.gmail.com> <CAFBinCBf+yJu4z1JYNdH7B4h07-U_0ckysV_=nC65nd5ByOCvA@mail.gmail.com>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Loys Ollivier <lollivier@baylibre.com>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2] arm64: dts: meson: Fix mmc cd-gpio polarity
In-reply-to: <CAFBinCBf+yJu4z1JYNdH7B4h07-U_0ckysV_=nC65nd5ByOCvA@mail.gmail.com>
Date:   Thu, 10 Jan 2019 13:58:35 +0100
Message-ID: <861s5ku0sk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed 09 Jan 2019 at 22:14, Martin Blumenstingl wrote:

> Hi,
>
> On Wed, Jan 9, 2019 at 7:31 PM Linus Walleij <linus.walleij@linaro.org> 
> wrote:
>>
>> Hi Ollivier!
>>
>> On Wed, Jan 9, 2019 at 2:56 PM Loys Ollivier <lollivier@baylibre.com> 
>> wrote:
>>
>> > Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
>> > changed the behavior of "cd-inverted" to follow the device tree bindings
>> > specification.
>> > Lines specifying "cd-inverted" are now "acitve high".
> there's a typo in the description - it should be "active"
>
Thanks I'll fix it.
>> >
>> > Fix the SD card for meson by setting the cd-gpio as "active low" 
>> > according
>> > to the boards specifications.
>> >
>> > Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
>> > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> >
>> > v2: fix more occurences, also in other meson boards.
>>
>> This is a good change in itself since it gets rid of some occasions
>> of the dreaded "cd-inverted" property. I think Martin Blumenstingl
>> already sent patches like these though (I might be confused).
> I sent patches for the 32-bit Amlogic SoCs
> my TODO-list is now a bit longer, I'll test this series on my Khadas
> VIM, VIM2 and Libretech CC during the weekend
>
I have seen Martin's patch for the arm boards.
This adresses arm64 boards.
Tested on libretech-cc.

>> But we should keep the old device trees working as well.
>> Can you test if Martins patch:
>> https://marc.info/?l=linux-mmc&m=154637189021211&w=2
>>
>> Also makes your boards work?
> feedback on that patch is appreciated
>
Answered to the patch mail directly. Tested on libretech-cc, it works.
Fixing the meson boards DT for future release would still be valid imho.

>
> Regards
> Martin

Best,
Loys
-- 
-L
