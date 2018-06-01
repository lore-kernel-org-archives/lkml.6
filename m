Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3547974-1527870569-2-6091681403461258047
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527870569; b=j+/wZqeqYxDQXWki7rAM/VmZkeHJOFQWDlHsOtvPyfSXCLDNdx
    +jcPVH2Jpl7j8SY2jpSbgk7f+yOCy5jDslxC/orDIRRJDbAaCmPtNHUyikNIairo
    Cq8mCkkftjmQtOUkMqH6DWAHjYj06ocsq2UxU9XrKVVJZ/oIgcET/nwPRinDzDOj
    Gog1XNpJfXSMMM0XRtlH7oVs0+329QfxzMIpV+oYdn+s4hv17bAuAYHG5f3gMoGM
    Hz0zhs9aMRo/+hi7wa9J6QNwQ4Xmg03/TxgjjUDB1zHcW3alsCtYDbCQrn8RkZf8
    FiV/QOMdHP0dxzana00mqPeE7okTk/EEyRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:subject:reply-to:from:to:cc
    :in-reply-to:message-id:date:content-transfer-encoding
    :content-type:references:sender:list-id; s=fm2; t=1527870569;
    bh=1gT+17muFaIPex+T0kVLIlefNpGdrQhW4e5L8qJe8q0=; b=GQTIRqTWiCBS
    oFudokVWz/vilfITq1YoRCFhzolzAmVAVelwRmafktQuiV4xrOBhPRFA2P9Ny84/
    DsgSJHGnkVvjTKv+z4TGTMjAtNj3XlEqsOcMHsaI5WskgNGGcwzZ3GKhgj2JQrHp
    4SaD52V+t6PYNjC+c+7y0tbTGESP6/QqADNTXyDPqDROkcPhxYx+Kq0rBZkY+Gbv
    MxBLwHR51mRnQh8Vzan9wR/Iyn/Pj5C2Bi+ZBuwNi4JFZ7wAGoF8roqztn2Qhf6y
    kHtM086jjmqn7/wH4oHAg6CPk2GcxkcU1v3otFAvG0A4RadorGzOanJsEp1VkM7U
    IykHO9NZiA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=samsung.com header.i=@samsung.com header.b=nfWWPgUn
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=samsung.com header.i=@samsung.com header.b=nfWWPgUn
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
X-CM-Envelope: MS4wfDpIgddiudNcQ73dwXDTMOXap6a6qpBJPHuANBg/RqyfKzAN60pMwXkoaN+s2r9XRDhlRGY2qF5MDHZePMfHGDtw17pG4s0VJjTk1zP+riWKT7kvg05m
    qAi/yP0HlcZOgeBELN2ibPelWkhz/1wQdKNByDjTxlwnyCWKfGS26MzEWGbxnaEzgsFZ1z0Fz9S7XYi0CV/J/pKAKmjGENpyqmH9awwkowUGg0187qK68ykO
    N1R1SsktAGn3KBsBsWqmDg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=oRl9GL9GRJ49vruvJxwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeFAQ3Y (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 12:29:24 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:56979 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752904AbeFAQ3S (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Jun 2018 12:29:18 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180601162916epoutp03404a7014948ba88cd75bdbbf700ea770~0Fi0Kk73g0514005140epoutp03r
X-AuditID: b6c32a4b-9a1ff70000001138-45-5b117459edac
Mime-Version: 1.0
Subject: RE: Re: [PATCH 1/1] Fix memory leak in kernfs_security_xattr_set
 and kernfs_security_xattr_set
Reply-To: chandan.vn@samsung.com
From: CHANDAN VN <chandan.vn@samsung.com>
To: "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        CPGS <cpgs@samsung.com>,
        Sireesha Talluri <sireesha.t@samsung.com>,
        Chris Wright <chrisw@sous-sol.org>,
        Casey Schaufler <casey@schaufler-ca.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <02d9878e-65bf-5de8-9658-cf0f692f358c@schaufler-ca.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180601162913epcms5p7737f5b4376d8865af1eae119aa866550@epcms5p7>
Date: Fri, 01 Jun 2018 21:59:13 +0530
X-CMS-MailID: 20180601162913epcms5p7737f5b4376d8865af1eae119aa866550
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHOd7t7qqtrtPqtCjWpf7Q2NxdbV7LRaTEDQuMiCirdZmHbeUe
        7M5eBK3CHkMjoRejrExN1sNcZmqKYU+Kyp5LInvYw1LL7KVF0b1eR/11Pnz4nvN7cAhMFcLV
        hMPlQ14Xl0/hcbK6y8kp2qW+hFx9eZuW6dq7jOmo+4kzxU/LMeZ9azKz7Xg1zgxWhhTMg8ZD
        ONN26Zac6St6hTONbR7m54mrYHY8e3bfVpwNh3bhbMvhUwp2d20IsFdbynC2rimAsV/CE3MU
        y1CGHXF5yKtBLqs7z+GymansRZZMi9Gkp7V0OpNGaVycE5mprPk52rmOfKFDSrOWyy8QVA7H
        81TqrAyvu8CHNHY37zNTuTRt0NH6NJ3BIJzGFTMMRiGyCtl7i1/hntvx64Nba3A/qIgPgFgC
        ktPhk+YnMpFV5EUAv3+QBwBBKMkE+Ls+UdSJpAO+LHwklyIaeKXntEzyU2Hgcs8Q42QyvFG6
        XyFyErkYvg1dBwEQR2DkDQxWhTpwqZYSHtzxRibxeHjhxHkgciyZBU997sIkPxq2n+xVRPnT
        tSNA4iRY2HF7OJMAXwxeBNF3qk7XDr/phuEH5xRi/5BcDzuax0k6DXa2n4sRWUkugP2RyBDL
        yCnw7IGPcimeBf1bFooaE8aqPNaNiRoTxqpuTI0276/5pZAiI2Hxr9cxUV9fGuXJ8E93xTCr
        4b2H34eZhR8KyzBxIyqyH4M3G97he4Am+G/Rwf8qB/9VPgqwEBiHPLzThnijZ5oLrdPxnJMv
        cNl0VrczDIb+aUp2PQjfmd8KSAJQI5Q5mQm5Kjm3lt/gbAWQwKgk5ZJ5glLmcRs2Iq/b4i3I
        R3wrMAorKMHUo61u4de7fBbaaDCZ9Ol64zTGRFNjlQMRMldF2jgfWoOQB3mj92KIWLUfrNn+
        qNCeFQ7Nvd6WZ5hZhRT67dZuqyn7TFPn857lk9I3r2s39/6x9tnqOstrMyf0VW/zFv0w3VTP
        Wf0RspHgs7jUmjHNE5hRDf1HN90Pa/2DdPzA4wZg+TqHKl34rWin5/DdwYGV+2BGyW6+ZlRl
        xo6SgaZPXFfk3kyzbkxjsoOS8XaOTsG8PPcXGc6k270DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b
References: <02d9878e-65bf-5de8-9658-cf0f692f358c@schaufler-ca.com>
        <1ced6bce-92cc-7e0c-fab4-0aaa3d03b82f@schaufler-ca.com>
        <1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
        <20180531153943.GR1351649@devbig577.frc2.facebook.com>
        <4f00f9ae-3302-83b9-c083-d21ade380eb2@schaufler-ca.com>
        <20180531161107.GV1351649@devbig577.frc2.facebook.com>
        <20180601085609epcms5p5fefac0156a4816e9e48751211ab595ee@epcms5p5>
        <CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcms5p7>
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


>>=C2=A0I=C2=A0agree=C2=A0that=C2=A0the=C2=A0fix=C2=A0can=C2=A0be=C2=A0done=
=C2=A0simply=C2=A0by=C2=A0using=C2=A0=22false=22=C2=A0for=C2=A0=0D=0A>>=C2=
=A0smack_inode_getsecurity(),=C2=A0but=C2=A0what=C2=A0happens=C2=A0with=C2=
=A0kernfs_node_setsecdata()=0D=0A>>=C2=A0and=C2=A0smack_inode_notifysecctx(=
).=C2=A0kernfs_node_setsecdata()=C2=A0is=C2=A0probably=C2=A0ignorable=0D=0A=
>>=C2=A0but=C2=A0smack_inode_notifysecctx()=C2=A0is=C2=A0sending=C2=A0the=
=C2=A0=22ctx=22=C2=A0to=C2=A0smack_inode_setsecurity()=0D=0A>>=C2=A0and=C2=
=A0since=C2=A0=22ctx=22=C2=A0would=C2=A0be=C2=A0NULL=C2=A0because=C2=A0we=
=C2=A0used=C2=A0=22false=22,=C2=A0smack_inode_setsecurity()=0D=0A>>=C2=A0be=
comes=C2=A0dummy.=0D=0A=C2=A0=0D=0A>Thank=C2=A0you=C2=A0for=C2=A0pointing=
=C2=A0this=C2=A0out.=C2=A0You're=C2=A0right,=C2=A0there's=C2=A0more=0D=0A>a=
t=C2=A0issue=C2=A0here=C2=A0than=C2=A0changing=C2=A0the=C2=A0alloc=C2=A0fla=
g=C2=A0will=C2=A0fix.=C2=A0I=C2=A0think=0D=0A>that=C2=A0calling=C2=A0smack_=
inode_getsecurity()=C2=A0from=C2=A0smack_inode_getsecctx()=0D=0A>is=C2=A0ma=
king=C2=A0the=C2=A0code=C2=A0more=C2=A0complicated=C2=A0than=C2=A0it=C2=A0n=
eeds=C2=A0to=C2=A0be.=C2=A0I=C2=A0will=0D=0A>have=C2=A0a=C2=A0patch=C2=A0sh=
ortly.=0D=0A=0D=0AIf=20you=20think=20the=20patch=20would=20take=20time=20or=
=20is=20complicated,=20I=20suggest=20that=20the=20kfree()=20fix=20should=20=
go=0D=0Ato=20fix=20the=20leaks=20for=20now.=C2=A0=0D=0A=C2=A0=0D=0A=C2=A0=
=0D=0A=C2=A0
