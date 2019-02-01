Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E34C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1A221872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BUFnIEPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfBAMsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:48:41 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57651 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfBAMsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:48:40 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190201124839euoutp016b7161bb059ca9161eb62ff52d05de22~-PlIX1HAD2618726187euoutp01D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 12:48:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190201124839euoutp016b7161bb059ca9161eb62ff52d05de22~-PlIX1HAD2618726187euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549025319;
        bh=3e0Loc/9MtjGyaBeuppoLHtbSML3f5t0k5ohhsbpEWw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BUFnIEPqbmUW11ed0gqcP4008QvIcSuHnSrc50zaCe/wht0ryTn22MqbTB7sc2CVz
         AOBDAcodNO0fU13peHUdFLBBO7qyi8iSpDCHzZKXLbL6U8zN2TJsbpg5GqssprffcH
         hrrudCq3njLvFqgPEQiVKSXSz28Ya5rXu3p9b4X0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190201124838eucas1p241ceb2549f6dec2f41762703bc4feca5~-PlHxnwP-0084200842eucas1p28;
        Fri,  1 Feb 2019 12:48:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 20.04.04806.620445C5; Fri,  1
        Feb 2019 12:48:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190201124837eucas1p2dd818b3b2380c3531e3f7c5368b87e1d~-PlHCFR4n3146631466eucas1p2R;
        Fri,  1 Feb 2019 12:48:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190201124837eusmtrp2a0fd166edbd273fe1fd953e53b00f0a8~-PlGzrJbb0847308473eusmtrp2T;
        Fri,  1 Feb 2019 12:48:37 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-80-5c5440266090
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3E.CF.04284.520445C5; Fri,  1
        Feb 2019 12:48:37 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190201124836eusmtip1f7fd851ba6ab91440c1c83da8c665fa8~-PlGXOFxg0518305183eusmtip1f;
        Fri,  1 Feb 2019 12:48:36 +0000 (GMT)
Subject: Re: [PATCH v2 4/8] drm/bridge: dw-hdmi: add support for YUV420
 output
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent.pinchart@ideasonboard.com, p.zabel@pengutronix.de,
        Sandy Huang <hjc@rock-chips.com>, heiko@sntech.de,
        maxime.ripard@bootlin.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zheng Yang <zhengyang@rock-chips.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <4416a526-f4d4-89ee-4c53-41d9a3c1adb8@samsung.com>
