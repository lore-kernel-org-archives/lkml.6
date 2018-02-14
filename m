Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4007663-1518647057-5-1124199186337915163
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
    t=1518647057; b=GERA/LGv9relCJpqhFSfiZSPjFzRIyQaSwSjEt9xP+WgVPP
    Fwpu2axAJ8wXD4en5dtEDvbvMWyv6xh6I3WQmiwoEVhsxR/VtGL9tMsEPj6GP7vb
    lP1yk71sCFi3w4R5AVpC4dZgHwd7dNqoEbuYVTd0K3H/Jy0w3jOZJFegoDZUEJwT
    cNM/mZ63gFFSg5Z8YaZNtZ4CZMR9WsdrWkrDdmDLm5JvQaxwpYQAZqc9QHIcWFiQ
    l4z+h+0s/Y79AeTcppveU3Ls47FQxJm7w9lO2fj6Mm6v524ZZKXDdY7pX2M5fX7N
    D0DlZsMMEcEsEeTHE7ao2HUMYTACKtnRP199i8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518647057; bh=9ogMfeWn+d6OC0lq+77WBqIktO
    9+a0MOybBVcNo6LAo=; b=KCMwlxLVGMaR5GtuKeDA7t+GgG1XxAPEMgU4zqxKnm
    p+bMxxZVrVBFEVWtbZEYtzIB0vgcRMo/URtJWiAbUQnEB3HW3YcsPDZLrL00nU1a
    Yfy8cm2tjy2RyAHMgJzdwPw65QJBgTEEL8TYEwayfrbx8tF766yN9WNEGHAqLoQC
    B06CdqUiXeqpUa73ROUN4vfGDVtOYD493XnIeiaA2kLD4NrgYEgAbXUkwTUMGRpG
    LqzPJQ3vQPECOHQZKAfnssEZ0z//LdrekmPa1xRJZsM3TZ2IgoOW0BOO9a+IulHA
    Xc/KZfFFNLjtlvSgR0FBVLqwilbEhRlRJ1zJ69MKHAKw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031527AbeBNWYO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 17:24:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031691AbeBNWYN (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 14 Feb 2018 17:24:13 -0500
Date: Wed, 14 Feb 2018 16:24:12 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: objtool warnings on 4.14-stable/gcc-7.3.0
Message-ID: <20180214222412.arg77l6vjpkje6pj@treble>
References: <CAK8P3a32XycubV_d8JpxLAD3LEB7LBdhMAgTfqsWpPNbmzok3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a32XycubV_d8JpxLAD3LEB7LBdhMAgTfqsWpPNbmzok3g@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 04:11:15PM +0100, Arnd Bergmann wrote:
> Hi Josh,
> 
> I recently did some randconfig testing with a plain 4.14-stable kernel
> and gcc-7.3.0, and came across three distinct objtool warnings:
> 
> drivers/misc/lkdtm_bugs.o: warning: objtool:
> lkdtm_CORRUPT_LIST_ADD()+0x15: return with modified stack frame
> 
> crypto/asymmetric_keys/x509_cert_parser.o: warning: objtool:
> x509_note_pkey_algo()+0xa4: sibling call from callable instruction
> with modified stack frame
> 
> drivers/infiniband/hw/bnxt_re/qplib_fp.o: warning: objtool:
> bnxt_qplib_poll_cq()+0x106: sibling call from callable instruction
> with modified stack frame
> 
> It's likely that this is the complete set at the moment, I saw each
> one multiple times,
> but did not see any others. I'll reply with the respective object
> files for your reference,
> in case these are so far unknown to you. There are only a handful of randconfig
> warnings we see overall in the kernel these days (at least on x86 and arm64), so
> even if they are false-positive, it would be great to get rid of the
> output so we can
> do randconfig testing on 4.14.y and treat any output from 'make -s' as
> a regression.
> I did not check

The third one has been fixed upstream with

  99ce7962d52d ("objtool: Fix switch-table detection")

... so we should put that one into stable.

I don't recall seeing the other two, I'll look into them.

> With gcc-8, things are looking very differently, and we still get an
> endless supply of
> similar warnings.

Yeah, I haven't forgotten about GCC 8, it just fell off my plate thanks
to spectre/meltdown.  It's still on my TODO list...

-- 
Josh
