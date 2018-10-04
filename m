Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D25C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2511B21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZUZV1OHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2511B21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJDSlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:41:32 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52596 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbeJDSlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:41:32 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181004114836euoutp0211796d22c6f3423ce33d324723d8cd4a~aZWcwaN171500115001euoutp02S
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 11:48:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181004114836euoutp0211796d22c6f3423ce33d324723d8cd4a~aZWcwaN171500115001euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538653716;
        bh=8qzniTjXSNfjbZKnBOetVIhoAHxLfI8rITm+H5LDUvQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZUZV1OHjN0oQNPfMJ2Kxv1Sy/Xa7uFQRiBANUY/6i0z6rw679C0dbZJ9A4VJcaHVm
         pRL6Jd999lXtpfDdEGbsme61WKDaY/vVWBANvUzrkePBVlfPZQlAYKFLAIfNEFJ71G
         +DGiVhDiaLxj47jDMst2XXyjQu/XxRHjBgMfWflY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181004114835eucas1p2ec36f3072967cdad56cae31a8922a9f8~aZWcLJ4ow0349503495eucas1p2n;
        Thu,  4 Oct 2018 11:48:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 68.6D.04806.31EF5BB5; Thu,  4
        Oct 2018 12:48:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181004114834eucas1p236dcc3d55686d347a82e79cc5b1628ba~aZWbN2bbZ0357203572eucas1p2e;
        Thu,  4 Oct 2018 11:48:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181004114834eusmtrp2aeade32a5f3e2768acd37f6f3e4a48c7~aZWbNCQwF1383813838eusmtrp2k;
        Thu,  4 Oct 2018 11:48:34 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-1a-5bb5fe13cd69
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C3.5B.04128.21EF5BB5; Thu,  4
        Oct 2018 12:48:34 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181004114834eusmtip2f19e8bce89f655d98a1ed5f3f37e425b~aZWa7vS8P1661416614eusmtip26;
        Thu,  4 Oct 2018 11:48:34 +0000 (GMT)
Subject: Re: [PATCH] ata: ep93xx: Use proper enums for directions
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Thu, 4 Oct 2018 13:48:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181004023754.15477-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduznOV3hf1ujDU5uU7dYfbefzeLYjkdM
        Fpd3zWGz+PC2xOLDhP9MDqweO2fdZfdYsKnU4/LZUo/Pm+QCWKK4bFJSczLLUov07RK4Mja1
        NzAXvOetePnyE2MD40euLkZODgkBE4mLDTtZuhi5OIQEVjBK7J7bzQrhfGGUmHnmKSNIlZDA
        Z0aJiZ0eXYwcYB2HWtggapYzSjxePYEdwnnPKLHj7BQ2kAZhAUeJVwemgjWLCBhItBxsAiti
        FmhnlPi+vZEJJMEmYCUxsX0VWBGLgIrE7n1fGUE2iApESPSfUQcJ8woISpyc+YQFxOYUsJOY
        u/4BM4jNDDTzyKI5rBC2vMT2t3OYQeZLCDSzSzRs+MsM0Vwm8ffoOnaIP10kdv9YCWULS7w6
        vgXKlpH4v3M+E0TzdEaJN7+WskA46xkl1pw5xgRRZS1x+PhFVoj/HSX2fvaEMPkkbrwVhDiC
        T2LStunMEGFeiY42IYhGNYkNyzawwazq2rmSGcL2kDix6wf7BEbFWUjenIXktVlIXlvAyLyK
        UTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMjMJGc/nf86w7GfX+SDjEKcDAq8fB2vNsSLcSa
        WFZcmXuIUYKDWUmE13DB1mgh3pTEyqrUovz4otKc1OJDjNIcLErivMvmbYwWEkhPLEnNTk0t
        SC2CyTJxcEo1MJaWivNPWBIsolJ45XJS1HmfNp53l+2+bLug/FxxX4xqywxfFamLc9adf/WE
        9eGskp931rw8lrV+Q0lpTNumxCW31h9atbtVIdJ7r8yHy/61kauuOS2LrPyp4jxr/w75UIXT
        +mFdTE1La/M/XI2foxFlF50W2hx5s6Fs19qzCSnm3FM09y+7eF+JpTgj0VCLuag4EQCjXn3E
        IAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xe7pC/7ZGGyzfa2Kx+m4/m8WxHY+Y
        LC7vmsNm8eFticWHCf+ZHFg9ds66y+6xYFOpx+WzpR6fN8kFsETp2RTll5akKmTkF5fYKkUb
        WhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZWxqb2AueM9b8fLlJ8YGxo9cXYwc
        HBICJhKHWti6GLk4hASWMko8fLqRHSIuI3F8fVkXIyeQKSzx51oXVM1bRomZx/ewgSSEBRwl
        Xh2YyghiiwgYSLQcbGKHKJrIKLFi7QmwBLNAO6PExXsBIDabgJXExPZVYHFeATuJc42LmUBs
        FgEVid37voLFRQUiJG497GCBqBGUODnzCZjNCVQ/d/0DZoiZehI7rv9ihbDlJba/ncM8gVFw
        FpKWWUjKZiEpW8DIvIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwPrYd+7llB2PXu+BDjAIc
        jEo8vB3vtkQLsSaWFVfmHmKU4GBWEuE1XLA1Wog3JbGyKrUoP76oNCe1+BCjKdATE5mlRJPz
        gbGbVxJvaGpobmFpaG5sbmxmoSTOe96gMkpIID2xJDU7NbUgtQimj4mDU6qBMVXq+QFp3zss
        0pHbBN5PC+fwlkhv+eJ/7SKb1+3XPXOrPJUnOjaemSlisvHVgyQ9sUkMFjm9Gq+7qz8tqDA0
        trSNcW3Wjvl1b1/rpZkShtvU1zk9f1A5L6tR5olybUylhUrHOtZi0eevMtcw7dW6+dCyIEth
        9s95MvsZPj9+GT5TV4X71McdSizFGYmGWsxFxYkAwiVahaUCAAA=
