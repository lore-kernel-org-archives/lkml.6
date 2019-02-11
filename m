Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1DDC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7ECA21B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PhuySy3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391896AbfBKPTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:19:22 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:33851 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390295AbfBKPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:19:20 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190211151917epoutp011e7333ce9044e71226e941d17c440a65~CWFgoQYmR1693816938epoutp01x;
        Mon, 11 Feb 2019 15:19:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190211151917epoutp011e7333ce9044e71226e941d17c440a65~CWFgoQYmR1693816938epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549898357;
        bh=lhsSfWDkbo3lRbw+vm5ZEv9KCbhxn/LqM9Eh4262GgI=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=PhuySy3aCsUIbt1hJq5jmJMWR+B80KCwbqntl5Di/9x5BgvFxSNqFrfUz2RHdmZKk
         GPm+k1Lf+nGEdbax9/7Kvk4qX6u4thouRfVuZMKOSbtzLyi373r0hVRFvbVXYLaiaj
         kg82wK4KnpsVclKJOc1caHg/IfpKhIDfQ2uDrHCI=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190211151916epcas2p34a0b85901b9528e94dda4d2b06919f2b~CWFf7gK3R2385523855epcas2p3w;
        Mon, 11 Feb 2019 15:19:16 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.08.04093.472916C5; Tue, 12 Feb 2019 00:19:16 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190211151915epcas2p3e37d482f88b21b8d76c2eda3a5d397f3~CWFfQS1Gj1135511355epcas2p3T;
        Mon, 11 Feb 2019 15:19:15 +0000 (GMT)
X-AuditID: b6c32a48-18bff70000000ffd-0e-5c6192748ce6
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.92.03689.372916C5; Tue, 12 Feb 2019 00:19:15 +0900 (KST)
Received: from [106.116.147.40] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMR00A1TP7ZYIB0@mmp1.samsung.com>; Tue, 12 Feb 2019 00:19:15 +0900 (KST)
Subject: Re: [PATCH 17/22] ASoC: samsung: odroid: Add support for secondary
 CPU DAI
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <c60fb7b9-8847-7e68-2ef4-4dbbfb48e71a@samsung.com>
Date:   Mon, 11 Feb 2019 16:19:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <CAJKOXPehfWHW+Mj=xZ_N+LA7nLUnOvHAwqEmBECquzVSx1ppPQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZdljTVLdkUmKMwYoT6hZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLiyu+MDlwemz43MTmsXPWXXaPTas6
        2Tz6tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoErY/vcN4wF8zgrfl8/zNbAuJiti5GTQ0LAROJw
        xzcWEFtIYAejxIMv2V2MXED2d0aJ940HWWCKrjw9zQ6R2M0o0bRtDZRzn1Hi7Z1vYKOEBUIl
        Whc/YwWxRQQ0Ja7//c4KUsQscIZJ4kbPJUaQBJuAoUTv0T4wm1fATqJ9/kGgSRwcLAKqEh2r
        weaICkRIHO59B1UiKPFj8j2wKzgFgiXWzvgKNp8ZaP6LL5NYIGxxiWP3bzJC2PISm9e8ZQbZ
        KyFwn03i8POFTBAvuEhs/PuTEcKWlni2aiOUXS2xa3s3VEMHo0TLhe3MEAlricPHL0Jt45Po
        OPwX7FAJAV6JjjYhiBIPiRtNK1ggIdHKJNH7byb7BEaZWUgOn4Xk2FlIjp2F5NgFjCyrGMVS
        C4pz01OLjQpM9IoTc4tL89L1kvNzNzGCU4eWxw7GA+d8DjEKcDAq8fAq5CbGCLEmlhVX5h5i
        lOBgVhLhre0BCvGmJFZWpRblxxeV5qQWH2KU5mBREud9KD03WkggPbEkNTs1tSC1CCbLxMEp
        1cAYpSV9iE/0+ReVpGnBUjU+s5+eqHbtXZc5uenukfuVQYo9y7Zm3NuiNjmcXW4Nu2vQQhvT
        SVslC6eVNlieZdPaUanCY+XbxlP2ZfPjvpBEs28GDVETt9WI573vcV3z/5mWwcXzCosq5mhJ
        JsvzuwqoTPnDPnX378+dH5UbS+c+zcu4lPXA5bASS3FGoqEWc1FxIgBM+P43GQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t9jAd3iSYkxBtP6TS2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWF1d8YXLg9NjwuYnNY+esu+wem1Z1
        snn0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXxva5bxgL5nFW/L5+mK2BcTFbFyMnh4SAicSV
        p6fZuxi5OIQEdjJKPGmYwwzhPGSU2DLtKjtIlbBAqMT6OxOZQGwRAU2J63+/s4IUMQucYZJ4
        teY5VHs7k8TRPbsZQarYBAwleo/2gdm8AnYS7fMPAhVxcLAIqEp0rAZbLSoQIfHx6T4miBJB
        iR+T77GAlHAKBEvcnqEGYjILqEtMmZILUsEsIC5x7P5NRghbXmLzmrfMExgFZiFpnoXQMQtJ
        xywkHQsYWVYxSqYWFOem5xYbFRjlpZbrFSfmFpfmpesl5+duYgTGxbbDWv07GB8viT/EKMDB
        qMTDq5CbGCPEmlhWXJl7iFGCg1lJhLe2ByjEm5JYWZValB9fVJqTWnyIUZqDRUmclz//WKSQ
        QHpiSWp2ampBahFMlomDU6qBUaBROPXLl9U8O5e0CPdsnzKj2m+VjmF/fMaG3i/sC5g/SN5r
        expqby/eybhpk5PZ4eBCdm+NHPHrJrdPn1Hwibn+ep3SquYg84fCPgW+x/xZ94vvOHfSfN7v
        guPMDzo73jzMDTIz8dl+K/0rX963I6fYv4bMiDjayDXb3SHuh+FX/mqRpgAmJZbijERDLeai
        4kQAsb32bYcCAAA=
