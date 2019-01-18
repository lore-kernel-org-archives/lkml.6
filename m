Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6659C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E29520855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vCLfYSdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfARInX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:43:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54685 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfARInW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:43:22 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190118084320euoutp017fa8c7ff19ef6c6d905337c8836ace71~65M87Nlnr0071700717euoutp01h
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:43:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190118084320euoutp017fa8c7ff19ef6c6d905337c8836ace71~65M87Nlnr0071700717euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547801000;
        bh=tq1+blycqGUdLuQH8x75+5LtQkOqEdnOKHyxgb/VHgs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vCLfYSdTixtJ+vEzL+4F0kGh2IxlqDrltprLktj57C3qL8Ad8v3JKI9qGGeHm9Lsv
         eeI5DzddYCRQTanZoaLBaLJ1QmO/oRb1Rk9TrzPx05FQdXogs8hiGLe2MR83gao5pc
         6eisT/0Q+ckg0U1dpaan2b4XZgz5aGeDkzUjtbqY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190118084319eucas1p1d612773db8e5c366b7f0f00f2106d567~65M8OToUV2117821178eucas1p1W;
        Fri, 18 Jan 2019 08:43:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 67.DA.04806.7A1914C5; Fri, 18
        Jan 2019 08:43:19 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190118084318eucas1p1b765ad5a0bfa93ea1ed27ed5c8787a6d~65M6u13IE0384303843eucas1p1T;
        Fri, 18 Jan 2019 08:43:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190118084318eusmtrp24edf195e7b0b0a928ac4b724ea2adff6~65M6eug7t1603016030eusmtrp2v;
        Fri, 18 Jan 2019 08:43:18 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-14-5c4191a72972
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 18.4B.04284.5A1914C5; Fri, 18
        Jan 2019 08:43:18 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190118084317eusmtip2306b3e2c8a0ae3be0fd57d9b708c2a86~65M6FwQPj0365403654eusmtip24;
        Fri, 18 Jan 2019 08:43:17 +0000 (GMT)
Subject: Re: [PATCH v4 0/5] drm/bridge: various small lvds-encoder things
To:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <be258481-b3e4-8051-abb2-ca430ecc2836@samsung.com>
Date:   Fri, 18 Jan 2019 09:43:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111151843.11114-1-peda@axentia.se>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtd+8e1+XiOo19rDBcWhi+oqJLiShEregPCYMe9ph50eWmtquW
        GSSSY74qRUw3a0qTqZnvNA1LfLQkFUXziWggapZG2UotLber5H/nO+c7nO/AR+Cidq6EUETG
        0OpIuVLKE3Dq3i51e5oyA4J9Cj+4UBndHRiVpJ3jUoa2bi7Vb/nKo1IyjXyqrzGfRxUN9mJU
        U4sBUclNbXx/O1nZkzIky2nW82V99zMwmV6bx5VVl6bwZPU/J7iy8TQzJluodg4kLgh8Q2ml
        Io5We/tdFYQPN2fj0bnkrdK6TiwR/bJPRXYEkAehqiAdS0UCQkQWI8hcWcLZ4QeC/qFXiB0W
        EPTql7ENS6JmlMMKJgTZqRo+O8wh+FI4wLFuOZInoWpwCFmxExkCJeMTthCc7MFgsUHDswo8
        0h1WaoZtWEj6wb0HkzYDh3QDveYTbsXbyXOgHX+2vuMAHXmTtgA78hCUDNVyrRgnd0H9XD7O
        YjGMTBpsYUAO8GFi9huPvfsY/G4vX+/gCLPmWj6Ld8LfBsM6fxeS8vpx1qxF8O6pad18FFrN
        vWtpxFqCO1Q0erN0AGQZspGVBnIbDM05sDdsg6y6RzhLC0GrEbHbLjDe9QJnsRiKeiy8h0iq
        29RMt6mNblMb3f/cAsQpRWI6llGF0cyBSPqmFyNXMbGRYV7XolTVaO253q+aLS/R6z8hLYgk
        kNReOFPnHyziyuOYeFULAgKXOgkd1n5PJAyVx9+m1VFX1LFKmmlBOwiOVCxM2DJxUUSGyWPo
        CJqOptUbKkbYSRLRCTTdpaPOBPt8RoqC3N0zfnGCyzMjzmMfE05JjnicnzfcWbgedNzM5OhR
        peulKeOqusnUiSu+B4Wr5c8b80t806v1y9me4uTp05aI4b7OqZrh1rHyw8rKjL0SD3dVmjGw
        1/fNntWtixWKrsej88azxVMNbnhwVg/nhuuk+xgu5TDh8v37cDUj/wdLZyFCWAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7rLJjrGGByMtOg9d5LJoqnjLavF
        /CPnWC2ufH3PZtE5cQm7xeVdc9gsll6/yGSx99B8RovWvUfYHTg91sxbw+gx7cBsdo/Lfb1M
        HrM7ZrJ6bFrVyeax/dsDVo/73ceZPD5vkgvgiNKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
        1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuHlgCnPBDIGKVdvOMDUwfufpYuTkkBAwkWhou83S
        xcjFISSwlFHids93FoiEuMTu+W+ZIWxhiT/Xutggil4zSjQc/s0GkhAW8JTYeP0GI4gtIpAk
        cWT2ZmaQImaBC0wS59c1QI3tYJS4u/Y0K0gVm4CmxN/NN8G6eQXsJFr6n4B1swioSsxuewm2
        TlQgQuLsy3WMEDWCEidnPgE7iVPAVGLljS1gc5gF1CX+zLvEDGHLS2x/OwfKFpe49WQ+0wRG
        oVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiN127Gfm3cwXtoY
        fIhRgINRiYf3xTaHGCHWxLLiytxDjBIczEoivILAOBfiTUmsrEotyo8vKs1JLT7EaAr03ERm
        KdHkfGASySuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwKj38ffU
        3Qy3z2+e/Ppa9OZfIrL3vj2bF5StaiNwxXTpn7+OB19rXn+ecrLjpVzDpM3811k4borfLWI7
        LbPSbQ6TYWnuvL8LF/ksexuzKP60cPCSwmjWmjunVhjzy06fp/zp4PrW31cXtwcolb7nmRb2
        ddvhh0cvV6U8rQq04b16VkHy11KTW5EnlViKMxINtZiLihMBdlv5/+oCAAA=
