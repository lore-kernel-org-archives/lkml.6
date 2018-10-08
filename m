Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C5FC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4E820841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o2RSJPOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4E820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJHRvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:51:33 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52342 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbeJHRvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:51:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181008104027euoutp01f2241208892d399521fc91d78ec35b4b~bnAFdhQLD1400314003euoutp01N
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 10:40:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181008104027euoutp01f2241208892d399521fc91d78ec35b4b~bnAFdhQLD1400314003euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538995227;
        bh=+3YmCEeuseQ1z6FJUzkhevy8ADz2BdqnF8oCvtw4poQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=o2RSJPOADjaU5For2pInlnOkPligUy15EztRgmOfkla7yyjRzUVQGmdU+WXPBOjPz
         g0DucLshul9eYI9D7kJTiB9E97ofSYxC70eKCF1CSQdkrZlj6/05YVKpl4OlZJbSXR
         N3ZvdktNaNWH93OSbRpMyicvm4uUbn0gxZBXQr3I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008104026eucas1p189079ce61a7020c5ae6f9cf6d4baba68~bnAFADLTn2555025550eucas1p1A;
        Mon,  8 Oct 2018 10:40:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2D.48.04294.A143BBB5; Mon,  8
        Oct 2018 11:40:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181008104026eucas1p254120530a8d1c441deba6a548c99b002~bnAESLW6H1306713067eucas1p2N;
        Mon,  8 Oct 2018 10:40:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181008104025eusmtrp241ee19839473d41f6315b7423448bf91~bnAEBhHgN1514815148eusmtrp2Z;
        Mon,  8 Oct 2018 10:40:25 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-74-5bbb341a8f5f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 65.E5.04128.9143BBB5; Mon,  8
        Oct 2018 11:40:25 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181008104025eusmtip16551ad6c8a1f9ea89d2d38c5fbf0e5a0~bnADxvTPj2524125241eusmtip1c;
        Mon,  8 Oct 2018 10:40:25 +0000 (GMT)
Subject: Re: [PATCH] Video: vgastate: fixed a spacing coding style
To:     Mehdi Bounya <bounya9mehdi@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mehdi Bounya <contact.mehdi@pm.me>,
        Mehdi Bounya <mehdi.bounya@gmail.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Mon, 8 Oct 2018 12:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1535114948-18615-1-git-send-email-contact.mehdi@pm.me>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOV0pk93RBk+eK1lsO32I2WLV6YUs
        Fif6PrBaXN41h83izKyvjA6sHjtn3WX3OLrnHJvH501yAcxRXDYpqTmZZalF+nYJXBmXL05m
        K1jBVHF2wQamBsZPjF2MnBwSAiYSX/btZe9i5OIQEljBKPHh7DRmCOcLo8S+981gVUICnxkl
        Di10gOk40fyeDaJoOaPEsQffodrfM0rMntjLBlIlLOAkMfd/J1i3iICmxNvrhxhBipgFuhgl
        XjXeYQZJsAlYSUxsXwVWxCKgIrGxu5+pi5GDQ1QgQqL/jDpImFdAUOLkzCcsIDangIvE/cZJ
        YOXMAgYSRxbNYYWw5SW2v50DdraEQDO7xLHlf9ggmsskDh/8wARxtovE2h/32SFsYYlXx7dA
        2TIS/3fOZ4Jons4o8ebXUhYIZz2jxJozx6C6rSUOH7/ICmE7Slz6+Zwd5FIJAT6JG28FIa7g
        k5i0bTozRJhXoqNNCKJaTWLDsg1sMLu6dq6EKvGQ6D2tOYFRcRaSN2cheW0WktcWMDKvYhRP
        LS3OTU8tNspLLdcrTswtLs1L10vOz93ECEwjp/8d/7KDcdefpEOMAhyMSjy8KwJ2RQuxJpYV
        V+YeYpTgYFYS4RXdDhTiTUmsrEotyo8vKs1JLT7EKM3BoiTOu2zexmghgfTEktTs1NSC1CKY
        LBMHp1QDo9nBqPNss8Pc7ST/Mu0wfOvV2sK5ZZ36sqRWgcth3ceLmt3W/t5mEdwbxL/t/tb7
        8veyO66dmipza/uTU0vu9L5UnfRervb6wqsHohV4VRl4k/LW+d3IXqtXZN+mt/BVk8kD+yLv
        jp5jMj8upc3Tmv01wmJe/5yeX9Gvl/15xf794cfOMxblr5RYijMSDbWYi4oTAYFuEiQfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xu7qSJrujDW7NMLDYdvoQs8Wq0wtZ
        LE70fWC1uLxrDpvFmVlfGR1YPXbOusvucXTPOTaPz5vkApij9GyK8ktLUhUy8otLbJWiDS2M
        9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIuX5zMVrCCqeLsgg1MDYyfGLsYOTkk
        BEwkTjS/Z+ti5OIQEljKKLH69B0ghwMoISNxfH0ZRI2wxJ9rXVA1bxkllvXdZQFJCAs4Scz9
        3wk2SERAU+Lt9UOMEEXTGSUm93wH62AW6GKUeNE3mx2kik3ASmJi+yqwDl4BO4mT7UeYQWwW
        ARWJjd39TCC2qECExK2HHSwQNYISJ2c+AbM5BVwk7jdOAutlFtCT2HH9FyuELS+x/e0c5gmM
        grOQtMxCUjYLSdkCRuZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgfGx7djPLTsYu94FH2IU
        4GBU4uFdEbArWog1say4MvcQowQHs5IIr+h2oBBvSmJlVWpRfnxRaU5q8SFGU6AnJjJLiSbn
        A2M3ryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QDo/qmpAuz5OdE
        mEWKSAuG6MUn7JY8/vTHtvCEu35Jv6c8Ms5d/rDklkPo+94rj56W1yz7vvpY53b3QGMTLeMY
        p7SZq9XDqrd+jnN/2fVV4tV9pXJj23S+0DNnn1WFan3Vjvqc3bf1ivhujc4ml5UXP1dcX5TV
        ERZs0NLzRmZnyOdChdiVZaVySizFGYmGWsxFxYkAqxdm9aUCAAA=
Message-Id: <20181008104026eucas1p254120530a8d1c441deba6a548c99b002~bnAESLW6H1306713067eucas1p2N@eucas1p2.samsung.com>
X-CMS-MailID: 20181008104026eucas1p254120530a8d1c441deba6a548c99b002
X-Msg-Generator: CA
X-RootMTR: 20180824124948epcas3p48f943b2815163971258231dcbcbed6a4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180824124948epcas3p48f943b2815163971258231dcbcbed6a4
References: <CGME20180824124948epcas3p48f943b2815163971258231dcbcbed6a4@epcas3p4.samsung.com>
        <1535114948-18615-1-git-send-email-contact.mehdi@pm.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/24/2018 02:49 PM, Mehdi Bounya wrote:
> Removed a space between function name and open parant.
> 
> Signed-off-by: Mehdi Bounya <mehdi.bounya@gmail.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