Message-Id: <20181004114834eucas1p236dcc3d55686d347a82e79cc5b1628ba~aZWbN2bbZ0357203572eucas1p2e@eucas1p2.samsung.com>
X-CMS-MailID: 20181004114834eucas1p236dcc3d55686d347a82e79cc5b1628ba
X-Msg-Generator: CA
X-RootMTR: 20181004023814epcas3p163f7ce4d927c86d837015cdbe58c2936
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181004023814epcas3p163f7ce4d927c86d837015cdbe58c2936
References: <CGME20181004023814epcas3p163f7ce4d927c86d837015cdbe58c2936@epcas3p1.samsung.com>
        <20181004023754.15477-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/04/2018 04:37 AM, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another.
> 
> drivers/ata/pata_ep93xx.c:662:36: warning: implicit conversion from
> enumeration type 'enum dma_data_direction' to different enumeration type
> 'enum dma_transfer_direction' [-Wenum-conversion]
>         drv_data->dma_rx_data.direction = DMA_FROM_DEVICE;
>                                         ~ ^~~~~~~~~~~~~~~
> drivers/ata/pata_ep93xx.c:670:36: warning: implicit conversion from
> enumeration type 'enum dma_data_direction' to different enumeration type
> 'enum dma_transfer_direction' [-Wenum-conversion]
>         drv_data->dma_tx_data.direction = DMA_TO_DEVICE;
>                                         ~ ^~~~~~~~~~~~~
> drivers/ata/pata_ep93xx.c:681:19: warning: implicit conversion from
> enumeration type 'enum dma_data_direction' to different enumeration type
> 'enum dma_transfer_direction' [-Wenum-conversion]
>         conf.direction = DMA_FROM_DEVICE;
>                        ~ ^~~~~~~~~~~~~~~
> drivers/ata/pata_ep93xx.c:692:19: warning: implicit conversion from
> enumeration type 'enum dma_data_direction' to different enumeration type
> 'enum dma_transfer_direction' [-Wenum-conversion]
>         conf.direction = DMA_TO_DEVICE;
>                        ~ ^~~~~~~~~~~~~
> 
> Use the equivalent valued enums from the expected type so that Clang no
> longer warns about a conversion.
> 
> DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1
> DMA_FROM_DEVICE = DMA_DEV_TO_MEM = 2
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
