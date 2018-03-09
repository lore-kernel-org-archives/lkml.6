Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3527705-1520567668-2-17217342476624180675
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
    t=1520567668; b=rW8RV5e7Ce03Mt87kQgn22N4kDm2LOVfPTf1REvwWvp8sh4
    Kl/eG9mIejdDFpifh2N2Aa2hHkDpbEtdiMNcZDuRMzQ+I49Nxbk1N0WyF+ugYfeZ
    LppDsD7iXA6N2aUMbeTjy/3YAm8Okim4+NkKoPuxvJ6TQUZPtryEwdzbrHJtH3su
    Z0I90LHzYqJ/lgk6w71jw4TAiXfgBxVMH/8Akq+34qNd1Skz+xEPZB6aY418mgmy
    PDgLb0Nz4JjhtuyCyJTPiqjal6rrvhM96VpcR7zQYZ0hC4y2HXIFxRW7uNeo1GKl
    26/1ihTlaitn9muzQUUUfNfwToN6Vlb89cSfe+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1520567668; bh=KYYoO
    IEagL0MzHHJEsm8Euv4UyTaosXvy2UOKH/NnzQ=; b=bf5t0nMxiSOTrVJKsPZhx
    Iyb1zz0/xTSOMVspAdPhD8+tUvFo24LLXb8oJYd0hu2iXW3BE4LEo5uCcQdOF/S5
    q8ddt3BS1iepnuHCwZ+HW0JNwDlfOz0FBZeCdURv1opxkPOkcRKAT6m/9/LhcPc/
    pP8lXWcgkxV64QT0JyqoUgliT1qg2V6pgsjwJnd3K5ssTAHCnf5TS54mdEHN2ggm
    vJyg6r1M4/Xy4iZB9AiHCTSRPjjpmj/XZqDqBgO0OFvjsrsIY2xGIOpaath1lU+d
    KHddieP8A8I0grLWdrNMIMtCDpdadu7DOwErH8JLJ43T4MWy9092dL5MnofaB9xM
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=fj0XTYve x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aynN81vH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=fj0XTYve x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aynN81vH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750909AbeCIDyZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 22:54:25 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:37269 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeCIDyY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 22:54:24 -0500
X-Google-Smtp-Source: AG47ELtWSSQwev6GlopiS/gOTKBADpoIspvosRs3EzhoeCR7xL+RA8FsuTzn99kFjA+GUMi+LvqYHw==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15D100)
In-Reply-To: <CA+55aFwRGDPvaCUgMtqnQHb2PZ77JSMQMQVf1znSN+PiV7NR-Q@mail.gmail.com>
Date: Thu, 8 Mar 2018 19:54:20 -0800
Cc: Kees Cook <keescook@chromium.org>,
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
Message-Id: <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net>
References: <20180306013457.1955486-1-ast@kernel.org> <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com> <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com> <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com> <CAGXu5j+B4wgT3ovynAxa1zwCeROfN5zK45tL1FUnFh0sg8M5AA@mail.gmail.com> <CA+55aFwRGDPvaCUgMtqnQHb2PZ77JSMQMQVf1znSN+PiV7NR-Q@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>




> On Mar 8, 2018, at 7:06 PM, Linus Torvalds <torvalds@linux-foundation.org>=
 wrote:
>=20
>=20
> Honestly, that "read twice" thing may be what scuttles this.
> Initially, I thought it was a non-issue, because anybody who controls
> the module subdirectory enough to rewrite files would be in a position
> to just execute the file itself directly instead.
>=20

On further consideration, I think there=E2=80=99s another showstopper. This p=
atch is a potentially severe ABI break. Right now, loading a module *copies*=
 it into memory and does not hold a reference to the underlying fs. With the=
 patch applied, all kinds of use cases can break in gnarly ways. Initramfs i=
s maybe okay, but initrd may be screwed. If you load an ET_EXEC module from i=
nitrd, then umount it, then clear the ramdisk, something will go horribly wr=
ong. Exactly what goes wrong depends on whether userspace notices that umoun=
t() failed. Similarly, if you load one of these modules over a network and t=
hen lose your connection, you have a problem.=20


The =E2=80=9Cread twice=E2=80=9D thing is also bad for another reason: conta=
iners. Suppose I have a setup where a container can load a signed module blo=
b. With the read twice code, the container can race and run an entirely diff=
erent blob outside the container.=20=
