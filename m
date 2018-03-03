Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3941094-1520067308-2-453622196612083206
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
    t=1520067307; b=qHwIY7nh0faTMdW5M8NumbpQPln8ZMMgC1ctFyDOXYvQYTn
    cmsFXdAwvbLk0Ux/cAeQ3tEVTLg7oAktIVPgemt59M8f/IEFsZa3ZrtS1wi++088
    +lbxvSQUB8R08nneSdGXpDmauEvb20fMv7CdwKuojRXiA8niynLISpTih7mk9iqM
    Odv2KeuiqJDfIiCdlXfR2yxNhSlA4fnsJqGvT220LOMtBEDRd3/U+2Sl1zECH6WL
    HYfm2emJ8xNvFqoiZKNPihU293mUoDp5/gwjZaAJoGE4Bzn7NMTMXszbstjhuSKd
    asJ9JbX3zmBMWSLZLktHM3zQ21KQnmvhrDdlhLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520067307; bh=BcML0Gg+sQ5DQJ53JLEkr+vM9d
    0mR1FySzCU6/4ss78=; b=hyFrZYd4kqPU6aw7Q8Xv+m4MMYg2aqThx1XKRP7JZx
    /2OjWujtPmdpaei/8QcnB2XbMZyJ4d+Fy3HzmeLJg2j6NRbwDaXyTGG8lmWkpT/G
    YPHiFYjd7K25KUex31f17MgrzXBSclpRBy6q7q1pk22TsrYuPI3cUNleTLTs/8/o
    QnWjN9BwtruvXZju3nhtTlX/h3wvIXaL+nXwQx3twm7BsOIjMsaQc9tPC4Rdpv3x
    C9MqRLx0zN327lFBBSkqVDh9GLWEa5MhWBmokCFNvG9w7TDyTw/Vbskq5vTkkQMx
    Ou24QToNrFfyeoFR5F3hPQLP21pWaosvSX0k4Hac/ivA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbeCCIy7 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 03:54:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34468 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeCCIy6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Mar 2018 03:54:58 -0500
Date: Sat, 3 Mar 2018 09:54:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>, ak@linux.intel.com,
        karahmed@amazon.de, pbonzini@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Backport IBPB on context switch to non-dumpable
 process
Message-ID: <20180303085454.GA23988@kroah.com>
References: <cover.1520026221.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520026221.git.tim.c.chen@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 01:32:08PM -0800, Tim Chen wrote:
> Greg,
> 
> I will like to propose backporting "x86/speculation: Use Indirect Branch
> Prediction Barrier on context switch" from commit 18bf3c3e in upstream
> to 4.9 and 4.4 stable.  The patch has already been ported to 4.14 and
> 4.15 stable.  The patch needs mm context id that Andy added in commit
> f39681ed. I have lifted the mm context id change from Andy's upstream
> patch and included it here.

What does this patch "fix" in those older kernels?  Is this a
performance improvement or something else?

thanks,

greg k-h
