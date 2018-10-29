Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B10C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF7420664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hHt+qc0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF7420664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbeJ2R6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:58:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58723 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbeJ2R6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:58:43 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181029091056euoutp012db2660ed8e9af7f971f9aaa1ddb6357~iCU64xna-0870908709euoutp01n
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:10:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181029091056euoutp012db2660ed8e9af7f971f9aaa1ddb6357~iCU64xna-0870908709euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1540804256;
        bh=e+YoKOIu0cm6Jc8pFEJEVHFX2I0pp5TXA0eK23Wd6i0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hHt+qc0oimMUlbWx3lOGk2K3/pg0rXLNaQObGGEBI1vvQ4aI5s7nNsDgS4SG2kp+z
         Nb93Biw2Trls2LfGBFEVqgq2lwIb/viEJ5QeelDDZ2Q4U3sc3WQ0W0mEaDfO4WPWvt
         IdbJpjBMZWegDJvDfd5Y4njOOV5x2pWyJEqWE5Es=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181029091055eucas1p11b397866987dcc7de2937bfa81d26d38~iCU6NtiCa0849608496eucas1p1I;
        Mon, 29 Oct 2018 09:10:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D5.96.04806.F9EC6DB5; Mon, 29
        Oct 2018 09:10:55 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181029091054eucas1p1756b51bc1e76d7033dcfeff884a41b15~iCU5cFNR01192711927eucas1p1_;
        Mon, 29 Oct 2018 09:10:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181029091054eusmtrp14baa9752a132cf78471a68ee219f7dc6~iCU5Lx1ZC2621526215eusmtrp1R;
        Mon, 29 Oct 2018 09:10:54 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-9b-5bd6ce9f038d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D5.0B.04128.E9EC6DB5; Mon, 29
        Oct 2018 09:10:54 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181029091053eusmtip27ed7f017516539f47da835058e250b43~iCU4oDCPm2007220072eusmtip2h;
        Mon, 29 Oct 2018 09:10:53 +0000 (GMT)
Subject: Re: [PATCH v2 5/6] dt-bindings: drm/panel: simple: Innolux TV123WAM
 is actually P120ZDG-BF1
To:     Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, ryandcase@chromium.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <5b059dbe-efb2-c379-beb6-216a6bcedcba@samsung.com>
Date:   Mon, 29 Oct 2018 10:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025222134.174583-5-dianders@chromium.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH931+3XPV5etOu89omrMYN0L+eEYam83TZubHZqaMB0+FCndS
        mU3ph36vqOyuXEi0MKSiSFOn03JHpPIjRX6sJqZcrUbc06Ppv9f3/Xl/39/3Z/uypLqTnsnu
        izoiGqKECB3jRlU3jToWFTvag5eYLiq5LEczwRVbHTRnv/yQ4dqc3xkuLfeSgsuttyu4F7VF
        DFfa0UpwyXVWBVfT6aS5rpt2xMVnJSm40VoLtVrFX7NcQ3xhfCvFv8jOIvgac5eCL0w10XxF
        eRrD3xnuofnuDBvBD1XM3qjc7hawV4zYd1Q0+AXucgt/9zWROWSZFjtUmcPEo2SPdKRkAS+H
        pNvnCInVuAzBh3q9zD8RZNZx6cjNxUMI+psfMpMX2sfzSdl0BYFtfJlsGkCQ86NxYqDBoVB5
        9REpDWbgUgRN+d2EdCBxLQEjnwYn3mPwAvh9+5UrlmVVOBCeZwsSUtgXOvpFyeGFt4G15wKS
        WIWnQ7PpIyWxEgdA+1jCBJPYBxKrCkmZtfD6YzEhF01goaT3uBQJeC3UDa+SZQ302yoVMntD
        y5lMSuYTcNLUNlEZcCqCxyVX/i28EhptrbSUQ7oa36j1k+U1cOrtMCPHe0LnwHS5gSecrj5L
        yrIKUlPUsnsOdNurSJm1UPrMyeQgnXnKXuYpu5in7GL+/+55RJUjrRhtjAwTjf5RYsxioxBp
        jI4KW7znYGQFcv23lnGb8y568Gt3A8Is0nmoetzbg9W0cNQYF9mAgCV1M1QjT1ySaq8Qd0w0
        HNxpiI4QjQ1oFkvptKrLllvBahwmHBEPiOIh0TA5JVjlzHgUFNPlkxjyecCiv95pRRp6f9W6
        8Lo3W8T39U8He+eXFJUEbdhs+uJXkOelafS+nmFb3uAvOnPiKssMId/U+kVv2rZaN+G3lr5d
        y16u97g3fEt4qk8JjZ3bVF3gG1Hect93x+Ehos+ed+wGhTT+HSvSae1Y9V2H+5/cefwDvVeF
        RUcZw4WlC0mDUfgLfCiC2WsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsVy+t/xe7rzzl2LNrj2Xsii99xJJov5R86x
        WpxddpDN4srX92wWnROXsFtM3H+W3eLyrjlsFkuvX2SyaN17hN1i542vrBZ3N5xltGjobWG3
        +LlrHosDr8eaeWsYPWY3XGTxuNzXy+Sxc9Zddo/ZHTNZPTat6mTz2P7tAavH/e7jTB6fN8kF
        cEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZdx7
        08xWMI+/4vOWCWwNjK08XYycHBICJhLX/k1l7mLk4hASWMooMev7KzaIhLjE7vlvmSFsYYk/
        17rYIIpeM0qce/0QLCEskCaxZfVRsG4RkO6HvSdYQBxmgV1MEj3LmtkhWg4ySlzZuZ8RpIVN
        QFPi7+abQLM4OHgF7CQu9SWCmCwCqhLXX6WCVIgKREisXv6CFcTmFRCUODnzCQuIzSlgI3Ht
        VyOYzSygLvFn3iVmCFteonnrbChbXOLWk/lMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5N
        zy020itOzC0uzUvXS87P3cQIjO1tx35u2cHY9S74EKMAB6MSD+8D7mvRQqyJZcWVuYcYJTiY
        lUR4v58BCvGmJFZWpRblxxeV5qQWH2I0BfptIrOUaHI+MO3klcQbmhqaW1gamhubG5tZKInz
        njeojBISSE8sSc1OTS1ILYLpY+LglGpgFI5/GyTTy2PTuO9/4pU7D03vXlB02sUdFvJH9tQc
        wa0FnHL/2P98Ff5+99JC9nXPtpx/uklE+9BCeeEmEctbO59N3rjnseKVc3aJlqtnuHTedjhs
        4BFxSX1JsPyHD09Oz1rN1ZVTdE1B8VoSG0fAvNXlf4I0516581ln3vnFP2+emR4osfrKo5NK
        LMUZiYZazEXFiQA6nkWCAwMAAA==
