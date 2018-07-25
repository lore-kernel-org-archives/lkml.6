Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56554C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107E820852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e2PB94Pu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107E820852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbeGYPki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:40:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56129 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbeGYPkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:40:32 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180725142833euoutp02557fdfded07974c2a0b1114e054193d4~Eou1x-xP_2941529415euoutp02N;
        Wed, 25 Jul 2018 14:28:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180725142833euoutp02557fdfded07974c2a0b1114e054193d4~Eou1x-xP_2941529415euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532528913;
        bh=uJ8Q8IYA18tcHATpJyYqZ67EcEWFrvGILwYYq4hEA1c=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=e2PB94PurP0r6VAg3HcZHp3hoZ+GiajifjS18VnDDZO6h5HcaBG42exb5DQt5pFxb
         ORKUX50OmwwB9n3zwWxXc0MmOIwcqAEhDnRewHI/pR35BJPmQmQtWornrI9sdC03y7
         j/hhuoI0SA9zTWUqtN+ohdiWJOieNL6SYHC9+1bk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180725142833eucas1p256d4fc15dd26254294d356fab1c63d3b~Eou1cWCdi1251812518eucas1p2q;
        Wed, 25 Jul 2018 14:28:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BB.87.05751.119885B5; Wed, 25
        Jul 2018 15:28:33 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180725142832eucas1p26a8b5a1226b1043d57332b70ba5caaa0~Eou0340Kc1696216962eucas1p2i;
        Wed, 25 Jul 2018 14:28:32 +0000 (GMT)
X-AuditID: cbfec7f4-c2dff70000001677-13-5b588911fea7
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CE.0B.04178.019885B5; Wed, 25
        Jul 2018 15:28:32 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCF00BJYEVKIO50@eusync1.samsung.com>; Wed, 25 Jul
        2018 15:28:32 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     "J, KEERTHY" <j-keerthy@ti.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] thermal: ti-soc-thermal: cleanup COUNTER feature
 handling for OMAP5
Date:   Wed, 25 Jul 2018 16:28:32 +0200
Message-id: <3308752.XLZtalhOvD@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <51799355-1a39-7f2f-6a20-a1718b9e0a64@ti.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7djPc7qCnRHRBh1zhS3mX7nGanFqexOT
        xeVdc9gsZi/pZ7H43HuE0eLJwz42BzaPnbPusnss3vOSyeP4je1MHp83yQWwRHHZpKTmZJal
        FunbJXBlzLu0m63gNUvFtl/r2BsYPzJ3MXJySAiYSHQv+8XaxcjFISSwglFi5azrLBDOZ0aJ
        GZs2MMFU3Vu4iwkisYxR4uSke1AtvxkltnTsZwOpYhOwkpjYvooRxBYRUJZ4sLSBFcRmFljM
        KNHfyw1iCwskSOyYcAFsKouAqsTB9mdg9bwCmhLXXveB3SQq4CWxZV87WA0n0MzXSxawQ9QI
        SvyYfI8FYqa8xL79U6Hm60icPbaOEeQgCYEVbBIfN/0EauAAclwknh4TgPhAWOLV8S3sELaM
        RGfHQSaI+umMEm9+LWWBcNYzSqw5cwzqZ2uJw8cvQm3gk5i0bTozxFBeiY42IYgSD4mNU1eB
        HS0k0M0kMfWNxwRGmVlIbp2F5NZZSG5dwMi8ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cT
        IzD6T/87/mUH464/SYcYBTgYlXh4P9qFRwuxJpYVV+YeYpTgYFYS4XU5DBTiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOK+0TES0kkJ5YkpqdmlqQWgSTZeLglGpgZNBU8y442/C9Znnqx9e/f0VM
        mqso31ir0hViu9P8itlq6SuzZt65e/TAemEn/o/8BaIvXqx4XZ3h89TTRkqKZ3PgCcO2pZaW
        LLNzG9dvfGPzqzZIbY1bDNsM1+22a5ftfXFB3E3gWsC9iXOfnbghdfX3j2uHX5VsfCib+LPY
        K1+UKTB14ZLrSkosxRmJhlrMRcWJAMkigeT6AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsVy+t/xy7oCnRHRBgdvW1jMv3KN1eLU9iYm
        i8u75rBZzF7Sz2LxufcIo8WTh31sDmweO2fdZfdYvOclk8fxG9uZPD5vkgtgieKySUnNySxL
        LdK3S+DKmHdpN1vBa5aKbb/WsTcwfmTuYuTkkBAwkbi3cBdTFyMXh5DAEkaJVa9PsUA4fxkl
        mnsXMYJUsQlYSUxsXwVmiwgoSzxY2sAKUsQssJhR4tuCP6wgCWGBBIkdEy4wgdgsAqoSB9uf
        gTXwCmhKXHvdB7ZOVMBLYsu+drAaTqChr5csYIfYtp1R4uDqpSwQDYISPybfA7OZBeQl9u2f
        ygpha0ms33mcaQIj/ywkZbOQlM1CUraAkXkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYPBu
        O/Zz8w7GSxuDDzEKcDAq8fB6OIZHC7EmlhVX5h5ilOBgVhLhdTkMFOJNSaysSi3Kjy8qzUkt
        PsQozcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp1cAY3LV9dz4fR+PtaXFOT5pTbmQ3ts5j
        NlTnfHFNZfezG7OKcgLLVrDE88wuWNC0piy2cvX9ozo6t5S5vya8nXT7WbWJtFKV3IerHIt/
        F6XZ/Lnk/nppYwhX3Fb1ZuGonu1BLHvl78xb/33PKsFzP7SfTPilLMy2p3r5uQN/Ff8td1a9
        8db0xz9LJZbijERDLeai4kQAjXrACVoCAAA=
X-CMS-MailID: 20180725142832eucas1p26a8b5a1226b1043d57332b70ba5caaa0
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180725142832eucas1p26a8b5a1226b1043d57332b70ba5caaa0
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <1526298141-14045-5-git-send-email-b.zolnierkie@samsung.com>
        <51799355-1a39-7f2f-6a20-a1718b9e0a64@ti.com>
        <CGME20180725142832eucas1p26a8b5a1226b1043d57332b70ba5caaa0@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 11, 2018 09:08:29 AM J, KEERTHY wrote:
> 
> On 5/14/2018 5:12 PM, Bartlomiej Zolnierkiewicz wrote:
> > OMAP5 sensors don't claim COUNTER feature support (they use
> > COUNTER_DELAY feature instead) so there is no need to set fields
> > of struct temp_sensor_registers which are only used for COUNTER
> > feature.
> > 
> > There should be no functional changes caused by this patch.
> 
> Acked-by: Keerthy <j-keerthy@ti.com>

Thank you! Could you please also review/verify patches 5-14?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

