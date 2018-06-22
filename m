Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADE6C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5925524007
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G8fnIZuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5925524007
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbeFVKH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:07:58 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38804 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbeFVKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:07:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180622100752euoutp01822cb8f9546a32b8746faca3a2da40d3~6c4zvxb3E2212022120euoutp01q;
        Fri, 22 Jun 2018 10:07:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180622100752euoutp01822cb8f9546a32b8746faca3a2da40d3~6c4zvxb3E2212022120euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529662072;
        bh=DaXRdSa4Ep7EFaPBnFrunhniPvETVb/W22+FbHdOuh0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=G8fnIZuJeVYi0LVj/eSraQGSq3AnTJlHP5tikiwKCU9CoW4AFOqBDtBUdnwrs9fKg
         K0hKb70ihJms4e5mOHKDLGVqktdhNyIsTEJAz7R5QYuxexXjhNAv4dj9q4+BxZwCtT
         PoaQeIaYD/8oqyTY+c/iRE2LcVZaLX5QpYMVg/FE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180622100751eucas1p1df55f997f9e76d4eab0b7f989c97f2da~6c4ya7nQ-1800918009eucas1p10;
        Fri, 22 Jun 2018 10:07:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 20.9B.05700.67ACC2B5; Fri, 22
        Jun 2018 11:07:50 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180622100749eucas1p2a47cfba3b4d3d5004e9a0068917d5616~6c4xO6x-_1860018600eucas1p24;
        Fri, 22 Jun 2018 10:07:49 +0000 (GMT)
X-AuditID: cbfec7f2-1c1ff70000011644-7b-5b2cca7671c7
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 13.FB.04178.57ACC2B5; Fri, 22
        Jun 2018 11:07:49 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync3.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PAP002R1YT1C670@eusync3.samsung.com>; Fri, 22 Jun
        2018 11:07:49 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Peter Jones <pjones@redhat.com>, Sinan Kaya <okaya@codeaurora.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
Date:   Fri, 22 Jun 2018 12:07:48 +0200
Message-id: <12969617.N13u7zUTf5@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <CAKv+Gu9dFGudOr1uTmOnM=X47gsOAgpdUJ6UMiDJJ_7phH1ZzA@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djP87plp3SiDX68ULf4/2E3o8WVr+/Z
        LDY9vsZqMXH/WXaLE30fWC0u75rDZtE4aRuTRdfCG+wWzY/VHTg9Lvf1MnncubaHzeN+93Em
        j81L6j3e77vK5vF5k1wAWxSXTUpqTmZZapG+XQJXxp65qxgLTgpUHNzg2cA4nbeLkZNDQsBE
        4s/5f4xdjFwcQgIrGCUOLNjHDpIQEvjMKLHvkRRM0ep3zWwQRcsYJa4+nMMC4fxmlLh58DYT
        SBWbgJXExPZVQKM4OEQE9CRausxAapgFfjFJnJvUxgZSIyyQKjFl/ytGEJtFQFXiVtcWsDiv
        gJbE7bPTWUBsUQEviS372sFmcgoES8y4uoQFokZQ4sfke2A2s4C8xL79U1khbB2Js8fWgb0g
        IXCZTeLl+qlMEGe7SNw/0cMCYQtLvDq+hR3ClpHo7DjIBNEwnVHiza+lLBDOekaJNWeOQXVb
        Sxw+fhFqBZ/EpG3TmUFekxDglehoE4Io8ZD4tmYeEyQo/jFKXD85m2UCo8wsJNfOQnLtLCTX
        LmBkXsUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYKk7/O/5pB+PXS0mHGAU4GJV4eCNW
        aEcLsSaWFVfmHmKU4GBWEuHN9deJFuJNSaysSi3Kjy8qzUktPsQozcGiJM4bp1EXJSSQnliS
        mp2aWpBaBJNl4uCUamDc+ua4kdGT5790n0c4ff8sUV2ktulncLeLtXXaSea9dRMW8CovWvAu
        lf2PyEel6cd3L1n2KZq1/PJ+/kidrU4vFXO9pr6+Yfr/cl/R1P/bT+23U563PHZrz66NPJtn
        9i+3d0urrl/2poeZSz4k+4PKjl2f+5yeW8SJvCkPNdY4Um3bWc7Sd5RViaU4I9FQi7moOBEA
        c0FychEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsVy+t/xq7qlp3SiDc5dk7L4/2E3o8WVr+/Z
        LDY9vsZqMXH/WXaLE30fWC0u75rDZtE4aRuTRdfCG+wWzY/VHTg9Lvf1MnncubaHzeN+93Em
        j81L6j3e77vK5vF5k1wAWxSXTUpqTmZZapG+XQJXxp65qxgLTgpUHNzg2cA4nbeLkZNDQsBE
        YvW7ZrYuRi4OIYEljBJ/Ly5kh3D+MkpMm/uHBaSKTcBKYmL7KsYuRg4OEQE9iZYuM5AaZoFf
        TBJTT68AqxEWSJWYsv8VI4jNIqAqcatrCxuIzSugJXH77HSwGlEBL4kt+9qZQGxOgWCJyXse
        MUMsW8UosefqL3aIBkGJH5PvgTUwC8hL7Ns/lRXC1pJYv/M40wRG/llIymYhKZuFpGwBI/Mq
        RpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwDDfduzn5h2MlzYGH2IU4GBU4uGNWKEdLcSaWFZc
        mXuIUYKDWUmEN9dfJ1qINyWxsiq1KD++qDQntfgQozQHi5I473mDyighgfTEktTs1NSC1CKY
        LBMHp1QDo/re1FPdnvtW7co6vyWm9PufW7/VCuw+ty6RM+rdKKIVnmtltep5uu2uJWz8fYzJ
        Eb/ev6xd6aBx4/rir4+/+Dy7/lCM41JE1e7fJeL33y5JWx++0nTST83p99PX37f03iFuFzf5
        WvLl93PTDKtWWf/amDrpBKvDnNqCafzzl0zjet1lcJn95j8lluKMREMt5qLiRADrpBDAbwIA
        AA==
