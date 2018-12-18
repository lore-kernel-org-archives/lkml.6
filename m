Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E8FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475D4218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bv9MlXRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbeLRNlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:41:10 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49540 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLRNlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:41:09 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181218134107euoutp015357d58724f2e0a170990acdfe3354b3~xcRGw57si1522915229euoutp01H
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:41:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181218134107euoutp015357d58724f2e0a170990acdfe3354b3~xcRGw57si1522915229euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545140468;
        bh=iyjckPEYyq+HvUcXDTCFjsJvM7TiJLZ4jxRj7wroLFo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bv9MlXRcEziyNw07hnLjUPn76TAujtVlx3xDwXF51OEoVit/xu+oNhGfVzQ6LRqb8
         jAx+TuRFWbxedJt+HUX/AgQ9wLCPylAJa0GeLxRmKGkkvKqiU+hk4s60ZANJ8e1n8w
         n/qfMTMOciR8H/ukoHvwvX0krhxkW2EH2j1WwZEY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181218134107eucas1p28ce1225336155da529f70e0664e78521~xcRF_hG6x1713017130eucas1p27;
        Tue, 18 Dec 2018 13:41:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 42.32.04806.2F8F81C5; Tue, 18
        Dec 2018 13:41:06 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181218134106eucas1p135cc5d59969b78032ce519c11bc908b3~xcRFOZtTc0569405694eucas1p1c;
        Tue, 18 Dec 2018 13:41:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181218134106eusmtrp1e41bc96e2543e841b6135207fedea238~xcRE-K0Ih1327813278eusmtrp1z;
        Tue, 18 Dec 2018 13:41:06 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-eb-5c18f8f217d5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8C.7E.04284.1F8F81C5; Tue, 18
        Dec 2018 13:41:05 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181218134105eusmtip263f90ff3afa6392bad83785b4053c94d~xcREfp4BI0563005630eusmtip2W;
        Tue, 18 Dec 2018 13:41:05 +0000 (GMT)
Subject: Re: [PATCH RFC v2 4/8] drm/bridge: dw-hdmi: add support for YUV420
 output
