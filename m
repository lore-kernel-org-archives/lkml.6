Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D19C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900A320815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BjFE794U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbeLTLiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:38:05 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42995 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbeLTLiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:38:04 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181220113803euoutp02ad1c32e8b262821933a8c5e7f3730fbf~yB4N2Gv770610606106euoutp02N
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 11:38:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181220113803euoutp02ad1c32e8b262821933a8c5e7f3730fbf~yB4N2Gv770610606106euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545305883;
        bh=/wtVSIU1u8jkniyVCmf9tdEnnLzL0IulpduUFjvvCK8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BjFE794UuI9MuzvIm3YGXcLukyrJeiTlxRtR44ChQ4SseyMjOR2gtyR7r4kxlgbxt
         Yv+XfZJWJduWQj1Kb2DRpmz6oYnL4Ip2MnZSI2VcwRMpkBEDEofauBqTYfdDhQktMc
         1ZWw3GnLDQlVnQsmgoygWrGn3P9ZH5J4aZ5QCXiA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181220113802eucas1p1e9ecf87e8492337bad2269605244fe90~yB4MuBWvu1592515925eucas1p1H;
        Thu, 20 Dec 2018 11:38:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AA.FC.04294.91F7B1C5; Thu, 20
        Dec 2018 11:38:01 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181220113801eucas1p1c8485c363200952f23a2a35e06d85842~yB4LvSiD91724317243eucas1p1B;
        Thu, 20 Dec 2018 11:38:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181220113800eusmtrp12021081b24e59575dfd7e3e20d8bc4ef~yB4LgJ2Mg2144921449eusmtrp1t;
        Thu, 20 Dec 2018 11:38:00 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-08-5c1b7f1962e0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.24.04284.81F7B1C5; Thu, 20
        Dec 2018 11:38:00 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181220113800eusmtip17949c581ea817caa20a3aa79d9b22a6d~yB4LBQtK11857618576eusmtip1E;
        Thu, 20 Dec 2018 11:38:00 +0000 (GMT)
Subject: Re: [PATCH v4 1/3] driver core: add probe_err log helper
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b9f7cb75-62a0-20f6-0e5b-1553852d81b2@samsung.com>
Date:   Thu, 20 Dec 2018 12:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220111403.GB10978@kroah.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHfbzbvdfR5G4qO2pkDgwsfE3lgmFKfbjUl1KIUqGmXpzlpmxq
        mR+0hFKTWoamQzNZaWhhvm26smCr1NR8W1qWWTgsxSGhlVJGXq+S337n/M//Of8DD4lJ+4Re
        ZJo6i9WoFelyXCQwvlp9E+CZ750YPGMMpud0VkS3VDYL6fIvdpwuNDTjdF1FA6JbZ8aF9Ji5
        Gqct5d2IfvRiiqBrlsuxaBEzNj6CMV36KYJpbSzGmec1Dwmm7V4+s/jsLc5cb29EzFLrrmNk
        vOhACpuelsNqgqLOiJQTZR9RZpXkgsWmwwrQd3EJciGBCgNb0ygqQSJSSj1A0D0ySvDFMgKb
        6ZuAL5YQ1Pe+dt6ytDV2YLzQgMBqc2z6HQjs0xMEN+VGxcDk0Dzi2J3aDzcG9RvvYtQvZzDa
        F4WcgFP+sNb2HudYTEVB4WwJxrGA8oOrs7c32IM6CUXTTZszEuirsgs4dqGCwFDEezHKB0yO
        aoxnGUzaa525ZUBNEjC0fAfxuQ/DmmmI4NkN5nvaN3kn9N8qFfCcD5erbBhvLkLQa2jAeSES
        rD0j66nJ9Q3+0GwO4tsx8HiknODaQLnCO4eEz+AKZUYuP9cWQ9EVKT/tC9ODHRjPMrg//APX
        Ibl+22X6bdfot12j/7/3LhI0IhmbrVWlstpQNXs+UKtQabPVqYHJGapWtP7B+v/2LHci858k
        C6JIJN8hroz3SpQKFTnaXJUFAYnJ3cUzZ70TpeIURe5FVpNxWpOdzmotyJsUyGXiPKfPCVIq
        VZHFnmPZTFazpTqTLl4FqEIXd/BnkpOyiw4/kmAj7l3yWZmLMAfbw/eZg4cNSaoC08zKxCFd
        WBSTP75QUDyQ5quLFX/NyzaFkHllVV79u1ei/ToksaFxAdfWfq9GRpV5mm+a9mQetfZ3Frao
        jaeSn/a5eLyUHa89IXEKS68rTVbW931ayu1+MjBu8Fv4ECEXaJWKkL2YRqv4Byl7wX9cAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7oS9dIxBotX61i8nHCY0WLjjPWs
        FlMfPmGzaF68ns1i4bTljBabHl9jtbi8aw6bxaGpexkt1h65y24x98tUZgcuj8vXLjJ77Jx1
        l91j06pONo/9c9ewe2xeUu/xft9VNo++LasYPT5vkgvgiNKzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuD7pDmPBTMGKQ1cmMDcwfuTtYuTkkBAw
        kdi8aisziC0ksJRR4s0hXYi4uMTu+W+ZIWxhiT/Xuti6GLmAal4zSjw69g0sISzgKHHr/CtG
        EFtEwFii/+wsdhCbWeA3k8SUDVkQDfcYJR6sfMMEkmAT0JT4u/kmG4jNK2An0fysC2wQi4Cq
        RPuz6WC2qECExNmX6xghagQlTs58wgJicwroSyzugOhlFlCX+DPvEjOELS+x/e0cKFtc4taT
        +UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM123Hfm7e
        wXhpY/AhRgEORiUe3hlRUjFCrIllxZW5hxglOJiVRHgfZ0nHCPGmJFZWpRblxxeV5qQWH2I0
        BXpuIrOUaHI+MJXklcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpg
        ZIrgv64m4f3inalX2J1Lm64fCcrZtHae/Ry55BlRe61VTTR/xj5393/CsPahJtvkM+LK3Kc2
        M7i2LBPbPXHle7OMtp3nJi6XYp17W8Ykx+Js3ZWvndsLVENlzJ48u2Y/g1vfa4aCjf70Fes7
        cwymHGIXL7550uW7qujhRnm/faFSK03r1+i9UmIpzkg01GIuKk4EABycEB7tAgAA
