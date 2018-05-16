Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-394842-1526481533-2-16862159057201070844
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526481533; b=na/zvy4a3FkxvXpsHlSWTw+tfDZPONdRw/lpoDHWlootnaasJk
    bAGGlhLaWwp5U31Bn5AOcC9eKYYH6UxoGK+gDGiaw3dPzGbcyUYiR1HwEvY03ncM
    DCQdboyPb9Uj3UAndYiHKxtQ72TMVGk6UBpvfmSlTR85Q4Ff/bHt/rsI5T6QOU4W
    xe2/l1vlZUkEqalgWWXwLfNUNDnfMJzSUX2Mu/WWomJRAQYcyQC+E/rKs/CS60Lf
    seEJX0A7hIR8zfZ1NDQh7/mhbesMAA5e7CY91NFcdqsgOwUnPrnChnPrAgXBYPH9
    oeyK6U8nTeIhIyWAtpuE3ad7FnJm1/a7RemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526481533;
    bh=eJbLCAjO5mprUpN8XMTrI1c9Cmyy01d//pxbT8Oekkc=; b=ibRVYM2t6czZ
    N49O7RoatQCfZ5ecQ9Fhs1UhRlVXv4y/m71PYlUw9v+HFbUwb85nTyD/IG9WG148
    hv+Kem0LGRgNGQRfvudJi0U0G2mjFhTLMpa+jSLsHdCik0gQtTYTddBflW8SOfNt
    edVbrSz7s+K8vBKqqOOrC/ZKvuOlpcoP+uLvr2yQLgUWBEsdromKCU+LKin4Iz8q
    gn7eYEUAuehoMlflZp40DSwnTjNAmAclP4OPgzDyOHOVJ/ZIPEikDFKHyIKrWIIE
    S+e6jNwYMA5uoRGECSg8WacD62SnnGHALVIJDt8t28PVirq8bIJNjkV1p1Z8DWmr
    YZsGqfmu3w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codethink.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codethink.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCjLknNRReWL//39qpjy3KMBqvtUBx1NhkuHO9qsGIG44yQiJnBhf4j+UhlEIwaF8YAfGpCKa9Y4CVZwq46GnX84LSpfZs1nlUNTnfx2K4us2pW3js6G
    momgWKbvHS39vIKDHxuwvYVsnfpPU8Sllc9ioK+mzZyEorDxb5GB0CI/yCwCJ82CeXfRKOoUMZi8spZ7CAfJcKnFJ6CtpfGGO9sIa1HXKFQnkBbewzBxSZmi
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=cfDla5lDEjkxF2rELVYA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeEPOil (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 10:38:41 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:44463 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbeEPOik (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 May 2018 10:38:40 -0400
Message-ID: <1526481515.9159.127.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 164/190] futex: Remove requirement for lock_page()
 in get_futex_key()
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, Chris Mason <clm@fb.com>,
        Darren Hart <dvhart@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        dave@stgolabs.net, Ingo Molnar <mingo@kernel.org>,
        Chenbo Feng <fengc@google.com>
Date: Wed, 16 May 2018 15:38:35 +0100
In-Reply-To: <20180411183602.117363832@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
         <20180411183602.117363832@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-11 at 20:36 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Mel Gorman <mgorman@suse.de>
> 
> commit 65d8fc777f6dcfee12785c057a6b57f679641c90 upstream.
[...]

This causes regressions, fixed upstream by:

commit 077fa7aed17de5022e44bf07dbaf732078b7b5b2
Author: Mel Gorman <mgorman@suse.de>
Date:   Wed Jun 8 14:25:22 2016 +0100

    futex: Calculate the futex key based on a tail page for file-based futexes

commit 48fb6f4db940e92cfb16cd878cddd59ea6120d06
Author: Mel Gorman <mgorman@suse.de>
Date:   Wed Aug 9 08:27:11 2017 +0100

    futex: Remove unnecessary warning from get_futex_key

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