X-CMS-MailID: 20190211151915epcas2p3e37d482f88b21b8d76c2eda3a5d397f3
CMS-TYPE: 102P
X-CMS-RootMailID: 20190207170145epcas1p465da0715aa629b525c17d263c1b49a68
References: <CGME20190207170145epcas1p465da0715aa629b525c17d263c1b49a68@epcas1p4.samsung.com>
        <20190207170028.720-1-s.nawrocki@samsung.com>
        <20190207170028.720-18-s.nawrocki@samsung.com>
        <CAJKOXPehfWHW+Mj=xZ_N+LA7nLUnOvHAwqEmBECquzVSx1ppPQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 14:57, Krzysztof Kozlowski wrote:
>> static struct snd_soc_dai_link odroid_card_dais[] = {
>> +       {
>> +               /* Primary FE <-> BE link */
>> +               .codec_name = "snd-soc-dummy",
>> +               .codec_dai_name = "snd-soc-dummy-dai",
>> +               .ops = &odroid_card_fe_ops,
>> +               .name = "Primary",
>> +               .stream_name = "Primary",
>> +               .platform_name = "3830000.i2s",

> Why exposing address as platform_name? I think it is not used so how
> about some friendlier name?
 
This entry is for selecting "PCM" (DMA) component for the link. 
For proper matching we need to use names of devices for which
the dmaengine based PCM component is registered (with a call to
samsung_asoc_dma_platform_register()).

We can't use platform_of_node because 2 PCM components ("3830000.i2s", 
"samsung-i2s-sec") are now associated with same DT node.


>> +       }, {
>> +               /* BE <-> CODECs link */
>> +       }, {
>> +               /* Secondary FE <-> BE link */

>> +               .platform_name = "samsung-i2s-sec",

>> +       }
>>  };


--
Thanks, 
Sylwester
