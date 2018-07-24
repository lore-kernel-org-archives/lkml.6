Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD8FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D97C20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZnVEgiOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D97C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbeGXSFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:05:46 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35783 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388415AbeGXSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:05:46 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180724165821euoutp02cee6ac7025d363082d137222aba9c292~EXIVrH7LG2986429864euoutp02U;
        Tue, 24 Jul 2018 16:58:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180724165821euoutp02cee6ac7025d363082d137222aba9c292~EXIVrH7LG2986429864euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532451501;
        bh=9tyD6ir9p7ZP3N0hDQNhc2o2GH4Ir7mchWMWgNE3L+k=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=ZnVEgiOVzVsZrKWvmq2Oy5AP6vqKmASSG82tQ2zRsQUsfloeqFmhB0AR0sZkeQE2k
         wlOVcQ3x1WVwGCsTjI1dhmNqUBGYqWEagWsWFKg+G4vSjFEEzJEm6ly6w4eTsGLN3S
         yt6xQughZ9nH00Lh3cQ2Bx6kgJxy846DrvkpBcc0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724165820eucas1p22ab5422b8595799990be3af5fe848b2b~EXIUtCwrD2568725687eucas1p2n;
        Tue, 24 Jul 2018 16:58:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 99.0E.04627.BAA575B5; Tue, 24
        Jul 2018 17:58:19 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724165819eucas1p1e1ffdecb438bb3c49ca65c880eeede34~EXIT-5QLN0676206762eucas1p1P;
        Tue, 24 Jul 2018 16:58:19 +0000 (GMT)
X-AuditID: cbfec7f2-0d3ff70000021213-29-5b575aabcae6
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B9.BD.04178.BAA575B5; Tue, 24
        Jul 2018 17:58:19 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD0033ZR57TV40@eusync1.samsung.com>; Tue, 24 Jul
        2018 17:58:19 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omapfb: encoder-tpd12s015: remove redundant pointer
 'in'
Date:   Tue, 24 Jul 2018 18:58:19 +0200
Message-id: <7824518.4rCHaMUqme@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180720185213.3085-1-colin.king@canonical.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWy7djPc7qro8KjDe632Vj8Xt3LZnHl63s2
        i623pC1O9H1gtbi8aw6bxewl/SwObB6zGnrZPO53H2fy+LxJLoA5issmJTUnsyy1SN8ugSuj
        5/YrpoJ/zBUrFx5ka2CczdzFyMkhIWAiMe/8c7YuRi4OIYEVjBLLt62Bcj4zSjx62MAGU3Xk
        0iRWiMQyRokrbUeYIJzfjBK7725gBKliE7CSmNi+Csjm4BAR0JQ4f64IpIZZYD6jxJ7NC8Em
        CQv4S+xqfQFWzyKgKrHrz3wwmxeovnnKArCbRAW8JLbsa2cCsTkFbCW6flxkhqgRlPgx+R4L
        iM0sIC+xb/9UVghbR+LssXWMIMskBBawSbyacYYd4mwXiS0zP0M9Kizx6vgWqLiMRGfHQSaI
        humMEm9+LWWBcNYzSqw5c4wJospa4vDxi1Ar+CQmbZvODPKahACvREebEESJh8SVpbtZIEEx
        gVGitWcF0wRGmVlIrp2F5NpZSK5dwMi8ilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzDq
        T/87/mkH49dLSYcYBTgYlXh4P9iFRwuxJpYVV+YeYpTgYFYS4TUNBArxpiRWVqUW5ccXleak
        Fh9ilOZgURLnjdOoixISSE8sSc1OTS1ILYLJMnFwSjUwhp6r1Vzk2qB5+36PhGG0Vun93IeL
        2WYfPd/5o6Lhy+bPrpMnbSuJkH+Xs68ia6Oc1TaJZ8rielkHRW/cLZht/t7Pi+ddf8W7A/PY
        yhm/fFsgzWTA3/H9of7x3ztS71b/PsDx3VQs1bLv6e8DYuftY8+/EXhx4g6vW0+BmwDDnkSn
        +J6CSZa2SizFGYmGWsxFxYkA2YXO3fYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsVy+t/xy7qro8KjDbatkLL4vbqXzeLK1/ds
        FltvSVuc6PvAanF51xw2i9lL+lkc2DxmNfSyedzvPs7k8XmTXABzFJdNSmpOZllqkb5dAldG
        z+1XTAX/mCtWLjzI1sA4m7mLkZNDQsBE4silSaxdjFwcQgJLGCWOL/gP5fxllDi88TQjSBWb
        gJXExPZVQDYHh4iApsT5c0UgNcwC8xkl3rxcywRSIyzgK3Hg0S6wqSwCqhK7/swH6+UFqm+e
        sgAsLirgJbFlXztYPaeArUTXj4vMEMsmMUqsWjqFBaJBUOLH5HtgNrOAvMS+/VNZIWwtifU7
        jzNNYOSfhaRsFpKyWUjKFjAyr2IUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAgM123Hfm7ewXhp
        Y/AhRgEORiUeXg/H8Ggh1sSy4srcQ4wSHMxKIrymgUAh3pTEyqrUovz4otKc1OJDjNIcLEri
        vOcNKqOEBNITS1KzU1MLUotgskwcnFINjFoemqub5qRzfZo+XziklMnwoscFI+Eo/UcXHl/d
        9SHuGd+Bj2u9uHzm6xfHfnqa0LHm+br579Ltyp6efv7jZUa304fPPbL1uW6pazlm6f16NK/J
        dK1rlkhknNpfbuOCzneb2Nt6nmZsWuy5XTRh+f1Onp+/Ga5HrdU/sMHshMxWs5PL/nKUsSmx
        FGckGmoxFxUnAgAC3OdlUwIAAA==
X-CMS-MailID: 20180724165819eucas1p1e1ffdecb438bb3c49ca65c880eeede34
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180720185219epcas1p2542795dbad64a8343ce7e9eff8dd7cce
References: <CGME20180720185219epcas1p2542795dbad64a8343ce7e9eff8dd7cce@epcas1p2.samsung.com>
        <20180720185213.3085-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 20, 2018 07:52:13 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer 'in' is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'in' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

