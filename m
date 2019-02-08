Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F05BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CA12083B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y3ItoYal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfBHRyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:54:10 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50487 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfBHRyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:54:09 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190208175407euoutp01a9b3d4edcfe427ea09e9d8c02723ea14~BdQ2O6VXI0427804278euoutp01i
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 17:54:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190208175407euoutp01a9b3d4edcfe427ea09e9d8c02723ea14~BdQ2O6VXI0427804278euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549648447;
        bh=I7zD+6k05Vefs521k5HxDW3ZdBSK6xPW4ZDEsguNOn4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Y3ItoYallJEW9L/BnpwLS4xCMsvhESaPcC5T7j3D3G/FkX0xgnjTpThCBLkBTUFRF
         BH5tmew0D8TYi+nDr+P2zs/M/xGraVHtMY7cO48Daje/SzMkAewHPFfXV8C2J2or1v
         qXKfBYK6kP/ZlnTT5q/tbKpe+PivKyoCA2zLBAQQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190208175407eucas1p15958e32d46f0ba6d0286e86dbbec334b~BdQ1asmad1785017850eucas1p1D;
        Fri,  8 Feb 2019 17:54:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5D.79.04806.E32CD5C5; Fri,  8
        Feb 2019 17:54:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190208175406eucas1p153221c7a9e18ba2c112a887f6d2e164f~BdQ0fGcXv3153731537eucas1p1p;
        Fri,  8 Feb 2019 17:54:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190208175405eusmtrp2db3293f047a4175519e04a3523652c00~BdQ0QwA731635516355eusmtrp23;
        Fri,  8 Feb 2019 17:54:05 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-86-5c5dc23ec9c2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 35.0E.04128.D32CD5C5; Fri,  8
        Feb 2019 17:54:05 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190208175405eusmtip1a9a915df7fd0ece96444b3e6076bebab~BdQz2kNxw2643626436eusmtip1i;
        Fri,  8 Feb 2019 17:54:05 +0000 (GMT)
