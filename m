Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23EFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6587D20881
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KcSp2IvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6587D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388423AbeGXQSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:18:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53509 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388385AbeGXQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:18:29 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180724151132euoutp014883e6860fb96b63e1d9bf6472c465f6~EVrFQaxA33007330073euoutp01M;
        Tue, 24 Jul 2018 15:11:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180724151132euoutp014883e6860fb96b63e1d9bf6472c465f6~EVrFQaxA33007330073euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532445092;
        bh=e85qUkYuh4HzBB0/S1Xjpq8/1mCodekAgiivAafhUoo=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=KcSp2IvHbbR6D/SdvqQKGi8jCKELpGaNrZTHW6E9KTu56c8GKIPvZRCl1Ze9EuZqS
         KCV44T6F3lghNbDRtM5qd6sIWnfS8W8/5CwA2Cb+4MNQcNXOxXrnuCircNlAwpcW0J
         wWdt47u3ADei8W1Nru8OUQbvAkLeMW1R1O+5sBLY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724151132eucas1p2171c4fb2ea0baa91c56471939020e277~EVrE251_C1523615236eucas1p2w;
        Tue, 24 Jul 2018 15:11:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E4.F6.04627.4A1475B5; Tue, 24
        Jul 2018 16:11:32 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724151131eucas1p11cb246a494bcb2cebb27b81d9621b6e8~EVrEKE9Il1642416424eucas1p13;
        Tue, 24 Jul 2018 15:11:31 +0000 (GMT)
X-AuditID: cbfec7f2-0d3ff70000021213-71-5b5741a4f389
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AB.14.04183.3A1475B5; Tue, 24
        Jul 2018 16:11:31 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD00JM9M77BL40@eusync4.samsung.com>; Tue, 24 Jul
        2018 16:11:31 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Timur Tabi <timur@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: fsl-diu-fb: Remove VLA usage
Date:   Tue, 24 Jul 2018 17:11:30 +0200
Message-id: <30654789.W1eWMCegYZ@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1b3f78f2-9fe9-62c5-24d2-1b6651ca2f08@kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWy7djPc7pLHMOjDY5/YbW48vU9m8WZ7lyL
        E30fWC0u75rDZnHit7oDq8fshossHptWdbJ53O8+zuTxeZNcAEsUl01Kak5mWWqRvl0CV8bH
        HRtZCu6wVnx/eYi1gfE6SxcjJ4eEgInErxkr2bsYuTiEBFYwSrScuM8G4XxmlFi9fyUTTNXF
        zgtMEIlljBK3HkxnhHB+M0pc/NvODFLFJmAlMbF9FSOILSLgIvHh5B2wHcwCCRJfbn4GqxEW
        sJfovgxhswioSuz/sROshldAS2L64lWsILaogJfEln3tQNs4ODgF7CSW9gpBlAhK/Jh8D2qk
        vMS+/VNZIWwdibPH1oHdIyEwh01iT890ZoirXSS2LjsL9aewxKvjW9ghbBmJy5O7WSAapjNK
        vPm1FMpZzyix5swxqJ+tJQ4fvwi1gk9i0jaQqRxAcV6JjjYhCNND4vOUUEhAbGKUWP5kAdsE
        RplZSI6dheTYWUiOXcDIvIpRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMw3k//O/5pB+PX
        S0mHGAU4GJV4eD/YhUcLsSaWFVfmHmKU4GBWEuFdJAoU4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zhunURclJJCeWJKanZpakFoEk2Xi4JRqYBRWZyz9p3zt4robBqcU5mccbn25uXf+ZUmTsHdu
        QZrsDPN2X2id9tN68nrvzV1B8YZqLd5ZTR6t63W5S0pm5vUFKBb6+/672HicKUda++x/hRkn
        NuuWhSz2jit2MW0T37i+52fGyTn3jNuk/z29dT+tpHHinefzAgS26j64o8K8V69avkD0hxJL
        cUaioRZzUXEiACEV503zAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsVy+t/xa7qLHcOjDZZME7K48vU9m8WZ7lyL
        E30fWC0u75rDZnHit7oDq8fshossHptWdbJ53O8+zuTxeZNcAEsUl01Kak5mWWqRvl0CV8bH
        HRtZCu6wVnx/eYi1gfE6SxcjJ4eEgInExc4LTF2MXBxCAksYJX5d62WFcP4ySlztOcwGUsUm
        YCUxsX0VI4gtIuAi8eHkHbBuZoEEiU33p4LVCAvYS3Rf/swMYrMIqErs/7ETrIZXQEti+uJV
        rCC2qICXxJZ97UDbODg4BewklvYKQezaxChx+Nw7Roh6QYkfk+9BzZeX2Ld/KiuErSWxfudx
        pgmM/LOQlM1CUjYLSdkCRuZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgaG67djPLTsYu94F
        H2IU4GBU4uH1AIawEGtiWXFl7iFGCQ5mJRHeRaJAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzn
        DSqjhATSE0tSs1NTC1KLYLJMHJxSDYx7p1xWP7hfqK7EdOnc+KKb7z8dbMoNubP8756dR3Ll
        /XOL/v4RcvzYqF/OV+wlHnCGVyX9UU3LudXWGXmz+Npvnr4e4PtwQ37IxvlSoW73bnp0rz1+
        QfX6rro563hcT0YFfv6q48B617VF2rLrKddr2S+e0Ton38eJR2zuC7GTL1UwSrCS3KXEUpyR
        aKjFXFScCADqB+HyUQIAAA==
X-CMS-MailID: 20180724151131eucas1p11cb246a494bcb2cebb27b81d9621b6e8
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180630155937epcas3p391d051b484a76fb57f0c385a89e2be04
References: <20180629184655.GA37391@beast>
        <CGME20180630155937epcas3p391d051b484a76fb57f0c385a89e2be04@epcas3p3.samsung.com>
        <1b3f78f2-9fe9-62c5-24d2-1b6651ca2f08@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, June 30, 2018 10:59:15 AM Timur Tabi wrote:
> On 6/29/18 1:46 PM, Kees Cook wrote:
> > In the quest to remove all stack VLA usage from the kernel[1], this moves
> > the buffer off the stack (since it could be as much as 1024 bytes), and
> > uses a new area in the cursor data structure. Additionally adds missed
> > documentation and removes redundant assignments.
> > 
> > [1]https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> > 
> > Signed-off-by: Kees Cook<keescook@chromium.org>
> 
> Acked-by: Timur Tabi <timur@kernel.org>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

