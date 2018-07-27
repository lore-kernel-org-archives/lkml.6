Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB65C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5817920673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SUGtQihT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5817920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeG0I61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:58:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41693 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbeG0I60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:58:26 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180727073748euoutp0266887db910758f38a0c05527b16b68e2~FKaxkUn6N0799507995euoutp02c
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 07:37:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180727073748euoutp0266887db910758f38a0c05527b16b68e2~FKaxkUn6N0799507995euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532677068;
        bh=D9FxbGf9jAtPOMXL4ZZXfyPDtjTGu8Ur+LLvn2EXEz4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SUGtQihT8RtyWROn/xrWfjRFys1e4cVwejy0kKxKx5XfM4bvekQn9EAcIp0uBvdbT
         Vfqp5RrlCWFNmb2swc/9pd0tVb8hTXTrRBDdxplPsfLtVX27bhP2jTdFc/Y+RRpegi
         cVcjbHBGr1Bek92bVklCI219P/NBVBUuIlbCpt0o=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180727073747eucas1p121760a55edbd1c9a06b4c9d41b547bff~FKawzR92K3141231412eucas1p1y;
        Fri, 27 Jul 2018 07:37:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0E.95.05751.BCBCA5B5; Fri, 27
        Jul 2018 08:37:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180727073746eucas1p1b3654f59b10d1263e4910029aa46788a~FKawCPesk2929129291eucas1p1v;
        Fri, 27 Jul 2018 07:37:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180727073746eusmtrp10e66a9dbaeddfc4419056b5216c8ea33~FKavzLY_w1877018770eusmtrp11;
        Fri, 27 Jul 2018 07:37:46 +0000 (GMT)
X-AuditID: cbfec7f4-c2dff70000001677-4e-5b5acbcb800a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.DF.04183.ACBCA5B5; Fri, 27
        Jul 2018 08:37:46 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180727073746eusmtip2d47697ce31e7e686cd34ec00a3e12edb~FKavWdvTh0882608826eusmtip2Y;
        Fri, 27 Jul 2018 07:37:46 +0000 (GMT)
