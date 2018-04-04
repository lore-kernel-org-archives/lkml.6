Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-168483-1522848572-2-11974181821528423796
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='ISO-8859-15'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522848571; b=EsjvnqHnSLvLUD8YFsZCG80gPrTvthoYHdfNMlUhzUD8VcVigc
    JckeIDRj/KfjJJw0yAW9t+z3CQOyldUylNcWARMW2Co7BL3eaC1+9+9CsH69M2Pc
    lOcxDAf+5bXlzWcYM93zIrnaa1/Gg1os2lT6I0fuqfjx5SJPOrkNdyWnFLO+klDv
    90KHECMjFSURxRqDK1Xcx+wCsLTSzPdGCGO+HYW63IyQIXPA71QYAzq09BvzWFiX
    AgiNlotfddCGjAXbX4AEmeyeXXbRnQtrWqgRDdRXGczwj0NU/wn/8Mno55yyvKxW
    jEvVCF6rdWZhIpm+zHycx8wLSF6XRJeEC0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522848571;
    bh=ygqTZ7EOzqIZU+Gz7dHdAObTQRyAVihDr0GCfAQbBT0=; b=EneCVpaWDPio
    YBI1rfQMpX6U0wf3ZHL3nU/SIXpYOU68/73mooJvcJcDOl5o3GT+/RXEqTU3WkP6
    NvoMiU164y3jMJfRV4s0fdR0P0lBezLY8kD/HnPbrF4i6Xzq85ldrM0wPbln9BvQ
    qfyOXdtYxx2EYpGg1vPdFPRqYHJo8wcGWpmGklq/80lveRletuJNnB6ZQaGIlfDB
    1Axv4pOxQEZCYO7xtNYHGEjoMBPgWUeUXJYGozHHZsVUOCeBWRdTTHyGfaKcwlI3
    qFEEbmlDPXAP5MuZPRXe8jALERyz3ZK7tB7QrS3rLcdZ0vlzpgB0SCfgaS557Pkz
    ggqt502CqQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDnt0wJYq8JyBfFrGKlLyqJrNdRJCxLVqkWk/cqJMsn+HTvtDMQwJrb1ONOG8n08ukVA3HeTSvd4A5ge22yzK7gYV9M3DPzHF9CS0aJh3tZX8SwqLS1Q
    oaxdzh9LQcnf2wuX+5NlPTDpqLQc9c5dGsSvAF1YAv+SjecKIQY0fPsvzdZFUBiF0DlF0JhpCnhPTnUZFpz9VTZDAT0Vp0AEvOdPG6hMxKjQPK/3N6ZBNHot
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Q9fys5e9bTEA:10 a=9ELdFX7kIBcA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=SmNLlxAS43CRxQhf42gA:9 a=PUjeQqilurYA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeDDN3a (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 09:29:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:57733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750890AbeDDN32 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Apr 2018 09:29:28 -0400
Message-ID: <1522848543.30109.3.camel@gmx.de>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
From: Mike Galbraith <efault@gmx.de>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Garrett <mjg59@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, luto@kernel.org,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Date: Wed, 04 Apr 2018 15:29:03 +0200
In-Reply-To: <20180404125743.GB16242@thunk.org>
References: <CACdnJuvFqXGLsAv1Km3MmdssHBfuH5-C_vG3A4eq4Yuj0HhFBA@mail.gmail.com>
         <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
         <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
         <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
         <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
         <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
         <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
         <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
         <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
         <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
         <20180404125743.GB16242@thunk.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Qbe3Wk5lzvfzj44sUxQpaWNNbw2UugbIdlt5bt4k/uiI+xtOuGF
 Ga7Wk96MRLvxK3D9Q2RH3cEu8emEerZMoXsHhqCeXjVLWvcBKbDgzi/iBhOwqIfzKDke/aD
 Ny0PLJNrX74erPUtc+D+TTsntESY1T8oiqo+97hT6wM0Mny4fJhg5Wm/MWeq3SJ4dmG+dqt
 0vuo4Yz57WI5DeGjiMwtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/z8YZcvgE8c=:JsoCnGlXBlH130FOQs4iHY
 5Gca6UkPS/Zf3UGQ3nfTP/jDbSbp4pHvX7y2CENsa+Wun6W2fbaBVJ+iZvoDkISDufQ9hkrog
 qtIIUXQ+MAkBArtFuMiFL0BtF/fmMoa1qS7B/NnwkPd2ey4928gJklxFjlEn8YaTBUFIR1EC2
 7Q1nO9TKHTTcI4soxOBM5Ut3/uyGks/tqk5SMEuAmjAZP6kC4JpgyhApPSkh3F8UC84+RV7pM
 GrDZxlSPycAZPEHJNFesDQci2QGiEnFMXRBobFcGJ39VGCXRPeS3O/ZTkphL57Od3nwB3nFTs
 pdZ59QxmhX/ieVs0q3aFArdJG97EXmlzB6YQy1WLyXitDj1uN+L2kFzfgVrkl0yqBNmZ8J7KF
 Bb8JE0K4Cd24QOgBRZm/mILYH1MjkQ29mUJMFScdLdDPa6b27KB8uLkI/M5AcZlQMH7sqoQy5
 UVCmM9ld3oNuTHaqIkDrs/799CRn/a88Jwkhry5wGhacEbCFAruBWSQyjyau+xoM18dudUDHt
 7PA53tpAGRKWTXg+GCwAnuCMeOMlQqxo9rz4rJ/SaOwF66TtqRwYOlmkiIdN65Iyk5hWmSEAu
 8JGayqCCkBNLZaA0CA3Uaov0cu5qy3RfJfd0Rhm6/tzzjICjGtR2hB/LBBZoNeWzBkmXSGa19
 meRxfdqcwchavrJ2JcBZ4mgXOQyAlSsF6LVTG04oQhSXIgdxUB9ZSrBwT/L8OLUxznJOU9xVC
 8o4PAkc+WPm6IviShoMJY+gMUeItnxmPpIeJbgXPrnf8QolxjeDb8VVJQN8BPEc35FICqSa44
 maTkicSJuInrTbcCDHIYfUzleMRG5+LcdICP7qYEHsQ6uijJ1k=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-04 at 08:57 -0400, Theodore Y. Ts'o wrote:
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
> 
> If lockdown simply included a requirement for a signed kernel for
> kexec --- and if kernel signing aren't available, to simply not alow
> kexec, wouldn't that take care of this case?
> 
> This wouldn't even be all that much of a burden for non-distro users
> with lockdown enabled, since in my experience outside of enterprise
> and data center use cases, kexec isn't used...

Lots of folks use kdump, ergo kexec.

	-Mike
