Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-470151-1522858943-2-8217008580063862298
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
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
    1522858943; b=sV3ENX78bDBP8IYLicjj8UEiaaoCP3O7rFGQ/8P12NkY2nAjaT
    jQX9xJsJus0Gsbq6NkuC1RVIUiPHsQTzLgfJUCjWajRGAppG/A0MgyIC2zKLDjN+
    7y46m9KFcFO4fYymAIK1G/K54iHI7ac7NGT/M3mtDAHic2Rp5OIYzz1c2vBkmMry
    wh6oNP2kEB0TCYH2SvEIiN1AYzgsNAlbB+Fl+jKuHtt4s60h4QvOjKF1IRnUBfDG
    z+sc2BOidvzZCwzMu/A8gz4IY08WU/MnLAUWud/LaaV5y5HJdb0YTSdf5VhxxcIG
    5rjn9GqQFlroFmS9HL9uCOC+x4aR7oGEnvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:content-type:sender:list-id; s=fm2;
    t=1522858943; bh=hdFdG47+whV4NZbBpqAtiwlzhJWjj51M8Z7wIU+mfJg=; b=
    k+31Uvl9gUH+VDZpeFGtRyfOM3hBB7Qyx80R6sFt6jmQj5Dkv6z5QfWwIcOUoFi3
    p7CIppXs4Hntl++wIQsPYuO7QDZV08h7wvbJPiQB1HaiHnXeLi4hNF4lfL60MRqg
    V1wbsUSNecu1CiCP3JrIccX7glELQcz+37yvw2rimItu2in+CJR17IuVSV/u/bRK
    nf1I7eZDQ/7vAbckcfN2yzVTMRmiJTKWDdSX9E8aOZqkvGrTXderSNxDtg8LYBRB
    A3BstVqfp1qdiAoxMiE2XlPB904ivyNScYci/ySaf0KmN7kLm1T8TzXfcXuhRvAJ
    E660TBz3/bANfZDaifFztg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=iLyD4Byy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MY7TJ75Y;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=iLyD4Byy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MY7TJ75Y;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPhP04P5bvFhiJAHdy3q395WdjaeBwlKQ4swZC7np2w0EfD4E+X5Do9ggJNx67/iJ+E5rq/6As3l2dJuC+Typ1D48lZmvzi+K8jt1eYiOh5SAZwo44y2
    aDBeVFtnBRaTv42Fnp+DdlIEW05SYNycFixg0d9WRFE/SzuXFzQpkGLvjvw6CGMPDjWwzSu3cZIPZpmrRW3SMG5DD0NTqI/cT17G0uRW6v5xPFqYXuPkdpxh
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=dsrfxofS0-3d_g-25oEA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeDDQWU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 12:22:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50806 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbeDDQWS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 12:22:18 -0400
X-Google-Smtp-Source: AIpwx49gLdbCVs5oQUu4BaNvxwZr13FVKXhycA1kn4GqrnJJpAcybsk7JvjRuWjyYbhfyV2Y8RDaYHqz9xJI7p0Yw1o=
MIME-Version: 1.0
References: <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
 <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
 <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
 <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
 <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
 <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
 <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
 <24353.1522848817@warthog.procyon.org.uk> <20180404135251.GD16242@thunk.org>
In-Reply-To: <20180404135251.GD16242@thunk.org>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 04 Apr 2018 16:22:06 +0000
Message-ID: <CACdnJuuGRRUt-a3i89o906ka3RDOhs+_7tz_G8LTG8Jc0DXAyQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: tytso@mit.edu, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        luto@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        jmorris@namei.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
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

On Wed, Apr 4, 2018 at 6:52 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:

> On Wed, Apr 04, 2018 at 02:33:37PM +0100, David Howells wrote:
> > Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > > Whoa.  Why doesn't lockdown prevent kexec?  Put another away, why
> > > isn't this a problem for people who are fearful that Linux could be
> > > used as part of a Windows boot virus in a Secure UEFI context?
> >
> > Lockdown mode restricts kexec to booting an authorised image (where the
> > authorisation may be by signature or by IMA).

> If that's true, then Matthew's assertion that lockdown w/o secure boot
> is insecure goes away, no?

If you don't have secure boot then an attacker with root can modify your
bootloader or kernel, and on next boot lockdown can be silently disabled.
