Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3541274-1520565077-2-8213063357713109633
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
    t=1520565076; b=GvtY40FqK2qOOBswwoPktyBn64V8JP+keMsek+GwNoNEZVp
    yFJIUc8otqD5+bFQ/5v8V/Uj+N0n7nvoDUluBnBBUtFA4Yi6/6tcv9ei8V3P3FkM
    xyMjw5WkOAdNNEe8/d8XRygDtb6whRiZq7FV2NHrWQvc59yD76uXwL81RxvedTXX
    i6G9w2jlaL9v6oWhA1wjcVINGz/QPlLc2JKEMSv5IPXLom10sOZOXxFr48H+DmTl
    zreNznBOgsJPCYVt04vlCecxUTRh4OhhA122PQNZPZyp0357Oiyt6dFs4hlGl7Xv
    zI3sd+9P25SYdDzQh1b1zKOLrio0iGdefSG3WKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1520565076; bh=XIH8U
    BO/+yhPXyZho0wQsu8UyZ4KvMIoeJqhXNJ7jL0=; b=HEnxxBeQsRNNma9RoI5bL
    hXpVqiXEO8+5mCycHhQ9aKZdTufTBDpeXhkVMMFO+6xN7I+kcIVI1xlOtabKPL2P
    eMiNg5Eym85YD0Y69lqQpKjBJPyD9y+w3THRa3J9s5kwhnLHU2Mr0M+cJaMPq0yk
    0M9wpPJbUMolvC6W4fc1LQZFRx+z+msd6lFIkP5BW/dpZfYrAi3nuxPovxG8nqGa
    9/OmYSkE4waJfgqqrTbhrMTeKYPnJqsmdQmpO9AWWpRv0b0Rqq3XCdMzi37ZjFJ5
    F6apEHKM+6rp3kbfau14MWpp0gx7EyJWELEsufcC0pl9MskuePVCIKHkKn5UCN7M
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=fOG6ZF5H x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eRIw+CmF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=fOG6ZF5H x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eRIw+CmF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbeCIDK6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 22:10:58 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36562 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeCIDK4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 22:10:56 -0500
X-Google-Smtp-Source: AG47ELvblDIMOkmWwUfGUquDo6uE+jdfKnhFWeskTDL//zG9Yv8mBZrzcaTkaEBNn35LMZFcMTBBDg==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15D100)
In-Reply-To: <20180308.213153.2003279953084099668.davem@davemloft.net>
Date: Thu, 8 Mar 2018 19:10:54 -0800
Cc: luto@kernel.org, alexei.starovoitov@gmail.com,
        keescook@chromium.org, ast@kernel.org, tixxdz@gmail.com,
        viro@zeniv.linux.org.uk, daniel@iogearbox.net,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        mcgrof@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-api@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3BC1EAA3-D926-4758-901D-A860718B846A@amacapital.net>
References: <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com> <20180309012046.6kcivmzzkap3a4xc@ast-mbp> <CALCETrV8nPo=_rsSzy3Dt+y09mNgRi2+aYRk0Pj45j6BLRXgAA@mail.gmail.com> <20180308.213153.2003279953084099668.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>




> On Mar 8, 2018, at 6:31 PM, David Miller <davem@davemloft.net> wrote:
>=20
> From: Andy Lutomirski <luto@kernel.org>
> Date: Fri, 9 Mar 2018 02:12:24 +0000
>=20
>> First, compile your user code and emit a staitc binary.  Use objdump
>> fiddling or a trivial .S file to make that static binary into a
>> variable.  Then write a tiny shim module like this:
>>=20
>> extern unsigned char __begin_user_code[], __end_user_code[];
>>=20
>> int __init init_shim_module(void)
>> {
>>  return call_umh_blob(__begin_user_code, __end_user_code - __begin_user_c=
ode);
>> }
>>=20
>> By itself, this is clearly a worse solution than yours, but it has two
>> benefits, one small and two big.  The small benefit is that it is
>> completely invisible to userspace: the .ko file is a bona fide module.
>=20
> Anything you try to do which makes these binaries "special" is a huge
> negative.

I don=E2=80=99t know what you mean.  Alexei=E2=80=99s approach introduces a w=
hole new kind of special module.  Mine doesn=E2=80=99t.=20

>=20
>> The big benefits are:
>=20
> I don't see those things as benefits at all, and Alexei's scheme can
> easily be made to work in your benefit #1 case too.
>=20

How?  I think you=E2=80=99ll find that a non-modular implementation of a bun=
dled ELF binary looks a *lot* like my call_umh_blob().

> It's a user binary.  It's shipped with the kernel and it's signed.
>=20
> If we can't trust that, we can't trust much else.

I=E2=80=99m not making any arguments about security at all. I=E2=80=99m talk=
ing about functionality.=20

If we apply Alexei=E2=80=99s patch as is, then I think we=E2=80=99ll have a s=
ituation where ET_EXEC modules are only useful if they can do their jobs wit=
hout any filesystem access at all.  This is fine for networking, where netli=
nk sockets are used, but I think it=E2=80=99s not so great for other use cas=
es. If we ever try to stick a usb driver into userspace, we=E2=80=99re going=
 to want to instantiate the user task once per device, passed as stdin or si=
milar, and Alexei=E2=80=99s code will make that very awkward.

