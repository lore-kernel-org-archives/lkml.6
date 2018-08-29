Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC14AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6473B2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h/vJ2G8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6473B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeH2GEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:04:49 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:43747 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeH2GEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:04:48 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180829021018epoutp042e5f2b8a81a8a9c7835ed0331e96f258~POPP3krFD0645206452epoutp04T
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 02:10:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180829021018epoutp042e5f2b8a81a8a9c7835ed0331e96f258~POPP3krFD0645206452epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535508618;
        bh=G5ZB46mhqy2dEARLouYsiFhc8le0j9AOWgR2ZM/NwgE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=h/vJ2G8ICBX3zhlo8tNbo5AdviV5oDmEGZJhfHwVsg/6tPio6N7AnPdst7iUXScoN
         LOatEVw197f36vMfJg9QerhOOxfqLN7Bd0AX7uL/BqlHnOkEFgxhyPzIeJZQlA35Dc
         bhBGXqcSkcmEpixBTYcSyeGHx5aGe3s8lFlxm7Ec=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180829021016epcas1p11d598c76107c423e6958f65943c4a1ef~POPNtb-1j0574405744epcas1p1H;
        Wed, 29 Aug 2018 02:10:16 +0000 (GMT)
X-AuditID: b6c32a39-bcbff7000000108b-7d-5b8600865969
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.AB.04235.680068B5; Wed, 29 Aug 2018 11:10:14 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] devfreq: Convert to using %pOFn instead of
 device_node.name
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <5B84AE40.50305@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180829021014epcms1p85b74efd54e73039e5a81629d8079e02e@epcms1p8>
Date:   Wed, 29 Aug 2018 11:10:14 +0900
X-CMS-MailID: 20180829021014epcms1p85b74efd54e73039e5a81629d8079e02e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdljTQLeNoS3aYGevlsX1L89ZLfofv2a2
        OH9+A7vF2aY37BabHl9jtbi8aw6bxefeI4wWM87vY7L4v2cHuwOnx6ZVnWwem5fUe/RtWcXo
        8XmTXABLVKpNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+Arltm
        DtApSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpWhDQyM9QwNzPSMjIG0ca2VkClSSkJpx
        trWHveAcZ8WsT+wNjMs4uxg5OSQETCTeHXjH0sXIxSEksINR4sKjZUAOBwevgKDE3x3CIDXC
        AmESN9/NZwWxhQSUJBpu7mOGiOtLdDzYxghiswnoSmzdcBdsjohAB6PEs7k3WEEcZoEzTBLP
        t25ghtjGKzGj/SkLhC0tsX35VrBuTgFNiRn31jJCxEUlbq5+yw5jvz82HyouItF67yzUHEGJ
        Bz93Q8WlJJ68XQhVXy9x/fMiJpDFEgITGCV+3/gPldCXeHRlNhuIzSvgK7F55ySwQSwCqhI3
        j3ZDHeQi8ehdN1g9s4C2xLKFr5lBIcEMdNz6XfoQYT6Jd197WGF+2THvCROErSZxaPcSqFUy
        EqenLwRrlRDwkJj9xgUSuMcZJc7O/s0ygVF+FiJ8ZyFZNgth2QJG5lWMYqkFxbnpqcWGBaZ6
        xYm5xaV56XrJ+bmbGMGJUMtyB+Oxcz6HGAU4GJV4eDmCW6OFWBPLiitzDzFKcDArifCenQwU
        4k1JrKxKLcqPLyrNSS0+xGgK9PNEZinR5Hxgks4riTc0NTI2NrYwMTQzNTRUEuc18guOFhJI
        TyxJzU5NLUgtgulj4uCUamDUYdt4jSFkpRKr5RF53fXtm95qfH2foOd3M+N34qf6hZfWnv/w
        LEk4OEFVbRZnaOb5uquv7AQZJCOjTaree1pMnK/0vipXTEbv+4FjPD6MO+Nq9B9kHNn519/B
        w0PPkcl/xcqt5xtLOf5lqF6Y+bj3z4zvvTlMUjd/+PA1+Fl68NkoJF4UtVViKc5INNRiLipO
        BADU1wJYmgMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180828015312epcas2p2fdb2ee1d1b292f212ec773dd8fb4bfc7
References: <5B84AE40.50305@samsung.com>
        <20180828015252.28511-1-robh@kernel.org>
        <20180828015252.28511-15-robh@kernel.org>
        <CGME20180828015312epcas2p2fdb2ee1d1b292f212ec773dd8fb4bfc7@epcms1p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Dear Rob,
>=20
> On 2018=EB=85=84=2008=EC=9B=94=2028=EC=9D=BC=2010:52,=20Rob=20Herring=20w=
rote:=0D=0A>=20>=20In=20preparation=20to=20remove=20the=20node=20name=20poi=
nter=20from=20struct=20device_node,=0D=0A>=20>=20convert=20printf=20users=
=20to=20use=20the=20%pOFn=20format=20specifier.=0D=0A>=20>=20=0D=0A>=20>=20=
Cc:=20Chanwoo=20Choi=20<cw00.choi=40samsung.com>=0D=0A>=20>=20Cc:=20MyungJo=
o=20Ham=20<myungjoo.ham=40samsung.com>=0D=0A>=20>=20Cc:=20Kyungmin=20Park=
=20<kyungmin.park=40samsung.com>=0D=0A>=20>=20Cc:=20Kukjin=20Kim=20<kgene=
=40kernel.org>=0D=0A>=20>=20Cc:=20Krzysztof=20Kozlowski=20<krzk=40kernel.or=
g>=0D=0A>=20>=20Cc:=20linux-pm=40vger.kernel.org=0D=0A>=20>=20Cc:=20linux-a=
rm-kernel=40lists.infradead.org=0D=0A>=20>=20Cc:=20linux-samsung-soc=40vger=
.kernel.org=0D=0A>=20>=20Signed-off-by:=20Rob=20Herring=20<robh=40kernel.or=
g>=0D=0A>=20>=20---=0D=0A>=20>=20=20drivers/devfreq/event/exynos-ppmu.c=20=
=7C=204=20++--=0D=0A>=20>=20=201=20file=20changed,=202=20insertions(+),=202=
=20deletions(-)=0D=0A>=20>=20=0D=0A=5B=5D=0D=0A>=20=0D=0A>=20Acked-by:=20Ch=
anwoo=20Choi=20<cw00.choi=40samsung.com>=0D=0A=0D=0AAcked-by:=20MyungJoo=20=
Ham=20<myungjoo.ham=40samsung.com>=0D=0A=0D=0A
