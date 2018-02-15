Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732695-1518706923-2-11442833104460817966
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
    t=1518706922; b=H81QY9AJJKZNHliiID90ENz6qYwZl0ZoE81nXhETUyaZQjJ
    KNepEVnMsjeffVGfiQYyRDmsha5CxEi0Fza+hnlFhHNkYQ3iZdPssIJIGaUSKLue
    1aMd3Si0EBuHc5O7EIw8/b9x/ZFudqaZVZqPxCXFTAXHeVyjgTcaM2PvlexJaze7
    Ka9CuBDn0k/yaoQCqpfA+bOYZrVknIZV/wSphH54C+AlxOIk4S1Mlx9UEjhLC1Sk
    pISJ+oft1FOeCyEDA6wl1HtlVsdggkK+KMWNQ13t+nlvRaYTcLrkCwFj0vxE9hsh
    BuaQyWUOL6Rbe/AIf/SBNOZiPMBmoy/TijMMUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518706922; bh=6iR63fqSowzIOk8TbL/1FXVfCVCOJa954kSiXV
    zk614=; b=IaUWGO772svfEiDq7Bi+mgmOOp0xZfU9aE6YhUsA+JRzO0ijYAfVzQ
    3ed0sfPzDRXb1xBr2zYQuUB3lMRFIKTMCsk2JmTr1aiC3BKUVDBEt0AyUYvCIqr9
    nEwKRtJcuSLJ+psjElvXZXyS/AgogLBlVtbq+/Di83MwonPAjciVY4btna51Ecim
    82Nr0zYu9enbnRrPzmcoexB52iD1B7Ekmp347WCDsIsiEe8LHn681R026MawP17l
    vTjXsb9PJfOGERXPEhfADQRcBi/227tPtzM/73HNst3PzHorSMQITG2SHXRXLfAW
    4yYK16AHN69cjeO96PJtjeUg//tZV0sg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DFxk/qQg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ai+1a7NV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DFxk/qQg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ai+1a7NV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033572AbeBOPCA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:02:00 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:44228 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033445AbeBOPB7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:01:59 -0500
X-Google-Smtp-Source: AH8x224zXhQK22c8htHx6/riJsPBjcvWBKuDBDZuWn8w0rjbuYGooCYPRz8YWj0uKhrpha3KXrO8Zb34dxTV68QNdwc=
MIME-Version: 1.0
In-Reply-To: <20180214224525.esxiqt7yjjjpzyz4@treble>
References: <CAK8P3a32XycubV_d8JpxLAD3LEB7LBdhMAgTfqsWpPNbmzok3g@mail.gmail.com>
 <20180214222412.arg77l6vjpkje6pj@treble> <20180214224525.esxiqt7yjjjpzyz4@treble>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Feb 2018 16:01:57 +0100
X-Google-Sender-Auth: 4kjekWvfP_nOJKv5Qyj3MDy3r20
Message-ID: <CAK8P3a1Q8O7=Wt71RkB0hqZA1dPGZMaBxVwyrx0+d2pPsDb8gQ@mail.gmail.com>
Subject: Re: objtool warnings on 4.14-stable/gcc-7.3.0
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 11:45 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Wed, Feb 14, 2018 at 04:24:12PM -0600, Josh Poimboeuf wrote:
>> On Wed, Feb 14, 2018 at 04:11:15PM +0100, Arnd Bergmann wrote:
>> > Hi Josh,
>> >
>> > I recently did some randconfig testing with a plain 4.14-stable kernel
>> > and gcc-7.3.0, and came across three distinct objtool warnings:
>> >
>> > drivers/misc/lkdtm_bugs.o: warning: objtool:
>> > lkdtm_CORRUPT_LIST_ADD()+0x15: return with modified stack frame
>
> While this is probably an objtool bug, the code is very odd:
>
> 00000000000001a8 <lkdtm_CORRUPT_LIST_ADD>:
>  1a8:   e8 00 00 00 00          callq  1ad <lkdtm_CORRUPT_LIST_ADD+0x5>
>                         1a9: R_X86_64_PC32      __fentry__-0x4
>  1ad:   55                      push   %rbp
>  1ae:   48 89 e5                mov    %rsp,%rbp
>  1b1:   48 83 e4 f0             and    $0xfffffffffffffff0,%rsp
>  1b5:   48 83 ec 20             sub    $0x20,%rsp
>  1b9:   48 89 ec                mov    %rbp,%rsp
>  1bc:   5d                      pop    %rbp
>  1bd:   c3                      retq
>
> The function just allocates/aligns its stack space and then returns.  It
> seems like GCC was too smart for its own good here, as the function
> doesn't test what it's supposed to.

AFAIU, there is an optimization step in gcc that eliminates basic blocks
that contain an unconditional NULL pointer dereference, based on the
assumption that it's undefined behavior, and if we ever get here, it is
free to drop not only code after but also before it as long as it doesn't
have any side-effects.

I would have expected an actual NULL pointer dereference to remain
in the function though, or at least another trapping instruction.

>  Can you share the config for this one?

https://pastebin.com/qFV6SPWP

        Arnd
