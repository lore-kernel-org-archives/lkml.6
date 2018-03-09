Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1185227-1520621354-2-17958337835455600300
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520621353; b=n5huMbztRHumcKQv4EZczRx81zG5YXyjp6vOywXWiXoTEUX
    +fRssS5RpR1BJg2MMlxoTG4VJnn/e+nb3iZr9ptjuJmfgoPTs+WotmQ3dZ2Eicv1
    qqm7tnTiAOVTATEZ8F075L/q8Aa/3mJdKnFfp1XAM1EpcU60fwYZd+rCz6k9KVVZ
    dEBY4+8DkJTciKwAx9DnejwfZ7zv2VL4uAh1RPIEC05VXeBVUJEQGkp+qqNjp1pQ
    5UkIDDhf/YEPVg+k2jMln9FtcZJsrmnSc1vlrwoyRAeCXjui9Rc1LpdoCdAfldBQ
    vM75+Az92zCiOwSnV50YvVvSJZjcapvFRYtJTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1520621353; bh=LTdAk
    ihwwwUC9EHWnM665A3q0E3RMzRN71ehbkECKaY=; b=JPgkt1fwVN99GDA5chASl
    ngEhWjkHGegdN58THev+VayRL0/s0nxhqXzcI7n8wiT0MRG9tpr8y7axrxgjP3C1
    Qqbc9ltsrLK3cJJ9UxtokCAsQT6rXavkKBkZmDXXdYSmKdNqQtSD2s0B038w30r3
    Nhzer56PHKA3GuY+Jy7C6zynzh/oaQNvMqiOc2hKNVVHg2LYy2WGt7NWMqm79s9g
    WoJEee7dTE1qzfIQRhWWTDcqguAUXSouh7gSKLTmGWfovteHUO8EaK3CJSvzDi5O
    RdOLLGh3dWI96jfurA6f6sjKcdLm97GKigAYMPYQhnPBBzupPzGSeUttPsyjAv9k
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=zv4bsLne x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pwtMWfFU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=zv4bsLne x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pwtMWfFU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932342AbeCISsz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 13:48:55 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34744 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeCISsy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 13:48:54 -0500
X-Google-Smtp-Source: AG47ELuiZ78iDl6nulQ7wE48YZDNATOvMGLajnVBv6itvKFrmBo55rpOVnPqNLl5aCw96tclPMgjDA==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15D100)
In-Reply-To: <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
Date: Fri, 9 Mar 2018 10:48:51 -0800
Cc: Alexei Starovoitov <ast@fb.com>, Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net>
References: <20180306013457.1955486-1-ast@kernel.org> <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com> <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com> <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com> <CAGXu5j+B4wgT3ovynAxa1zwCeROfN5zK45tL1FUnFh0sg8M5AA@mail.gmail.com> <CA+55aFwRGDPvaCUgMtqnQHb2PZ77JSMQMQVf1znSN+PiV7NR-Q@mail.gmail.com> <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net> <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com> <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On Mar 9, 2018, at 10:17 AM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20

>=20
> Hmm. I wish we had an "execute blob" model, but we really don't, and
> it would be hard/impossible to do without pinning the pages in memory.
>=20

Why so hard?  We can already execute a struct file for execveat, and Alexei a=
lready has this working for umh. Surely we can make an immutable (as in even=
 root can=E2=80=99t write it) kernel-internal tmpfs file, execveat it, then u=
nlink it. And /proc/PID/exe should be openable and readable.  The blob itsel=
f would be __initdata so it gets discarded after it lands in tmpfs.=20=
