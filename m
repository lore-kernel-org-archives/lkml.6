Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6174C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F48F2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hxcIwHvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F48F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbeLKBnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:43:22 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:51435 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbeLKBnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:43:22 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181211014319epoutp017e8616ec41da6f918d2914b8d8282a25~vI9X755VV1700017000epoutp01Z
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:43:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181211014319epoutp017e8616ec41da6f918d2914b8d8282a25~vI9X755VV1700017000epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544492599;
        bh=N6gtlJaIZdoRTs9uBS6/4m50BwuZJ04ayUsPQyAtdHE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=hxcIwHvWVVaH0Gsehy0RFaaw/RO9Yu8Rz2x5flyjIEiPPZmz7CG4BboBwCX6rtQ7r
         kvyP6UoodRyvm4IiU0n9ASs7/YW/bqUH3DZFRdHb/U4qgsorRBM/vaKe/yBHWJ6w5H
         hcrVeDUVrkdDpnrtXXPfKvZtz17DvTjvmDvs07yQ=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181211014315epcas1p235be1126f6a1b2156c68333bb87d1741~vI9U64bM40864408644epcas1p2r;
        Tue, 11 Dec 2018 01:43:15 +0000 (GMT)
X-AuditID: b6c32a35-e1fff70000000fda-e2-5c0f163391a4
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.6A.04058.3361F0C5; Tue, 11 Dec 2018 10:43:15 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v3 2/5] devfreq: add support for suspend/resume of a
 devfreq device
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <5C0878C0.4060500@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20181211014315epcms1p153a54217e587fd76a8198db77762699a@epcms1p1>
Date:   Tue, 11 Dec 2018 10:43:15 +0900
X-CMS-MailID: 20181211014315epcms1p153a54217e587fd76a8198db77762699a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwTZxz2vev1DmK7o6K+6Zg2l02DWuCsZS9GliUSc9l0IxH8Y+DgAjcg
        9Cu9YtRtsRGdEz8oxmhTFMaEVT4WtEDt5MNRq1EZVpyD+QHqqDGKuEWYE4yyfhH978lzv+ee
        5/m970vhip2kkioxWASzgdcx0liJ+3yiWq1Z8E5uyhF7KurtSESn7a0EOnP6OYGGJh8SqNZ3
        lUDlJ1ql6Ld9elQ5OoYjv/8Uifp3PiHRLWsCchzuxpBrdJBAv589JkUTB3wA2f09GPrZN0yi
        hqEBDA1fuRCU910n0O5uH4m+a/6HQE+ujUg+Xsi5O90E11LTArhq64CEs1U+A9yJrkcY52ra
        K+XOHW8hubb6HdzriyTX+7QL49r/2CPhDrY3Ae5k838kN+FalCn/onRNscAXCmaVYCgwFpYY
        itKZTzfmrc3TpqawajYNfcioDLxeSGcy1meq15XogvUZ1RZeVxakMnlRZJI/WmM2llkEVbFR
        tKQzgqlQZ0ozJYm8XiwzFCUVGPWr2ZSUldrgYH5p8d07l0hTr3zr/ZnLUivYK68AMRSkV0Hb
        6HOsAsRSCtoDYIO1ElQAipLRcfCVZ15oZh69GfbbrXgIK2gGWm/24BE+GX5/zw1CWEqrYcep
        YUnoP/G0E4fPnCFBLIXT4wS8cvsXLOImg/Y9DyQR/C484+wIq2Po5fDQTKM0ws+HN5vHyVn8
        98VaEMHxcPdIPx7BcfDeVGeUV8LAeF10fgccmvgx3AbSNgBf/jkT/ZAM/7pRHTaQ0Rtgb+P5
        cCAJ/QG8O3QnGi4D+lu6wuHwYKCf6sbw0CZwOhG2nk2O0HL49N/9xGwXT00gKl0CvZ31UasE
        2He0LiyFNAevXVBFljsJYE95OW4Dix1v9ut4y8zxxuwHgDeBBYJJ1BcJImti3z5SFwjf/2Va
        Dzh8db0X0BRg5spUu+S5CoLfIm7TewGkcCZepv5KlquQFfLbtgtmY565TCeIXqANdq7ClfML
        jMHXZLDksdqVGo0GrWJTtSzLLJQFlMdzFHQRbxFKBcEkmGd1GBWjtAIDcft6axs/NVE/7W88
        0rb4VU72ocCKR3Pfs70/Wb+5NmZascKXlPV4JOGTarhp068vBl3ykSx7XHdX/qJ9HXOyB5pS
        Cw6e+zKL/Nak4NY+aK9aqnmY3/34hncyY7vTXbX1m77lvtWfjzoGsTnHxj5rqNE2OL+WTg16
        ZnIqN9in07IDjEQs5tlluFnk/wePnE3hFQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181205110620eucas1p14de70dc092580b684a0304b5ce771605
