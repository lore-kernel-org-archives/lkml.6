Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3342454-1520558457-2-12263722427668075703
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520558456; b=UJUHVIXDFR/Ztr9FWQ2bDlzI8apyivMNMQqiELraybSDsLY
    QQTQc1hb+wYBJSAJ49jWiSuMx7U98Qo/dZAqj0czOaniYtI8lCm8tykB6Ovz4Gis
    A44GwyHIUySAcoMOUtDMvFVE5eWUFUKOOatkwKytTnuFgiVq7Now/ydoBZrkpzjx
    9pwr7qrKxZeKN67zjV2Z7zqjEWhESaQ7qfE3ZZqHuj6zBUQS/GicBXG6FYBbx1o/
    /gcu/quzHsJxbb2k9iIf3SM3D++kPXd+Ze6TSSqBZDrgPWB2N2ykMZuVyFuBDfBW
    z67UgH+cbsiFmcRxdiD1V6hguBsUR1a2qMvgj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520558456; bh=BFp8SMd4AIEOThCbnSFUlxknk+
    m+6aud4qKoDbXDWOY=; b=D1fmAuKhsSi77WiknUdCiui9yNHjr8wUMFR0QPAsmk
    lJyW1qJ8CpBjOeNRBXO6JyTR2wc8GoKeH8jZedk3Fkk4b//3fmFBULfapa2XvjEl
    simUXBC4nuSMS86+CaL/VOH8GjM7+PKlpNu9abxMwpNphHV+pesfhno8ttWLuLP/
    U5nqgo7cfpcFwM9XxcdExFfd1SfgZbUhlGpFZecuxzXsVTpRkmLhTl/+lK9hWFNg
    NobOuDTACDkKb4nkXATRg7mW0Lh5n7qqiErGszwmQDvtLN3FtoRBUBgEmbQp+scz
    kFmQTns2kcyT2CSuGJ7BhocMzyj/udQyDqZdcsIa/N9A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=b6vgS/f6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AsBqzxEF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=b6vgS/f6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AsBqzxEF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeCIBUx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 20:20:53 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41644 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeCIBUw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 20:20:52 -0500
X-Google-Smtp-Source: AG47ELs3G6Rk4r/5nNHjy53MoAWtr5UfulfI5yxNIOcVzIhkvh/rplcBLLNSOiKYJ4Qcd0B8EEJQ5A==
Date: Thu, 8 Mar 2018 17:20:48 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
Message-ID: <20180309012046.6kcivmzzkap3a4xc@ast-mbp>
References: <20180306013457.1955486-1-ast@kernel.org>
 <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 12:59:36AM +0000, Andy Lutomirski wrote:
> 
> Alexei, can you give an example use case?  I'm sure it's upthread
> somewhere, but I'm having trouble finding it.

at the time of iptable's setsockopt() the kernel will do
err = request_module("bpfilter");
once.
The rough POC code:
https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/tree/net/ipv4/bpfilter/sockopt.c?h=ipt_bpf#n25

> Also, I just tested this concept a bit.  Depmod invoked explicitly on
> an ET_EXEC with a.ko extension gets mad, but depmod -a on a kernel
> that has a "module" like that seems to work fine.  Go figure.

right. that's with the current patch.
In v2 I require .modinfo section to make sure license is specified,
but depmod still not very happy:
$ depmod /lib/modules/`uname -r`/kernel/net/bpfilter/bpfilter.ko
depmod: ERROR: Bad version passed /lib/modules/4.16.0-rc4-00799-g1716f0aa3039-dirty/kernel/net/bpfilter/bpfilter.ko
I'm not sure it's worth to silence it, since
as you noticed 'depmod -a' works.

