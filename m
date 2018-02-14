Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3076253-1518621081-2-10710164964684684238
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518621081; b=acZhqLSgHAbLdnv22De4ZLoB4Vg8mU+GZG9o+6CFVoAnaht
    IsmtSUglvbwPOHZn39TxlD2bvsao+XTZ64rK+tCgMpRH0DghP9hqcqARuFYf+ke/
    Dsc8KdPCQ0qI1FMtQySZWdQwmyfpUyNFR2bALc7RyQbFQJakYWlrm3XxUUDBrDqG
    vOq164BnLHLGFRjDVmkTtY8MXvT7t89A9vMqcHe/9lnKc+GyISM1O5FpK6MeXZsa
    IH+NgyiBzStcJc5vLjeoldLXevGTUpx7+Sb1y8ArySbp6S+gxaQB4dBpFSW92wlV
    DOBRhOBBELy60i34EqbyVjawK3l5f0iYU3hJ5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:cc:content-type:sender:list-id; s=arctest; t=1518621081; bh=
    7wLkV9QMsmyCQNxrGiIBgm1VDF09JFCVsR39oCYFdFI=; b=dQSrIuineJugMUSq
    7I3umAdf6t61o+/gA4iYzp69fEJ1/WPoWRquza8Fqb50znWN+rIEalZUcSdQMFoC
    ifOVvZWvG/KhcK28TChy5OiYjvp+VLrMHi/AmrlXalGWR8pGwfnMCqyiIZU+WAuE
    Q7kUQ3q+DgNhITTjFwd2QuMPmjYuoz+dRes+6KerLOBo82XOpdDNmBJ9poWAa7YM
    zRn04zLLg0VoNhBp+vOQBwYiaOXm6FmG7q4+VKLZwyTGRxxojY5RQCH2LTkKfNwE
    2u9gzBHUxURnMXUlPjBDDDs/Adg/mEbbmpDDgHB0z8wIbjRoVirG27aShLSllIKx
    OAY9+g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=l2GedAaj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i2wBDgE9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=l2GedAaj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i2wBDgE9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030889AbeBNPLS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 10:11:18 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:45717 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030825AbeBNPLR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Feb 2018 10:11:17 -0500
X-Google-Smtp-Source: AH8x225WsmCeb+blYSbojNeTUZU/T+4ErP8ufNAZ9Y6fxTSI8r1v88rJzHVfjR9eK/y1uIpMWSrs7uEaR8jKZ4C1KU0=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Feb 2018 16:11:15 +0100
X-Google-Sender-Auth: 1m2Ralf25HPNRDAt3NP4EQyLoIE
Message-ID: <CAK8P3a32XycubV_d8JpxLAD3LEB7LBdhMAgTfqsWpPNbmzok3g@mail.gmail.com>
Subject: objtool warnings on 4.14-stable/gcc-7.3.0
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Josh,

I recently did some randconfig testing with a plain 4.14-stable kernel
and gcc-7.3.0, and came across three distinct objtool warnings:

drivers/misc/lkdtm_bugs.o: warning: objtool:
lkdtm_CORRUPT_LIST_ADD()+0x15: return with modified stack frame

crypto/asymmetric_keys/x509_cert_parser.o: warning: objtool:
x509_note_pkey_algo()+0xa4: sibling call from callable instruction
with modified stack frame

drivers/infiniband/hw/bnxt_re/qplib_fp.o: warning: objtool:
bnxt_qplib_poll_cq()+0x106: sibling call from callable instruction
with modified stack frame

It's likely that this is the complete set at the moment, I saw each
one multiple times,
but did not see any others. I'll reply with the respective object
files for your reference,
in case these are so far unknown to you. There are only a handful of randconfig
warnings we see overall in the kernel these days (at least on x86 and arm64), so
even if they are false-positive, it would be great to get rid of the
output so we can
do randconfig testing on 4.14.y and treat any output from 'make -s' as
a regression.
I did not check

With gcc-8, things are looking very differently, and we still get an
endless supply of
similar warnings.

        Arnd
