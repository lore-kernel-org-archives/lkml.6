Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD10C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F092084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mtXo+hFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F092084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbeKLKIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:08:39 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:54810 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbeKLKIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 05:08:37 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181112001806epoutp04f0de84c0667e44787301af70829abed1~mOFsgjZ5A2543325433epoutp04c;
        Mon, 12 Nov 2018 00:18:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181112001806epoutp04f0de84c0667e44787301af70829abed1~mOFsgjZ5A2543325433epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541981886;
        bh=rVPkUIvpttXq9Po2Ci+mCk6uQjnDWJFRO/Lt7WIvO+E=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=mtXo+hFhLDJ4Nj/RGurQqxOIswSN2L7G4SysOUEC2cvxVjoUuQozyqoszPNOufEe/
         pflhuY4mLytMG+6Fy+NeEL6QzJ+m2l2ArtWdk5giDwSbZY8ongmTvS1RkgVx2ybkl0
         QSfV1k02kOsA4217L5taLuAkwEs7++DgnTCWCQeg=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181112001804epcas1p134eb5b6bcbac3fe8196c28b232a375f8~mOFqTiOVU1905919059epcas1p1R;
        Mon, 12 Nov 2018 00:18:04 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.8C.04069.AB6C8EB5; Mon, 12 Nov 2018 09:18:02 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181112001802epcas1p207a912865ea3702eee9bc5a4bb36657e~mOFof-vmb2865328653epcas1p2X;
        Mon, 12 Nov 2018 00:18:02 +0000 (GMT)
X-AuditID: b6c32a36-f2bff70000000fe5-e3-5be8c6ba8a42
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.2C.03701.9B6C8EB5; Mon, 12 Nov 2018 09:18:02 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PI200IJG0U1W840@mmp1.samsung.com>; Mon, 12 Nov 2018 09:18:01 +0900 (KST)
Message-id: <5BE8C6B9.1090609@samsung.com>
Date:   Mon, 12 Nov 2018 09:18:01 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 0/4] Fix common issue in MAX* extcon drivers
In-reply-to: <20181108134548.31140-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmvu6uYy+iDXoXSlpsnLGe1eL8+Q3s
        Fpd3zWGzmHF+H5PF2iN32S1uN65gc2Dz2LSqk82jb8sqRo/Pm+QCmKOybTJSE1NSixRS85Lz
        UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
        8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL89L1kvNzrQwNDIxMgQoTsjN+r7nKVvCNp+LjqQks
        DYzruboYOTgkBEwk7r8v7mLk4hAS2MEo8Wj/JhYI5zujxKf+v0AOJ1jR5BV72CESuxklrv27
        BpbgFRCU+DH5HgvIJGYBeYkjl7JBwswCmhJbd6+Hqr/LKLH//n12iHotiSt7toPZLAKqEheu
        dTGC2GxA8f0vbrCB2PwCihJXfzwGi4sKREjsnP8NrF5EoEjiV0MX2FBmgS5GiQnX97GCLBYW
        cJBo+cUBUsMpYCdx7d0XNpAaCYE9bBLH3s1ih/jAReLzn7NQ3whLvDq+hR3ifWmJS0dtIerb
        GSW+vGhmhXAmMEp8OLWZCaLBWOLZwi4miNf4JN597WGFaOaV6GgTgijxkOj4PYcR4uOJjBJP
        zp1gmcAoOwspkGYhAmkWUiAtYGRexSiWWlCcm55abFhghBx7mxjBaUzLbAfjonM+hxgFOBiV
        eHg1Sl9EC7EmlhVX5h5ilOBgVhLh/XsAKMSbklhZlVqUH19UmpNafIjRFBjGE5mlRJPzgSk2
        ryTe0NTI2NjYwsTQzNTQUEmc94nU3GghgfTEktTs1NSC1CKYPiYOTqkGxh1fTF32vhF5XdT3
        0Gfr7bj0TwLG7uInEi8Xvy8JnCn/R/EJy5u0uHOS5wKTJ7OXr2Zwfh6idOn00p16cZ2Bmaav
        31qm6yoeOeT+f9Nxy67vGb2H/+g+in10eeH9PpY3Uyxf5Z1Nv5x37MEBnbsZVVNLu58e/LlX
        1W2zl3nOk/odZySXNO3bEKDEUpyRaKjFXFScCADwauNqeQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsVy+t9jAd1dx15EG5ycy2KxccZ6Vovz5zew
        W1zeNYfNYsb5fUwWa4/cZbe43biCzYHNY9OqTjaPvi2rGD0+b5ILYI7isklJzcksSy3St0vg
        yvi95ipbwTeeio+nJrA0MK7n6mLk5JAQMJGYvGIPexcjF4eQwE5GiQ1zLzCBJHgFBCV+TL7H
        0sXIwcEsIC9x5FI2SJhZQF1i0rxFzBD19xklZv6YxwhRryVxZc92dhCbRUBV4sK1LrA4G1B8
        /4sbbCA2v4CixNUfjxlBZooKREh0n6gECYsIFEkcOfUe7AZmgR5GiW1Nq1hBaoQFHCRafnFA
        7JrMKPF05zIWkAZOATuJa+++sE1gFJiF5NRZCKfOQnLqAkbmVYySqQXFuem5xUYFhnmp5XrF
        ibnFpXnpesn5uZsYgcG87bBW3w7G+0viDzEKcDAq8fA2lL+IFmJNLCuuzD3EKMHBrCTC+/cA
        UIg3JbGyKrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6YklqdmpqQWpRTBZJg5OqQbGkneH5PYe
        XjCH+zu3SsBW9226yZ87/613tNr9fW3C3p/Fu9ulF5hxc8feKqy00T/feOyDzBK7a8t3r69c
        uULpi+hLz9bUk0lL0xdN+vZC8X3tN9etTLvnuK1ot8ieYRLd8OOSTMq2C0c2zTRZeq5ur64p
        v5vlVrUpGyc9kYlKXRherNZ484LpNSWW4oxEQy3mouJEAC4Tr7FiAgAA
