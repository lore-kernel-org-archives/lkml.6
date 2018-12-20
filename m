Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC886C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F975218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vk323Bne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbeLTQth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:49:37 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59996 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeLTQtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:49:36 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181220164935euoutp029172bc6a57ed9ad52542148381308878~yGIN6CM490925409254euoutp02s
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 16:49:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181220164935euoutp029172bc6a57ed9ad52542148381308878~yGIN6CM490925409254euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545324575;
        bh=5SopC54hdF6i+F0aVfMTTAbXp5OQRW7nIZjGukDNiC0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Vk323Bne7Hc36x3nCatoeoyqXijdotdcG4F/PXlUiuT5N1jj+Ka3K0fnQfXL7KepE
         TMe4rVzbUUJe48J8e9ZPOuJTRHIuYTdfaf1BpeQMdjjdCvh7spjUMXv+vu0OxOD1rR
         h2CkM3iyzzAY43lh7QgqXcWAhDPB14nvohfX6TqA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181220164934eucas1p1959aa46c93c8c46ee6f62d34d47a45fc~yGINTRGAv2382623826eucas1p1P;
        Thu, 20 Dec 2018 16:49:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E1.F7.04806.E18CB1C5; Thu, 20
        Dec 2018 16:49:34 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181220164933eucas1p2ac0190f35fc1b08683723886ba246f58~yGIMRZmRF1865718657eucas1p2x;
        Thu, 20 Dec 2018 16:49:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181220164933eusmtrp235d67db7f423d04a36a8aaaa8e8bd0ec~yGIMCVHZA3142031420eusmtrp2e;
        Thu, 20 Dec 2018 16:49:33 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-67-5c1bc81efa05
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EE.6C.04128.D18CB1C5; Thu, 20
        Dec 2018 16:49:33 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181220164932eusmtip191fac2f6e69921bdf90e7047bf2503d5~yGILs51b_0977009770eusmtip1B;
        Thu, 20 Dec 2018 16:49:32 +0000 (GMT)
Subject: Re: [REGRESSION PATCH] fbdev: fbmem: behave better with small
 rotated displays and many CPUs
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Geoff Levand <geoff@infradead.org>,
        James Simmons <jsimmons@users.sf.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ff208bfb-500d-3d8a-94ec-6c78e29f1331@samsung.com>
Date:   Thu, 20 Dec 2018 17:49:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <bfd5d16a-6fb2-4bc8-c5fd-b7086f44e7dc@axentia.se>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7pyJ6RjDK71sltc+fqezWLu7EmM
        Fkte2lncWyFrcaLvA6vF5V1z2Cz2HprPaLF+/i02Bw6PaQdms3tMPKvrsXmFlsf97uNMHsdv
        bGfyWL3Sz+PzJrkA9igum5TUnMyy1CJ9uwSujN6O6WwFr5krGpqeMTcwtjF3MXJySAiYSDzY
        85sdxBYSWMEocb5ZuouRC8j+wigxv/UNG4TzmVHixoGLcB19e09CdSxnlDh1MAGi6D2jxKZ3
        W5lAEsIC6RL7J81kA7FFBBQlFuyaxQxSxCzwjkliwudesG42ASuJie2rGLsYOTh4BewkXjfq
        gIRZBFQlHk9dzwISFhWIkOg/ow4S5hUQlDg58wkLiM0JVP3q5ilWEJtZQF5i+9s5YOMlBLax
        S7yaupwVpFdCwEXi/GExiJuFJV4d38IOYctI/N85nwmifjqjxJtfS1kgnPWMEmvOHGOCqLKW
        OHz8ItggZgFNifW79CHCjhJrj6xggpjPJ3HjrSDEDXwSk7ZNZ4YI80p0tAlBVKtJbFi2gQ1m
        bdfOldAg9JB4t6iHaQKj4iwkn81C8s0shL0LGJlXMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn
        525iBKae0/+Of93BuO9P0iFGAQ5GJR5ejV3SMUKsiWXFlbmHGCU4mJVEeNcfAgrxpiRWVqUW
        5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpg3BvyVlg+zdhuX9Skzkvm
        +45OOJjw4dXP+bm6Lyx7am/ulVYy+3Ls+K3pmpIXDRelyZ27+iExPtb44LR4m08r3cWccw/V
        7FxWaCWx/MW6/pDwiRUz/h4+dTJ70d/Aw8fnnj5278m9iNvzTwjU9ElWys64XSL75bX1PxHd
        iA+TzA+Zb/3PK2OpfVOJpTgj0VCLuag4EQAJQ7HTOQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xu7qyJ6RjDGa8Y7G48vU9m8Xc2ZMY
        LZa8tLO4t0LW4kTfB1aLy7vmsFnsPTSf0WL9/FtsDhwe0w7MZveYeFbXY/MKLY/73ceZPI7f
        2M7ksXqln8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2Nimp
        OZllqUX6dgl6Gb0d09kKXjNXNDQ9Y25gbGPuYuTkkBAwkejbe5IdxBYSWMooMW2DdhcjB1Bc
        RuL4+jKIEmGJP9e62LoYuYBK3jJKtJ44AtYrLJAu0fmqH8wWEVCUWLBrFjNE0VImiX9/D7OD
        OMwC75gkziw9wQZSxSZgJTGxfRUjyAZeATuJ1406IGEWAVWJx1PXs4DYogIRErcedoDZvAKC
        EidnPgGzOYHKX908xQpiMwuoS/yZd4kZwpaX2P52DvMERsFZSFpmISmbhaRsASPzKkaR1NLi
        3PTcYiO94sTc4tK8dL3k/NxNjMC42nbs55YdjF3vgg8xCnAwKvHwauySjhFiTSwrrsw9xCjB
        wawkwrv+EFCINyWxsiq1KD++qDQntfgQoynQExOZpUST84Exn1cSb2hqaG5haWhubG5sZqEk
        znveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgdE3bXl3Qcg/m2CN9ZpZV+6yfL32yPy8+Pa06tBP
        M/YlT+DRu+ehdemuzmebCa6lufVBWzfcrld663Ly35O25G2mx44ynmX7syUiLYLjwZQWExPZ
        3JLwfsMZV+Q9OnVWt6rLzOPb+eQE58IMgd+Rr7/5zau5tmXH/8r7JwWLk9bzxS3sE2BYL6TE
        UpyRaKjFXFScCABiTU/FwQIAAA==
X-CMS-MailID: 20181220164933eucas1p2ac0190f35fc1b08683723886ba246f58
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181126141651epcas1p346d68ff01402cea354ad4686fdbb7284
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181126141651epcas1p346d68ff01402cea354ad4686fdbb7284
References: <20181108095347.19326-1-peda@axentia.se>
        <CGME20181126141651epcas1p346d68ff01402cea354ad4686fdbb7284@epcas1p3.samsung.com>
        <8faae5c6-ce11-99b4-4fc7-7a8925aad3e4@axentia.se>
        <94947dad-2ac4-99b0-3ebd-0aba62f27d4a@samsung.com>
        <bfd5d16a-6fb2-4bc8-c5fd-b7086f44e7dc@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/26/2018 10:19 PM, Peter Rosin wrote:
> On 2018-11-26 15:33, Bartlomiej Zolnierkiewicz wrote:
>> On 11/26/2018 03:16 PM, Peter Rosin wrote:
>>> Ping?!
>>
>> Hi,
>>
>> Thank you for your patch, it will be considered for 4.21 (as it is not
>> a recent regression + I'm busy with other things currently).
> 
> Right, thanks for letting me know!

Patch queued for 4.21, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
