Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5AAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C7B2402F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bsB6GVJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C7B2402F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933663AbeFVKMB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:12:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56657 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933214AbeFVKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:11:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180622101156euoutp0261872b1bade14a539452d51c61ad06ff~6c8W587ja0462904629euoutp02z;
        Fri, 22 Jun 2018 10:11:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180622101156euoutp0261872b1bade14a539452d51c61ad06ff~6c8W587ja0462904629euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529662316;
        bh=8ETRikVpVQsvePX8qOzZTA5Mnw1G5+RSHMGeQiF2Hds=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=bsB6GVJXcpeDam3W/lRsvvmDJZ9kbzg6bXhu7VpHNzthk66+t//U4b3gOKs1i5EFu
         VJxDCmXS6RJ4VIeP5YLd8HM2Rg/uHwLRkfadb4N/vkLa19XoUhE2RwlXK1BtJ+VEce
         JKGMoiy6UmwKRo7whNdQBeQSlU9kj2IDW5u9msyE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180622101155eucas1p17519605a9e90d44e53a8db2993f310a3~6c8V738nC0996509965eucas1p1M;
        Fri, 22 Jun 2018 10:11:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9D.53.17380.A6BCC2B5; Fri, 22
        Jun 2018 11:11:54 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180622101154eucas1p2bec1bdf0e82d5c2c6dbdb71f95f43d69~6c8UyI3jR2901329013eucas1p2N;
        Fri, 22 Jun 2018 10:11:54 +0000 (GMT)
X-AuditID: cbfec7f4-713ff700000043e4-4f-5b2ccb6aab5c
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FD.B7.04183.A6BCC2B5; Fri, 22
        Jun 2018 11:11:54 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PAP00DGVYZTX480@eusync4.samsung.com>; Fri, 22 Jun
        2018 11:11:54 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Sinan Kaya <okaya@codeaurora.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 1/2] efi/fb: Simplify fixup code to prefer struct
 resource
Date:   Fri, 22 Jun 2018 12:11:53 +0200
Message-id: <1548378.AvPlWv1vxJ@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <CAKv+Gu-LkJBa+QKwROqWApfKHjZ8huDYPi9FanU2AhKECv=dog@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZduzned2s0zrRBue3W1r8/7Cb0eLK1/ds
        FpseX2O1mLj/LLvFib4PrBaXd81hs2ictI3JomvhDXaL5sfqDpwel/t6mTzuXNvD5nG/+ziT
        x+Yl9R7v911l8/i8SS6ALYrLJiU1J7MstUjfLoEr4/zaZ8wFR1gqGpu+MjUw3mfuYuTkkBAw
        kZjT8oOpi5GLQ0hgBaPE+bYvUM5nRok3DYvhqu5v2giVWMYoceHxE3YI5zejxMd9qxlBqtgE
        rCQmtq8Csjk4RAT0JFq6zEBqmAV+MEnsnXCcCaRGWCBY4selV2A2i4CqROetrWA2r4CmxLs/
        29hAbFEBL4kt+9rB4pxA9fffHWaDqBGU+DH5HguIzSwgL7Fv/1RWCFtH4uyxdYwgyyQEzrBJ
        HNq9iQ3ibBeJlx+PQNnCEq+Ob2GHsGUkLk/uZoFomA7056+lUM56Rok1Z44xQVRZSxw+fhFq
        BZ/EpG3TmUFekxDglehoE4Io8ZB4/OQqNFzuMUr8annNMoFRZhaSa2chuXYWkmsXMDKvYhRP
        LS3OTU8tNspLLdcrTswtLs1L10vOz93ECEwXp/8d/7KDcdefpEOMAhyMSjy8ESu0o4VYE8uK
        K3MPMUpwMCuJ8Ob660QL8aYkVlalFuXHF5XmpBYfYpTmYFES543TqIsSEkhPLEnNTk0tSC2C
        yTJxcEo1MBa+1uA2e3a09KZPmvJh58j5n1e3pV+TKJbK6eLkPazYa5OYn/6eJ2nfxA9T2b79
        2uj/zFq40PuSt/INwRcbp7IzCDHolxR4XRRb1lKz0KFwbvEmT8moQ3UPdxXzrtxjXf/mvE5l
        oNrkCR4HNCrmp7+umia7f9VeSz7J5zv9PJ4I+IjK2oe/UGIpzkg01GIuKk4EANPIHZkTAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsVy+t/xa7pZp3WiDb4v5LD4/2E3o8WVr+/Z
        LDY9vsZqMXH/WXaLE30fWC0u75rDZtE4aRuTRdfCG+wWzY/VHTg9Lvf1MnncubaHzeN+93Em
        j81L6j3e77vK5vF5k1wAWxSXTUpqTmZZapG+XQJXxvm1z5gLjrBUNDZ9ZWpgvM/cxcjJISFg
        InF/00amLkYuDiGBJYwS/fcPM0M4fxklfrzdxwpSxSZgJTGxfRVjFyMHh4iAnkRLlxlIDbPA
        HyaJeXOfMoLUCAsES/y49IoJxGYRUJXovLUVzOYV0JR492cbG4gtKuAlsWVfO1icE6h+651d
        7BDL7jFK/Ol/AtUgKPFj8j0WEJtZQF5i3/6prBC2lsT6nceZJjDyz0JSNgtJ2SwkZQsYmVcx
        iqSWFuem5xYb6RUn5haX5qXrJefnbmIEBvq2Yz+37GDsehd8iFGAg1GJhzdihXa0EGtiWXFl
        7iFGCQ5mJRHeXH+daCHelMTKqtSi/Pii0pzU4kOM0hwsSuK85w0qo4QE0hNLUrNTUwtSi2Cy
        TBycUg2MV69KKH7Ok819nvnc5F5kPU92zdLnRUcOa88Iy/21fvd3q7mvTdf8vO2+RT7X8V+b
        YfLr+QdnF16sSNZIFKo4u2VqSXFWym+2fzlb98wMesTsa/Sw6cSmBObihY9WnZ1xjCN14Uzh
        3x0PmgKlm6651OjyRX5qOODRr132jYGnbco5g7kPnNZbKrEUZyQaajEXFScCAOIqMaJwAgAA
X-CMS-MailID: 20180622101154eucas1p2bec1bdf0e82d5c2c6dbdb71f95f43d69
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180613154216epcas4p16e6cac42e19f870f761ee3e735bc4dc3
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
        <CGME20180613154216epcas4p16e6cac42e19f870f761ee3e735bc4dc3@epcas4p1.samsung.com>
        <CAKv+Gu-LkJBa+QKwROqWApfKHjZ8huDYPi9FanU2AhKECv=dog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 13, 2018 05:42:11 PM Ard Biesheuvel wrote:
> On 18 May 2018 at 16:17, Sinan Kaya <okaya@codeaurora.org> wrote:
> > Get rid of base and size variables in favor of a struct resource.
> > The conditional for checking window can be replaced with
> > resource_contains().
> >
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