X-CMS-MailID: 20180622100749eucas1p2a47cfba3b4d3d5004e9a0068917d5616
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180622100749eucas1p2a47cfba3b4d3d5004e9a0068917d5616
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
        <6376822.ENUjdQ58sn@amdc3058>
        <CAKv+Gu9dFGudOr1uTmOnM=X47gsOAgpdUJ6UMiDJJ_7phH1ZzA@mail.gmail.com>
        <CGME20180622100749eucas1p2a47cfba3b4d3d5004e9a0068917d5616@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 22, 2018 09:54:22 AM Ard Biesheuvel wrote:
> On 13 June 2018 at 18:08, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > On Wednesday, June 13, 2018 05:45:48 PM Ard Biesheuvel wrote:
> >> On 18 May 2018 at 16:17, Sinan Kaya <okaya@codeaurora.org> wrote:
> >> > A host bridge is allowed to remap BAR addresses using _TRA attribute in
> >> > _CRS windows.
> >> >
> >> > pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
> >> > pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
> >> >
> >> > When a VGA device is behind such a host bridge and the resource is
> >> > translated efifb driver is trying to do ioremap against bus address
> >> > rather than the resource address and is failing to probe.
> >> >
> >> > efifb: probing for efifb
> >> > efifb: cannot reserve video memory at 0x1e000000
> >> > efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
> >> > efifb: mode is 800x600x32, linelength=3200, pages=1
> >> > efifb: scrolling: redraw
> >> > efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> >> >
> >> > Use the host bridge offset information to convert bus address to
> >> > resource address in the fixup.
> >> >
> >> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> >>
> >> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>
> >> Bartlomiej, could you please take these via the fbdev tree for v4.19?
> >
> > Sure, I will queue it after the current merge window.
> >
> >> Peter already gave his ack but Sinan dropped it (presumably because of
> >> the split in v2)
> >
> > Peter, can I (re)add your ACK to V2 patches?
> >
> 
> Actually, it would be better if we could take this through the EFI
> tree instead, with your ack. Would you mind?

Fine with me.

> There are some other efifb changes coming up, some of which depend on
> core EFI changes, and taking these through different trees is going to
> be more trouble than it's worth.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

