Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-51756-1522846959-2-8482434959546145132
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522846959; b=jA288nHGPYe9xrKqBtFWcbeSPL/9tS3RClgWwlHtbO5qCJFKBa
    Sr9w6sT0kvNIaCy6d75zt6sDXCZ2/FY4CHoB3jtGMQsI4j3U/b7hbBFJR6gxNcC3
    /vjElNY6tlyOGfqMCsoBtwMitqnqX1o48YIB+TMShk4YpUtTer+pLv4K91egEP3L
    CRJFhqpWXOd7CNPBuLKSwoVV8RJDgfzTUtL0jz0MmlUj2DCpUULY0ajgL3qLL9bA
    Wbx6Si39WKr55XjAX3zJWhNtiWTEHsGoIOCs/pIVjds1Sdmkj9k9k5jq4Y836tid
    psXbhZhXdb4lA+z1HESGKsoYmVUBbTXSVOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522846959; bh=bFHFD7pyoSEoYzbtpfZDYMbpJsnYgn
    jCY/BGtz2MI3U=; b=Htm1F4JhfBGGuIKy3ejzVrYPmrYhvKPMK2yLjMGlRZc63x
    ++PNzHNrujEMq3moXUU6dnZ4nE4HhRGMMISPIa1pxTkQVurABhUqKjm2uBpK1/8T
    969FVYEyXwqZjcIkUIutXhkYHLecDpgdusshg0mprn6o4f1fq2/kaFZQxg70S67n
    7WMrTtccvCjcv/ch+TxxvXJaaOSOMyE1WyOWmrnvzrVkjPAMZBYHgTJ4Qw3nW43t
    WPo6i38JP7sHKeiiVHSBsJfy1ihMUM5RVFXJ9OAqOnLeV0d16DlTWh4T/z+mtEV4
    U8HmkLcemCrukAXYrHPjDzPRSdJeHSBHkeO7ivJw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBTMYHZ88cddYinodzjxTY3Pb33ecSpeAaQYTkGPGezx00ojAk7VCp0f5fw13mwhmxXbWNVWIxJwE+u4wE5h2m2a1l+m/PoDrXs1+kf4XgBDVXjTJLCp
    WBDrfVhXfr6AXYn/X1ypDW5JPbEzcsqcApK458fUZ9LdRkU2ukZNXcHmKL22DxZUB7M6T36z4pTYhFTKpDrBU+ggNuVILC7qzmePCoRCLyTHfNwrgfQQwKsq
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=WjtkPYvqeJBMkjCbGiAA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeDDNCg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 09:02:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40562 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDDNCf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 09:02:35 -0400
Date: Wed, 4 Apr 2018 15:02:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        luto@kernel.org, David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
Message-ID: <20180404130233.GA24008@kroah.com>
References: <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
 <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
 <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
 <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
 <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
 <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
 <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
 <20180404125743.GB16242@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404125743.GB16242@thunk.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 08:57:43AM -0400, Theodore Y. Ts'o wrote:
> On Wed, Apr 04, 2018 at 04:30:18AM +0000, Matthew Garrett wrote:
> > What I'm afraid of is this turning into a "security" feature that ends up
> > being circumvented in most scenarios where it's currently deployed - eg,
> > module signatures are mostly worthless in the non-lockdown case because you
> > can just grab the sig_enforce symbol address and then kexec a preamble that
> > flips it back to N regardless of the kernel config.
> 
> Whoa.  Why doesn't lockdown prevent kexec?  Put another away, why
> isn't this a problem for people who are fearful that Linux could be
> used as part of a Windows boot virus in a Secure UEFI context?

Because no one is afraid of that :)

greg k-h
