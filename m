Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C08C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D024208CE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vBlSgj0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D024208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936302AbeF2QKe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:10:34 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50896 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbeF2QKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:10:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180629161029euoutp01deadfb595af3b934dad509576e8bef26~8rWaLH65t0735407354euoutp01X;
        Fri, 29 Jun 2018 16:10:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180629161029euoutp01deadfb595af3b934dad509576e8bef26~8rWaLH65t0735407354euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530288629;
        bh=TBYI9A2j/NO0+ZKjZuX4Fw2lfKtFpZWgKimdp1toPsc=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=vBlSgj0zn24TSjJAZSjUsLOkPi7Sf43KjPDNj8tnHXSGbi1iialNgFDv/xvEmtR7C
         dFm+fWAze6bWWA2m8n826zG7bJYSojr4wpjR3SU50kuujjpAhwthu4vV7jEBZTHXRo
         +JLRQ1xgIN6Z7I2zIwEfxCHRAJoW/LHah8vaS8no=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180629161028eucas1p2ddeed9f96b087e57fd0554b3b5d01ce6~8rWZlG5gv2713327133eucas1p2a;
        Fri, 29 Jun 2018 16:10:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 59.1E.10409.4F9563B5; Fri, 29
        Jun 2018 17:10:28 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180629161027eucas1p20846507c4f98f50d80ab58aaa1628fd1~8rWY42eCB1665116651eucas1p2L;
        Fri, 29 Jun 2018 16:10:27 +0000 (GMT)
X-AuditID: cbfec7f5-b45ff700000028a9-0d-5b3659f4589c
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 55.5C.04183.3F9563B5; Fri, 29
        Jun 2018 17:10:27 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PB3006PNE9FHZ00@eusync1.samsung.com>; Fri, 29 Jun
        2018 17:10:27 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: ti-soc-thermal: remove dead code
Date:   Fri, 29 Jun 2018 18:10:26 +0200
Message-id: <3318201.BAqn4C3t6k@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <10747698.EAsn0e6Ddm@amdc3058>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7djP87pfIs2iDWZsErOYf+Uaq8Wp7U1M
        Fpd3zWGzmL2kn8Xic+8RRosnD/vYHNg8ds66y+6xeM9LJo/jN7YzeXzeJBfAEsVlk5Kak1mW
        WqRvl8CV0TP9LHvBEq6Kmd9WMDUwruboYuTkkBAwkZi16S5LFyMXh5DACkaJWysamUESQgKf
        GSW2LDGGKbr/6DIzRNEyRom+2x3sEM5vRome3b9ZQKrYBKwkJravYgSxRQTcJGYt+QNmMwtU
        Six5fYUJxBYWsJO49fEomM0ioCqxpHk5WA2vgKZE588tYHNEBbwktuxrB6vhFNCWmNq5gh2i
        RlDix+R7LBAz5SX27Z/KCmHrSJw9to4R5CAJgSVsEkd2n2SEONtF4tetvWwQtrDEq+Nb2CFs
        GYnLk7tZIBqmM0q8+bUUylnPKLHmzDEmiCpricPHL0Kt4JOYtG06MAA4gOK8Eh1tQhAlHhI7
        Nn5nhIRXncScxjMsExhlZiE5dhaSY2chOXYBI/MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT8
        3E2MwOg//e/41x2M+/4kHWIU4GBU4uG9EGQWLcSaWFZcmXuIUYKDWUmENxAkxJuSWFmVWpQf
        X1Sak1p8iFGag0VJnDdOoy5KSCA9sSQ1OzW1ILUIJsvEwSnVwCj0KUiU8VJ8Wt3F82LH4/KW
        xNxfdd4y7vKNmMP1QYfzK2MvrGHZNGlzWt2PB8bPFsw5va6p01qMJdopfbKRqhwjc+2qC6n3
        by1eo+xyzJbR407Kjk8bBB+m/WKu3F1s9Cs6OYlV20i//PCESyqTbnCfW25knn+p8Mlye1OL
        3T0Va/9tMGXzva/EUpyRaKjFXFScCAAvY2ko+gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t/xy7qfI82iDRZ8s7CYf+Uaq8Wp7U1M
        Fpd3zWGzmL2kn8Xic+8RRosnD/vYHNg8ds66y+6xeM9LJo/jN7YzeXzeJBfAEsVlk5Kak1mW
        WqRvl8CV0TP9LHvBEq6Kmd9WMDUwruboYuTkkBAwkbj/6DJzFyMXh5DAEkaJNRuesEM4fxkl
        VtyYywZSxSZgJTGxfRUjiC0i4CYxa8kfMJtZoFJi5cJGVhBbWMBO4tbHo0wgNouAqsSS5uVg
        NbwCmhKdP7ewgNiiAl4SW/a1g9VwCmhLTO1cwQ5iCwloSSx9+5EZol5Q4sfkeywQ8+Ul9u2f
        ygpha0ms33mcaQIj/ywkZbOQlM1CUraAkXkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYOBu
        O/Zzyw7GrnfBhxgFOBiVeHgvBJlFC7EmlhVX5h5ilOBgVhLhDQQJ8aYkVlalFuXHF5XmpBYf
        YpTmYFES5z1vUBklJJCeWJKanZpakFoEk2Xi4JRqYOzInHdh2cfk8KDiupPdj3rvPv8n7bti
        a792m25Pkm/b8dgd8zcbTQr/KHPZ54Z5p8mvmdfyLPNZ5snJuqlc3rfUtWuHQPLGoM3v6oUl
        TzsFvPhQpWOjwGH0bbu795/YwyL5F44kmc5QMZXMZn7XcqB584JUhor6u8/PWJbGvmivOF/d
        bXptrxJLcUaioRZzUXEiADKcDKBYAgAA
X-CMS-MailID: 20180629161027eucas1p20846507c4f98f50d80ab58aaa1628fd1
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180629161027eucas1p20846507c4f98f50d80ab58aaa1628fd1
References: <10747698.EAsn0e6Ddm@amdc3058>
        <CGME20180629161027eucas1p20846507c4f98f50d80ab58aaa1628fd1@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Wednesday, May 02, 2018 03:20:35 PM Bartlomiej Zolnierkiewicz wrote:
> Majority of this code (i.e. functions from ti-bandgap.c) has been
> introduced in May 2013 by commit eb982001dbd8 ("thermal: introduce TI
> SoC thermal driver"). Just remove it altogether (in case it is needed
> it can be easily resurrected from git repo).
> 
> While at it fix incorrect "not used" comments.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/ti-soc-thermal/dra752-bandgap.h      |   68 ---
>  drivers/thermal/ti-soc-thermal/dra752-thermal-data.c |   65 ---
>  drivers/thermal/ti-soc-thermal/omap3-thermal-data.c  |    6 
>  drivers/thermal/ti-soc-thermal/omap4-thermal-data.c  |   10 
>  drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h    |   10 
>  drivers/thermal/ti-soc-thermal/omap5-thermal-data.c  |   46 --
>  drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h    |   41 --
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c          |  370 -------------------
>  drivers/thermal/ti-soc-thermal/ti-bandgap.h          |   43 --
>  9 files changed, 5 insertions(+), 654 deletions(-)

Gentle ping.

It would be great to see this patch in v4.19.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

