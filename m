Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F3EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B09F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qCXf2A0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B09F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbeGRLfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:35:46 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:49262 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbeGRLfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:35:46 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180718105823epoutp0189ef2fa9635f6fd01a8a90b15f1676c1~CcWVjVb8s0559705597epoutp01n
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 10:58:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180718105823epoutp0189ef2fa9635f6fd01a8a90b15f1676c1~CcWVjVb8s0559705597epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531911503;
        bh=P0riJyq8+InZtyM/n9tMKUyI4cuoACFPQJbFNHqBg7g=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=qCXf2A0psSnTXklkl5OfLdKHkU8z/zMzytluGAllshq4exPB5hEvkYHbMZFbMIf95
         Q0A0rVZE9Ujk0sLUrX5m22KdXraPbgvUNwj/2xGankFJSALZtl2/u/fmi1vUgR/cAL
         aTTZxfku7TTfHtiWOp+pxopJTRyanCGjzyVxe3AU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.194]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20180718105821epcas5p36527f3577fd68442e753d58d1d9918e4~CcWTg2w380092300923epcas5p3m;
        Wed, 18 Jul 2018 10:58:21 +0000 (GMT)
X-AuditID: b6c32a49-aefff70000001142-be-5b4f1d4d9044
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.23.04418.D4D1F4B5; Wed, 18 Jul 2018 19:58:21 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH 1/1] Preventive fix in sound module
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
In-Reply-To: <s5hfu0gzw5e.wl-tiwai@suse.de>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180718105820epcms5p173879897edd4cc93b381f8125c11b91b@epcms5p1>
Date:   Wed, 18 Jul 2018 16:28:20 +0530
X-CMS-MailID: 20180718105820epcms5p173879897edd4cc93b381f8125c11b91b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmuq6vrH+0wZl3ghZXLh5isrix8x+r
        xctDmhbnO5czW5zpzrW4vGsOm0Xnrn6g8OY3TBbn/x5ndeD02PC5ic1jdsNFFo9nLyczeex7
        u4zNo2/LKkaPzaerPZpOtbN6fN4k57HpyVumAM6oVJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4
        UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoAuVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZK
        0YaGRnqGBuZ6RkZA2jTWysgUqCQhNaPn/COWgvNSFU0Hr7I3MH6V7GLk5JAQMJF4e24KUxcj
        F4eQwG5GiS8/7rN2MXJw8AoISvzdIQxSIyxgLfFv2gWwsJCAgsStVdEQYQuJSTM6mUFsNgEz
        iZ7ve5hAbBGgkjev7jGCjGQWWMcs8X/TS2aIXbwSM9qfskDY0hLbl29lBLE5BbQlTq+bzgQR
        F5W4ufotO4z9/th8RghbRKL13lmoOYISD37uZoSZ8/4YxP0SApMZJb7+3MkC4axmlNh/6AXU
        NnOJxzc3g23gFfCVODfxDQvINywCqhLb+4UhSlwk5v+/yAZiMwMdtGzha2aQEmYBTYn1u/Rh
        7m/Y+JsdooRPovf3EyaY+I55IDYHkK0i8WB/GYQpJdH7yQ6iwkNi5fZ+dkgor2OUWLVmMdME
        RoVZiICehWTvLIS9CxiZVzFKphYU56anFpsWGOallusVJ+YWl+al6yXn525iBCdULc8djLPO
        +RxiFOBgVOLhPfDfN1qINbGsuDL3EKMEB7OSCO/B937RQrwpiZVVqUX58UWlOanFhxhNgQEw
        kVlKNDkfmOzzSuINTY3MzAwsDUyNLcwMlcR5z/F6RAsJpCeWpGanphakFsH0MXFwSjUwbuDR
        M5ncov3/Q14Vy3xljl0GzGczN20o5/c63sM1bc9Ov6rumFxpFq9G3puPWlZNeSbNnGv00U7U
        7hPTwiUcnxvlzrD93np+5rKGB/K2sabHZrsdu5/9X0VR+eyn0BwWm5yQU32L39S56ul8+HVg
        OtP+eZ0iEo1P1FrKTCZ2Ri031gjavT5QiaU4I9FQi7moOBEA7P16Tb4DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180718100741epcas1p393bea852d102e903ab6a48ff952761db