Subject: =?UTF-8?Q?Re:_[PATCH=ed=98=bbRESEND_v2_0/4]_Fix_ssd1307fb_OLED_driv?=
 =?UTF-8?Q?er_reset?=
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <590890b7-f4ed-e346-8caa-8bb4ada43bc5@samsung.com>
Date:   Fri, 8 Feb 2019 18:54:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1548676383-29685-1-git-send-email-michal.vokac@ysoft.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3cuOxtOjtPwycJwRDdQixJOmTMjaH2yT2Wl1mwHlTaVzWlT
        hKWVl0BLUtFCK/O+Upd3UnOJl1LLSpAussAwxU1jhnmp5ekk+e33/J//8z7/B14Kk1YQXlRs
        XCKrjVOqZaQYb+lbGvGVWyLC99lMu5lMe6WQKesdIZjGpx9xZiB3nmDeddwjGet0N2KcjkmC
        ud7ZK2S+NXkeFSlKTakKc202qWi0twkUDrO3YvrXPHaKOCc+omLVsUms1l9+URzzuOc9SqgQ
        XplrmBYa0RSRg0QU0AfBmTMu4FhKVyN43uSSg8RrvIBgyTzxr+FAkG73Wh+YGjARvKkKgW22
        GfHFHALLg2qMc7nTLPRaW4Uce9BB0D2b8ZcxukYA95vSOCbpw3A7sxZxLKHl0DLsIDnG6R2w
        nPFyTaeozXQY5A3t4i1uMFg8iXMsok9A+2ApyT+5HTKa72JcBqDNQsi1P8L5pMeh+ksx4tkd
        ZvqbhDxvA2d7mYAfKEIwu1yB80U9AtNQn4B3BcKL/lGCS4HRe6C+w5+XQ2Dqai7JyUC7wrjN
        jQ/hCvktRRgvSyDrhpR374SGygZyfW1Oew3GswKsfVn4LeRTsuG0kg3nlPzfex9htciT1es0
        0azuQByb7KdTanT6uGi/S/EaM1r7PK9+9/9oQ12rURZEU0jmIgm7FhEuJZRJOoPGgoDCZB6S
        oJ41SaJSGlJYbfwFrV7N6ixoK4XLPCWpm6znpXS0MpG9zLIJrHa9K6BEXkZkWD2zeDZg0fZz
        rCvFHjlA1edHvrF+/6SK/Jry+tiWD5OdonI0PeAzifTiPJUzMNuYWZhmFONe6rK3K3fqPKoW
        Rl2Db54OkQfXmQ6R40azd+JCqCk12Xdm+Fm6ryEoocN1pbCgMqD8pH3CYMmVrzj8HrY6Q2f1
        /pqwqCdjnwtkuC5GuX8vptUp/wBqd23JOAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xu7q2h2JjDDobdCza3y1jt5h/5Byr
        xcbNt1ksTvR9YLW4vGsOm8WDl/sZLf5/fsJq0br3CLvFiy3iDpwe89ZUe2xa1cnmsfHdDiaP
        z5vkPF7+/cAcwBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
        llqkb5egl7H24BXGgqXsFe83vGRvYHzO2sXIySEhYCLx/MQaIJuLQ0hgKaPEhAddLF2MHEAJ
        GYnj68sgaoQl/lzrYoOoecso0fryN1izsECqxJEH29lBbBEBW4n9b5rZIYpmMUqcfHMSbCqz
        wEomiQ0z9zKDVLEJWElMbF/FCGLzCthJbDv7mQ3EZhFQkfjVfAosLioQIXHrYQcLRI2gxMmZ
        T8BsTgF3iZ0n54HVMwuoS/yZd4kZwpaXaN46m3kCo+AsJC2zkJTNQlK2gJF5FaNIamlxbnpu
        sZFecWJucWleul5yfu4mRmBcbTv2c8sOxq53wYcYBTgYlXh4GZpiY4RYE8uKK3MPMUpwMCuJ
        8NoeBArxpiRWVqUW5ccXleakFh9iNAV6YiKzlGhyPjDm80riDU0NzS0sDc2NzY3NLJTEec8b
        VEYJCaQnlqRmp6YWpBbB9DFxcEo1ME5k2WflvOPZIxuzpWVfouzd9qz7vOlZb4T8ye3RUt6H
        WBjDeRVj2r9fv7pq3gXv4n37AxYm/Zl2/LLSibzzq8/OY9q3Rst9c4HCnSo+iQOTD5bu2ewp
        eVS/y1fc/8Vnr3+BnNWXJzKVskzas3WhyV5vrWt7d5rr2XK0WU56uVlNbrqA2xupfQ+VWIoz
        Eg21mIuKEwEPcwP0wQIAAA==
X-CMS-MailID: 20190208175406eucas1p153221c7a9e18ba2c112a887f6d2e164f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190128115430epcas1p243804249cd6c841166eb6cd5a504ce22
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128115430epcas1p243804249cd6c841166eb6cd5a504ce22
References: <CGME20190128115430epcas1p243804249cd6c841166eb6cd5a504ce22@epcas1p2.samsung.com>
        <1548676383-29685-1-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/28/2019 12:52 PM, Michal Vokáč wrote:
> Hi all,
> 
> this is my third attempt to fix the ssd1307fb OLED driver reset. In the
> second attempt [1] Rob suggested to take different aproach. That is to
> apply what was originaly part of the first round and eventually merged
> but reverted later on [2][3].
> 
> The last patch in this series is a fixup for the single user (in-tree)
> that uses this OLED. Rob suggested the fixup may actually be applied
> only after someone complains their display broke.
> 
> And a comment from Alexandre regarding the status of the Crystalfontz
> platform:
> 
> On 20.12.2018 13:35, Alexandre Belloni wrote:
>> Honestly, the platform has been discontinued and I don't really think
>> it is worth having that fixup in the tree forever.

Patches #1-3 queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