X-CMS-MailID: 20190118084318eucas1p1b765ad5a0bfa93ea1ed27ed5c8787a6d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190115040858epcas3p4b4b9bfa6f6706842ad92825fea36d59e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190115040858epcas3p4b4b9bfa6f6706842ad92825fea36d59e
References: <CGME20190115040858epcas3p4b4b9bfa6f6706842ad92825fea36d59e@epcas3p4.samsung.com>
        <20190111151843.11114-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.2019 16:18, Peter Rosin wrote:
> Hi!
>
> I'm not sure if I should have added the texas chips to the lvds_encoder_match
> list in the driver, right next to the thine,thc63lvdm83d entry, but ended
> up not doing that. That can always be added later, if needed...
>
> Changes since v3:
> - retained a (modified) note in lvds-transmitter.txt about encoders with
>   additional device-specific properties
> - added tag from Rob on patch 3/5
>
> Changes since v2:
> - changed from pwdn-gpios to powerdown-gpios after discussion with Rob with
>   new patch 3/5 updating the thine,thc63lvdm83d binding as well as a
>   consequence
> - added patch 4/5 which helps keep lines shorter in the lvds-encoder driver
> - added tag from Rob on patch 2/5
>
> Changes since v1:
> - fork out the bindings for the texas chips into their own file in order
>   to avoid clutter in the generic lvds-transmitter binding.
> - added a patch to remove some surplus stuff in the generic lvds-transmitter
>   binding.
>
> Cheers,
> Peter


Queued to drm-misc-next.


One thing I have spotted after merging is that there no need to
null-check before gpiod_set_value_cansleep, no big deal, I guess.


Regards

Andrzej


>
> Peter Rosin (5):
>   dt-bindings: display: bridge: fork out ti,ds90c185 from
>     lvds-transmitter
>   dt-bindings: display: bridge: lvds-transmitter: cleanup example
>   dt-bindings: display: bridge: thc63lvdm83d: use standard
>     powerdown-gpios
>   drm/bridge: lvds-encoder: add dev helper variable in .probe()
>   drm/bridge: lvds-encoder: add powerdown-gpios support
>
>  .../bindings/display/bridge/lvds-transmitter.txt   | 12 ++---
>  .../bindings/display/bridge/thine,thc63lvdm83d.txt |  2 +-
>  .../bindings/display/bridge/ti,ds90c185.txt        | 55 ++++++++++++++++++++++
>  drivers/gpu/drm/bridge/lvds-encoder.c              | 53 +++++++++++++++++----
>  4 files changed, 103 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
>

