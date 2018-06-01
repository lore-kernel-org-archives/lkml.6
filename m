Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899834-1527843381-2-5373177426813278690
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527843381; b=ZHlU+Qnp9CIO+RIwCZxZT2MRuC3ORFoogkoW2uZU2aRvK+3LVM
    Mq/9cU46hUrOZEGxnMA6DRjiKBVpMkIho+PUt064LpvuiKzCv3mam0G6X814KBfM
    5RTlbmk5TIixQ3vyNzBzJV4xqeBR9CAf+2oZ/iVMTsveSiBgVBgdpWp2DDG/PrHg
    BUesuwRRjXAw7EmGf5lijQtqVB3Y+KvMpcERch126JBNeQ6cb/PCCXV/33wGTNES
    6EXaXoC2+G6qgNTylG65F9J0XWdoI4Ze/FzbIW/QrHDB3Py5H9JGXR0AiLyvAohu
    rmLNI5HeHBzOVZbwckIkEDgz1/FXRiFE101w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:subject:reply-to:from:to:cc
    :in-reply-to:message-id:date:content-transfer-encoding
    :content-type:references:sender:list-id; s=fm2; t=1527843381;
    bh=5WhmWId2A2sx9hozK9J03uTs2HAcqWKVg3IgHSqu4kE=; b=nkxIHi+N+k1d
    HDes731bTZ3KhXNVFj2pknAb/bnJBYa68CoLb7B1OfMzsJWIi4etJ9WaniuUFjPI
    a6UT2mseTquszH/9qUuE1EyLvv7q8Gg58yNuto9OVwj/ZxHFOZ5u1DZycjwn6KC5
    SPiKZhqsbUcvnrs29joCJtW+Me8VP5kg72rIx8wEYLhOmUDpcf92Xm8hQImY/YwA
    oeX7MtqWgQZ6zqXPQlPAQefgXFct4ptOvwH/rXmm7s13CdqewKavfUxKUL7TGuB5
    y397Vk0n1f6jGFD6FYmt1pBmF1ZH0Xkop61J4Tj2l29cslH6wqrOAJKP/kNPfcG6
    qTlR9Cus5Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=samsung.com header.i=@samsung.com header.b=OaSZuT0H
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
      header.d=samsung.com header.i=@samsung.com header.b=OaSZuT0H
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
X-CM-Envelope: MS4wfMY2uPncyztdUEAzzJxs4v5v0hwgV8mzybHbrjKhbe/95zcKQ6/eJ0ckg9H5U3Ro8JpN4/7ybG+0bAtj5zeyV+fBdS1+DKbao4n4vA1oqsYyOTQXwic5
    YxoOAwANruaZKSp5W9Xv7WHVA69d4gKhQyjObyuwVWJWLNYiZAtl1ZKgu5tK3zHzoQb0Je2jPaX2YWxXooMsM2vQ0AJyzdUhULPD+6/i9xHmXmda4MoHF6yg
    CMbljaWFMrOuMiQJLFSAzg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=SE7QUZ7f_n-xmhOgujQA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750766AbeFAI4R (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 04:56:17 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:50899 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeFAI4P (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Jun 2018 04:56:15 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180601085613epoutp03e3b07ac8a93e2f8204da56915d3b4d1e~z-XQBOc9E2950829508epoutp03u
X-AuditID: b6c32a4a-abdff70000001139-5e-5b110a2a45b0
Mime-Version: 1.0
Subject: RE: Re: [PATCH 1/1] Fix memory leak in kernfs_security_xattr_set
 and kernfs_security_xattr_set
Reply-To: chandan.vn@samsung.com
From: CHANDAN VN <chandan.vn@samsung.com>
To: Tejun Heo <tj@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        CPGS <cpgs@samsung.com>,
        Sireesha Talluri <sireesha.t@samsung.com>,
        Chris Wright <chrisw@sous-sol.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1ced6bce-92cc-7e0c-fab4-0aaa3d03b82f@schaufler-ca.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180601085609epcms5p5fefac0156a4816e9e48751211ab595ee@epcms5p5>
Date: Fri, 01 Jun 2018 14:26:09 +0530
X-CMS-MailID: 20180601085609epcms5p5fefac0156a4816e9e48751211ab595ee
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1BMYRjHvXu2s6dYTmsbbzFm57iWKXuWrVMjaTTaITPN+ILFOlOv3R27
        Z3f2bCk+CBMjioaMyV0XpEQlq0VaFiNREtMYjdwvmVIh13H2Nnx6f+9//s91HgKTVeMRhJGz
        IxvHmig8RNx4I3JmdFRIqFZZ9m06827/Sqan8QfOFD4tx5j3rkhmW1ktznyvrJIwnU2Hcab9
        emsQM7D7Bc40tVuZH6fcYMFozfmSrbimrmonrmk+Ui3RFDVUAY27+SSuabxSgGmG6ianS1ai
        eQbEZiKbAnEZlkwjp0+klizTLdSpY5V0NB3PxFEKjjWjRColLT16kdEkdEgpsllTliClszxP
        zZ4/z2bJsiOFwcLbEyktTatiaGVcjEolvOrVCSq1YFmLDNsf3sGshybl3N9eJMkDzokFIJiA
        5Fw4uOWypACEEDLSCeAr56DwIQgpGQp/O8Z7PONJI+zN7wrysIxUwJt9NWKfPgsW3OjzMk5G
        wjtHD0g8LCdT4Zu9LUGenBj5GIO1e3YDXzEpPLjjtdjHE+GlUxe9ejCZAkcG6/16GOw++0kS
        4P5bx/yxcpjf04b5OBQ+/+4EgTynaxr8sRZY11nv7R+SObDnarhPjoMvu+tFHpaSS2GH6xDu
        YTE5Dd7rbBb5PCnwylCXV8eEuSpPfMQ8aTBhrtqm2YHu8y78lPgsY2Hhz1eigO44GuCp8M/H
        Cj9HwI5HX/2sgR/yT2K+NQ+LoNvhxPcCRem/TZf+V7n0X+XjAKsC4cjKm/WIV1tVHNoQw7Nm
        PovTx2RYzHXAe6lRix2g8n6aC5AEoMZIZw6P08qC2Gw+1+wCkMAouXR/tiBJM9ncjchm0dmy
        TIh3AbWwg2IsIizDItw9Z9fRalVsrDJeqZ7DxNLUBOnIE1IrI/WsHa1HyIpsgTgRERyRB1Ir
        dDNaNonEFdWO9lZ7YUtc2sX25u4zvW0LZw0/TihJIbQ47GXPFauKW9dIbzd+wZu48FUD7Oqv
        dz8nvzY3JD+Qt3b1vzThW0qXJoUtBzVOp2H+4LPkfSG518KX7Co/Vstyv84afyUh1/GRzW3u
        KaPcqfKohLc5JWJ6RUd+/DpKzBtYOgqz8exfuWWWXb8DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b
References: <1ced6bce-92cc-7e0c-fab4-0aaa3d03b82f@schaufler-ca.com>
        <1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
        <20180531153943.GR1351649@devbig577.frc2.facebook.com>
        <4f00f9ae-3302-83b9-c083-d21ade380eb2@schaufler-ca.com>
        <20180531161107.GV1351649@devbig577.frc2.facebook.com>
        <CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcms5p5>
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi
=C2=A0=0D=0A=0D=0A>On=C2=A05/31/2018=C2=A09:11=C2=A0AM,=C2=A0Tejun=C2=A0Heo=
=C2=A0wrote:=0D=0A>=C2=A0On=C2=A0Thu,=C2=A0May=C2=A031,=C2=A02018=C2=A0at=
=C2=A009:04:25AM=C2=A0-0700,=C2=A0Casey=C2=A0Schaufler=C2=A0wrote:=0D=0A>>>=
=C2=A0On=C2=A05/31/2018=C2=A08:39=C2=A0AM,=C2=A0Tejun=C2=A0Heo=C2=A0wrote:=
=0D=0A>>>>=C2=A0(cc'ing=C2=A0more=C2=A0security=C2=A0folks=C2=A0and=C2=A0co=
pying=C2=A0whole=C2=A0body)=0D=0A>>>>=0D=0A>>>>=C2=A0So,=C2=A0I'm=C2=A0sure=
=C2=A0the=C2=A0patch=C2=A0fixes=C2=A0the=C2=A0memory=C2=A0leak=C2=A0but=C2=
=A0API=C2=A0wise=C2=A0it=C2=A0looks=0D=0A>>>>=C2=A0super=C2=A0confusing.=C2=
=A0=C2=A0Can=C2=A0security=C2=A0folks=C2=A0chime=C2=A0in=C2=A0here?=C2=A0=
=C2=A0Is=C2=A0this=C2=A0the=C2=A0right=0D=0A>>>>=C2=A0fix?=0D=0A>>>>=C2=A0s=
ecurity_inode_getsecctx()=C2=A0provides=C2=A0a=C2=A0security=C2=A0context.=
=C2=A0Technically,=0D=0A>>>>=C2=A0this=C2=A0is=C2=A0a=C2=A0data=C2=A0blob,=
=C2=A0although=C2=A0both=C2=A0provider=C2=A0provide=C2=A0a=C2=A0null=C2=A0t=
erminated=0D=0A>>>>=C2=A0string.=C2=A0security_inode_getsecurity(),=C2=A0on=
=C2=A0the=C2=A0other=C2=A0hand,=C2=A0provides=C2=A0a=0D=0A>>>>=C2=A0string=
=C2=A0to=C2=A0match=C2=A0an=C2=A0attribute=C2=A0name.=C2=A0The=C2=A0former=
=C2=A0releases=C2=A0the=C2=A0security=0D=0A>>>>=C2=A0context=C2=A0with=C2=
=A0security_release_secctx(),=C2=A0where=C2=A0the=C2=A0later=C2=A0releases=
=C2=A0the=0D=0A>>>>=C2=A0string=C2=A0with=C2=A0kfree().=0D=0A>>>>=0D=0A>>>>=
=C2=A0When=C2=A0the=C2=A0Smack=C2=A0hook=C2=A0smack_inode_getsecctx()=C2=A0=
was=C2=A0added=C2=A0in=C2=A02009=0D=0A>>>>=C2=A0for=C2=A0use=C2=A0by=C2=A0l=
abeled=C2=A0NFS=C2=A0the=C2=A0alloc=C2=A0value=C2=A0passed=C2=A0to=0D=0A>>>=
=C2=A0smack_inode_getsecurity()=C2=A0was=C2=A0set=C2=A0incorrectly.=C2=A0Th=
is=C2=A0wasn't=C2=A0a=0D=0A>>>=C2=A0major=C2=A0issue,=C2=A0since=C2=A0label=
ed=C2=A0NFS=C2=A0is=C2=A0a=C2=A0fringe=C2=A0case.=C2=A0When=C2=A0kernfs=0D=
=0A>>>=C2=A0started=C2=A0using=C2=A0the=C2=A0hook,=C2=A0it=C2=A0became=C2=
=A0the=C2=A0issue=C2=A0you=C2=A0discovered.=0D=0A>>>=0D=0A>>>=C2=A0The=C2=
=A0reason=C2=A0that=C2=A0we=C2=A0have=C2=A0all=C2=A0this=C2=A0confusion=C2=
=A0is=C2=A0that=C2=A0SELinux=0D=0A>>>=C2=A0generates=C2=A0security=C2=A0con=
texts=C2=A0as=C2=A0needed,=C2=A0while=C2=A0Smack=C2=A0keeps=C2=A0them=0D=0A=
>>>=C2=A0around=C2=A0all=C2=A0the=C2=A0time.=C2=A0Releasing=C2=A0an=C2=A0SE=
Linux=C2=A0context=C2=A0frees=C2=A0memory,=0D=0A>>>=C2=A0while=C2=A0releasi=
ng=C2=A0a=C2=A0Smack=C2=A0context=C2=A0is=C2=A0a=C2=A0null=C2=A0operation.=
=0D=0A>>=C2=A0Any=C2=A0chance=C2=A0this=C2=A0detail=C2=A0can=C2=A0be=C2=A0h=
idden=C2=A0behind=C2=A0security=C2=A0api?=C2=A0=C2=A0This=C2=A0looks=0D=0A>=
>=C2=A0pretty=C2=A0error-prone,=C2=A0no?=0D=0A=C2=A0=0D=0A>>It=C2=A0*is*=C2=
=A0hidden=C2=A0behind=C2=A0the=C2=A0security=C2=A0API.=C2=A0The=C2=A0proble=
m=C2=A0is=C2=A0strictly=0D=0A>>within=C2=A0the=C2=A0Smack=C2=A0code,=C2=A0w=
here=C2=A0the=C2=A0implementer=C2=A0of=C2=A0smack_inode_getsecctx()=0D=0A>>=
made=C2=A0an=C2=A0error.=0D=0A=0D=0AI=20agree=20that=20the=20fix=20can=20be=
=20done=20simply=20by=20using=20=22false=22=20for=20=0D=0Asmack_inode_getse=
curity(),=20but=20what=20happens=20with=20kernfs_node_setsecdata()=0D=0Aand=
=20smack_inode_notifysecctx().=20kernfs_node_setsecdata()=20is=20probably=
=20ignorable=0D=0Abut=20smack_inode_notifysecctx()=20is=20sending=20the=20=
=22ctx=22=20to=20smack_inode_setsecurity()=0D=0Aand=20since=20=22ctx=22=20w=
ould=20be=20NULL=20because=20we=20used=20=22false=22,=20smack_inode_setsecu=
rity()=0D=0Abecomes=20dummy.=0D=0A=0D=0A
