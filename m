Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-470151-1522858860-2-17925299290883518756
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
    1522858860; b=JUy9aGepXYsi3xlO8IBxXaEWsjfAatCyyb5msDl2uKI/7Rri2G
    Px6zMgobVpXdPmCdaqsa/mJdBLNyfGnwbYln2hShWuFsytE8hRfwkHDlV+3ue9Wk
    V9Pxf4SvPgwFdTGxAxogzuzs14w+BCmdDMRi8Fam5EGn0q0kXvPJwFifqr/ocITU
    2KQnqc246qRZKIbUOYHHiiU6RmTf/R7RHNlNXGboMGwpP0BO13OHhY+CFpXh7k4p
    eO6Rjh26fq6RxlKuYtIluOTbRvwv8dPJax9z/KCB3vMFaSmKGaNnfyMTSJA/HJVw
    bOHnzKlUFsSSs2pjgf3SEPmQ4IKuCGvFx7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:content-type:sender:list-id; s=fm2;
    t=1522858860; bh=jNtwkQa0aT4RO0KEH78+oC378Emr1982p1fnNJjgfiE=; b=
    qGpeYPnvDgS5ihPyCCYfIFIc2cLmF1+fhr4wmtaucMHMdNlQukkYh96sw9x1bGFQ
    k/RTY79RX1TT4AAkfElba5DJMv8NNFrMJDIED68eIg/3CNpo+U6YnO2LbFMaCUqb
    E6+l6vNRqq1HDx37qz6lUzNvd2eS0Kk3dObUe0CR7vJtlJb+pYy3MHdgcyt0pFnu
    cdYQFuZlU6AtM4drh3q3tcnvqjmw8TkEGelz4WYIIyC4Br1pocTWSKEnwoSRFjux
    2pWAGovFwPqaiE6Rk9/OSF9X40zFXPlJVpWbVqvdOQPF0jcL8ATOO08OrGop+KlK
    LHOygoc6rSruQKoikJY2JA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=udk/+daQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nbCv8vYJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=udk/+daQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nbCv8vYJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEubszubWyBaEac7WFztFN8+udazITop3gGWorlw20BQgFtiiqo/Ev8F1Jf4Ub2OjVAIKJ+zUlCIQnzabQUHykttV0ipfR3yhUJ5lcQLSB3G0fQQ+MQh
    c3/fYtQhVlsCWO74xWg0SsW6jlMKiCDdtSZVoB/mVpkThq7rEoaDqW7lWZq6duQbSufrYVkxBHzg20IVCidBZy6AOr43gDRDC1ZaYHi5XOEyreTLLazmAQrh
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=BoNv7qHuTjCj7_PzGN0A:9 a=7IWdw6aFAX7hGTmX:21
    a=4I91lv15M3YWr13U:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeDDQU5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 12:20:57 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35277 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbeDDQUz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 12:20:55 -0400
X-Google-Smtp-Source: AIpwx4976anfY+FyARkXgVVBBt2n/3ttmrhGzCHBaQLonJh1Qq949sTaeo2TceAJhC0I/KK6PTuE2vDDpgz0q1l/AtM=
MIME-Version: 1.0
References: <CACdnJuvFqXGLsAv1Km3MmdssHBfuH5-C_vG3A4eq4Yuj0HhFBA@mail.gmail.com>
 <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
 <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
 <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
 <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
 <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
 <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
 <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com> <20180404125743.GB16242@thunk.org>
In-Reply-To: <20180404125743.GB16242@thunk.org>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 04 Apr 2018 16:20:43 +0000
Message-ID: <CACdnJutKZL-48Ua=GYgU2vs38N5MjovP5+ENUNzVpmpi4-QFTQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: tytso@mit.edu, Linus Torvalds <torvalds@linux-foundation.org>,
        luto@kernel.org, David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
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

On Wed, Apr 4, 2018 at 5:57 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:

> On Wed, Apr 04, 2018 at 04:30:18AM +0000, Matthew Garrett wrote:
> > What I'm afraid of is this turning into a "security" feature that ends
up
> > being circumvented in most scenarios where it's currently deployed - eg,
> > module signatures are mostly worthless in the non-lockdown case because
you
> > can just grab the sig_enforce symbol address and then kexec a preamble
that
> > flips it back to N regardless of the kernel config.

> Whoa.  Why doesn't lockdown prevent kexec?  Put another away, why
> isn't this a problem for people who are fearful that Linux could be
> used as part of a Windows boot virus in a Secure UEFI context?

It does - I was talking about the non-lockdown case. In the lockdown case
you can only kexec images you trust, so there's no problem. Red Hat have
been shipping a signed kdump image for years.
