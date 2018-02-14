Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4007663-1518648350-2-9675032368657712248
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518648350; b=ZlFkemmFtca7hAitCD6SdAo2pmt6vICI3r/eFBjuWbgr+ih
    +XmKeiG/62tNgnQwsKhWZ/kfG2iG5faBanJNjbtC8q7kEaB/xS+FXjJd1hdsf2l4
    6gfPqPjsLfl/diQkUxLm8MolliPopRkBH9acxnTfjUXQhe4KQO8qY6ygit80tgb3
    dPuro+pYIrAzll1H+z+laUYW4WWX4EKnDBfj+sWKDHV90l4J/Q0qicCv1C2Djj39
    XiL8N6xQIrOyLqAGID9dgfvDKvOyFqPFD/KYsueiSLrktY7+6eHxV9JnjmSfZKTa
    49JezhUF9jWMEqcCfc4+NNd1wh26FBC9a/LeKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518648350; bh=i/a/UKTDUBP9wma6Kt2U8f+OOa
    9jlCdRO4T6iU7yAHk=; b=bgQnnhOTFfhe8jis6Scq/Ptf1AYA/9eBUhtKBjc4Ol
    JW33JFxQTYJTw8jOg56/VJuDEf70n3b5+cT6cIGHMnZlyuisNvRFQR11KUnILF1X
    uRsJ9PaZOSQVoc5HJy/1IrlLBiPlhRqHX/CSF6knn2nI5cJNTz4CoBNHWaqZqd10
    DhjK462fjjmQKv6l3fZHkIHaPo1nPtSbX/iiV9V6cHpZBWxJHeSxBvmu3KMPsobb
    nTeHZombuikEPTTuYjihvrEGpkMiELbaBO67RXnMQpoEPf8bm1TBxmgRYNX5dI67
    I+zrnf3d0XZ2+jPl733TzWbyA4J7lV0+Kg12PNlTleYQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031933AbeBNWp1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 17:45:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031527AbeBNWp0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 14 Feb 2018 17:45:26 -0500
Date: Wed, 14 Feb 2018 16:45:25 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: objtool warnings on 4.14-stable/gcc-7.3.0
Message-ID: <20180214224525.esxiqt7yjjjpzyz4@treble>
References: <CAK8P3a32XycubV_d8JpxLAD3LEB7LBdhMAgTfqsWpPNbmzok3g@mail.gmail.com>
 <20180214222412.arg77l6vjpkje6pj@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180214222412.arg77l6vjpkje6pj@treble>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 04:24:12PM -0600, Josh Poimboeuf wrote:
> On Wed, Feb 14, 2018 at 04:11:15PM +0100, Arnd Bergmann wrote:
> > Hi Josh,
> > 
> > I recently did some randconfig testing with a plain 4.14-stable kernel
> > and gcc-7.3.0, and came across three distinct objtool warnings:
> > 
> > drivers/misc/lkdtm_bugs.o: warning: objtool:
> > lkdtm_CORRUPT_LIST_ADD()+0x15: return with modified stack frame

While this is probably an objtool bug, the code is very odd:

00000000000001a8 <lkdtm_CORRUPT_LIST_ADD>:
 1a8:   e8 00 00 00 00          callq  1ad <lkdtm_CORRUPT_LIST_ADD+0x5>
                        1a9: R_X86_64_PC32      __fentry__-0x4
 1ad:   55                      push   %rbp
 1ae:   48 89 e5                mov    %rsp,%rbp
 1b1:   48 83 e4 f0             and    $0xfffffffffffffff0,%rsp
 1b5:   48 83 ec 20             sub    $0x20,%rsp
 1b9:   48 89 ec                mov    %rbp,%rsp
 1bc:   5d                      pop    %rbp
 1bd:   c3                      retq

The function just allocates/aligns its stack space and then returns.  It
seems like GCC was too smart for its own good here, as the function
doesn't test what it's supposed to.  Can you share the config for this
one?

> > crypto/asymmetric_keys/x509_cert_parser.o: warning: objtool:
> > x509_note_pkey_algo()+0xa4: sibling call from callable instruction
> > with modified stack frame

>From a quick glance, this looks like yet another switch statement
detection issue.  I'll need to dig into it more (unless PeterZ, my shiny
new co-maintainer, wants to take a look!)

-- 
Josh
