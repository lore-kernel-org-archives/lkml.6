Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CF0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AA220875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LgHN+Nxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AA220875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbeGXR6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:58:10 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45429 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388399AbeGXR6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:58:09 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180724165047euoutp01189d438af6947b65cd991034de5f96ba~EXBvOu-zH1033110331euoutp01k;
        Tue, 24 Jul 2018 16:50:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180724165047euoutp01189d438af6947b65cd991034de5f96ba~EXBvOu-zH1033110331euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532451047;
        bh=dkQdhkux9AQ3sA4yq3O5Di3HjdJ7TsR9A7+2irSYooM=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=LgHN+NxiO4USkTZ5gkrJtN/ZcPdknAxpBJ9mlcpUhZBmpcfQp369uQqnVR912+V8e
         QftxI5+HrfggkJEPlGe79EkRracKQgQfsfcs/85eIFQL7mn7PGYZ95Ih2dpChM83/j
         etoKifCUFGRfLmt4MK/RpZx3OJQcsOBwpA9SA5yw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724165047eucas1p15598709cd48d80b978333ace5ea3c496~EXBuuROfo1048910489eucas1p1m;
        Tue, 24 Jul 2018 16:50:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 04.73.05751.6E8575B5; Tue, 24
        Jul 2018 17:50:46 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724165046eucas1p2f2b94b7a4642c977d76df0462b6750ea~EXBt3uHC30418704187eucas1p2R;
        Tue, 24 Jul 2018 16:50:46 +0000 (GMT)
X-AuditID: cbfec7f4-c2dff70000001677-fe-5b5758e6d644
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 52.7D.04178.6E8575B5; Tue, 24
        Jul 2018 17:50:46 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync3.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD00CHQQSM1S70@eusync3.samsung.com>; Tue, 24 Jul
        2018 17:50:46 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Colin King <colin.king@canonical.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: tridentfb: remove deadcode on unreachable
 case statement
Date:   Tue, 24 Jul 2018 18:50:45 +0200
Message-id: <2543058.xq6agm5N8h@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180716134458.8654-1-colin.king@canonical.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7djP87rPIsKjDda+M7L4vbqXzeLK1/ds
        FltvSVuc6PvAanF51xw2B1aPWQ29bB73u48zeXzeJBfAHMVlk5Kak1mWWqRvl8CVcbDvIkvB
        MpaKbXv2MzYw7mTuYuTkkBAwkdjf3cPWxcjFISSwglGi8cwXKOczo8SsaV/YYar+LZkK1iEk
        sIxRYt8WPYii34wSaxeeYAJJsAlYSUxsX8XYxcjBISKgKXH+XBFIDbNAI6PErYnbwOLCArES
        S+5agpSzCKhK9O+EuIIXqPzsjDesILaogJfEln3tYCM5BWwlvv59xApRIyjxY/I9FhCbWUBe
        Yt/+qawQto7E2WPrGCHunMEmcaedA8J2kZi38CYbhC0s8er4FqhfZCQ6Ow4ygdwmITCdUeLN
        r6UsEM56Rok1Z44xQVRZSxw+fhFqA5/EpG3TmUEekBDglehoE4Io8ZD42zuHGRIQExglnk2e
        wjSBUWYWkmNnITl2FpJjFzAyr2IUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAiM8tP/jn/Z
        wbjrT9IhRgEORiUe3o924dFCrIllxZW5hxglOJiVRHhNA4FCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeeM06qKEBNITS1KzU1MLUotgskwcnFINjCzMPy24xeM+6hr8NwpcOnmz3+NHmQrl+g85
        DY1m2bQ0rNVgPnRL2KLWT/Xao/Ms++vZ0yfu3nLFOVJ1D+fL5WdWBvsV/KlapvFgL8e+K+dm
        H47TWvhe/LupwqtQq1VbUw53eIuurT4v8m/tPNsZDke8bTJkNY/61LIkzJofV1/+pFpVb9WB
        +UosxRmJhlrMRcWJALz0mEnuAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsVy+t/xq7rPIsKjDc7u4LH4vbqXzeLK1/ds
        FltvSVuc6PvAanF51xw2B1aPWQ29bB73u48zeXzeJBfAHMVlk5Kak1mWWqRvl8CVcbDvIkvB
        MpaKbXv2MzYw7mTuYuTkkBAwkfi3ZCqQzcUhJLCEUaLz+k02COcvo8SyGxdZQKrYBKwkJrav
        Yuxi5OAQEdCUOH+uCKSGWaCRUeL6z6lgcWGBWIkldy1BylkEVCX6d0Is4AUqPzvjDSuILSrg
        JbFlXzsTiM0pYCvx9e8jVohdkxgl3l3+wwTRICjxY/I9sL3MAvIS+/ZPZYWwtSTW7zzONIGR
        fxaSsllIymYhKVvAyLyKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMES3Hfu5eQfjpY3BhxgF
        OBiVeHg9HMOjhVgTy4orcw8xSnAwK4nwmgYChXhTEiurUovy44tKc1KLDzFKc7AoifOeN6iM
        EhJITyxJzU5NLUgtgskycXBKNTDyGwQfjMoU2c116l7HrTeTr0rvyZjw1vnInhMvpQI61vv4
        CKh2lNddyI7d/yL8xKa3+nqTJ78uOcRcMPWix+n0Zf+ufjikGGqkqNM8hWWG9psJa1YvmyC1
        UzPdird8g+dfwU1b1m2/cf5DQeKj/fz1WQkO+z3P5HU+LxVm6tqSFXo3XcZdQ4JViaU4I9FQ
        i7moOBEABvuTMU0CAAA=
X-CMS-MailID: 20180724165046eucas1p2f2b94b7a4642c977d76df0462b6750ea
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180716134504epcas5p2138ba82f2293c27750d4794f0152aad8
References: <CGME20180716134504epcas5p2138ba82f2293c27750d4794f0152aad8@epcas5p2.samsung.com>
        <20180716134458.8654-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 16, 2018 02:44:58 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The value of tmp being used in the switch statement has the range of
> just 0..3 hence the case 4 statement can never be reached and is
> deadcode and can be removed.
> 
> Detected by CoverityScan, CID#744384 ("Logically dead code")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