X-CMS-MailID: 20181029091054eucas1p1756b51bc1e76d7033dcfeff884a41b15
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181025222234epcas5p49f58ac6ec1f0fa0ef1b5f35162b215a3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181025222234epcas5p49f58ac6ec1f0fa0ef1b5f35162b215a3
References: <20181025222134.174583-1-dianders@chromium.org>
        <CGME20181025222234epcas5p49f58ac6ec1f0fa0ef1b5f35162b215a3@epcas5p4.samsung.com>
        <20181025222134.174583-5-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.2018 00:21, Douglas Anderson wrote:
> As far as I can tell the bindings that were added in commit
> 9c04400f7ea6 ("dt-bindings: drm/panel: Document Innolux TV123WAM panel
> bindings") weren't actually for Innolux TV123WAM but were actually for
> Innolux P120ZDG-BF1.
>
> As far as I can tell the Innolux TV123WAM isn't a real panel and but
> it's a mosh between the TI TV123WAM and the Innolux P120ZDG-BF1.
> Let's unmosh.
>
> Here's my evidence:
>
> * Searching for TV123WAM on the Internet turns up a TI panel.  While
>   it's possible that an Innolux panel has the same model number as the
>   TI Panel, it seems a little doubtful.  Looking up the datasheet from
>   the TI Panel shows that it's 1920 x 1280 and 259.2 mm x 172.8 mm.
>
> * As far as I know, the patch adding the Innolux Panel was supposed to
>   be for the board that's sitting in front of me as I type this
>   (support for that board is not yet upstream).  On the back of that
>   panel I see Innolux P120ZDZ-EZ1 rev B1.
>
> * Someone pointed me at a datasheet that's supposed to be for the
>   panel in front of me (sorry, I can't share the datasheet).  That
>   datasheet has the string "p120zdg-bf1"
>
> * If I search for "P120ZDG-BF1" on the Internet I get hits for panels
>   that are 2160x1440.  They don't have datasheets, but the fact that
>   the resolution matches is a good sign.
>
> While we doing the rename, also mention that no-hpd can be used with
> this panel.  See the previous patch in this series ("drm/panel:
> simple: Add "no-hpd" delay for Innolux TV123WAM").
>
> Fixes: 9c04400f7ea6 ("dt-bindings: drm/panel: Document Innolux TV123WAM panel bindings")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Cc: Sandeep Panda <spanda@codeaurora.org>

Grats for good deduction.


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
