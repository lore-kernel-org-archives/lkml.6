Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-163741-1522849991-2-8099488711266686959
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522849990; b=t7ItSqIYQTnFWqKjiu34Wu4MAzdy9Ex4e7qatHGWF0k7H1M1NU
    65SO5V5V6RVw0NKYV/n8GYjsttKEXgQvjCGVlc1TeROSFh1XX+EQS513KAl5f2hi
    Wac7GozXjnSi+4bNp4HoNuefSfZZNMOIQrv90LHZyDXsUSNYTK53JKNI7eoOIB4h
    9g6QGhGarWGuDsJLeKXqbfQ7dzm8MWENA+3egz1GlsuF3GgZVx2skQItA8rVxvXu
    /Iqgb3z6jmk+3qrXES6pWMWKU06NmRCZiQC/IliKz3RG2ud9tdGG+xBov65T8E33
    2Ylz/kK8Ths2Orqjib/yUxXU9vpsyNAzbqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522849990; bh=3If9g2XgHou7+jTISwf+G18lxmBJwR
    bqmN/9uMPJqAg=; b=AUIFd2xD50uOrzStx0S6KHheNB/C5i+Tja9NsvplxwZJtO
    wdgOCshz/jtyrdJPr6IKAUz2tTQn3p2s+jyqVJ3+HmQNx7wby0YRfkqpMCaOmBqQ
    MmfZqsAl1rVZ6rJyLamx+Qkg5uKueExCAToGDVM5q9wvGkx5iGpzGRaITEsvo/Xr
    XyOtaOxzBhIeSwBK3adHR0KIx6ureFe4LX+cvgUtvUEJ9C40tUnVDP2xBRqbuJSy
    wxsxWZvHzyRG3oXGOF+JKeKw8rgic4RkZgGdAjGNcCFJ75pWv42j2V2rpxbiwTas
    ciMXd8bz0POfjpsGB62MHbrphdN9w06JmR87b3Tw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=d24EDXDu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=d24EDXDu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIAp7q82lG6oO8CUhwMhliQuRiH/9XpZMOCqpmaUUXANNcFhnYMlLRhPiaVlE9rYGE+XLrcc3QynGquH5h4TPlsBI4hY37AALC4LR5v1ZIqk22Yz1Hyf
    KkkAmnaFfyfnLl8DGeXHm9O5FCUf+Lq4l6KbSpX9OSszTMf6SCI/UmU8I4Ilu5Q5NtUyyVhvV1ayO0m1tRLqLDuv7rUiHaEuya+MPjiQRJNxafWFlTWG4TGl
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=zTFvAVEp7HZA2Vjv2NcA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeDDNxA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 09:53:00 -0400
Received: from imap.thunk.org ([74.207.234.97]:60532 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbeDDNw6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Apr 2018 09:52:58 -0400
Date: Wed, 4 Apr 2018 09:52:51 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: David Howells <dhowells@redhat.com>
Cc: Matthew Garrett <mjg59@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        luto@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        jmorris@namei.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
Message-ID: <20180404135251.GD16242@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, luto@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
 <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
 <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
 <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
 <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
 <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
 <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
 <24353.1522848817@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24353.1522848817@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 02:33:37PM +0100, David Howells wrote:
> Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 
> > Whoa.  Why doesn't lockdown prevent kexec?  Put another away, why
> > isn't this a problem for people who are fearful that Linux could be
> > used as part of a Windows boot virus in a Secure UEFI context?
> 
> Lockdown mode restricts kexec to booting an authorised image (where the
> authorisation may be by signature or by IMA).

If that's true, then Matthew's assertion that lockdown w/o secure boot
is insecure goes away, no?

							- Ted
