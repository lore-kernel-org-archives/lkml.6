Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2332931-1528182298-2-1499560461816986798
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528182298; b=Bxw7YAYDgCqyAtiOI+67BX++35sguTlxNwMB/m9tUETI3cJfTT
    /h1UwLgIR0dTZuRehUNFifMtfiUccW7xRgnoH+e+6gMl53DlAj29QlVIIojEIIf1
    Eoqd49oJhVjqBvICzt0qcl2k9xDJ6p9g3htWzZsf9pG7vVVMhXRBTHT6UM9IJ4dH
    DoiLjm925RkB5AkcVbmAqXpgMxf2BdKbly35L14DWrHOmiQNFOql6+q3hQIS1snq
    ta076UcqkAPBlDSA1vQhi71jBSAbHUkXRIJrskkSUNE7W1tvDwI8JVNjBcZOA2ZD
    El8UobKx1MXH0lKgr8es3JXo82hrerkQXarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:subject:reply-to:from:to:cc
    :in-reply-to:message-id:date:content-transfer-encoding
    :content-type:references:sender:list-id; s=fm2; t=1528182298;
    bh=J091ln+mzv7tc741sIGfpXNi0FdPI2Gk7EJO67xVmWg=; b=EHKkxJERFNei
    0Qu4GN8hVsJCLiN3esND6z5ivLcNXpmfAtzb/4HP8Tyhi3ttZJLLFo7kak8jJuqZ
    O+lfd1yx69RgNfvoTJAdNWFkAiH/H9WZdf5sZCcqYAGQ5OK1TtgMh2cqIw0D9HjI
    UpjBuOPeShnIYVfcQLhjLWDwX+dA+hcsoLv4tjeO5r0/YuUWwT6IzqthNNyHejPs
    vIzHuIH5G/XDuUZ4+1P/+H/XPlJ4y+FGZxyr0E9X2xtncYFb2qczcgKb8GpR6XnS
    K/bOoz5a1J5LoTXmdiyDL3as497gxjagWEpAaIQOfRhMev3gkfJ6gbmbCXtc6HUU
    R11SHkmWSw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=samsung.com header.i=@samsung.com header.b=Xk3AH8tL
    header.a=rsa-sha256 header.s=mail20170921 x-bits=1024;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=samsung.com header.i=@samsung.com header.b=Xk3AH8tL
      header.a=rsa-sha256 header.s=mail20170921 x-bits=1024;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFsChHAtLfmcJVZTItHjOmY7QUdQAqfm1El7MB4QoeyC9OZAXKvBcwMOsc1+6JDroMr032/BBMufiblZ4RZ/15cyD+/1gVFLah7+IDlDtDkbfJpJqae8
    DoTQTzrmYSSb3H2QN623YPntd5tKn6CiyC+FxBskfmiVZ+cYa79Oz0Z1AEAg6N0QF3opDfw31/xZtr8dwBV/tygKpdeTEf4OdUUU06hLaOLBDyBXubJzjOF0
    F/gfxqUpVJEFGliRkC8bHQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=vpqfxihKAAAA:8 a=VwQbUJbxAAAA:8 a=dsMhmKz7u3Ig0-sdsnYA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AULIiLoY-XQsE5F6gcqX:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbeFEHEz (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 03:04:55 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:16536 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeFEHEx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Jun 2018 03:04:53 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180605070452epoutp015da372d3a52ba4a3ab35f59c15af8495~1MbKt--Yn2437224372epoutp01Q
X-AuditID: b6c32a4a-abdff70000001139-35-5b16361159f8
Mime-Version: 1.0
Subject: RE: Re: [PATCH] Smack: Fix memory leak in smack_inode_getsecctx
Reply-To: chandan.vn@samsung.com
From: CHANDAN VN <chandan.vn@samsung.com>
To: Tejun Heo <tj@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
CC: "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        CPGS <cpgs@samsung.com>,
        Sireesha Talluri <sireesha.t@samsung.com>,
        Chris Wright <chrisw@sous-sol.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180604212704.GC1351649@devbig577.frc2.facebook.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180605070449epcms5p317013469ed52cc50878011c428bd12aa@epcms5p3>
Date: Tue, 05 Jun 2018 12:34:49 +0530
X-CMS-MailID: 20180605070449epcms5p317013469ed52cc50878011c428bd12aa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmlq6gmVi0weM/mhYvpkRZ3Nv2i82i
        9/YSZouXhzQtmhevZ7P4uWwVu8XlXXPYLC4cOM1q8aHnEZvFrgsFFr+WH2V04PbYMLWJzWPT
        qk42j/1z17B79G1ZxehxdP8iNo9te7qYPT5vkgtgj0q1yUhNTEktUkjNS85PycxLt1XyDo53
        jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6UEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xi
        qxRtaGikZ2hgrmdkBKRNY62MTIFKElIzlve3MhZc5K44+rWLuYFxJXcXIweHhICJxO+51l2M
        XBxCArsZJZaeOsQCEucVEJT4u0O4i5GTQ1jAQ2LR/7/MILaQgILEkTdrWSDi2hJdh9+A2WwC
        mhIn5k1jB7FFBNwlnk04yApiMwtcYZboeRIHYksI8ErMaH/KAmFLS2xfvpURxOYUcJZYdeA3
        M0RcVOLm6rfsMPb7Y/MZIWwRidZ7Z6FqBCUe/NzNCDNnxdotUDPzJTZd3swO8VaFxL29khBh
        c4nHNzczgdi8Ar4SP67/AytnEVCVaDn5DGqVi8Sd+zPYIE7Wlli28DUzyBhmoLfW79KHub5h
        4292iBI+id7fT5hg4jvmwdgqEv9eL4WypSQuXvkGZXtIvGpdxAwJ5ZWsErff3GGbwKgwCxHQ
        s5BsnoWweQEj8ypGydSC4tz01GLTAqO81HK94sTc4tK8dL3k/NxNjOB0quW1g3HZOZ9DjAIc
        jEo8vBpWotFCrIllxZW5hxglOJiVRHhPFwCFeFMSK6tSi/Lji0pzUosPMZoCw2Ais5Rocj4w
        1eeVxBuaGpmZGVgamBpbmBkqifP+uC4QLSSQnliSmp2aWpBaBNPHxMEp1cB4yrXOaDaron1K
        3rNzN1k4s5/WxBWpuN24XN6n2//79pK2n8L57Fs+abrxbAlV/ac5tcrYNcxpPtPUebveemh4
        flOw9X++bZah0opHvBmOzzXunDJQ/LXoaGN4G1vljY53F5dKhb3gunW4hU1W6bj1mVVp7qFc
        eTzHEjs2bRHdfuOH5X8/l1AlluKMREMt5qLiRABb+gk1vQMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b
References: <20180604212704.GC1351649@devbig577.frc2.facebook.com>
        <1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
        <20180531153943.GR1351649@devbig577.frc2.facebook.com>
        <4f00f9ae-3302-83b9-c083-d21ade380eb2@schaufler-ca.com>
        <20180531161107.GV1351649@devbig577.frc2.facebook.com>
        <20180601085609epcms5p5fefac0156a4816e9e48751211ab595ee@epcms5p5>
        <20180601162913epcms5p7737f5b4376d8865af1eae119aa866550@epcms5p7>
        <5b0b157a-0e8c-d8f5-901e-836d545a8e4c@schaufler-ca.com>
        <fa278910-5c99-11dc-c9cb-b88a97592e53@schaufler-ca.com>
        <b6cc4bd5-8d79-bbc2-373f-ea0bf0806884@schaufler-ca.com>
        <CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcms5p3>
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

=C2=A0=0D=0A=0D=0A>On=C2=A0Mon,=C2=A0Jun=C2=A004,=C2=A02018=C2=A0at=C2=A002=
:01:34PM=C2=A0-0700,=C2=A0Casey=C2=A0Schaufler=C2=A0wrote:=0D=0A>>=C2=A0On=
=C2=A06/1/2018=C2=A010:45=C2=A0AM,=C2=A0Casey=C2=A0Schaufler=C2=A0wrote:=0D=
=0A>>=C2=A0>=C2=A0Fix=C2=A0memory=C2=A0leak=C2=A0in=C2=A0smack_inode_getsec=
ctx=0D=0A>>=C2=A0>=0D=0A>>=C2=A0>=C2=A0The=C2=A0implementation=C2=A0of=C2=
=A0smack_inode_getsecctx()=C2=A0made=0D=0A>>=C2=A0>=C2=A0incorrect=C2=A0ass=
umptions=C2=A0about=C2=A0how=C2=A0Smack=C2=A0presents=C2=A0a=C2=A0security=
=0D=0A>>=C2=A0>=C2=A0context.=C2=A0Smack=C2=A0does=C2=A0not=C2=A0need=C2=A0=
to=C2=A0allocate=C2=A0memory=C2=A0to=C2=A0support=0D=0A>>=C2=A0>=C2=A0secur=
ity=C2=A0contexts,=C2=A0so=C2=A0=22releasing=22=C2=A0a=C2=A0Smack=C2=A0cont=
ext=C2=A0is=C2=A0a=C2=A0no-op.=0D=0A>>=C2=A0>=C2=A0The=C2=A0code=C2=A0made=
=C2=A0an=C2=A0unnecessary=C2=A0copy=C2=A0and=C2=A0returned=C2=A0that=C2=A0a=
s=C2=A0a=0D=0A>>=C2=A0>=C2=A0context,=C2=A0which=C2=A0was=C2=A0never=C2=A0f=
reed.=C2=A0The=C2=A0revised=C2=A0implementation=0D=0A>>=C2=A0>=C2=A0returns=
=C2=A0the=C2=A0context=C2=A0correctly.=0D=0A>>=C2=A0>=0D=0A>>=C2=A0>=C2=A0S=
igned-off-by:=C2=A0Casey=C2=A0Schaufler=C2=A0<casey=40schaufler-ca.com>=0D=
=0A>>=C2=A0=0D=0A>>=C2=A0Tejun,=C2=A0does=C2=A0this=C2=A0pass=C2=A0your=C2=
=A0tests?=0D=0A=C2=A0=0D=0A>Oh,=C2=A0I'm=C2=A0not=C2=A0the=C2=A0one=C2=A0wh=
o=C2=A0reported.=C2=A0=C2=A0Chandan?=0D=0ALooks=20good=20to=20me.=20Leak=20=
not=20found.
