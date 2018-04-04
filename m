Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-163741-1522848875-2-12050873472543667738
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
    1522848874; b=GpZ+tEsE69Oz45H9Jfz/ycDZOwOJvlrewgeDpQ/eTb3H6GNnEU
    WQ1S0nQxLE1y4ykf/pSvNRKvPzSZattiCWTj6Gxujz3VpRKnqO38WdXbwItKQ8MQ
    hjRLerQgCH+w59lFGHDo4H/8hC2F200Fnmlop5FsrdOhRYIDm08aFMO9ldLSIyIq
    JgJ1z+zlPM7bFQbwwrBi12N+zzJPYfIAW5R72WI6kMH2V23xwUU9+KrunKzSwHSo
    L4XS3wdJAayggGtldH/YHTTT7l8jAPgK3BEijiqsVjAmn4imPGxKRdB22A7edd4V
    SoLWzFoGfIwob2XGiHaLcBt05KILnzQLGwXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522848874; bh=p3P5Ec7ol3nSewpPVvanT5wMU2ni6T
    iO0OCvSskTAm8=; b=RxUaoGhB742BY3IC93OvXLmhWO+knBRIQNKX9BngyIDtbV
    PcwDpwDTSwVUONgUS4zDr/737NwrFdsGMxQgPQ1iNRp/eHqiQbBnYECD8q1uZCHr
    iGa6F6J9yHOOzMs9F1WH5xUwIYd1hCPD5GlvYVdli2SQE5tAFho4RnVKLrgJI+fY
    0HfhpbpFNE3dppkvOV5ds3vn1nukRJsjYT6img8DeXplVniRW2uacjGGBWGzbDVg
    kH6l9sk9phBciSWOF3A+zXY7bb7zozJNQlHOC0t+nss3fJ2w02Tc/VBVJ5F6z6XD
    tauoWJSBDBWavj7B3fhgy++wU/CPv79kd1vL3RTA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=l1ETzRQT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=l1ETzRQT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJSFBM0wK7Sxc16oFxEDIxXwUhvxPBEr61RhJ2BNOfRhiTit/IibAKWhA2qyQMXCyvKdnBvh7TK9CEP1GnQADe1MBKvLr203jZBxikeu2LkNnTKYJ34A
    ssRPUA16kncrUrIC9tObN1vb3ari2cQx5WgOKlAb1pAVJdsk+Q9I9RE4J+Ut7LmI2KYrd5RvEN3ByDe8tnSxhIyv6HH9WZ8d25b1oU/LNBJDl4hQ46mdys9N
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=PoU8W4VC0bJmwltSvzUA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeDDNeT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 09:34:19 -0400
Received: from imap.thunk.org ([74.207.234.97]:60442 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750890AbeDDNeS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Apr 2018 09:34:18 -0400
Date: Wed, 4 Apr 2018 09:34:11 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Garrett <mjg59@google.com>,
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
Message-ID: <20180404133411.GC16242@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, luto@kernel.org,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
 <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
 <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
 <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
 <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
 <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
 <20180404125743.GB16242@thunk.org>
 <20180404130233.GA24008@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404130233.GA24008@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 03:02:33PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 04, 2018 at 08:57:43AM -0400, Theodore Y. Ts'o wrote:
> > On Wed, Apr 04, 2018 at 04:30:18AM +0000, Matthew Garrett wrote:
> > > What I'm afraid of is this turning into a "security" feature that ends up
> > > being circumvented in most scenarios where it's currently deployed - eg,
> > > module signatures are mostly worthless in the non-lockdown case because you
> > > can just grab the sig_enforce symbol address and then kexec a preamble that
> > > flips it back to N regardless of the kernel config.
> > 
> > Whoa.  Why doesn't lockdown prevent kexec?  Put another away, why
> > isn't this a problem for people who are fearful that Linux could be
> > used as part of a Windows boot virus in a Secure UEFI context?
> 
> Because no one is afraid of that :)

Well, this is the excuse used by Windows.  Some more cynical people
believe it's really an anti-competitvie thing, but we should
acknowledge this is what is causing the fear that some distros have
that their UEFI secure boot certs will be revoked by Microsoft if they
don't have this crazy lockdown enforcement for UEFI Secure Boot.

So how about this as a compromise.  We can have a config option for
the behavior that those distros (and Matthew) want, and we can have
separate config options that turn things on in what others would say
is a more rational way.

And I would all be for having the Kconfig description says, "This
config option is only needed by distros who are fearful of Microsoft
revoking their UEFI secure boot certificate."

						- Ted