To:     Neil Armstrong <narmstrong@baylibre.com>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zheng Yang <zhengyang@rock-chips.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <edebea46-7edd-a5e1-d673-6df6a12fc99b@samsung.com>
Date:   Tue, 18 Dec 2018 14:41:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130134301.17963-5-narmstrong@baylibre.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRj1t/vY3Wx1vRX70B60kEwojR5csEQp6P5ZWZQp2aqbGzmtXddD
        C8VHLlOrhXObWlKaopE2NWP2gEVuUZmhiBmlliVlIqRSQrPc7iT/O9853+E758ePwpi3RDCl
        TU3n9anqFBUpxx90TL9Z9/M3JEZWmTexOcYxgu2ZGifZv59GCbbSdIG9dK1aylaVB7LdjgqS
        Hfz2FLHOkgT2w0c3zjbmRcQEcuN9+VLuxt1MrrukWMKVG60EN3DZJeGaq7O4K55IzmN7inNt
        vTcwbsK+Ypf8oHzrMT5Fe5rXR0QflmuGhn5gJ+8TZ9sfOYls1IoXIhkF9Cbo77gyi+UUQ9ch
        cM+U+odJBKO/8jBxmEDwvMtCzFnMBWZCFGoR9NQ/Jr0CQ48hGC4JLUQUtZjeCx0mn3kJnSeB
        X5YvvgGjixG0fO7EvAaSXgue5nc+s4KOBrPFKvFinA4F9+iEL+BS+gAYBxr8O0Hwwjrs42X0
        NmhvakdejNErIbe1HBOxEvqHb0q8x4Aek8L7snp/0x3Q7rH68WL47mqRingZvLxe5OezIMfa
        g4lm4+xr3K4lRSEKnrneEt5q2GzqRkeESMeCzdGNe2mgF0LfWJCYYSGYHpRhIq0A40VG3F4F
        A69bMREroaZriryKVLZ5zWzz2tjmtbH9v1uF8Hqk5A2CLpkXNqbyZ9YLap1gSE1efzRNZ0ez
        H+3ljGvqIXry54gT0RRSLVAEuJWJDKE+LZzTORFQmGqJot8AiYzimPpcBq9PS9IbUnjBiUIo
        XKVUZAYMJjB0sjqdP8HzJ3n9nCqhZMHZ6M7umm5TRVJQ75bVzcbK7Ka2EPyV4ojlPNGx72vp
        5vjc5VsitRvyG8iMmEWnzjAZg+Oejx6pjJ1MUIRPh7+XF2nsRWFaqtJj2DnUKWnYuH2/UFia
        LhxIe6fTn42y3xtxLI2DvXWHYolqB1V36/jwiCVuz642TfzAmgwyqyDsqAoXNOoN4ZheUP8D
        WFW/p2QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xe7off0jEGKx6YW3R1PGW1eLK1/ds
        Fv8fvWa1mDup1qJz4hJ2iwWzuS0u75rDZvHg5X5Gi0N90RZ3751gsVjfou/A7fH+Riu7x7w1
        1R6X+3qZPGZ3zGT1uN99nMlj85J6j/6/Bh5/Z+1n8dh+bR6zx+dNcgFcUXo2RfmlJakKGfnF
        JbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZDx++YS7YyFqxe88h1gbG
        rSxdjJwcEgImEtPap7GC2EICSxkllny0g4iLS+ye/5YZwhaW+HOti62LkQuo5jWjxJSOF0AN
        HBzCAiESxyaB1YgItDBJvHxuDVLDLNDLKPHm6hcmiIbDjBK995rBtrEJaEr83XyTDcTmFbCT
        mDZjJhOIzSKgKnHi9WewGlGBCImzL9cxQtQISpyc+QQszilgK7F7w26wOLOAusSfeZeYIWx5
        ieats6FscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/
        dxMjMIK3Hfu5eQfjpY3BhxgFOBiVeHgZTojHCLEmlhVX5h5ilOBgVhLhvVUqESPEm5JYWZVa
        lB9fVJqTWnyI0RTouYnMUqLJ+cDkklcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1
        ILUIpo+Jg1OqgbEx15Vn/0MX/ymSeawxZqebdKY+bDXiVPXnS/yn2i/a+sNWcs7nkGsCFooW
        0+fl6ZYWXNp6nTGQ59babytidxz41xWX8kApzvrL7LUHlnz9/uHqRpndtUbSlt9mPPnw6GmI
        o57Vjfe7nP5Kfs8qbTbc+WabkrT5PS+jc/WZ9ivS9R+43F6g/EmJpTgj0VCLuag4EQAYj9zl
        9gIAAA==
X-CMS-MailID: 20181218134106eucas1p135cc5d59969b78032ce519c11bc908b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181130134319epcas5p1681fc1aa84565eb0ae8824c00515b9ae
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181130134319epcas5p1681fc1aa84565eb0ae8824c00515b9ae
References: <20181130134301.17963-1-narmstrong@baylibre.com>
        <CGME20181130134319epcas5p1681fc1aa84565eb0ae8824c00515b9ae@epcas5p1.samsung.com>
        <20181130134301.17963-5-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.11.2018 14:42, Neil Armstrong wrote:
> In order to support the HDMI2.0 YUV420 display modes, this patch
> adds support for the YUV420 TMDS Clock divided by 2 and the controller
> passthrough mode.
>
> YUV420 Synopsys PHY support will need some specific configuration table
> to support theses modes.
>
> This patch is based on work from Zheng Yang <zhengyang@rock-chips.com> in
> the Rockchip Linux 4.4 BSP at [1]
>
> [1] https://github.com/rockchip-linux/kernel/tree/release-4.4
>
> Cc: Zheng Yang <zhengyang@rock-chips.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


