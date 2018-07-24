Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9224DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416722064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qA8e0Z4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416722064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbeGXQbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:31:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56943 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388320AbeGXQbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:31:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180724152442euoutp01262e83c4732a7c405cc8f2cf4e0ed3d5~EV2kZKz5j0363003630euoutp01_;
        Tue, 24 Jul 2018 15:24:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180724152442euoutp01262e83c4732a7c405cc8f2cf4e0ed3d5~EV2kZKz5j0363003630euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532445882;
        bh=0hDzloPqThAZv5g/z/YwjxpDd4TqnvwwIg6WwL0L67Y=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=qA8e0Z4Cx8140l2WrU40VW9crR6XDPJ7b6yWgd/lPswZQ84CgrdzHH/uGKay0vBHn
         oDfgXUfOHbtDi3PQKztbm1pzSaGP08YIJwBdPWg6imVT7k3zLXBjnqTo5r/tgEsOy5
         lZJmf69QmojGLAlWuQ6TD9/8KSxzDJJvvqJzQJoo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724152441eucas1p19aa4616b0e5b62ef94efd1b467effc6c~EV2kEnhHH1614516145eucas1p1q;
        Tue, 24 Jul 2018 15:24:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D1.38.04627.9B4475B5; Tue, 24
        Jul 2018 16:24:41 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724152440eucas1p1f326ef1b8ad7a286360bf4bb98ed16c7~EV2jRuCuI1613316133eucas1p1Q;
        Tue, 24 Jul 2018 15:24:40 +0000 (GMT)
X-AuditID: cbfec7f2-0edff70000021213-aa-5b5744b9b55f
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 87.55.04183.8B4475B5; Tue, 24
        Jul 2018 16:24:40 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD008PMMT44M70@eusync4.samsung.com>; Tue, 24 Jul
        2018 16:24:40 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Kees Cook <keescook@chromium.org>,
        Jan =?ISO-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video/console/vgacon: Print big fat warning with
 nomodeset
Date:   Tue, 24 Jul 2018 17:24:40 +0200
Message-id: <2310317.6avsyZ3xgb@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180702210442.18648-1-lyude@redhat.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7djP87o7XcKjDQ72ylksacqwuPL1PZvF
        lpNfmC3OdOdanOj7wGpxedccNoupu/tZHdg9dv3ewuYxu+Eii8eCTaUe97uPM3m833eVzePz
        JrkAtigum5TUnMyy1CJ9uwSujLVPNrEVvOSueDRzMWMD4wHOLkZODgkBE4lLq3sYuxi5OIQE
        VjBKbNuwiB3C+cwo8efYXiaYqrOfTzBBJJYxSmy/Ph/K+c0osejCFhaQKjYBK4mJ7asYQWwR
        AUWJyR8mgI1iFnjBKPHg4zywImGBQInHdzeCjWURUJWYNWsbM4jNK6Ap8enyYVYQW1TAS2LL
        vnawGk4BM4kXTy+wQdQISvyYfA9sDrOAvMS+/VNZIWwdibPH1oE9ISGwh01i9/b/jBB3u0g0
        vJgM9YOwxKvjW9ghbBmJy5O7WSAapjNKvPm1FMpZzyix5swxqA5ricPHL0Kt4JOYtG060Kkc
        QHFeiY42IYgSD4kFe69BQ6yTUeLL3dvMExhlZiG5dhaSa2chuXYBI/MqRvHU0uLc9NRiw7zU
        cr3ixNzi0rx0veT83E2MwNRw+t/xTzsYv15KOsQowMGoxMP7wS48Wog1say4MvcQowQHs5II
        7yJRoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeOI26KCGB9MSS1OzU1ILUIpgsEwenVAPjfFc+
        Bwn1y5ZzpvWonQtsOnWV12e6vq3G8qQTO2rDPCv8267c2fny5rPIN3zsD/s3Sv+4pJTqY1c5
        O/J8XUFfwEo+pt/eolKqwY35H+xiJ8ovahPyTWp2Efzj7bRXMHjVIv0Mm4B783bn3W/8MPVD
        V9lJS+tW+dM23mLBrkGrZHpe8wpOS1RiKc5INNRiLipOBABfk/RcCQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsVy+t/xa7o7XMKjDRp3aVosacqwuPL1PZvF
        lpNfmC3OdOdanOj7wGpxedccNoupu/tZHdg9dv3ewuYxu+Eii8eCTaUe97uPM3m833eVzePz
        JrkAtigum5TUnMyy1CJ9uwSujLVPNrEVvOSueDRzMWMD4wHOLkZODgkBE4mzn08wgdhCAksY
        JT6sDu9i5AKy/zJKtBxexAiSYBOwkpjYvgrMFhFQlJj8YQI7SBGzwAtGibdtM9lAEsIC/hJN
        L++ygtgsAqoSs2ZtYwaxeQU0JT5dPgwWFxXwktiyrx1sG6eAmcSLpxfYILZ1M0rs7trFBNEg
        KPFj8j0WEJtZQF5i3/6prBC2lsT6nceZJjDyz0JSNgtJ2SwkZQsYmVcxiqSWFuem5xYb6RUn
        5haX5qXrJefnbmIEhvS2Yz+37GDsehd8iFGAg1GJh9fDMTxaiDWxrLgy9xCjBAezkgjvIlGg
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd7zBpVRQgLpiSWp2ampBalFMFkmDk6pBsaj344UFzBY
        9f5ZtEelOfW8qy2T4781t5nFIn1XF25ZfDx2/8b/krVfGF46iD+d37TON8tfWae/fWq91yc3
        510lch0RJbflVsdL/qhWdd/34tc7Lz81u63hgXFWZyY+mXvs/40vqp1Kqbueeh7MeVTrInvu
        lt6Zf3GnHSRu3nBhdkt6kmzT/EGJpTgj0VCLuag4EQA0m/TkZQIAAA==
X-CMS-MailID: 20180724152440eucas1p1f326ef1b8ad7a286360bf4bb98ed16c7
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180702210516epcas3p151aefd4a0217c4cd30143147f0bafe1d
References: <CGME20180702210516epcas3p151aefd4a0217c4cd30143147f0bafe1d@epcas3p1.samsung.com>
        <20180702210442.18648-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 02, 2018 05:04:40 PM Lyude Paul wrote:
> It's been a pretty good while since kernel modesetting was introduced.
> It has almost entirely replaced previous solutions which required
> userspace modesetting, and I can't even recall any drivers off the top
> of my head for modern day hardware that don't only support one or the
> other. Even nvidia's ugly blob does not require the use of nomodeset,
> and only requires that nouveau be blacklisted.
> 
> Effectively, the only thing nomodeset does in the year 2018 is disable
> your graphics drivers. Since VESA is a thing, this will give many users
> the false impression that they've actually fixed an issue they were
> having with their machine simply because the laptop will boot up to a
> degraded GUI. This of course, is never actually the case.
> 
> Things get even worse when you consider that there's still an enormous
> amount of tutorials users find on the internet that still suggest adding
> nomodeset, along with various users who have been around long enough to
> still suggest it.
> 
> There really isn't any legitimate reason I can see for this to be an
> option that's used by anyone else other then developers, or properly
> informed users. So, let's end the confusion and start printing warnings
> whenever it's enabled.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