Subject: Re: [RESEND PATCH] drm/bridge/synopsys: remove commented-out flag
 in Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        David Airlie <airlied@linux.ie>
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Fri, 27 Jul 2018 09:37:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532496348-11589-1-git-send-email-yamada.masahiro@socionext.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUgUYRjG/WZmZ8fFkXE1fNMsWxJUSu34YyCRoqAhIo1AKonactLSXWUn
        Vy0okcqj8ko8VjFlDaWDSl2PDQXNcs08NjetPDsgUxY1j4pS2nWM/O/3Pu/7fO/7wEfh8q8S
        D+q8+iKvUStjFaSMqH/5q3dbV9eJiKA0kxd7u6cTY1PTrRLWsjBNsk3jRilb+cuIsRm5lVK2
        31hKshWzBoJty4pg32TnYuzIk27ENo/OoT1OXP+AGeem312XciUpZoLL//1UwvVn3ca4kvRi
        CdewOC7hyjqPcGM3OzCuKa8Z40yFPwhurmZjmNMJWXAkH3tey2sCQ07LojNf96H4m2TSZHMu
        noIKJJnIkQJmF9SkTKFMJKPkTDUC6zWLRCzmEUyUWHCxmENQ1TeM/bP0tNcRYqMKQeuMYdVv
        RdA0krfysCtzDPTDL0h7w40ZQvDze8uKBWf0GFSNfCTtUyTjB0u171eYYHygsDlnhdfZ3O3j
        FcjONOMCncVfCDs7Mofhc3um1M44swkarKW4yO7w4ctdzL4AmOsU3DJmk6JZCzNFS0g8fD8M
        3nhGiuwKkx11UpE3QNedW4TIVyG1WEwNTDoCk75q1bAbnneYbdko2zY/eGwMFOW9UFunQ3YZ
        GGd4Z3UR73GGvPpCXJRpSL8hF6c3w1i3ARfZHe71LZA5SKFbk1K3JpluTTLd/73liLiP3PkE
        QRXFCzvUfGKAoFQJCeqogLNxqhpk+35dyx3zjcj450wbYiikcKLDpo5HyCVKrZCsakNA4Qo3
        +uGgTaIjlcmXeE3cKU1CLC+0IU+KULjTnoeORciZKOVFPobn43nNvy5GOXqkIH9D0f3qYQc6
        7NXOrNC32qYDbpa+oImFmC3zT02XkmZ7l8fONfrzWaHJB0szfI8njMrUBfnh5mCtuUd1YeDB
        UBKpuOLl8CpsYt+34kfl2OKnustpnaSH6ye9ENRw1Kcs3Nd5Nq3W2xC41SNkbKhlPU2bCDY1
        Z9dJ7xHLhKOQ2KoghGjldn9cIyj/Ap96BLp6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsVy+t/xe7qnTkdFG0zarWHRe+4kk0VTx1tW
        iytf37NZ7Hywi91iyc9dTBadE5ewW1zeNYfNYuHHrSwWh/qiLS71T2SyuLvhLKPF3nufGR14
        PC5fu8js8f5GK7vH7IaLLB5Tfm9k9bjc18vkMbtjJqvH9m8PWD3mnQz0uN99nMlj56S9TB4n
        pn9n8fi8SS6AJ0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7Ms
        tUjfLkEvo+vMBcaCbraKV3snMjcwTmPtYuTkkBAwkTh3ZAtLFyMXh5DAUkaJ2UfXQiXEJXbP
        f8sMYQtL/LnWxQZR9JpR4ujftUwgCWGBCIm/E46BdYsI3GaUeHx2FjtIgllgMZPEwU2OEB0L
        GSXa/3wA62AT0JT4u/kmG4jNK2AnMaXvBNg6FgFViel7J4DFRYGmrl7+ghWiRlDi5MwnLCA2
        p4CfxOMjXVAL1CX+zLvEDGHLS2x/OwfKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVS
        S4tz03OLjfSKE3OLS/PS9ZLzczcxAqN927GfW3Ywdr0LPsQowMGoxMMb8DoyWog1say4MvcQ
        owQHs5II75rrQCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OByaivJJ4Q1NDcwtLQ3Njc2Mz
        CyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFINjEU3PO+sf3xVe3rzgmwzf+4J5wXj99/kdxWe
        KDLldd7b/sK/fteqbpqv0uNpj9LqPe7CbLvxz/5d1l6ODqfe/tazri/9K72b5VfNFiGtMB+r
        d+cm505QLVj4XW4Vl1jqDk0JmWk3jnye+NVlbSnL4tVmh3UZ+ObU9O6oWP/12N2rC9aGFy34
        3KXEUpyRaKjFXFScCABk5ahJDAMAAA==
Message-Id: <20180727073746eucas1p1b3654f59b10d1263e4910029aa46788a~FKawCPesk2929129291eucas1p1v@eucas1p1.samsung.com>
X-CMS-MailID: 20180727073746eucas1p1b3654f59b10d1263e4910029aa46788a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180725052739epcas3p39b7080b6adeff8657c7c64c3b60f06c9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180725052739epcas3p39b7080b6adeff8657c7c64c3b60f06c9
References: <CGME20180725052739epcas3p39b7080b6adeff8657c7c64c3b60f06c9@epcas3p3.samsung.com>
        <1532496348-11589-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.2018 07:25, Masahiro Yamada wrote:
> Please do not comment out unneeded code.  Remove.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Queued to drm-misc-next.

Regards
Andrzej

> ---
>
>  drivers/gpu/drm/bridge/synopsys/Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/Makefile b/drivers/gpu/drm/bridge/synopsys/Makefile
> index 5dad97d..3e1b1e3 100644
> --- a/drivers/gpu/drm/bridge/synopsys/Makefile
> +++ b/drivers/gpu/drm/bridge/synopsys/Makefile
> @@ -1,5 +1,3 @@
> -#ccflags-y := -Iinclude/drm
> -
>  obj-$(CONFIG_DRM_DW_HDMI) += dw-hdmi.o
>  obj-$(CONFIG_DRM_DW_HDMI_AHB_AUDIO) += dw-hdmi-ahb-audio.o
>  obj-$(CONFIG_DRM_DW_HDMI_I2S_AUDIO) += dw-hdmi-i2s-audio.o


