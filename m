Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1793992-1526548016-2-8295848262596232277
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526548016; b=ejeqOmQGgVY5IPABSRXlmnH6DC16R/AhAUjDdtQ//jHynswr0+
    ROmtL9Vrcm5TtnpDDaXcp/Pi7tbMl/4EBQBY+49XYbK3XgbrigGmTUR35FtnivSO
    s3ZhOXe+j165OoUPbVKc5y2wxC+tkeh23ux02Iw9T9QSFMD8sUDZodEMuItpmGnZ
    sVSNkPUJGyzyjmZsRwMyAOGPCRmCjZQ7ZBNl24eggzeleB5y7kv4I+RHQHsUbtAc
    HIzdcCFMumXvRLE/knVa7MEJN5WjmGUsJ/kzRKz9UhphGqwgOm01JqEGQqb32ue8
    OLBUccaYFbw2cSsXuQjrLymcoRNc2SL9OUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526548016; bh=YoGInNoWs1l
    N2dZhcZWTkAZ/SFfEK+tJ38CzGXDmCwc=; b=ZfeMepnov6u8tiUqDxIVNl3Zw8C
    4Tma9Z8BTI8ABWIWeirraAbXhygyZ3e7q3qiApKFb3r97pinAJa/VcO0wKzzV9Qj
    5AkZAjoWgzr1n8wTNcVo1WVG8cUWQ6ROua7Vubc/iJvo7Dyom+Xsvc8EEB7ZRXOd
    PXhoyTtnCVLDiA3Vanv5VWb/Up1ZjjCUfK1tn9963MBUWnBbmXXbCZpYG1d9M5ov
    xJMrFc6mO1bxJhvvIUUyHeAYFvE2csMJUxPFrsWRMPvj2Aqm1Qscuasq+UjFTtyp
    jsCEkfVHVZpOw3jq3Db3MNCdNWkOHFnZnSu8ywzXxsK4QbgeBNX6y29C6CQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=DtvfTxHY x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=DtvfTxHY x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAZGSsHJxcx96NanqyW7fVVuQHS5opM4efP4hWxPIECgLooVqZnVHElegEmexnnlk5RC84qcs4cocrMXvPDlcg0ktxfqmH2BE6dxYvQPME03uOScQZ+5
    WSzkbHUDPlgv/Eq05u5O/5IV9m7W4MLrYxM1406pZMbhk/+FRxG/NVAmd7AnVPcwqcJIhKdrXNs+r8gWxzG9/3i7PEKWBRZ16wnys2gLYfN0QAP58rGAVhho
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=XJ26XowO2UBODmLoVwgA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeEQJGU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 05:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeEQJGP (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 17 May 2018 05:06:15 -0400
Date: Thu, 17 May 2018 11:05:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, Chris Mason <clm@fb.com>,
        Darren Hart <dvhart@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        dave@stgolabs.net, Ingo Molnar <mingo@kernel.org>,
        Chenbo Feng <fengc@google.com>
Subject: Re: [PATCH 4.4 164/190] futex: Remove requirement for lock_page() in
 get_futex_key()
Message-ID: <20180517090557.GG25318@kroah.com>
References: <20180411183550.114495991@linuxfoundation.org>
 <20180411183602.117363832@linuxfoundation.org>
 <1526481515.9159.127.camel@codethink.co.uk>
 <1526481745.9159.128.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526481745.9159.128.camel@codethink.co.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 03:42:25PM +0100, Ben Hutchings wrote:
> On Wed, 2018-05-16 at 15:38 +0100, Ben Hutchings wrote:
> > On Wed, 2018-04-11 at 20:36 +0200, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Mel Gorman <mgorman@suse.de>
> > > 
> > > commit 65d8fc777f6dcfee12785c057a6b57f679641c90 upstream.
> > 
> > [...]
> > 
> > This causes regressions, fixed upstream by:
> > 
> > commit 077fa7aed17de5022e44bf07dbaf732078b7b5b2
> > Author: Mel Gorman <mgorman@suse.de>
> > Date:   Wed Jun 8 14:25:22 2016 +0100
> > 
> >     futex: Calculate the futex key based on a tail page for file-based futexes
> 
> Actually I think this backport to 4.4 incorporated the fix above, but
> the one below still looks applicable.
> 
> Ben.
> 
> > commit 48fb6f4db940e92cfb16cd878cddd59ea6120d06
> > Author: Mel Gorman <mgorman@suse.de>
> > Date:   Wed Aug 9 08:27:11 2017 +0100
> > 
> >     futex: Remove unnecessary warning from get_futex_key

Thanks, I missed that one, now queued up.

greg k-h
