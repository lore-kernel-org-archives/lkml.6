Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-199772-1517777883-2-524760197764385867
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
    t=1517777882; b=luZBSPLyzUTDW6rPGhv4araix1F9vps8EbDBh94t/DhXOoR
    ZOSW/PMCRCUe4w3c0N70IMTXup2gZzx+nU7LE5c7k/dJN3OSPJnIOu1jTdKQ4wwZ
    EqdBg5fYP/7qzrBZGnsMnwXkEAo03E7xoJZJKh3lsCUPdwEeQ+sfHDQDEHt8vPCF
    785BuB3PMtr2KTfwwHcuq5Ns7x9R587gcc8BrPvVG5xxYrDEHjZw9Ewkfvp90DIZ
    rJAXoS5h+FRWNDA6el+lMXKnmVI+jNLfd0QAFPmE100JUt/5vkxyLtxhExXapdtY
    WFLOr1E8zLoqZbj8h9vrUx2H81t7Uy3oytX3fPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517777882; bh=D2WorI7SBNAufrqqcTSQAmsficQH+9PqDfb6wg
    yPU+4=; b=pI6Gp6ysTEOp2qBEkqTaqkw5EPKKKzeiuDHaiCb3hpr8AXPVCRw+GW
    O4qEWwJMrUsCk5lyadGdtee/oYpr8qDGTaGcB9sJmN4BRuNtnhNbFWn5/8WiuI67
    yAer6KSZrqz/WbS0uSA5wfxdjgvNZS3n1bHJhErz4TIyfbnn+JeBoa+gFT9X2lAD
    TJ4ttmK5+y7D2KmWnXNlBngB7SYzhCOLjYmNmYFIIanUk07QsvS1eLNOjRHE73PI
    AKJRABD9nTrJikkR7CSBRPpR6rtN1Fe2XXjvEOEsZdHtNO5C/lnlhFEvZtdLV/iM
    Cyjwn4YMl33+XwIjSQqBB4tgOdP64wHQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=POEzQ/Vm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oJCYZCS0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=POEzQ/Vm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oJCYZCS0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeBDU5v (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Feb 2018 15:57:51 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43543 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeBDU5u (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Feb 2018 15:57:50 -0500
X-Google-Smtp-Source: AH8x226Yscq4tp43vKtBeFT34LkiiVELRbzcmfnRlmCUJHt+NM+OKGpqR6PWt5CsOQRTFP+L8Jt4Ep+SnGsblr7+HLA=
MIME-Version: 1.0
In-Reply-To: <20180204184517.GQ21802@cbox>
References: <20180202150756.420422-1-arnd@arndb.de> <20180204184517.GQ21802@cbox>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 4 Feb 2018 21:57:49 +0100
X-Google-Sender-Auth: E2FpVQtAE0LJpReuYUbT6WUSWg4
Message-ID: <CAK8P3a2EFdTcM6U4TU6EZz9vzGKK=hE=8yQ-1eTTxjGMRs5SKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: kvm: fix building with gcc-8
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        Richard Earnshaw <rearnsha@gcc.gnu.org>,
        Tamar Christina <tnfchris@gcc.gnu.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 4, 2018 at 7:45 PM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> Hi Arnd,
>
> On Fri, Feb 02, 2018 at 04:07:34PM +0100, Arnd Bergmann wrote:
>> In banked-sr.c, we use a top-level '__asm__(".arch_extension virt")'
>> statement to allow compilation of a multi-CPU kernel for ARMv6
>> and older ARMv7-A that don't normally support access to the banked
>> registers.
>>
>> This is considered to be a programming error by the gcc developers
>> and will no longer work in gcc-8, where we now get a build error:
>>
>> /tmp/cc4Qy7GR.s:34: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_usr'
>> /tmp/cc4Qy7GR.s:41: Error: Banked registers are not available with this architecture. -- `mrs r3,ELR_hyp'
>> /tmp/cc4Qy7GR.s:55: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_svc'
>> /tmp/cc4Qy7GR.s:62: Error: Banked registers are not available with this architecture. -- `mrs r3,LR_svc'
>> /tmp/cc4Qy7GR.s:69: Error: Banked registers are not available with this architecture. -- `mrs r3,SPSR_svc'
>> /tmp/cc4Qy7GR.s:76: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_abt'
>>
>> Passign the '-march-armv7ve' flag to gcc works, and is ok here, because
>> we know the functions won't ever be called on pre-ARMv7VE machines.
>> Unfortunately, older compiler versions (4.8 and earlier) do not understand
>> that flag, so we still need to keep the asm around.
>
> Does "not understand" mean "ignores" or do we get an error?

We get an error, which is why I used the $(call cc-option) Makefile
helper to check if the compiler supports it.

>> Backporting to stable kernels (4.6+) is needed to allow those to be built
>> with future compilers as well.
>
> This builds on the toolchains I have on my machine, so:
>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
>
> Are you applying this via a tree with other fixes or would you like me
> to carry it in the kvmarm tree?

Please pick it up in your tree.

Thanks,

       Arnd
