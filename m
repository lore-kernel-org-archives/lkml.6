Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1F0C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B402B20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MsAPHn0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B402B20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeIMPJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:09:49 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35600 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeIMPJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:09:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180913100102euoutp02d6f977637380ea23319f2ce939436fa2~T7VifWq711726117261euoutp02j
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 10:01:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180913100102euoutp02d6f977637380ea23319f2ce939436fa2~T7VifWq711726117261euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536832862;
        bh=zJiEJrsfx7TRRaLHiPZc16ssDBpe6nsRSEWFma8f0Yc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MsAPHn0rugSCsUedHCRakI2rTpPFo01gSqoWV072LLgcC+FzNC+pC5n2MMffPE3N/
         1iZmMQb2oKIGtxw5EPjZmxbmicVxlascjvSG+rDJvJQ4THH+v9bEfXJIX/0HsZGdZa
         bS4TfG2PPhCIoUUnHfVTNbaRPPJM6D5rGqJ9F1j0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180913100101eucas1p1c854d875f41d24e9b82d71702ab2e083~T7VhGn8Wc2905929059eucas1p1S;
        Thu, 13 Sep 2018 10:01:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 12.D5.04441.C553A9B5; Thu, 13
        Sep 2018 11:01:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180913100100eucas1p23e7e33035b6cba51d6219a58b34eea92~T7VgDpN8L3204732047eucas1p2_;
        Thu, 13 Sep 2018 10:01:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180913100059eusmtrp2e3983c93a41ea52a132f5f592133ca4c~T7Vfxi4Aq2383823838eusmtrp2i;
        Thu, 13 Sep 2018 10:00:59 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-7d-5b9a355c35a7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 10.7C.04284.B553A9B5; Thu, 13
        Sep 2018 11:00:59 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180913100058eusmtip2647ea2ee6b51636445a96022aa142e83~T7VetXdQj1560815608eusmtip2c;
        Thu, 13 Sep 2018 10:00:58 +0000 (GMT)
Subject: Re: [PATCH v3 1/5] drm/rockchip: prepare common code for cdns and
 rk dpi/dp driver
