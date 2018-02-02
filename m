Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2844860-1517589055-2-15863611836468060552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517589055; b=HIEsaQsSPH0ESUctUo0InAV+0fyAgTYMnFPnmbwZOAHuP4D
    mNt0CvF37A8Na8oJV710Au4n/YjCdDOzPMvtv0KxI5GqkDNckncr4kQFwQgMCTTo
    lvFEFQ4LHdHKwyNi/yShPSyEx4OquzjqrTyaWi01zdhRc2Wph1nRZIM0PK/ZUCv2
    DZ9vmWKzYWag1FgT6yMTPsw9bKrqnOql+UTpNLdpk4nUFd7xNrOW0kS5PooUBzYZ
    kkRs6PZAVY5hf+8fOLsWqwek9Hw42ZrdwJWpgK5TzmdohfLSRND32JHTuGcE0pOE
    zrzmDKu/4x6NaxSjG9LUt6lPxoUXDKGa2Sc5rKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517589055; bh=NpgpR8hzWE7sunEhon3dke1VILYP4q+ZH5WrGLpkjkU=; b=e
    vt4xLgPqUT3gzXOWA/BZhJSCF/1Xx5VXv8Tj5279JpNhg0y+p7QkuwPPiEY31Tjk
    vgnUmzFfxi6wAkIaHxBnzHtEQWCtPMgaWStsDHcCLotxAPjhNCEh1N2NuOWWcZmu
    KT2nr9dGdn2gtZsdqwW3vJy+2H99e4eK9xLlQJJup7X46+Qt1Gt3Xh3opNUEop0L
    mgqDC+nm43qT8+jOnjC6mlBB61Fy+nOzbr9IiiAVQqrmmbXkD52k6xaC/sa6SL97
    KQhK59WMDxJsEDwxRYhM2unyknVbBZ2bSMOiU3hIa+pcHGShjNbsG1RuIz0jAzJv
    +9eKuyd7ut6S+2lvwZKHw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeBBQax (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 11:30:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33230 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751651AbeBBQax (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Feb 2018 11:30:53 -0500
Subject: Re: [PATCH 1/2] ARM: kvm: fix building with gcc-8
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Richard Earnshaw <rearnsha@gcc.gnu.org>,
        Tamar Christina <tnfchris@gcc.gnu.org>,
        kvmarm@lists.cs.columbia.edu,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180202150756.420422-1-arnd@arndb.de>
 <2cff070a-357d-c5f5-9ec6-036d93112ce4@arm.com>
 <e5afa875-56a5-fca4-1fdd-2c0968b35790@arm.com>
 <CAK8P3a0s_muecNBYTn5EvOPrg11Kuc9NKn0Hiqu4PAE2mTQ+-A@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <276d0fe2-c742-7c95-f549-f2e49f13baac@arm.com>
Date: Fri, 2 Feb 2018 16:30:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0s_muecNBYTn5EvOPrg11Kuc9NKn0Hiqu4PAE2mTQ+-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/18 16:29, Arnd Bergmann wrote:
> On Fri, Feb 2, 2018 at 5:23 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 02/02/18 15:55, Robin Murphy wrote:
>>>
>>> On 02/02/18 15:07, Arnd Bergmann wrote:
>>>>
>>>> In banked-sr.c, we use a top-level '__asm__(".arch_extension virt")'
>>>> statement to allow compilation of a multi-CPU kernel for ARMv6
>>>> and older ARMv7-A that don't normally support access to the banked
>>>> registers.
>>>>
>>>> This is considered to be a programming error by the gcc developers
>>>> and will no longer work in gcc-8, where we now get a build error:
>>>>
>>>> /tmp/cc4Qy7GR.s:34: Error: Banked registers are not available with this
>>>> architecture. -- `mrs r3,SP_usr'
>>>> /tmp/cc4Qy7GR.s:41: Error: Banked registers are not available with this
>>>> architecture. -- `mrs r3,ELR_hyp'
>>>> /tmp/cc4Qy7GR.s:55: Error: Banked registers are not available with this
>>>> architecture. -- `mrs r3,SP_svc'
>>>> /tmp/cc4Qy7GR.s:62: Error: Banked registers are not available with this
>>>> architecture. -- `mrs r3,LR_svc'
>>>> /tmp/cc4Qy7GR.s:69: Error: Banked registers are not available with this
>>>> architecture. -- `mrs r3,SPSR_svc'
>>>> /tmp/cc4Qy7GR.s:76: Error: Banked registers are not available with this
>>>> architecture. -- `mrs r3,SP_abt'
>>>>
>>>> Passign the '-march-armv7ve' flag to gcc works, and is ok here, because
>>>> we know the functions won't ever be called on pre-ARMv7VE machines.
>>>> Unfortunately, older compiler versions (4.8 and earlier) do not
>>>> understand
>>>> that flag, so we still need to keep the asm around.
>>>>
>>>> Backporting to stable kernels (4.6+) is needed to allow those to be built
>>>> with future compilers as well.
>>>
>>>
>>> Is "-Wa,arch=armv7-a+virt" (as we appear to do for a couple of files
>>> already) viable as a possibly cleaner alternative, or is GCC itself now
>>> policing the contents of inline asms?
>>
>>
>> In fact, looking at the binutils history, any version capable of assembling
>> this file should understand that (modulo my typo), so hopefully it ought to
>> be feasible to replace these global asms with assembler flags entirely.
> 
> No, this only works for .S files, not .c, since gcc starts the output with
> an explicit .arch setting that overrides the command line. I think this
> was done intentionally to prevent such a hack from working, and have
> more reliable checks on the validity of the assembler instruction in
> inline asm statements (which we try to circumvent here).

Ah, I see, that is unfortunate. Thanks for clarifying.

Robin.
