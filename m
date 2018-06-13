Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 84E8FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF79208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rkyfrpX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF79208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935171AbeFMQIp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:08:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46825 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934563AbeFMQIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:08:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180613160838euoutp01ef7d260a4a5edc485b5194b2207da154~3xAOihAmG0068200682euoutp014;
        Wed, 13 Jun 2018 16:08:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180613160838euoutp01ef7d260a4a5edc485b5194b2207da154~3xAOihAmG0068200682euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528906118;
        bh=M4ccvzf28c1i0EsNntMWHgnBwOFkxsMaHQN6yKtR2OI=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=rkyfrpX3rPQRcJ2ZqNPKEDFpxOQHb3RglYaBqOete+TQrV65Xs+NUhPPmEVtSHAMe
         dT37Y4u0+p4TU+hNve2HzvOiEbK8Vtec37nlYypm/FMXLQGeZg4EhvReKAj/W1LkXh
         cRmLrX8gEXfAJzXLLywnZ4Iof8lrpakS8csaQNcA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180613160837eucas1p143c5430d7be4efd786bbe2e336d50f27~3xAN5mx8G0612106121eucas1p19;
        Wed, 13 Jun 2018 16:08:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 43.F4.05700.581412B5; Wed, 13
        Jun 2018 17:08:37 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180613160836eucas1p2877b4afb58fde464bdbc484875785f1f~3xAM_jQUg0874508745eucas1p20;
        Wed, 13 Jun 2018 16:08:36 +0000 (GMT)
X-AuditID: cbfec7f2-1dbff70000011644-9a-5b2141851f0a
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 50.8E.04183.481412B5; Wed, 13
        Jun 2018 17:08:36 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PA90097CRIC9540@eusync1.samsung.com>; Wed, 13 Jun
        2018 17:08:36 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Jones <pjones@redhat.com>
Cc:     Sinan Kaya <okaya@codeaurora.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
Date:   Wed, 13 Jun 2018 18:08:36 +0200
Message-id: <6376822.ENUjdQ58sn@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <CAKv+Gu9+M8zOtACPQ4_UMgp-M1LfZnciYe1VTQNqn_zNWJea4g@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZduzned1WR8Vog56l4hb/P+xmtLjy9T2b
        xabH11gtJu4/y25xou8Dq8XlXXPYLBonbWOy6Fp4g92i+bG6A6fH5b5eJo871/awedzvPs7k
        sXlJvcf7fVfZPD5vkgtgi+KySUnNySxLLdK3S+DK+P9nGVNBI0/F4YuH2BsYr3N2MXJySAiY
        SPzd0MDaxcjFISSwglHi3rV2FgjnM6PElyvfGGGq3k16yQSRWMYo0fxiCjuE85tRYu6FhSwg
        VWwCVhIT21cBdXBwiAgEShw6IwZSwyxwnUliS89eZpAaYYFUiSn7X4FNZRFQlWhqnAwW5xXQ
        lNj+fzsbiC0q4CWxZV87E4jNKRAs8fL2JxaIGkGJH5PvgdnMAvIS+/ZPZYWwdSTOHlvHCLJM
        QuAMm0T/gausEGe7SBzufMkOYQtLvDq+BcqWkbg8uZsFomE6o8SbX0uhnPWMEmvOHGOCqLKW
        OHz8ItQKPolJ26Yzg7wmIcAr0dEmBFHiIXFgwVFGSFDcY5ToWviFeQKjzCwk185Ccu0sJNcu
        YGRexSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZguTv87/mkH49dLSYcYBTgYlXh4N8gp
        RguxJpYVV+YeYpTgYFYS4fV7oRAtxJuSWFmVWpQfX1Sak1p8iFGag0VJnDdOoy5KSCA9sSQ1
        OzW1ILUIJsvEwSnVwKh852JB7Bn7LUV7I++WSS7m7fy00bJ4ZeiPr2cP2y6dU8FukzRRW7cx
        rmf74/nrS489WCHCcMP9vmXp7ylhpkcuhe5Mt88KOtYiVb/Bvzbz3bNUm7YkS9viyWff7cmX
        Ofyp3DPAgMl294Yizw/8ovkCHEL1BmJWL/SnrOqcc2t2mtux8oSQc0osxRmJhlrMRcWJAG1l
        vR8TAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsVy+t/xy7otjorRBm/eaVj8/7Cb0eLK1/ds
        FpseX2O1mLj/LLvFib4PrBaXd81hs2ictI3JomvhDXaL5sfqDpwel/t6mTzuXNvD5nG/+ziT
        x+Yl9R7v911l8/i8SS6ALYrLJiU1J7MstUjfLoEr4/+fZUwFjTwVhy8eYm9gvM7ZxcjJISFg
        IvFu0kumLkYuDiGBJYwSt3euYoRw/jJKfF6+mgWkik3ASmJiO0iCk0NEwF+i//kSVpAiZoGb
        TBLHPvxnBkkIC6RKTNn/CqyIRUBVoqlxMlicV0BTYvv/7WwgtqiAl8SWfe1MIDanQLDE7OdL
        mCG23WOUONi7kh2iQVDix+R7YJuZBeQl9u2fygpha0ms33mcaQIj/ywkZbOQlM1CUraAkXkV
        o0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYKhvO/Zzyw7GrnfBhxgFOBiVeHg3yClGC7EmlhVX
        5h5ilOBgVhLh9XuhEC3Em5JYWZValB9fVJqTWnyIUZqDRUmc97xBZZSQQHpiSWp2ampBahFM
        lomDU6qB0a5A604c7057g10GupPSfB/3ZAZVfrHYXpQSKLCNfV9O9qedqY2CAdv4NQ9p9RV+
        ljq8I7iObU/Wd3ubzxIHyy+UX7pRbFx1VOuYd8ay2LM269i2KWfq3uEq0hE8sDLF3kbShIez
        65+uYE63uJLZ0+mL5ExNQyP+ra9aysVxLi335JLwlMlKLMUZiYZazEXFiQC/5P3ycQIAAA==
X-CMS-MailID: 20180613160836eucas1p2877b4afb58fde464bdbc484875785f1f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180613154552epcas5p4877f53310b66cf9d3e17196b0d028e41
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
        <CGME20180613154552epcas5p4877f53310b66cf9d3e17196b0d028e41@epcas5p4.samsung.com>
        <CAKv+Gu9+M8zOtACPQ4_UMgp-M1LfZnciYe1VTQNqn_zNWJea4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 13, 2018 05:45:48 PM Ard Biesheuvel wrote:
> On 18 May 2018 at 16:17, Sinan Kaya <okaya@codeaurora.org> wrote:
> > A host bridge is allowed to remap BAR addresses using _TRA attribute in
> > _CRS windows.
> >
> > pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
> > pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
> >
> > When a VGA device is behind such a host bridge and the resource is
> > translated efifb driver is trying to do ioremap against bus address
> > rather than the resource address and is failing to probe.
> >
> > efifb: probing for efifb
> > efifb: cannot reserve video memory at 0x1e000000
> > efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
> > efifb: mode is 800x600x32, linelength=3200, pages=1
> > efifb: scrolling: redraw
> > efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> >
> > Use the host bridge offset information to convert bus address to
> > resource address in the fixup.
> >
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Bartlomiej, could you please take these via the fbdev tree for v4.19?

Sure, I will queue it after the current merge window.

> Peter already gave his ack but Sinan dropped it (presumably because of
> the split in v2)

Peter, can I (re)add your ACK to V2 patches?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

