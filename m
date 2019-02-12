Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294A4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B93217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R1/J+w97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfBLBA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:00:29 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:35071 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfBLBA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:00:28 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190212010025epoutp01543e91bfe5f0b46e23d5df50fd06b78e~CeA59raa31214512145epoutp01O
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:00:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190212010025epoutp01543e91bfe5f0b46e23d5df50fd06b78e~CeA59raa31214512145epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549933225;
        bh=VA0lNo4csi/ad0keB4R7g0GZE7isxRAd21ddeg5CWoY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=R1/J+w97QMPLGA8EUVSNPyRCy1Zkp/2riiLq45nLa0OR871+WI2ozmkg9Je1AcGx1
         83cNqM7JKCI4n25O93FoAbdIqol6DVkkBivln1zCW2NBF6ID01/56NEixxxsWZ4WMd
         cFdzOXMjAOqfR33X4JVa1Nb8X/9bUZOiImfJwXpA=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212010021epcas1p181e7dd376c45ec30fcd6f075ddfcdb4f~CeA2KXoVO0448204482epcas1p1C;
        Tue, 12 Feb 2019 01:00:21 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.DC.04074.5AA126C5; Tue, 12 Feb 2019 10:00:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190212010020epcas1p30ed98e10f06aaf90e1c6c35e8391d2e1~CeA1ulgD43144631446epcas1p3a;
        Tue, 12 Feb 2019 01:00:20 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190212010020epsmtrp233393632d7a60ce5d0c3cca8c5971626~CeA1tIk-v0992709927epsmtrp2j;
        Tue, 12 Feb 2019 01:00:20 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-53-5c621aa52c3c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.CB.03601.4AA126C5; Tue, 12 Feb 2019 10:00:20 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190212010020epsmtip12c63fd5255a1c95fc074167873d5d94f~CeA1c0Ie60770907709epsmtip1c;
        Tue, 12 Feb 2019 01:00:20 +0000 (GMT)
Subject: Re: [PATCH 2/3] dt-bindings: devfreq: add compatible for mt8183 cci
 devfreq
