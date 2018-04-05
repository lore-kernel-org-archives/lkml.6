Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1314283-1522886752-2-13626692016656731517
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522886751; b=MfPOe4XjPgWUqg7uYZGPR4Ud2ovMKGvN9xFDMqAb7WXF5dy3Vs
    D0MV1u2lmn6t5Aim/f1iu1DOmshcDQtwQyCywV3a254WMWzUX2T3J9hm6Ha8QyNM
    MizTf2hiaLL22FaRU3SJ6RHHSA8OCEkXvx4bpR/T05Wh2+C4+X57IRTn34y1bQbH
    vTXkkSkfVR/giPWn4PUqVslgUkNkVKXhWIA+06nPBXkmEAkTkaTSN5VhoiBZv5QI
    ELBtdGyqQsrB9jyBpujnSt0SbE+QUYqpsqGhuZ7PXPOn5hi3gQnZUmEI8i12eHYn
    RqefkjyPPUtV4MW0E3Jw8IV+A4tDFVjTfS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522886751; bh=/3A/UVLyWhK9xZJDs+KESBQjzIugHj2dvq4pHCLiAP
    E=; b=oBco0wAkyeQv08th32YjspRqPzURdPjz5liYhEhBLZFa4NFCcPuahi9SaR
    oOPXhiqUYv7tVb/bD/DR10WQxkJdORG7yRcqhkqEPeZGVxBhqrNSg+u7m5ftvjb1
    3OIaCqenl7M3JOTFyKzyHJZzbWWODxOWtBj9mwahUpwEq8FCiQisXOfY1dEAepjp
    Am1m/Cv2kiieMJfrKfEswY37uFkMyOf5M13UEwTVrOuYnqfghO14iFznVhcFGsrp
    /LEeiIQaKtiAnapwfiYCsQiE8bDCi0CBzZ+Oi2sg4VvdcRddJ8TAdKMCbyfhXkIU
    tsOxyJvHV24CWHxZnZt11phf770w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=b0vfQs+R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Q4r2ibUv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=b0vfQs+R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Q4r2ibUv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCdUIE6+Hpv69mvG92AEpUZQ7rN0S0ieXT1wYdPWrvAdR7pZVekoiIyAGEm/0LHMylAZX7NxKPaq1SGnyph23b3nSQ+DCqpA/YtdxM+s5SKj4F8M3ajy
    tFhtcQiywhbq38FEM/eTh8d56IGzXQ775O9SoIci7K9wfylT4gvAXQjCIKQXafeHjKlqpHDu14vJBMM7EIywK3d5twgE41ZAyGzcVN/De++0VhHMbVAvb3OK
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=j0yIDaVBfk0A:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=OjqLqJy3pGowdK5NaNMA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeDEAFu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 20:05:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35563 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeDEAFs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 20:05:48 -0400
X-Google-Smtp-Source: AIpwx4+3n0I6pWLCQ2uGDcvS8sE0srXvbSPrBUEDJXCgJ8dFTgrrD+Eor85yv6J8ZpJHbbGt0Uvgjc+Pkjx/nGhFK28=
MIME-Version: 1.0
In-Reply-To: <CACdnJuuGRRUt-a3i89o906ka3RDOhs+_7tz_G8LTG8Jc0DXAyQ@mail.gmail.com>
References: <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
 <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
 <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
 <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
 <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
 <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
 <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
 <24353.1522848817@warthog.procyon.org.uk> <20180404135251.GD16242@thunk.org> <CACdnJuuGRRUt-a3i89o906ka3RDOhs+_7tz_G8LTG8Jc0DXAyQ@mail.gmail.com>
From: Peter Dolding <oiaohm@gmail.com>
Date: Thu, 5 Apr 2018 10:05:45 +1000
Message-ID: <CANA3KFWLCfe=KYPBhKj+g698=frt4E-u-Hq2--5jFkHnkNoBnA@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Matthew Garrett <mjg59@google.com>
Cc: Theodore Tso <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        luto@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> If you don't have secure boot then an attacker with root can modify your
> bootloader or kernel, and on next boot lockdown can be silently disabled.

Stop being narrow minded you don't need secure boot to protect
bootloader or kernel the classic is only boot from read only media.

Another is network boot using https can coreboot firmware.   This
checks the certificate  of the https server against selected CA before
downloading anything and as long as the firmware is set read only in
hardware the attack has absolutely nothing to work on.

In fact the network boot form https server is more secure than UEFI
secureboot due to highly limited parties who can alter/provide the
approved boot loader/kernel image.

Having root user rights does not override physical security.    The
fact there are other ways of doing bootloader and kernel security
other than UEFI secureboot that are in lots of cases more secure than
UEFI secureboot due to using more limited keys is the absolute reason
why lockdown is required without UEFI secureboot.

It would make sense to extend kexec to support UEFI secureboot
verification  and also kexec to have frameworks to support other
security options like https server storage of all kernel images.
Please note kexec supporting UEFI secureboot verification should also
support booting non UEFI secureboot but verified by some other method
and having own PK/KEK set for kexec and this would be when the Linux
kernel is placed in firmware and used instead of EFI firmware..

Please note there are many UEFI firmwares that with secureboot off
allow setting up secure https bootting where you are not in fact
validating the boot loader or kernel but validating the source you get
them from.

There are three different ways to achieve a protected boot process.
1) validate the boot files.(this is like UEFI secure boot and many
other methods)
2) validate source the boot files.  Yes this can be apply key check to
image if image is not signed don't boot from it and the image contain
boot loader and kernel then not bother validating the boot loader and
kernel image/parts individually same with https.
3) make boot files read only.

All three achieve the same level of security.   If you are using any
of the three lockdown option may provide some benefit.

Yes https network boot effectively does 2 and 3 so making having a
very limit threat against the boot process.

Remember there is more 1 way to skin a cat just like there is more
than 1 way to make a secure system.   Currently being too narrow in
methods for doing protected booting.


Peter Dolding.
