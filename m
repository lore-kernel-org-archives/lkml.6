Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506B5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72AA20856
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HSYQmRzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72AA20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeH2OWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:22:02 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:56561 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2OWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:22:02 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180829102546epoutp045a3d8b2407aaa4375002105713210549~PU-2KE6sY2021720217epoutp04J
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 10:25:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180829102546epoutp045a3d8b2407aaa4375002105713210549~PU-2KE6sY2021720217epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535538346;
        bh=cI6awkY8q7PNwlNQC18pvSlwaOvuPgh1nA82yok60i0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=HSYQmRzQ264C+XPqUbupDtq2P8yl3j/BH2CHKBwtYqC3Io/e22h0AEJ1P0/o83Is4
         IdRlRgHil37yMvs4AJvrlxAZz0ZvqOFtl1SJcyZ8BJwdrhdXMcfqtX3efyhnkxnTK/
         6VFOZ9E2ExTv5F6k0NHhUp3AFq/KA1JSnwepzLvs=
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.192]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20180829102543epcas5p237768d7213d443f4652bef0388402a4e~PU-z15BZ-2738527385epcas5p2V;
        Wed, 29 Aug 2018 10:25:43 +0000 (GMT)
X-AuditID: b6c32a49-d05ff7000000115d-58-5b8674a72bfb
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.CB.04445.7A4768B5; Wed, 29 Aug 2018 19:25:43 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] Preventive patch in the pin control subsystem to
 handle NULL check.
Reply-To: srikanth.h@samsung.com
From:   Srikanth Korangala Hari <srikanth.h@samsung.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Srikanth Korangala Hari <srikanth.h@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1535359139-6264-1-git-send-email-srikanth.h@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180829102543epcms5p2070c1c13edc239aa3f776f53b584c27a@epcms5p2>
Date:   Wed, 29 Aug 2018 15:55:43 +0530
X-CMS-MailID: 20180829102543epcms5p2070c1c13edc239aa3f776f53b584c27a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmlu7ykrZogwdTTCxeHtK0mPJnOZPF
        5vl/GC0u75rDZrHjxSsmB1aPO9f2sHn0bVnF6PF5k1wAc1SqTUZqYkpqkUJqXnJ+SmZeuq2S
        d3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QRiWFssScUqBQQGJxsZK+nU1RfmlJqkJG
        fnGJrVK0oaGRnqGBuZ6REZA2jbUyMgUqSUjN2HN+LnvBWsmK5mWH2BsYb0h0MXJySAiYSLxo
        /8faxcjFISSwm1HiYP8Dpi5GDg5eAUGJvzuEQWqEBeIknk/ZxgISFhJQkLi1KhoibCExaUYn
        M4jNJmAm0fN9DxPIGBGB7YwSlxtfsYEkmIHmN06+wgSxi1diRvtTFghbWmL78q2MIDangJvE
        oufzWSHiohI3V79lh7HfH5vPCGGLSLTeO8sMYQtKPPi5mxFmzvtjU8AWSwhMZpT4+nMnC4Sz
        mlFi/6EXUNvMJR7f3Ax2Ba+Ar8TWyf/AulkEVCXmnrgENclFovHJJCaIq7Ulli18zQzyMbOA
        psT6XfowDzRs/M2OzmYW4JPo/f0E7skd856Aw1BCQEXiwf4yCFNKoveTHUSFh8SGtvssExgV
        ZyECehaStbMQ1i5gZF7FKJlaUJybnlpsWmCYl1quV5yYW1yal66XnJ+7iRGc8LQ8dzDOOudz
        iFGAg1GJh5cjuDVaiDWxrLgy9xCjBAezkghvkEFbtBBvSmJlVWpRfnxRaU5q8SFGU2AATGSW
        Ek3OBybjvJJ4Q1MjMzMDSwNTYwszQyVx3g9+wdFCAumJJanZqakFqUUwfUwcnFINjIaR1ev6
        I+Sy0pLdQ+9H83P3yNgcFmC0MThmbRU2sax3gdKVBKG4HVd+SDl8bH9+RuElx735D4vv6kxz
        OXTW6oHQPQ4nrYuzkx1eR/LHC35fzxEkYX3n0V5B52obYda0KLeypWWvilLkq2wkVmbyb9P8
        0pqwRDin8SyPecbN7O+rzxZGc1krsRRnJBpqMRcVJwIA1vcF9o4DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180827083916epcas1p43a3fc8570269411de215254ce0ae4b37
