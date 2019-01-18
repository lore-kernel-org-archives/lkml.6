Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202B9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C922086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RRy7dUNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfARHcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:32:47 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60587 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfARHcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:32:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190118073246euoutp01f4d76109b37ba9dcdaf13b2921e8510f~64PVbHKRF2819928199euoutp01u
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 07:32:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190118073246euoutp01f4d76109b37ba9dcdaf13b2921e8510f~64PVbHKRF2819928199euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547796766;
        bh=N4IBx/SlQtAtS+7TwDCMzA+5pEUkwHm/ykYd1uTtsVA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RRy7dUNqMdPImx6DVfwd+Ky758M9+lBhH+ZQzMtwGGRRhE/5xY6KzEMRX+WllbClF
         tCWVhUNLBtLhh4kh26S6ehVhWSgah98U0dk7L+aeFyFFzUiQlKbGKTGuJmEQawD+LC
         KXUKMt9Tm6CsBhqo/bB/qqUIuyC0XUlTmpBVvDlQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190118073245eucas1p1045a2347abde475e14cf461e57d08e7f~64PUsILuI0526405264eucas1p1R;
        Fri, 18 Jan 2019 07:32:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FB.91.04806.D11814C5; Fri, 18
        Jan 2019 07:32:45 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190118073244eucas1p2c1e66f873e698fea80f7dc5f70af8a36~64PTgIeVd0203702037eucas1p28;
        Fri, 18 Jan 2019 07:32:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190118073244eusmtrp1d0f4a76963c9d155e361d12d900b506b~64PTPqmOW0585505855eusmtrp1U;
        Fri, 18 Jan 2019 07:32:44 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-87-5c41811dd517
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EE.E2.04284.B11814C5; Fri, 18
        Jan 2019 07:32:43 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190118073243eusmtip117b77a2fd031a055e6607b83e9f022dd~64PS2Os9J2112121121eusmtip1s;
        Fri, 18 Jan 2019 07:32:43 +0000 (GMT)
Subject: Re: [PATCH v4 5/5] drm/bridge: lvds-encoder: add powerdown-gpios
 support
To:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <6926787a-4a87-ef01-4a73-73a0f4ecad68@samsung.com>
Date:   Fri, 18 Jan 2019 08:32:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111151843.11114-6-peda@axentia.se>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djPc7qyjY4xBmsn8Vn0njvJZNHU8ZbV
        Yv6Rc6wWV76+Z7PonLiE3eLyrjlsFkuvX2Sy2HtoPqNF694j7A6cHmvmrWH0mHZgNrvH5b5e
        Jo/ZHTNZPTat6mTz2P7tAavH/e7jTB6fN8kFcERx2aSk5mSWpRbp2yVwZcxr/M1W8JGx4vO5
        D8wNjAcYuxg5OSQETCSOPm1h72Lk4hASWMEo8eXODjaQhJDAF0aJd2+YIBKfGSUuXPvCBtPx
        6NAJqI7ljBIvVs1lhHDeMko0XVoAViUsECwxb9sSsB0iAkkSK+8/ABvFLHCBSeLHzjawIjYB
        TYm/m2+C2bwCdhKXu9ewgtgsAqoSP2d1sIDYogIREh33V0PVCEqcnPkELM4pYCoxExg6IDaz
        gLxE89bZzBC2uMStJ/PBlkkIXGOX2Hd7LlADB5DjInH0CQfEC8ISr45vYYewZSROT+5hgbDr
        JZpmXmGG6O1glDixeDnUz9YSh49fZAWZwwx09Ppd+hBhR4nmdzOYIMbzSdx4KwhxAp/EpG3T
        mSHCvBIdbUIQ1YoS989uZYawxSWWXvjKNoFRaRaSx2YheWYWkmdmIexdwMiyilE8tbQ4Nz21
        2DgvtVyvODG3uDQvXS85P3cTIzBpnf53/OsOxn1/kg4xCnAwKvHwvtjmECPEmlhWXJl7iFGC
        g1lJhNeozjFGiDclsbIqtSg/vqg0J7X4EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dU
        A2NPlsOT2HexpUW3q6pj5u90uSX43+mJztorWRnKmWJLj0Zv4IoWVP/wJHdn7awD6x7FXD3V
        a6X83UlN8Oq6jwEP5/5h3MIyVfDbLh+b9eqSpq7WD1tLeE3T1Jnesr+ceSBy/+RVFgqr+r7r
        vqkv3n3lxuQrwpuu3r395rOp5E+3W8c3zrmyt4lDiaU4I9FQi7moOBEAeupXb1YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7rSjY4xBpNO2lj0njvJZNHU8ZbV
        Yv6Rc6wWV76+Z7PonLiE3eLyrjlsFkuvX2Sy2HtoPqNF694j7A6cHmvmrWH0mHZgNrvH5b5e
        Jo/ZHTNZPTat6mTz2P7tAavH/e7jTB6fN8kFcETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZ
        WOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZcxr/M1W8JGx4vO5D8wNjAcYuxg5OSQETCQeHTrB
        3sXIxSEksJRRYuPf+0wQCXGJ3fPfMkPYwhJ/rnWxQRS9ZpR42v4XrEhYIFhi3rYlYJNEBJIk
        jszezAxSxCxwgUni/LoGFoiOzYwSBzb8B+tgE9CU+Lv5JhuIzStgJ3G5ew0riM0ioCrxc1YH
        C4gtKhAhcfblOkaIGkGJkzOfgMU5BUwlZgIDDcRmFlCX+DPvEjOELS/RvHU2lC0ucevJfKYJ
        jEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTG6rZjPzfvYLy0
        MfgQowAHoxIP74ttDjFCrIllxZW5hxglOJiVRHiN6hxjhHhTEiurUovy44tKc1KLDzGaAj03
        kVlKNDkfmEbySuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwJuY+
        8Jz4Tl/xlLzCo1P1PS8XeDBXH+pc6XHcKLDAf42pb/tRfotn1Wu2fOe6rtbHN3PS4d5gzust
        vqcepB+asHzulzjRVR82Lys8ZLXLYL5zm270ka1u+dZfZfvc9vC9OHmCPVmo08SKd8WMWzqu
        S1ZOmLnQQ3FXzrsfj6v3b5k6PzysRbXbVImlOCPRUIu5qDgRALNWm9frAgAA
X-CMS-MailID: 20190118073244eucas1p2c1e66f873e698fea80f7dc5f70af8a36
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190111151958epcas2p2452ae6ee5a15410a2786aea36330f15a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190111151958epcas2p2452ae6ee5a15410a2786aea36330f15a
References: <20190111151843.11114-1-peda@axentia.se>
        <CGME20190111151958epcas2p2452ae6ee5a15410a2786aea36330f15a@epcas2p2.samsung.com>
        <20190111151843.11114-6-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.2019 16:19, Peter Rosin wrote:
> Optionally power down the LVDS-encoder when it is not in use.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>


 --
Regards
Andrzej