X-CMS-MailID: 20181112001802epcas1p207a912865ea3702eee9bc5a4bb36657e
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181108134553eucas1p1a513f538b74fab263c3f143914d30720
References: <CGME20181108134553eucas1p1a513f538b74fab263c3f143914d30720@eucas1p1.samsung.com>
        <20181108134548.31140-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 2018년 11월 08일 22:45, Marek Szyprowski wrote:
> Hi All
> 
> Most MAX* MUIC drivers unconditionally force UART path during probe.
> This approach causes some issues, especially when board is booted with
> non-UART cable connected to micro-USB port. For example, when USB cable is
> connected, UART TX/RX lines are unconditionally short-circuited to USB
> D+/D- lines. This is in turn recognized by a series of serial BREAK
> signals and some random characters when USB host tries to perform
> enumeration procedure.
> 
> To solve the above issue and keep UART console operational as early as
> possible, set UART path only when USB ID reports UART capable cable.
> 
> This patchset fixes following MAX* extcon drivers: 8997, 14577, 77693
> and 77843.
> 
> Tested on following Samsung boards: Trats (8997), Rinato (14577), Trats2
> (77693) and TM2/TM2e (77843).
> 
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
> 
> 
> Patch summary:
> 
> Marek Szyprowski (4):
>   extcon: max77843: Avoid forcing UART path on drive probe
>   extcon: max77693: Avoid forcing UART path on drive probe
>   extcon: max14577: Avoid forcing UART path on drive probe
>   extcon: max8997: Avoid forcing UART path on drive probe
> 
>  drivers/extcon/extcon-max14577.c | 15 +++++++++++++--
>  drivers/extcon/extcon-max77693.c | 16 ++++++++++++++--
>  drivers/extcon/extcon-max77843.c | 18 +++++++++++++++---
>  drivers/extcon/extcon-max8997.c  | 15 +++++++++++++--
>  4 files changed, 55 insertions(+), 9 deletions(-)
> 

Applied them. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