References: <1535359139-6264-1-git-send-email-srikanth.h@samsung.com>
        <CGME20180827083916epcas1p43a3fc8570269411de215254ce0ae4b37@epcms5p2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If=C2=A0the=C2=A0pin=C2=A0descriptor=C2=A0requested=C2=A0for=C2=A0the=C2=
=A0physical=C2=A0pin=C2=A0fails=C2=A0then=C2=A0the=0D=0A>=20descriptor=C2=
=A0is=C2=A0dereferenced=C2=A0without=C2=A0checking=C2=A0for=C2=A0its=C2=A0v=
alidity=C2=A0which=0D=0A>=20may=C2=A0lead=C2=A0to=C2=A0crash,=C2=A0hence=C2=
=A0added=C2=A0preventive=C2=A0code=C2=A0to=C2=A0check=C2=A0for=C2=A0NULL=0D=
=0A>=20and=C2=A0accordingly=C2=A0dereference.=0D=0A=C2=A0=0D=0A>=20Signed-o=
ff-by:=C2=A0Srikanth=C2=A0K=C2=A0H=C2=A0<srikanth.h=40samsung.com>=0D=0A>=
=20---=0D=0A>=C2=A0drivers/pinctrl/pinconf.c=C2=A0=7C=C2=A05=C2=A0+++--=0D=
=0A>=C2=A01=C2=A0file=C2=A0changed,=C2=A03=C2=A0insertions(+),=C2=A02=C2=A0=
deletions(-)=0D=0A=C2=A0=0D=0A>=20diff=C2=A0--git=C2=A0a/drivers/pinctrl/pi=
nconf.c=C2=A0b/drivers/pinctrl/pinconf.c=0D=0A>=20index=C2=A0d3fe143..576d0=
8d=C2=A0100644=0D=0A>=20---=C2=A0a/drivers/pinctrl/pinconf.c=0D=0A>=20+++=
=C2=A0b/drivers/pinctrl/pinconf.c=0D=0A>=20=40=40=C2=A0-269,8=C2=A0+269,9=
=C2=A0=40=40=C2=A0void=C2=A0pinconf_show_setting(struct=C2=A0seq_file=C2=A0=
*s,=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case=C2=A0P=
IN_MAP_TYPE_CONFIGS_PIN:=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0desc=C2=A0=3D=
=C2=A0pin_desc_get(setting->pctldev,=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0setting->data.configs.group_or_pi=
n);=0D=0A>=20-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0seq_printf(s,=C2=A0=22pin=C2=A0%s=C2=A0=
(%d)=22,=C2=A0desc->name,=0D=0A>=20-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0setting->data.configs.group=
_or_pin);=0D=0A>=20+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(desc)=0D=0A>=20+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0seq_printf(s=
,=C2=A0=22pin=C2=A0%s=C2=A0(%d)=22,=C2=A0desc->name,=0D=0A>=20+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0setting->data.configs.group=
_or_pin);=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;=0D=0A>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case=C2=A0PIN_MAP_TYPE_CONFIGS_GROUP=
:=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0seq_printf(s,=C2=A0=22group=C2=A0%s=C2=
=A0(%d)=22,=0D=0A=0D=0ADear=20Maintainer's,=0D=0A=0D=0APlease=20confirm=20m=
e=20whether=20the=20above=20patch=20is=20considered=20for=20merging=20onto=
=20mainline=20?=0D=0A=0D=0AThanks,=0D=0ASrikanth=0D=0A=C2=A0=0D=0A=C2=A0