To:     Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <803eacf2-a3c7-a4d0-682a-837b7367bf2f@samsung.com>
Date:   Tue, 12 Feb 2019 10:00:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548743704-16821-3-git-send-email-andrew-sh.cheng@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmru5SqaQYg6ObBCy2r3/BajH/yDlW
        i293fjNZnG16w26x6fE1VovLu+awWVxuvsho8bn3CKPF0usXmSyaWowtbjeuYLM4c/oSq0Xr
        3iPsFtPvClls/OrhwO+xZt4aRo+ds+6ye2xa1cnmcefaHjaPzUvqPVpO7mfx2HK1ncWjb8sq
        Ro/Pm+QCOKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
        MnOAzldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW6BUn5haX5qXrJefnWhka
        GBiZAhUmZGc0/V/GWLBPoOLX003MDYzLebsYOTkkBEwkrtycw9LFyMUhJLCDUeLV1cuMEM4n
        Romze46wQjjfGCUObjvDAtNy/NshJhBbSGAvo8Siu3oQRe8ZJfYc+M0OkhAWCJO49WUbWLeI
        wEUmiW1L1jKDJJgFbjFKvN7PBmKzCWhJ7H9xA8zmF1CUuPrjMSOIzStgJ9F87C+YzSKgKtFy
        fTfYNlGBCInDve+gagQlTs58AnYRp4CvxJz+vewQ88Ulbj2ZzwRhy0s0b53NDHKEhMApdolT
        n7YyQrzgIrFv7iqod4QlXh3fwg5hS0l8freXDcKullh58ggbRHMHo8SW/RdYIRLGEvuXTgba
        wAG0QVNi/S59iGV8Eu++9rCChCUEeCU62oQgqpUlLj+4ywRhS0osbu+EGu8h8WHlM6YJjIqz
        kLwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBYbI0b2JEZy2tUx3ME4553OIUYCDUYmHVyE3
        MUaINbGsuDL3EKMEB7OSCK+BcFKMEG9KYmVValF+fFFpTmrxIUZTYGhPZJYSTc4H5pS8knhD
        UyNjY2MLE0MzU0NDJXHe9Q7OMUIC6YklqdmpqQWpRTB9TBycUg2Me1qzNjlM563uvFS86OeC
        b6Fr3VozGb+Hf72puXnTwslTI/nNRcrt0ick7An4s/H05PjJ3eXy3FFS98I9JP4cFzIL3lrH
        /y58i2LYjTQe1hkfEmvNV+q9Lr0VeTLz758Hd75KFnzi2BXb3THr2q2oq79LTy5w3rSnvOGN
        s9A9yTNOZYsmTNDcrcRSnJFoqMVcVJwIAM12fKLxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7bCSnO4SqaQYg0XndSy2r3/BajH/yDlW
        i293fjNZnG16w26x6fE1VovLu+awWVxuvsho8bn3CKPF0usXmSyaWowtbjeuYLM4c/oSq0Xr
        3iPsFtPvClls/OrhwO+xZt4aRo+ds+6ye2xa1cnmcefaHjaPzUvqPVpO7mfx2HK1ncWjb8sq
        Ro/Pm+QCOKO4bFJSczLLUov07RK4Mpr+L2Ms2CdQ8evpJuYGxuW8XYycHBICJhLHvx1i6mLk
        4hAS2M0oseTMIUaIhKTEtItHmbsYOYBsYYnDh4shat4ySsxbsY8JpEZYIEzi1pdtrCAJEYGr
        TBK9E9tYQBxmgVuMEpuaj7BDtDxmlHh3vIkdpIVNQEti/4sbbCA2v4CixNUfj8HW8QrYSTQf
        +wtmswioSrRc3w22QlQgQuLjU4h1vAKCEidnPmEBsTkFfCXm9O8Fm8ksoC7xZ94lZghbXOLW
        k/lMELa8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L
        10vOz93ECI5hLa0djCdOxB9iFOBgVOLhVchNjBFiTSwrrsw9xCjBwawkwmsgnBQjxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnFc+/1ikkEB6YklqdmpqQWoRTJaJg1OqgTHiF3eN65HTjqJ/dGdJ
        CUfzzrd3fH5SU//hRiuTDUwnQ574ihhU6eyzPfW+doP1a7NkqTStdzUzlqeH5u8tb5S+u7FN
        NvQox6KkpLc/f0/WqshLFrvqlPD378RPmq2v8357H1jHVDdz3u0X1ZER0n7zfX7/E7x/YUVa
        SvXFg88b2Y76nK2vuKfEUpyRaKjFXFScCAB/fZXv3QIAAA==
X-CMS-MailID: 20190212010020epcas1p30ed98e10f06aaf90e1c6c35e8391d2e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190129063540epcas2p2562f42dd248030292eb438259e54236b
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20190129063540epcas2p2562f42dd248030292eb438259e54236b@epcas2p2.samsung.com>
        <1548743704-16821-3-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew-sh.Cheng,

On 19. 1. 29. 오후 3:35, Andrew-sh Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> This adds dt-binding documentation of cci devfreq
> for Mediatek MT8183 SoC platform.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  .../bindings/devfreq/mt8183-cci-devfreq.txt           | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt b/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
> new file mode 100644
> index 0000000..e2b61cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
> @@ -0,0 +1,19 @@
> +* Mediatek CCI frequency device

You have to add more detailed what to do on this driver.
Also, please add the full alphabet for CCI.

> +
> +Required properties:
> +- compatible: should contain "mediatek,mt8183-cci" for cci devfreq

Usually, dt-binding document only specifies h/w information
and how to bind device. 'devfreq' is the word of linux-side.
It means that 'devfreq' cannot indicate the any h/w device.

You should use the h/w device information and word of CCI for writing
the dt-binding document without linux-side word like devfreq.

For example, 
- cci devfreq -> frequency scaling of CCI

> +

Remove unneeded blank line.

> +- clocks: for cci devfreq

ditto of 'devfreq' word.

> +

ditto of blank line

> +- clock-names: for cci devfreq driver to reference

ditto of 'devfreq' word.

> +

ditto of blank line

> +- operating-points-v2: for cci devfreq opp table

ditto of 'devfreq' word.

> +
> +Example:
> +	cci: cci {
> +		compatible = "mediatek,cci";
> +		clocks = <&apmixedsys CLK_APMIXED_CCIPLL>;
> +		clock-names = "cci_clock";
> +		operating-points-v2 = <&cci_opp>;
> +	};
> +
> 

This document is missing the 'regulator' property. Please add it

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
