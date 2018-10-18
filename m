Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74E1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9362145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ReZOmL42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9362145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeJRVNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:13:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42448 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeJRVNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:13:11 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181018131211euoutp01a9f443cd28dfa5cbaaea0255feceae1c~ethbKi6G_1089210892euoutp01B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 13:12:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181018131211euoutp01a9f443cd28dfa5cbaaea0255feceae1c~ethbKi6G_1089210892euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539868331;
        bh=pQ5nZ1qDEAtPX9EMJ1JtbQ2/TEbkHb1ki8t3eY8HsLA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ReZOmL42WveD8EGR4Mt+4F91Rx6PVXj4FnIOhXmfwagdjnyi7TTBI2Ype5+HcB+UT
         5saiLtQrzi7A1j2yuiyUWzfL5UdW9GZIHgu6PKBxihDwLuSYWJx3gyTA8c0kfywBrJ
         OD5n/xkuSTLOygrecsDmFvKvXk7HdiQk9jcdcjzs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181018131211eucas1p25c937c5488b8a265a9b485ce69a01d3e~ethaq9rhO1486614866eucas1p2s;
        Thu, 18 Oct 2018 13:12:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FC.DF.04441.AA688CB5; Thu, 18
        Oct 2018 14:12:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181018131210eucas1p14a11ec7555ca9ef3003387f1985326e6~ethZ7giWB0310803108eucas1p1X;
        Thu, 18 Oct 2018 13:12:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181018131210eusmtrp133844b31873f8f7e5abaf5e7479c2a29~ethZrNf4E0324103241eusmtrp1u;
        Thu, 18 Oct 2018 13:12:10 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-1a-5bc886aa7fa0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CF.8D.04128.9A688CB5; Thu, 18
        Oct 2018 14:12:09 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181018131209eusmtip274a9e9eafbaeed0ef0ed13eb8cc07393~ethZUwf1s2342923429eusmtip2p;
        Thu, 18 Oct 2018 13:12:09 +0000 (GMT)
Subject: Re: [PATCH] ata: add Buddha PATA controller driver
To:     Christoph Hellwig <hch@infradead.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Thu, 18 Oct 2018 15:12:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181018124118.GA10376@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj229nlbDQ5HhXflhnNsjI0xaBThhVU7E/Rv0Shmu6k4qayOS8l
        4Q9vWKalMpwXTGva1FIzL6PUpjjFS+mITPJSs4RwKlqr9UNzOxP89zzv+z7v87wfH46RzRwR
        npCUSiuTpHIxV8DuHLK/D9LnDUeHVGhCqKbZYi71Y+Yti6pc9adGS+pY1FD3NxZlNlRxqYbF
        FoyqztXwzuOSHu0sT/KqMVBiHldLjAMFSDKSa2NL3k1MIMlGu981XpTgrIyWJ6TRyhMRtwTx
        enMbN6Wfk7Fgq+Nloy52IeLjQJyElT4dVogEOEk0Ilg36hFDfiGw9X13kQ0E5pkabEfytNzq
        lJNEA4KFJV8GryL4ZMlyYE8iHNaalrkO7EUcg5mGfKcFRhSx4O/KJM/R4BJn4FG+w46Ps4nD
        YP9q2cY47k1EQvHYEUdZSHjASMWi04tPhMFy/aYzA0aEwGBdFYfBB6DLWuXcD4SBB+P2+xgj
        TgPrXAOHCX0R3li1PAZ7wk9Thwv7wmjpAzYj1iBY/vfMRV4iaB4bYjFT4TBgmnRtugB/2uZ5
        jqRAuMO01YNJ4Q6POzUYUxZCQR7JTAdAq66Vu+NV2PPc9YgSKMoxsErQQe2uO7W7btPuuq0W
        YXrkQ6tVijhaFZpEpwerpAqVOikuODZZ0Y62/9Dopmm9G/2eijEiAkfiPcIF2hRNcqRpqkyF
        EQGOib2ESznD0aRQJs28QyuTbyrVclplRPtwtthHqKtpiyaJOGkqnUjTKbRyp8vC+aJsRJ97
        caq0I2Bh734j+aU+psAwbvm4dVzWZ+Df83GTX718Kdw+WBq7FVNZHHBovam3rPfodVH/3OsS
        c8vDtYgiuz0xTKTrre0xx1Y0yYKm+0TzT2zVJY3+d6eaNTduT5hgJeuKG+Kne+vFnytqlidP
        +2UM1FNPei1lkR9wMqc8SsxWxUtDAzGlSvofc31mPD8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xe7or205EGzx+aG2x+m4/m8WzW3uZ
        LGa/V7Y4PWERk8WxHY+YLC7vmsNmsfzJWmaLua3T2R04PHbOusvusXmFlsfls6Uehw53MHqc
        bP3G4nHw3DlGj8+b5ALYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1s
        UlJzMstSi/TtEvQyVl3eyFZwgLXiwbdF7A2M21m6GDk5JARMJJZMfQtkc3EICSxllJg1cy1T
        FyMHUEJG4vj6MogaYYk/17rYIGreMkqc/NDPDJIQFrCW+LD6DRuILSKgKXFreTtYXEjgM6PE
        0eWmIA3MAv1MEmcO7GYHSbAJWElMbF/FCLKAV8BO4kUHWJhFQFXi58PHjCC2qECExK2HHWDH
        8QoISpyc+QTM5hQwlniz+B/YfGYBPYkd13+xQtjyEtvfzmGewCg4C0nLLCRls5CULWBkXsUo
        klpanJueW2ykV5yYW1yal66XnJ+7iREYW9uO/dyyg7HrXfAhRgEORiUe3gepx6OFWBPLiitz
        DzFKcDArifA+bzkRLcSbklhZlVqUH19UmpNafIjRFOiJicxSosn5wLjPK4k3NDU0t7A0NDc2
        NzazUBLnPW9QGSUkkJ5YkpqdmlqQWgTTx8TBKdXAODHrwAlhfle3KR89VVemHb3y79O96mQ1
        tmuuq061Mx7ttbJ7WqRbtv7+3U8bV7mfVXjkflHskpXbCxFXzYBj6Tteqi9eM/3Bv2TxqmVu
        zuUnT33OOL7wi0jHkmCRZZsEFWS0275zuOhI1l+/02Fw1uTNAhbOK4XrQ47cCVqkVas6cYaS
        fGN7hxJLcUaioRZzUXEiAM3fNKbDAgAA
Message-Id: <20181018131210eucas1p14a11ec7555ca9ef3003387f1985326e6~ethZ7giWB0310803108eucas1p1X@eucas1p1.samsung.com>
X-CMS-MailID: 20181018131210eucas1p14a11ec7555ca9ef3003387f1985326e6
X-Msg-Generator: CA
X-RootMTR: 20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457
References: <CGME20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457@eucas1p2.samsung.com>
        <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
        <20181018124118.GA10376@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/18/2018 02:41 PM, Christoph Hellwig wrote:
>> +static int __init pata_buddha_init_one(void)
>> +{
>> +	struct zorro_dev *z = NULL;
>> +
>> +	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
> 
> I'm not really an m68k expert, but shouldn't this implement a
> struct zorro_driver instead?  (or maybe two of them as xsurf
> seems sufficiently different).

I didn't want to introduce too many changes over old IDE's
driver in the initial version of the libata driver as
I can't test them myself. Once the new driver is verified
to work I plan to convert it into proper Zorro_driver.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