To:     Damian Kos <dkos@cadence.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     pgaj@cadence.com, ltyrala@cadence.com, stelford@cadence.com,
        jartur@cadence.com, piotrs@cadence.com
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Thu, 13 Sep 2018 12:00:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535451894-2518-2-git-send-email-dkos@cadence.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yNYRzH97z34uTtuPQbxjqbuWwI4XGZacg7M3P7w8Q46ZWocF6Vy1zK
        cKplhDjvyUkuR+W4dFLpjMwRp0iii9taZ8RMyuU4NlninIfpv8/v9/t+n+f3ffYItDafGyzE
        JW6TDYn6eB0XyJTd/1E3dtVkNSrMXBuOs+pqKJxm7GBxXlUdi1tap+BG7ycOV7gdPO553c7i
        09m7sbnpJsLpR8/z2P6mmcUNjlwOf3X30Pjdz4k4/0spgy88e0LhyucnGFxgKUG4+HYliw/c
        quJxy7EqhD+22dDsQZLNYkOSxbZLsqW3U1LD4SxKMhtNrGQvSuek8u9uVrLULJFaM12UVHJ+
        r1SRfYuSXI6XvNSt3mak8mYLLXnswxb3Wxk4M0aOj0uWDeNnrQ3c4HxgpbYU8Nsr6x1oH2pl
        M5AggBgO9uppGShQ0IoFCIzWFxQpviHIvJxFk8KD4Ju1ms9AAX5HprWLIYOLCI5/8PCk6ECQ
        9vA+51P1F1dDz9sSv32AqLLwtNvM+S6kxTjIqd3q03DiaOgueeHXM+IIKDfe8PNAcQVUufOR
        jzViMNSY2hgfB4izoftxAetjWhwO+0vNNOEQeNmW598bxEYBas9YaGJOhuIcKyJrz4UDN1WG
        cH/44Lr+N85Q6KnwmX28F9JMjTQ5yIig+txFjgxmwF3XE5YEGA1XHeNJOwLyzj2gyEMGwfOO
        YLJPEGSXnaRJWwPGg1qiDoXWR6U04RC4UO/ljiCd2iul2iuZ2iuZ+v/eM4gpQiFykpIQKysT
        EuWUcYo+QUlKjB23bnOCHf35uA9/ub7eQN6n0U4kCkjXV3NqpClKy+qTlR0JTgQCrRugaef/
        tDQx+h07ZcPmNYakeFlxoiECowvRBI1ZH6UVY/Xb5E2yvEU2/JtSQsDgfciS2imhpCbWcrYp
        oiuFmp6pBi0rnBYat7VwzhfMrZovLljEz4nIaYnemX1taqS9T5ppxfXwpZWFLV0x4fWpU0LX
        BHN7tPcWXipqcM5bulLQFXs6U+4oqT8G1YdFl7kjPN7mO5Gdp03L1zXc3XiWOfR51KtJkaa6
        K6u9/d4PK8oNO6xjlA36CWNog6L/De8Im8a0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTURjHOe9lNxq9rZUHKZNBRdFe27ydiYkfD33K+iKK2bIXldxme6do
        EYWZVwy7kjPfJaiZjagNNVdtZOKY2dWyUkwp7cI0KUvLvKRbgd9+PM/5/f8ceCSkopUOlWQb
        LZzZqM9RiWTUowXvO3VqtDV15+BMOKp64iNQUdkEjWxdT2g0NByDXv6cFKGOEZcYLb7306ju
        3HFU++oeQOVnG8TI8aGfRn2uKyL0fWSRRB//aFH9t1YKNb5+TiD3m4sUahacAN32uGl0+n6X
        GA2d7wJofNQOEtdju2AHWLAfw/ZyP4H7zlQRuLashsaOlnIRbp8eobHgS8LDlV4COxtO4I5z
        9wnsdQ2I8bzVQ+H2foHEU46wPatT2HizKc/ChWeZeMsuVaoGaVmNDrHaKB2riYxNi9NGqyIS
        4g9xOdn5nDki4QCb1dnTROQ2iwvcz1zgJBimK4BUApkoWNk0S1UAmUTBNAJYcu+tOLgIgXdt
        E2SQ18K5/grRMisYP4APxyKWeS2TBr0dDcSyrGQEGvYWf6GWFySTDeunfomDqT4Apz3+QJ2I
        2QbnnW8DSXImAfZMPAi0Ucxm2F52JzBfxyTDG9c+08E3a6CvZjQQKmUS4fzTZjpYsBXOCS/I
        IG+Cp1pr/3EIHBi1EdVAYV2hW1co1hWKdYVyFVAtQMnl8YZMA69heb2BzzNmshkmgwMsnUxb
        92/nHfDi9r5OwEiAapX8s6omVUHr8/lCQyeAElKllPvFSyP5IX3hUc5sSjfn5XB8J4he+txZ
        MnRdhmnpAI2WdE20JhbpNLGRsZExSBUif7qzMEXBZOot3GGOy+XM/z1CIg09CTa2le6+wGq3
        yB8P2simiPNC76aSblf+jF1GHTRukcmSF3QX++Uj0svu3B6TTS2r9aQkJaqtz41vSn/4Fodx
        3HhZ8ditHq8yx+EWwsOkRXwb3nEz8ZJ/f8HsdeWtyfE91RtMbOnC1/SqTOeQOuNTnUXHN273
        ENV7j2gLanJVFJ+l12wnzbz+L0zPZoJIAwAA
Message-Id: <20180913100100eucas1p23e7e33035b6cba51d6219a58b34eea92~T7VgDpN8L3204732047eucas1p2_@eucas1p2.samsung.com>
X-CMS-MailID: 20180913100100eucas1p23e7e33035b6cba51d6219a58b34eea92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180828102612epcas2p376fa6f21ce57f4753a8d0f80f5359842
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180828102612epcas2p376fa6f21ce57f4753a8d0f80f5359842
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
        <CGME20180828102612epcas2p376fa6f21ce57f4753a8d0f80f5359842@epcas2p3.samsung.com>
        <1535451894-2518-2-git-send-email-dkos@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damian,

Quite late but.

On 28.08.2018 12:24, Damian Kos wrote:
> - Extracted common fields from cdn_dp_device to a new cdns_mhdp_device
>   structure which will be used by two separate drivers later on.
> - Moved some datatypes (audio_format, audio_info, vic_pxl_encoding_format,
>   video_info) from cdn-dp-core.c to cdn-dp-reg.h.
> - Changed prefixes from cdn_dp to cdns_mhdp
>     cdn -> cdns to match the other Cadence's drivers
>     dp -> mhdp to distinguish it from a "just a DP" as the IP underneath
>       this registers map can be a HDMI (which is internally different,
>       but the interface for commands, events is pretty much the same).
> - Modified cdn-dp-core.c to use the new driver structure and new function
>   names.
>
> Signed-off-by: Damian Kos <dkos@cadence.com>

Many changes, hard to review. Anyway:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


