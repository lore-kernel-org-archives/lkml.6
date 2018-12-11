Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D328C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B19720645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b6VZoOkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B19720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbeLKCpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 21:45:22 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:25129 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbeLKCpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 21:45:21 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181211024518epoutp0326da37e4bf717f387efe6305b54517f5~vJzfvpbrp1894118941epoutp03N
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:45:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181211024518epoutp0326da37e4bf717f387efe6305b54517f5~vJzfvpbrp1894118941epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544496318;
        bh=nk+OwosOKiyxXRumfbgppOX5mjdzpDJ1RVVVuD8Ot/I=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=b6VZoOkggATzVvEZRYcUClPo1KIpN4RsyOYxORBGkQDC+5jZ2XCYtjzB5Wd5pXvoJ
         ant0z6alT65BnI1K3mqugit50IhuaHGZkH0aC0odQly/QvmbXu0+Dz5XbZFHmxs/Fl
         XP3qb9TZTTd46sVjldAU942+0CQNzNPjciaI5UHY=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181211024514epcas1p482deb2c0b1c7db055b0df34a789171fb~vJzcixyxK0469704697epcas1p4C;
        Tue, 11 Dec 2018 02:45:14 +0000 (GMT)
X-AuditID: b6c32a37-411ff70000000fdc-41-5c0f24ba7ffb
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.42.04060.AB42F0C5; Tue, 11 Dec 2018 11:45:14 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v3 3/5] devfreq: add devfreq_suspend/resume()
 functions
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
In-Reply-To: <5C087BC3.1050405@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20181211024514epcms1p3ad01341631793f00a4161ff39139a1ce@epcms1p3>
Date:   Tue, 11 Dec 2018 11:45:14 +0900
X-CMS-MailID: 20181211024514epcms1p3ad01341631793f00a4161ff39139a1ce
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkl+LIzCtJLcpLzFFi42LZdlhTX3eXCn+MwZ3j5hYHt2pabJyxntVi
        +8ZvrBbXvzxntZh/5ByrRfPi9WwWZ7pzLfofv2a2OH9+A7vF2aY37Ba3GmQsZk3Zy2Sx6fE1
        VovLu+awWXzuPcJoMeP8PiaLtUfuslssvX6RyeLuqaNA7acvsVq07j3CbtG2+gOrxZsL91gc
        xD227d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaPg+/2MHls
        udrO4tG3ZRWjx4rV39k9Pm+SC+CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBX
        nJhbXJqXrpecn2tlaGBgZApUmJCdcfDiZuaCnZwVW648ZWxgnMjZxcjJISFgIjGlaRZ7FyMX
        h5DADkaJdddfMncxcnDwCghK/N0hDGIKCwRKdPz1AikXElCSaLi5jxnEFhbQl+h4sI0RxGYT
        0JXYuuEuC8gYEYHlzBKfljcwgzjMAm9ZJU7d3skEsYxXYkb7UxYIW1pi+/KtYN2cAtoSs5ru
        sEPERSVurn4LZ78/Np8RwhaRaL13lhnCFpR48HM3VFxK4snbhVD19RLXPy9iAlksITCBUeL3
        jf9QCX2JR1dms4HYvAK+EpP27wFrZhFQlVh95SErRI2LRMOsKWCHMgMdtGzha3BAMAtoSqzf
        pQ8R5pN497WHFeaXHfOeQP2lJnFo9xKoVTISp6cvBGuVEPCQuPMuBxK2XxglPq1dwzaBUX4W
        InhnIVk2C2HZAkbmVYxiqQXFuempxYYFxsgxuokRnPy1zHcwbjjnc4hRgINRiYdXoYUvRog1
        say4MvcQowQHs5IIr24ab4wQb0piZVVqUX58UWlOavEhRlOgnycyS4km5wMzU15JvKGpkbGx
        sYWJoZmpoaGSOO8TqbnRQgLpiSWp2ampBalFMH1MHJxSDYwzZRVzDeZunOfhpp65TKFc0+Gv
        qtrjFvmNN48Vu8ta+1+2OPW2U9v7hpXf5JXHL/h9nf2vaVptg+OuXVNusNyb2HV10vnakDm1
        bRv6X/Guj59Q1rFRVzqrfGq+2xZLFuPKu5eZ7rhPbAlM2m5zcdNu2wmlUtH5TOcC3ZfmSx2R
        zfzt9ebGnVVKLMUZiYZazEXFiQD6GzsrFAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181205110622eucas1p23d788afd54ad34c0a2663efac8734648
References: <5C087BC3.1050405@samsung.com>
        <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <1544007956-28889-4-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110622eucas1p23d788afd54ad34c0a2663efac8734648@epcms1p3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Lukasz,
>=20
> On 2018=EB=85=84=2012=EC=9B=94=2005=EC=9D=BC=2020:05,=20Lukasz=20Luba=20w=
rote:=0D=0A>=20>=20This=20patch=20adds=20implementation=20for=20global=20su=
spend/resume=20for=0D=0A>=20>=20devfreq=20framework.=20System=20suspend=20w=
ill=20next=20use=20these=20functions.=0D=0A>=20>=20=0D=0A>=20>=20Suggested-=
by:=20Tobias=20Jakobi=20<tjakobi=40math.uni-bielefeld.de>=0D=0A>=20>=20Sugg=
ested-by:=20Chanwoo=20Choi=20<cw00.choi=40samsung.com>=0D=0A>=20>=20Signed-=
off-by:=20Lukasz=20Luba=20<l.luba=40partner.samsung.com>=0D=0A>=20>=20---=
=0D=0A>=20>=20=20drivers/devfreq/devfreq.c=20=7C=2044=20+++++++++++++++++++=
+++++++++++++++++++++++++=0D=0A>=20>=20=20include/linux/devfreq.h=20=20=20=
=7C=20=206=20++++++=0D=0A>=20>=20=202=20files=20changed,=2050=20insertions(=
+)=0D=0A>=20=0D=0A>=20Reviewed-by:=20Chanwoo=20Choi=20<cw00.choi=40samsung.=
com>=0D=0A=0D=0AAcked-by:=20MyungJoo=20Ham=20<myungjoo.ham=40samsung.com>=
=0D=0A=0D=0AThe=20patches=20from=201=20to=203=20are=20being=20applied=20and=
=20tested.=0D=0AI'll=20probably=20send=20pull-request=20to=20Rafael=20today=
=20after=20some=20testing=20targetting=204.21+=0D=0A=0D=0ACheers,=0D=0AMyun=
gJoo=0D=0A=0D=0A=0D=0A
