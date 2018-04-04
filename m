Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-227748-1522850263-2-4288020645685847246
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
    1522850263; b=nRXC5VJqDxvft8TtxZrnd0hTzS3Byd/BxI4DiJ2Nt4xvPnVW4P
    XsUYIP1bXAVVw65awx7WynOUAS+NLP35ljExPb4K2UdaSREpJPATaSOvnBU+JUBI
    E38HMc1rjXp+7UCuu4dZurjMcsGbE32Lu48buRBQ6KSI3jwgJ6J6q1dS5+VqU2Fw
    NARasu4k39ZKURjW7G5X3Gyrmgoxn1siZHEww9MjDJE7S6pHWZe5J5VxdXJ6e3dM
    m2cfR3bf0w0SJIVa1EAwZO8f9i4ALLWYvSAPS+5IApuh3XiwR54vhauVUDpfpXxP
    SCZ0EdQ9VJuPOl/KsvSytPM/hTY+2wlMTKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522850263; bh=EQ4QvWTarjlv6+JGtWZNIp6jHeLpuj
    8vE1QF0k2JgNA=; b=vlUUQGnXFEi29MtX6lifeQ0GgyzDRL7c/47QkxmOCaB75z
    aQ7mKT6Pn9cDApUrYD5g5QsyR4a2f90t11NK7KexcExR2DrKFESuHBpdOhcGVAgq
    nvE4CahnXqTLM1tW+TC6EfJAxzgM5P6+wYIVtMbt3fiFGtdG0hV7ds9mnrmvY/CP
    SffU58WoALR4p1/qCiQIgs7Rklvdcp0teB43C4WNQ3ELIl1LH0fVGJQh8WObItpQ
    39dsOFwYqAto/4bIDBWNFGvN3fpjC6XCaeF4YyVYwAiKzU2Bu3F0lixnuqMFyf5Y
    nj+rVBgwprh9gwNdRMWb/Wttyfn4auesj7ktgtvg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfFHDtsI0Xs83KfD+TquHeCruzPW+9+XBCobj0XITSUj6w2GwLk1RobXUCRO64oqLjgzEvWpY74up6iDXmhXrCKrs5K3sROG/dFuQ+wTaS1OAafIVz+Dg
    Jz/wuv8zapgqnipCZv8avReZJ2IqkX1KC0PnnF86Y8m151nG5Rn0VgxUZPNH7urFdsgbV5QKmgRqx6fTd+RMFHdgpNehudviDb6YPsV8uqvOBaxvjBv/kg6N
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=SfP4ZrG7tYHwAZka75oA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbeDDN5k (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 09:57:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDDN5j (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 09:57:39 -0400
Date: Wed, 4 Apr 2018 15:57:38 +0200
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
Message-ID: <20180404135738.GA17482@kroah.com>
References: <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
 <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
 <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
 <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
 <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
 <20180404125743.GB16242@thunk.org>
 <20180404130233.GA24008@kroah.com>
 <20180404133411.GC16242@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404133411.GC16242@thunk.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 09:34:11AM -0400, Theodore Y. Ts'o wrote:
> On Wed, Apr 04, 2018 at 03:02:33PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 04, 2018 at 08:57:43AM -0400, Theodore Y. Ts'o wrote:
> > > On Wed, Apr 04, 2018 at 04:30:18AM +0000, Matthew Garrett wrote:
> > > > What I'm afraid of is this turning into a "security" feature that ends up
> > > > being circumvented in most scenarios where it's currently deployed - eg,
> > > > module signatures are mostly worthless in the non-lockdown case because you
> > > > can just grab the sig_enforce symbol address and then kexec a preamble that
> > > > flips it back to N regardless of the kernel config.
> > > 
> > > Whoa.  Why doesn't lockdown prevent kexec?  Put another away, why
> > > isn't this a problem for people who are fearful that Linux could be
> > > used as part of a Windows boot virus in a Secure UEFI context?
> > 
> > Because no one is afraid of that :)
> 
> Well, this is the excuse used by Windows.

Really?  Every time I have tried to actually follow up on this
statement, it turns into an urban myth.  If you have proof of this,
please let me know, otherwise I am going to keep saying it is false.

> Some more cynical people
> believe it's really an anti-competitvie thing, but we should
> acknowledge this is what is causing the fear that some distros have
> that their UEFI secure boot certs will be revoked by Microsoft if they
> don't have this crazy lockdown enforcement for UEFI Secure Boot.

Unsubstantiated fear of relying on another company's signing key to
suddenly stop working is worrying.  But it's just that, fear, and not
anything that is actually true.  We have a working shim binary that is
signed, in use by all distros and other operating systems (community and
corporate).  To revoke that key now would be insane on a variety of
levels.

So let's stop playing the myth and fear card people, and focus on the
actual facts here.

> And I would all be for having the Kconfig description says, "This
> config option is only needed by distros who are fearful of Microsoft
> revoking their UEFI secure boot certificate."

Again, no fear please, facts only.

thanks,

greg k-h
