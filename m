Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96412ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF0320673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LxBY+M3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF0320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeGSF5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:57:50 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:59856 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbeGSF5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:57:50 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180719051633epoutp03ddfde296e6dfc947261eda02880e92cf~CrVKibiBN2519725197epoutp03V
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 05:16:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180719051633epoutp03ddfde296e6dfc947261eda02880e92cf~CrVKibiBN2519725197epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531977393;
        bh=LeUcNYPFqZuk3Og/sfv46Aa9ZdUYrO7h2Zrg/tiuM/A=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=LxBY+M3AuokXt8NQkeFBAVJ76j0TxevXRFmNWyY3JyQDEtYtRzYDIXpA4QVNNWPHR
         /QTjfLLRqPu98Iu1xApChaWZTQ9wojftSze8ZUADgiaWy3gVj7HxhbCRuhyO+kOkpe
         0AbNlqaliYjxnL4DVdOFJb1VpAHH3s9SicbOmMfU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.195]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20180719051632epcas5p2aa83725f03f8d0b93bb4b64f5f63d38f~CrVJArZA41872718727epcas5p2s;
        Thu, 19 Jul 2018 05:16:32 +0000 (GMT)
X-AuditID: b6c32a49-aefff70000001142-28-5b501eaf5147
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.2D.04418.FAE105B5; Thu, 19 Jul 2018 14:16:31 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCHv2 1/1] Preventive fix in sound module
Reply-To: srikanth.h@samsung.com
From:   Srikanth Korangala Hari <srikanth.h@samsung.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "ben.hutchings@codethink.co.uk" <ben.hutchings@codethink.co.uk>,
        "perex@perex.cz" <perex@perex.cz>,
        "elfring@users.sourceforge.net" <elfring@users.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        CPGS <cpgs@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <s5hd0vkbm7r.wl-tiwai@suse.de>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180719051631epcms5p8224b903510a4fe2414c30f3b6b02d7de@epcms5p8>
Date:   Thu, 19 Jul 2018 10:46:31 +0530
X-CMS-MailID: 20180719051631epcms5p8224b903510a4fe2414c30f3b6b02d7de
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmuu56uYBogze/rCyuXDzEZHFj5z9W
        i5eHNC3Ody5ntjjTnWtxedccNovOXf1A4c1vmCzO/z3O6sDpseFzE5vH7IaLLB7PXk5m8tj3
        dhmbR9+WVYwem09XezSdamf1+LxJzmPTk7dMAZxRqTYZqYkpqUUKqXnJ+SmZeem2St7B8c7x
        pmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QBcqKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yV
        og0NjfQMDcz1jIyAtGmslZEpUElCasaXnsPsBQ1sFS132lkaGN+wdjFyckgImEjcv3mbvYuR
        i0NIYDejxLXtr4ASHBy8AoISf3cIg5jCArYSp3eFgJhCAgoSt1ZFg3QKC1hITJrRyQxiswmY
        SfR838MEYosAlbx5dY8RZCKzwDpmif+bXjJDrOKVmNH+lAXClpbYvnwrI4jNKaAt8bNpHdQ5
        ohI3V79lh7HfH5vPCGGLSLTeOws1R1Diwc/djDBz3h+bwgSyTEJgMqPE1587WSCc1YwS+w+9
        gNpmLvH45maw83gFfCWuHF8Ato1FQFVi+a8pbBA1LhIHZqwG28wMdNGyha+ZQT5mFtCUWL9L
        H+aBho2/oUr4JHp/P2GCie+YB2JzANkqEg/2l0GYUhK9n+wgKjwkbq7YyAYJ5deMEs1LrrFM
        YFSYhQjoWUj2zkLYu4CReRWjZGpBcW56arFpgWFearlecWJucWleul5yfu4mRnBC1fLcwTjr
        nM8hRgEORiUe3gP/faOFWBPLiitzDzFKcDArifDuPekfLcSbklhZlVqUH19UmpNafIjRFBgC
        E5mlRJPzgck+ryTe0NTIzMzA0sDU2MLMUEmc9xyvR7SQQHpiSWp2ampBahFMHxMHp1QD47K4
        zbleUzgyZhx333U4QuqGT8tJB+0VhwseK839cUyve8eWdv3pfwuTBYty5fovKfpuldpxZutn
        xy39+/hj5K8p9t4+eWCl/HJlVfeb8Wfr59xiev9V1+PLTCXTEM6p7ypMtlWUnjOY8vX9xCX/
        G51NG9b8+7Qh9/AG3iUSHh/0m/Z5yPGGPFJiKc5INNRiLipOBADw9uz1vgMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180718150653epcas2p3c2f0e36569529df72ce0b79a22867eac
References: <s5hd0vkbm7r.wl-tiwai@suse.de>
        <1531908468-1352-1-git-send-email-srikanth.h@samsung.com>
        <1531926420-25488-1-git-send-email-srikanth.h@samsung.com>
        <CGME20180718150653epcas2p3c2f0e36569529df72ce0b79a22867eac@epcms5p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C2=A0=0D=0A>=20The=C2=A0checks=C2=A0in=C2=A0proc=C2=A0are=C2=A0moot=C2=A0i=
f=C2=A0we=C2=A0guarantee=C2=A0the=C2=A0non-NULL=C2=A0card=C2=A0at=0D=0A>=20=
snd_timer_new()=C2=A0in=C2=A0the=C2=A0above.=0D=0A=C2=A0=0D=0A>=20So=C2=A0i=
t's=C2=A0not=C2=A0about=C2=A0fixing=C2=A0in=C2=A0sound=C2=A0module.=C2=A0=
=C2=A0It=C2=A0serves=C2=A0right.=C2=A0=C2=A0Your=0D=0A>=20patch=C2=A0would=
=C2=A0add=C2=A0a=C2=A0sanity=C2=A0check=C2=A0to=C2=A0catch=C2=A0a=C2=A0bugg=
y=C2=A0code=C2=A0in=C2=A0the=C2=A0caller=0D=0A>=20side.=0D=0A=C2=A0=0D=0AYo=
u=20are=20right=20Takashi,=20as=20you=20said=20this=20changes=20will=20catc=
h=20buggy=20code=20in=20caller=20side.=0D=0A=0D=0AThank=20you=20for=20your=
=20respose.=0D=0A=0D=0AThanks,=0D=0ASrikanth=0D=0A=C2=A0=0D=0A=C2=A0