References: <5C0878C0.4060500@samsung.com>
        <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <1544007956-28889-3-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110620eucas1p14de70dc092580b684a0304b5ce771605@epcms1p1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Lukasz,
>=20
> On 2018=EB=85=84=2012=EC=9B=94=2005=EC=9D=BC=2020:05,=20Lukasz=20Luba=20w=
rote:=0D=0A>=20>=20The=20patch=20prepares=20devfreq=20device=20for=20handli=
ng=20suspend/resume=0D=0A>=20>=20functionality.=20The=20new=20fields=20will=
=20store=20needed=20information=20during=20this=0D=0A>=20>=20process.=20Dev=
freq=20framework=20handles=20opp-suspend=20DT=20entry=20and=20there=20is=20=
no=0D=0A>=20>=20need=20of=20modyfications=20in=20the=20drivers=20code.=20It=
=20uses=20atomic=20variables=20to=0D=0A>=20>=20make=20sure=20no=20race=20co=
ndition=20affects=20the=20process.=0D=0A>=20>=20=0D=0A>=20>=20Suggested-by:=
=20Tobias=20Jakobi=20<tjakobi=40math.uni-bielefeld.de>=0D=0A>=20>=20Suggest=
ed-by:=20Chanwoo=20Choi=20<cw00.choi=40samsung.com>=0D=0A>=20>=20Signed-off=
-by:=20Lukasz=20Luba=20<l.luba=40partner.samsung.com>=0D=0A>=20>=20---=0D=
=0A>=20>=20=20drivers/devfreq/devfreq.c=20=7C=2047=20++++++++++++++++++++++=
+++++++++++++++++++------=0D=0A>=20>=20=20include/linux/devfreq.h=20=20=20=
=7C=20=207=20+++++++=0D=0A>=20>=20=202=20files=20changed,=2048=20insertions=
(+),=206=20deletions(-)=0D=0A>=20=0D=0A>=20Reviewed-by:=20Chanwoo=20Choi=20=
<cw00.choi=40samsung.com>=0D=0A>=20=0D=0A=0D=0ALooks=20goot=20do=20me=20as=
=20well.=0D=0A=0D=0AAcked-by:=20MyungJoo=20Ham=20<myungjoo.ham=40samsung.co=
m>=0D=0A=0D=0A=0D=0AAnyway,=20for=20the=20sake=20of=20curiosity...=0D=0A=0D=
=0AHaving=20suspend-frequency=20is=20usually=20required=20when=0D=0Athe=20f=
requency=20configuration=20is=20reset=20with=20suspend-resume=0D=0Aas=20old=
er=20Exynos's=20CPU=20did=20(I=20don't=20know=20whether=20it=20still=20does=
).=0D=0A=0D=0ADoes=20GPU=20do=20this=20as=20well?=0D=0A(memory-bus=20won't=
=20do=20this=20because=20they=20are=20kept=20turned=20on=20during=20suspend=
)=0D=0A=0D=0A=0D=0ACheers,=0D=0AMyungJoo=0D=0A
