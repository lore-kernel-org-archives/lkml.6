Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BD0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8E12175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h4zeheek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfBFKLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:11:13 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:29630 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfBFKLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:11:13 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190206101109epoutp03efeab2665fe633891f32d2d88387fb45~AvqCx-5op1312913129epoutp03_;
        Wed,  6 Feb 2019 10:11:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190206101109epoutp03efeab2665fe633891f32d2d88387fb45~AvqCx-5op1312913129epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549447869;
        bh=l4PwiBMxIrie1Cq1bShiur3WqOctNu7Eowvhgerw9LQ=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=h4zeheekk7+seeqnqmuYjFfl3JZswl2gBCgN8HOuA8t+P5QUR1oDHrdd4q64c7Hwq
         gTSpZla5osx1lkjY7vbXGtw/ZOfC6TlAsOHyv7rjAytBHMwtXjSe09yom697ywNuaI
         8sB874xSL96ZUuIMZBnjLOgjdsTsABuhF9M+xi0k=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190206101108epcas1p113f50fb5cb6d4e437abd0220e2727f36~AvqChhIAy2808728087epcas1p1h;
        Wed,  6 Feb 2019 10:11:08 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.7C.04074.CB2BA5C5; Wed,  6 Feb 2019 19:11:08 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190206101108epcas1p3bd1f069716d666e10b2019692cb97df0~AvqB9n4J-2500225002epcas1p32;
        Wed,  6 Feb 2019 10:11:08 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-97-5c5ab2bcb889
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id F9.69.04015.CB2BA5C5; Wed,  6 Feb
        2019 19:11:08 +0900 (KST)
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMI00IMY1MF0PB0@mmp2.samsung.com>; Wed, 06 Feb 2019 19:11:08 +0900 (KST)
Subject: Re: [BUG BISECT] NULL pointer after commit
 "ASoC: dapm: Only power up active channels from a DAI"
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <5f4f2221-f11f-98c8-fadc-e713f4623246@samsung.com>
Date:   Wed, 06 Feb 2019 11:11:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <844c3f34-f7db-6b26-169a-994922367c78@samsung.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7bCmru6eTVExBvPumVhcuXiIyWLqwyds
        FldaNzFanD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWnbv6WS02fF/L6MDlseFzE5vHzll3
        2T02repk85g+5z+jx763y9g8+rasYvRYv+Uqi8fnTXIBHFFcNimpOZllqUX6dglcGY8XaRQs
        Eqy4dLeVuYHxDm8XIyeHhICJxM/tL1lAbCGBHYwSS9bzdTFyAdnfGSVO3/wClOAAK3pyNAgi
        voFRomflL3YI5z6jxKNV/WDdwgI5EsenXACzRQQyJA4c+csKUsQs8IdR4vXRRcwgCTYBQ4ne
        o32MIDavgJ3EmtMTmEBsFgFViU1LZ7CC2KICERKHe99B1QhK/Jh8D2wop4C9xP32u+wgNrOA
        psSLL5NYIGxxiWP3bzJC2PISm9e8ZQZZLCHwn01i/rKz7BB/uki8vbOTDeIdaYlLR20hwtUS
        u7Z3Q9V3MEq0XNjODJGwljh8/CIrxFA+iXdfe1ghenklOtqEIEo8JPoWt7FAQmIbo8S/51tZ
        JjDKzEJy9ywkt85CcussJLcuYGRZxSiWWlCcm55abFhgqFecmFtcmpeul5yfu4kRnF60THcw
        Tjnnc4hRgINRiYdXozsyRog1say4MvcQowQHs5IIr/mMqBgh3pTEyqrUovz4otKc1OJDjNIc
        LErivOsdnGOEBNITS1KzU1MLUotgskwcnFINjKdVti/cH+Omn/55vthZFwPtM3VaD8Jnb09N
        Wearus1CWrtLI1Jv0sckA8bsb2al8f4zfqmsTTone8nDb/a7loP1q9OfJgUdmqM64/x5Fi1/
        d++HDKrnr19eEd/g+27zWx+naYc2vfujdTX/zCTRBddaT/YKMLfN9u2b9uvqW511k0Q3Z3LY
        8iixFGckGmoxFxUnAgBr3fmyKwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e+xoO6eTVExBs8u81pcuXiIyWLqwyds
        FldaNzFanD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWnbv6WS02fF/L6MDlseFzE5vHzll3
        2T02repk85g+5z+jx763y9g8+rasYvRYv+Uqi8fnTXIBHFFcNimpOZllqUX6dglcGY8XaRQs
        Eqy4dLeVuYHxDm8XIweHhICJxJOjQV2MXBxCAusYJRZff80E4TxklPi1+SVLFyMnh7BAjsTx
        KRfAbBGBDIlH16+BFTEL/GGUaFvXxgLRsYNRYtnETawgVWwChhK9R/sYQWxeATuJNacnMIHY
        LAKqEpuWzgCrERWIkPj4dB8TRI2gxI/J98A2cArYS9xvv8sOch6zgLrElCm5IGFmAXGJY/dv
        MkLY8hKb17xlnsAoMAtJ9yyEjllIOmYh6VjAyLKKUTK1oDg3PbfYqMAwL7Vcrzgxt7g0L10v
        OT93EyMwfrYd1urbwXh/SfwhRgEORiUe3gsdkTFCrIllxZW5hxglOJiVRHjNZ0TFCPGmJFZW
        pRblxxeV5qQWH2KU5mBREue9nXcsUkggPbEkNTs1tSC1CCbLxMEp1cDoXLPMIODggwknNx29
        PWmNv+7ta2cMrC3T9yxb3WIVxGBnWbjHRCd655bEqUzTu77MuFN/dccOxmsLOx8dO6NueTIr
        k7nyihHLpRdTQ5den3F42qpN1xt6Xh3Y6bRYaE/PgaCnHNUF9w+nLOSr2Mlt3SMn+IBP++bj
        O+r7TTXPlyS1K06VXCPYo8RSnJFoqMVcVJwIABlUvQSbAgAA
