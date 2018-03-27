Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3150741-1522135708-2-8352199916116640135
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522135707; b=h0vYUy6MGvMpb8B7Hw3QRpjNq1IOGXQVXlN62ogt88VbgNP
    fWmOmHgV/vHbjjlkoIrD+zE8bZd3muljc4n7/+YQUFyq4HlQtwrSGjCmyTb/VxXy
    fd5rlCNxo1AX0f4EMU9k/SWh9pit3MUqMrYK/OpcDR6Lc51GTn1GzipyLFzdbbRV
    2ILzorieH0+1Nl0JIPYxT7E97gvzuqEnsZurt7s8nXN7suGswtWEG6kTg2VEgjO6
    qj7blOL3sRVDyAS+ZdmFAcZGWUvWLBk5WU8KWmAI2KvsOJz6pZo0epLnlZNrNv41
    klRknoDIHBCHyULwFJbNYFDcmSQ6HbZ4rqMBpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522135707; bh=j1NzwJnTl8WQEicEyLT7RayF3E
    e2eyKLP1OH6jt82YE=; b=M6ILcRv8YPd7igHLCwS6HyADEzEUR5aK34O3rjbZtZ
    V5XSBvmXMWkU5nzbSDJm/ZaL5Z3o01MyXu8Ptr1I7wTmN6FHdWVFZc53M2JXKDy+
    1ri/v85UcA2hyRp8ysm8AJE7aQ3DK7jfwT1xFQqJuxEDpMkLzKPxe5Ke9ZcaulKd
    kzNCPFltRfIKLHvm5jeV8qQTZ13AOYAMydeJNid1QBzj3qpH6bQ3jYwknbrkxnNS
    Agde4QHFUzrw+7VQVaGMkqAWyRUKeejCCnL81DPVYXYzFszkcNoBG8ZnIqIkAT7G
    ykGcv41v0+YsrJkf9TTk5Pl4fiDTOQWKcxglBsy08y2w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDp3IxQPqbhSdl6MpMVuBVFFN46LhFkPEMveiHSoVlz3h/kUu+Y2Mh8ilP0tGo69r4BGVOeWOtJB2cE0JhdYLfXzTTugpkWJ9ChC/wuxX/tMnrH1dFh5
    XTTG7hGg6MnN4OGAkOQMGRNCjncM0Tc2Og/hW5aklKem9KvjA9Gr38b3jwSuFItQvxslygW5IvqVU3sVq+uSPkHpJpTRbIKuIDnTfpy7zur5PqSNbj5QVO1s
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=DWDKLPo_AOAA:10
    a=v2DPQv5-lfwA:10 a=g_eK73hcWBTA_9jxeRIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751065AbeC0H20 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 03:28:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeC0H2Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 03:28:25 -0400
Date: Tue, 27 Mar 2018 09:28:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kash Pande <kash@tripleback.net>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
Message-ID: <20180327072822.GA8380@kroah.com>
References: <20180316152329.844663293@linuxfoundation.org>
 <7ec4a6aa-72cb-9fb6-5168-d1c4d49f1a6c@tripleback.net>
 <20180319182032.GA23774@roeck-us.net>
 <6b6fca54-9cd9-3c62-6c0f-b5e8477947ac@tripleback.net>
 <20180327062808.GC28908@kroah.com>
 <7e14038c-23c2-80b6-9c93-7843cbb5c36f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e14038c-23c2-80b6-9c93-7843cbb5c36f@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 11:37:28PM -0700, Guenter Roeck wrote:
> On 03/26/2018 11:28 PM, Greg Kroah-Hartman wrote:
> > On Mon, Mar 26, 2018 at 01:54:18PM -0400, Kash Pande wrote:
> > > On 2018-03-19 02:20 PM, Guenter Roeck wrote:
> > > > Ryzen and Threadripper are only supported in v4.15+.
> > > 
> > > 
> > > Nope, the offset for 1900X is not available in 4.15, I've had to
> > > manually patch all systems otherwise monitoring complains they idle at 53C.
> > 
> > I don't understand, what patch are you talking about here?
> > 
> 
> 6509614fdd2d, but you'll also want aef17ca12719 if that isn't queued already.

Both now queued up, thanks.

greg k-h