Date:   Fri, 1 Feb 2019 13:48:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549022873-40549-5-git-send-email-narmstrong@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7pqDiExBs/v81lc+fqezeL/o9es
        FnMn1Vp0TlzCbrFgNrfF5V1z2CwevNzPaHGoL9ri7r0TLBbrW/QduDze32hl95i3ptpjdsdM
        Vo/73ceZPDYvqffo/2vg8XfWfhaP7dfmMXt83iQXwBnFZZOSmpNZllqkb5fAlXFt2kz2gl62
        ioOTORsY/7N0MXJySAiYSHz4sJO5i5GLQ0hgBaPEoUXLmCCcL4wSdyb8BasSEvjMKHGl362L
        kQOs49QrM4ia5YwSa++8ZoFw3jJKPF10kg2kQVggQGLv+Slgk0QEdjJKrPv7gw3EYRboZZTY
        8vgcM0gVm4CmxN/NN8E6eAXsJM71XQZbxyKgItH4fzk7iC0qECFxuPcdI0SNoMTJmU/AajgF
        PCSauz6AzWEWkJfY/nYOlC0ucevJfLDNEgL32CVWTN/KDPGpi8Spk7tZIWxhiVfHt7BD2DIS
        /3eCNIDY9RJNM68wQzR3MEqcWLycDSJhLXH4+EVWUAAwA129fpc+RNhR4mXLbzZIuPBJ3Hgr
        CHEDn8SkbdOZIcK8Eh1tQhDVihL3z8JcIy6x9MJXtgmMSrOQfDYLyTezkHwzC2HvAkaWVYzi
        qaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIGp6/S/4193MO77k3SIUYCDUYmHd8OvoBgh1sSy
        4srcQ4wSHMxKIrwLpEJihHhTEiurUovy44tKc1KLDzFKc7AoifNWMzyIFhJITyxJzU5NLUgt
        gskycXBKNTBKRMzb9EJunu+hvwqhG06t4Mt5VJi+YxLr+43Z9wQPLBN8GebwVKz7Z6kK261Z
        /BfiDwffi5smEs7sNpF9k8k0w+5I6VWHp334wvOG+Xmw2yf73ElW3455na9+Na/Ewi72i7ZI
        3DUOhthSY+uf96tP3bwZse4Mq9brR6tm71rhn3E9wfLO/aYwJZbijERDLeai4kQAbrCH3VkD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7qqDiExBve7pCyufH3PZvH/0WtW
        i7mTai06Jy5ht1gwm9vi8q45bBYPXu5ntDjUF21x994JFov1LfoOXB7vb7Sye8xbU+0xu2Mm
        q8f97uNMHpuX1Hv0/zXw+DtrP4vH9mvzmD0+b5IL4IzSsynKLy1JVcjILy6xVYo2tDDSM7S0
        0DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7g2bSZ7QS9bxcHJnA2M/1m6GDk4JARMJE69
        Muti5OIQEljKKLHv3RfWLkZOoLi4xO75b5khbGGJP9e62CCKXgMVHWlnAUkIC/hJrDq4mhUk
        ISKwk1Fiyax7LCAOs0Avo8Sbq1+YIFpuMkpsOLeNEaSFTUBT4u/mm2wgNq+AncS5vstgo1gE
        VCQa/y9nB7FFBSIkPj7dxwRRIyhxcuYTsBpOAQ+J5q4PYDcxC6hL/Jl3CcqWl9j+dg6ULS5x
        68l8pgmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbrtmM/
        N+9gvLQx+BCjAAejEg/vhl9BMUKsiWXFlbmHGCU4mJVEeBdIhcQI8aYkVlalFuXHF5XmpBYf
        YjQFem4is5Rocj4wleSVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCU
        amAUN2PYUBJlWPnebWGZ5P/Je446urRzxIVJTiyxXmtypCW+UDvctIVx5oTkGSZdKyRlt3x5
        kzv1uq3FHn7lE5dZXK35OOdNfhf9iL/Admrmf/uDbHv1v/nWKeyvvSXjvv/96Qsa58vOr+gr
        8pzNEXIxmP3WDp9JdxYL5r26+vVfsa2r25t9fEuUWIozEg21mIuKEwHtCloQ7QIAAA==
X-CMS-MailID: 20190201124837eucas1p2dd818b3b2380c3531e3f7c5368b87e1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190201120808epcas2p1f3b7a5f182f8f9815d95198f3a6177f8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201120808epcas2p1f3b7a5f182f8f9815d95198f3a6177f8
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
        <CGME20190201120808epcas2p1f3b7a5f182f8f9815d95198f3a6177f8@epcas2p1.samsung.com>
        <1549022873-40549-5-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.2019 13:07, Neil Armstrong wrote:
> In order to support the HDMI2.0 YUV420 display modes, this patch
> adds support for the YUV420 TMDS Clock divided by 2 and the controller
> passthrough mode.
>
> YUV420 Synopsys PHY support will need some specific configuration table
> to support theses modes.
>
> This patch is based on work from Zheng Yang <zhengyang@rock-chips.com> in
> the Rockchip Linux 4.4 BSP at [1]
>
> [1] https://github.com/rockchip-linux/kernel/tree/release-4.4
>
> Cc: Zheng Yang <zhengyang@rock-chips.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> ---


Patches 1-4 queued to drm-misc-next.


Regards

Andrzej