X-CMS-MailID: 20181220113801eucas1p1c8485c363200952f23a2a35e06d85842
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181220102259eucas1p2f748c68e01cd4e09a266da879722e218
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181220102259eucas1p2f748c68e01cd4e09a266da879722e218
References: <20181220102247.4911-1-a.hajda@samsung.com>
        <CGME20181220102259eucas1p2f748c68e01cd4e09a266da879722e218@eucas1p2.samsung.com>
        <20181220102247.4911-2-a.hajda@samsung.com>
        <20181220111403.GB10978@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.2018 12:14, Greg Kroah-Hartman wrote:
> On Thu, Dec 20, 2018 at 11:22:45AM +0100, Andrzej Hajda wrote:
>> During probe every time driver gets resource it should usually check for error
>> printk some message if it is not -EPROBE_DEFER and return the error. This
>> pattern is simple but requires adding few lines after any resource acquisition
>> code, as a result it is often omited or implemented only partially.
>> probe_err helps to replace such code sequences with simple call, so code:
>> 	if (err != -EPROBE_DEFER)
>> 		dev_err(dev, ...);
>> 	return err;
>> becomes:
>> 	return probe_err(dev, err, ...);
> Can you show a driver being converted to use this to show if it really
> will save a bunch of lines and make things simpler?  Usually you are
> requesting lots of resources so you need to do more than just return,
> you need to clean stuff up first.


I have posted sample conversion patch (generated by cocci) in previous
version of this patchset [1].

I did not re-posted it again as it is quite big patch and it will not be
applied without prior splitting it per subsystem.

Regarding stuff cleaning: devm_* usually makes it unnecessary, but also
even with necessary cleaning you can profit from probe_err, you just
calls it without leaving probe - you have still handled correctly probe
deferring.

Here is sample usage (taken from beginning of the mentioned patch):

---
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 4b900fc659f7..52e891fe1586 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -581,11 +581,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
 	int i, irq, n_ports, rc;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "no irq\n");
-		return irq;
-	}
+	if (irq <= 0)
+		return probe_err(dev, irq, "no irq\n");

---

And there is plenty of such places, with new version of cocci script I can locate about 2700 such cases, and it is still far from completeness.

[1]:
https://lore.kernel.org/lkml/20181016072244.1216-4-a.hajda@samsung.com/T/#u


Regards

Andrzej


