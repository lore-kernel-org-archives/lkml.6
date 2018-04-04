Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2795407-1522801117-2-16034299712171233349
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522801117; b=Qx0K+Zu3uPxOhtuBJ5ZD9ssv45lZveSplcY8JaDjwMeYFqzfQZ
    HpE1ogB8m+zjqCLCDamedE1rlKgrdK9bafIzC5Cvc8iRL6pY0gaXWeu2mlyvN1qP
    n5EYkrKPBnOyqCnBuDI3c626w1siY+fd8sib/MxtuidltwtU7mxr9xRDlmtzDh8m
    Mi07VeYQ/tiJSIpUyE6Paqhq2Sd95myaUu4xZpWFwtvbAdJOmuQuDW+qJ54SNAnl
    7PzrfTjs0WFqptfewv24aQV3vgbVjusUuH3F0514lk/eWp+wj3vnQ6SnYP70Rpx5
    r09vWAfQhZpC1xhCDT/lKzyvCgc5IAOzEgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522801117; bh=3CyV3C0DhjuRHGBEpirPfdNHQB8uEa1dhpry950zFS
    o=; b=hA1lSQyL+pvU8J8G0HBDba3oC+0pheaGOrSxwsOy4nJ4a56aL6CLkZeQ0T
    F2a/yaLRQ/kg1/milCoRr00X4M39ObhpbzpXHfYZ8wVxnpdQqpXe/pKbskId7YLH
    iDQgD5MDGyzfc51ozBHPUDkEfQJc9bOYUPhpDCm2Ri4f5y1ufchj8AtnsFRwnCpw
    r/V9z6Han+unoRFHih/yKMviUDLqNeP+xDMDleEt8P23mmDu1NFgBtBP1iOrrCjt
    VtK5mOkDn0+JrO0eNuCl4vm+5VZouNcV3ZGbk71wsqfBGX1vYDozfG1sUnJA/Ypq
    +hAv8oQin2xcKOs2cbFReWoY6Qkg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBsNs96bafBwEWuH8odY3en0OOv0HBkBHm5gwXKYVvGx3suA5SPF7HOVREbDABkT1JZtmk1WxYMrJZhMhLetqB5154OJt0XqL2Ik8GoNJHSRmVvEZ4F1
    VerEXRHPqSko2S542ZXih18l1L74lfo+W+j36Bs/YNpNobYzCfmjpBuIWc6pCwyYPjgUYMP6bXQBY5fWSbLBUdcrkoCcnx7IqHzAxLY3UhuulwFpUVCciUBi
    skT1tde5zmNJ0TOtoXzM9A==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=nTloBKGrtv_pAUDkHkUA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756714AbeDDASe (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 20:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756400AbeDDASb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 20:18:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15AE21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx4/hu1cGU/cRJguw3weY27wxLOMAY5+nuXcdoyLw9/wwG7/6xlvXVhqdQRW7ODm6jtMaqBHeV7BlhqnC/oblXX8=
MIME-Version: 1.0
In-Reply-To: <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
 <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com>
 <CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gmail.com>
 <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
 <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
 <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com>
 <CA+55aFwVUmjZ+Swe9xUdDOEE+EOoaU3dh7BcrH74BOLCi8y_Kw@mail.gmail.com>
 <CACdnJuvqQQ+hidokY5GA7g-yrAs5-358it0cs+m_d4RFDMuB_w@mail.gmail.com>
 <CA+55aFwJBGCr-anrdV9N63fUH4V_QJqgr0_fJyHhH=fuqGAoog@mail.gmail.com>
 <CACdnJuvFqXGLsAv1Km3MmdssHBfuH5-C_vG3A4eq4Yuj0HhFBA@mail.gmail.com>
 <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com> <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 3 Apr 2018 17:18:09 -0700
X-Gmail-Original-Message-ID: <CALCETrVF2vSvoz0sBCrfMKcbJ4hmi=1QJZbUxdvurkimVXr0nA@mail.gmail.com>
Message-ID: <CALCETrVF2vSvoz0sBCrfMKcbJ4hmi=1QJZbUxdvurkimVXr0nA@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Matthew Garrett <mjg59@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 5:16 PM, Matthew Garrett <mjg59@google.com> wrote:
> On Tue, Apr 3, 2018 at 5:15 PM Linus Torvalds
> <torvalds@linux-foundation.org>
> wrote:
>> On Tue, Apr 3, 2018 at 5:10 PM, Matthew Garrett <mjg59@google.com> wrote:
>> >
>> >> Exactly like EVERY OTHER KERNEL CONFIG OPTION.
>> >
>> > So your argument is that we should make the user experience worse?
> Without
>> > some sort of verified boot mechanism, lockdown is just security theater.
>> > There's no good reason to enable it unless you have some mechanism for
>> > verifying that you booted something you trust.
>
>> Wow. Way to snip the rest of the email where I told you what the
>> solution was. Let me repeat it here, since you so conveniently missed
>> it and deleted it:
>
> I ignored it because it's not a viable option. Part of the patchset
> disables various kernel command line options. If there's a kernel command
> line option that disables the patchset then it's pointless.

if your secure boot-enabled bootloader can't prevent a bad guy from
using malicious kernel command line parameters, then fix it.