X-CMS-MailID: 20190206101108epcas1p3bd1f069716d666e10b2019692cb97df0
CMS-TYPE: 101P
X-CMS-RootMailID: 20190205211638epcas3p409823d4acac8073473153d745151ea5f
References: <CGME20190205211638epcas3p409823d4acac8073473153d745151ea5f@epcas3p4.samsung.com>
        <20190205211622.GA5891@kozik-lap>
        <844c3f34-f7db-6b26-169a-994922367c78@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/19 10:46, Sylwester Nawrocki wrote:
> On 2/5/19 22:16, Krzysztof Kozlowski wrote:
>> Bisect pointed to commit:
>>     commit 078a85f2806f0ffd11289009462a6a390f9adb5c
>>     Author: Charles Keepax <ckeepax@opensource.cirrus.com>
>>     Date:   Thu Jan 31 13:30:18 2019 +0000
>>         ASoC: dapm: Only power up active channels from a DAI
>>
>> as a bad commit for NULL pointer on my Odroid XU3 and Odroid U3 board when
>> doing "aplay /usr/share/sounds/alsa/Front_Right.wav".
>>
>> 1. Arch ARM Linux
>> 2. exynos_defconfig
>> 3. Odroid U3, XU3, Exynos SoC, ARMv7
>>
>> Last address is in calltrace:
>> c079552c
>> dapm_update_dai_unlocked
>> sound/soc/soc-dapm.c:2586
> 
> Thanks for bisecting this, I ran into same issue last night and I'm starting
> to debug this now. I have added some debug prints and it looks like it oopses
> on NULL playback_widget of the dummy DAI.
> 
> [   30.701182] hdmi-audio-codec hdmi-audio-codec.0.auto: Update DAI routes for i2s-hifi playback
> [   30.709630] dapm_update_dai_unlocked:2586 w=8bd27d28
> [   30.714403] dapm_update_dai_unlocked:2594 w=8bd27d28
> [   30.724688] max98090 5-0010: Update DAI routes for HiFi playback
> [   30.730163] dapm_update_dai_unlocked:2586 w=3fc942af
> [   30.735154] dapm_update_dai_unlocked:2594 w=3fc942af
> [   30.745051] snd-soc-dummy snd-soc-dummy: Update DAI routes for snd-soc-dummy-dai playback
> [   30.753128] dapm_update_dai_unlocked:2586 w=  (null)
> [   30.758114] Unable to handle kernel NULL pointer dereference at virtual address 0000007c

With a change as below there is no oops and everything works again,
but I'm not sure this is a proper fix.

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5b74dffc9c11..111a23a9708a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2580,6 +2580,9 @@ static int dapm_update_dai_unlocked(struct snd_pcm_substream *substream,
        else
                w = dai->capture_widget;
 
+       if (!w)
+               return 0;
+
        dev_dbg(dai->dev, "Update DAI routes for %s %s\n", dai->name,
                dir == SNDRV_PCM_STREAM_PLAYBACK ? "playback" : "capture");

-- 
Thanks,
Sylwester