References: <s5hfu0gzw5e.wl-tiwai@suse.de>
        <1531908468-1352-1-git-send-email-srikanth.h@samsung.com>
        <CGME20180718100741epcas1p393bea852d102e903ab6a48ff952761db@epcms5p1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>=C2=A0=0D=0A>>=C2=A0Signed-off-by:=C2=A0Srikanth=C2=A0K=C2=A0H=C2=A0<srik=
anth.h=40samsung.com>=0D=0A=C2=A0=0D=0A>What=C2=A0does=C2=A0this=C2=A0fix,=
=C2=A0and=C2=A0above=C2=A0all,=C2=A0why=C2=A0is=C2=A0this=C2=A0needed?=0D=
=0A=0D=0AHi,=0D=0A=0D=0AWhen=20the=20sound=20driver=20creates=20the=20timer=
=20without=20sound=20card=20object,=20then=20while=20reading=20the=20sound=
=20info=20entry=20the=20timer=20object=E2=80=99s=20card=20information=20is=
=20dereferenced=20without=20checking=20for=20NULL=20pointer=20which=20will=
=20result=20for=20kernel=20panic.=20I=20tried=20to=20simulate=20this=20scen=
ario=20and=20got=20below=20call=20stack,=0D=0A=5B=20=20=2036.668=5D=20E/DEV=
KMSG=20(P=20=20=20=200,=20T=20=20=20=200):=20Unable=20to=20handle=20kernel=
=20NULL=20pointer=20dereference=20at=20virtual=20address=2000000000=0D=0A=
=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=200):=20p=
gd=20=3D=20e52f0000=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=20=
0,=20T=20=20=20=200):=20=5B00000000=5D=20*pgd=3D00000000=0D=0A=5B=20=20=203=
6.668=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=200):=20Internal=20err=
or:=20Oops:=205=20=5B=231=5D=20PREEMPT=20SMP=20ARM=0D=0A=5B=20=20=2036.668=
=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=200):=20Modules=20linked=20=
in:=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=
=200):=20CPU:=201=20PID:=201258=20Comm:=20cat=20Tainted:=20G=20=20=20=20=20=
=20=20=20W=20=20=20=203.10.65-00121-g83e9b9b-dirty=20=2354-Tizen=0D=0A=5B=
=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=200):=20task=
:=20e653aec0=20ti:=20e52ec000=20task.ti:=20e52ec000=0D=0A=5B=20=20=2036.668=
=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=200):=20PC=20is=20at=20snd_=
timer_proc_read+0x104/0x278=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=
=20=20=200,=20T=20=20=20=200):=20LR=20is=20at=20snd_timer_proc_read+0xec/0x=
278=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=
=200):=20pc=20:=20=5B<c0527cfc>=5D=20=20=20=20lr=20:=20=5B<c0527ce4>=5D=20=
=20=20=20psr:=2060040013=5Cx0asp=20:=20e52eded0=20=20ip=20:=2000000000=20=
=20fp=20:=2010624dd3=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=
=200,=20T=20=20=20=200):=20r10:=20c08ded6c=20=20r9=20:=20e49e3bd8=20=20r8=
=20:=20c074f518=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=200,=
=20T=20=20=20=200):=20r7=20:=20c0afbae4=20=20r6=20:=20eb95a000=20=20r5=20:=
=20e49e3240=20=20r4=20:=20eb257e00=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=
=20(P=20=20=20=200,=20T=20=20=20=200):=20r3=20:=2000000000=20=20r2=20:=2000=
000000=20=20r1=20:=20c0987cd7=20=20r0=20:=20e49e3240=0D=0A=5B=20=20=2036.66=
8=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=200):=20Flags:=20nZCv=20=
=20IRQs=20on=20=20FIQs=20on=20=20Mode=20SVC_32=20=20ISA=20ARM=20=20Segment=
=20user=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=
=20=200):=20Control:=2010c53c7d=20=20Table:=20a52f006a=20=20DAC:=2000000015=
=0D=0A=0D=0AHence=20this=20is=20a=20preventive=20patch=20to=20avoid=20kerne=
l=20panic=20in=20case=20if=20the=20card=20object=20passed=20to=20timer=20fu=
nction=20is=20NULL.=20This=20would=20not=20happen=20in=20normal=20case,=20b=
ut=20in=20case=20of=20buggy=20scenario=20this=20would=20results=20in=20kern=
el=20panic=20rather=20than=20graceful=20exit.=0D=0A=0D=0Athanks,=0D=0Asrika=
nth
