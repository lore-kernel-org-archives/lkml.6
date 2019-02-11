Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46B8C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBBE222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zhxmb9W8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbfBKOut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:50:49 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:28451 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388141AbfBKOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:50:43 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190211145040epoutp01cb2fdb26b5d86ddf664b739d4298e78a~CVshOO5183058330583epoutp01j;
        Mon, 11 Feb 2019 14:50:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190211145040epoutp01cb2fdb26b5d86ddf664b739d4298e78a~CVshOO5183058330583epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549896640;
        bh=lCUBxf+sw5OaWmcViSftf4XY/FxUPP4DRgL1KIGv0SU=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=Zhxmb9W8I4GUti3rLZmuLIPvajSnPLDbFZWAd0iGxHv/sHMu6gv9q+w8aPDLvmpTM
         uteo6epzTBlgRsareOOdiOKyWUpxwHcLDQbvAm88sFxyuz6XgMhE4sU9yAp82yrhCm
         LCzPjqckBd/wXiKjEoJShkxM9iK0ZJaJIi3Zy9+s=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190211145038epcas2p46f14df2efe27798dd37dd11a247f5276~CVsf8Fyyd0462904629epcas2p4U;
        Mon, 11 Feb 2019 14:50:38 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.51.04136.EBB816C5; Mon, 11 Feb 2019 23:50:38 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190211145038epcas2p13b213f613cba275c4810625c5b276924~CVsfiQwfI2776427764epcas2p1B;
        Mon, 11 Feb 2019 14:50:38 +0000 (GMT)
X-AuditID: b6c32a46-2bfff70000001028-bc-5c618bbe7c57
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id AF.62.03689.EBB816C5; Mon, 11 Feb
        2019 23:50:38 +0900 (KST)
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMR002Y3NWA4370@mmp2.samsung.com>; Mon, 11 Feb 2019 23:50:38 +0900 (KST)
Subject: Re: [PATCH 06/22] ASoC: samsung: i2s: Restore support for the
 secondary PCM
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <0d5c9877-ab82-9d80-5336-6324e111c32c@samsung.com>
Date:   Mon, 11 Feb 2019 15:50:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <CAJKOXPfTZ1EGUpL_Zg20iWYJFkoCvEhoQSM=f92N-NJwo1LsNg@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZdljTTHdfd2KMwad5mhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLiyu+MDlwemz43MTmsXPWXXaPTas6
        2Tz6tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoErY2LLZeaCVWwVH5ZtYmlgvMLSxcjJISFgIvFq
        3zamLkYuDiGBHYwSZ8+fZINwvjNK/Dq7EcjhAKv6MEECIr6BUWJmcz9U0X1Gib2z7rKCFAkL
        hEnsaQoDmSoioClx/e93VpAaZoEzTBI3ei4xgiTYBAwleo/2gdm8AnYSu2bOArNZBFQl3k26
        wAxiiwpESBzufQdVIyjxY/I9sFM5BYIlpu96DRZnBlrw4sskFghbXOLY/ZtQcXmJzWveMkO8
        9phNYv7LCgjbReLOo1nsELa0xLNVGxkh7GqJXdu7mUEOlRDoYJRoubAdqtla4vDxi6wQQ/kk
        Og7/ZYeEBK9ER5sQRImHxPqZ8xghAdHCJLHqYSf7BEaZWUjunoXk1llIbp2F5NYFjCyrGMVS
        C4pz01OLjQqM9IoTc4tL89L1kvNzNzGCE4eW2w7GJed8DjEKcDAq8fAq5CbGCLEmlhVX5h5i
        lOBgVhLhdWgDCvGmJFZWpRblxxeV5qQWH2KU5mBREud9KD03WkggPbEkNTs1tSC1CCbLxMEp
        1cC4bcac3dIqzjt+sKX8yG3ZlGY8pc2PO/vVpCNP2I+5LN35c82Zc1P2vPuZaWIiGtMwZwLH
        vRtbMh9cP9Z7XPLv9IYvUp8DWS7tWuCt0yjGmZAp0HdIr25PsY5dxIWV8qXtN1a0qT5V60yz
        eyet2c08uePANQcpGW9BzfSV0w1/ZHJ9nLPio+1zJZbijERDLeai4kQAwn9LJRgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t9jQd193YkxBtPn81hcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktLq74wuTA6bHhcxObx85Zd9k9Nq3q
        ZPPo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujIktl5kLVrFVfFi2iaWB8QpLFyMHh4SAicSH
        CRJdjFwcQgLrGCVad/eyQTgPGSVmvFnHCFIkLBAmsacprIuRk0NEQFPi+t/vrCA1zAJnmCRe
        rXnODtHQxiTxsGEWM0gVm4ChRO/RPkYQm1fATmLXzFlgNouAqsS7SRfAakQFIiQ+Pt3HBFEj
        KPFj8j0WEJtTIFji39X/YIuZBdQlpkzJBQkzC4hLHLt/kxHClpfYvOYt8wRGgVlIumchdMxC
        0jELSccCRpZVjJKpBcW56bnFRgVGeanlesWJucWleel6yfm5mxiBcbHtsFb/DsbHS+IPMQpw
        MCrx8CrkJsYIsSaWFVfmHmKU4GBWEuF1aAMK8aYkVlalFuXHF5XmpBYfYpTmYFES5+XPPxYp
        JJCeWJKanZpakFoEk2Xi4JRqYNQXfMLaeErJlXt5+KJjS68+cRINP1LVlNe5ubLmTqW7w8Yf
        d/a/c1fa8cv2mqZWRtv82lMHllw4w2H8/turQy0iN95ZWKxKNFsrmJNme7ZKINh7xcp+poKp
        DkbvKv2ezPOInLloT7rCy2LjnxKMWUkfGZz+Vi7akmnUGXBxyroVr3JVF+zNzFFiKc5INNRi
        LipOBACwfuimhwIAAA==
X-CMS-MailID: 20190211145038epcas2p13b213f613cba275c4810625c5b276924
CMS-TYPE: 102P
X-CMS-RootMailID: 20190207170105epcas1p3d4a1da9ae268f8e95b32fb499e5a1dad
References: <CGME20190207170105epcas1p3d4a1da9ae268f8e95b32fb499e5a1dad@epcas1p3.samsung.com>
        <20190207170028.720-1-s.nawrocki@samsung.com>
        <20190207170028.720-7-s.nawrocki@samsung.com>
        <CAJKOXPfTZ1EGUpL_Zg20iWYJFkoCvEhoQSM=f92N-NJwo1LsNg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 14:41, Krzysztof Kozlowski wrote:
>> @@ -1469,12 +1506,16 @@ static int samsung_i2s_remove(struct platform_device *pdev)
>>         struct samsung_i2s_priv *priv = dev_get_drvdata(&pdev->dev);
>>         struct i2s_dai *pri_dai = samsung_i2s_get_pri_dai(&pdev->dev);
>>
>> +       if (!priv)

> This is not obvious. Maybe comment that it is secondary device remove()?

Sure, I will a comment here, I was considering it earlier but somehow it got missed.

>> @@ -1573,6 +1614,9 @@ static const struct platform_device_id samsung_i2s_driver_ids[] = {
>>                 .name           = "samsung-i2s",
>>                 .driver_data    = (kernel_ulong_t)&i2sv3_dai_type,
>>         },
>> +       {

> Nit - squash with previous line.

Will change it.


-- 
Thanks,
Sylwester
