Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-107388-1524636024-2-12770921203084400661
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524636024; b=ggcgme1AYVd0PBqoeDXOB9cAIxw0akJADt1mNjXCyMtw8W/gLd
    0/dykGXavQC9G+062LBXa11i4p1hhMVvM7PIDYnW0aINtlHoRQYSmplWjonXRkUI
    HR1GCKKMrvyKMkiyZ/e/cNym1ykWKf9NLzKS+5izmsH4le9ZZk1dFO8oIpkXQD5z
    S2o5UJNEibriNlsbTu+2bqF+TSpyE/8uD6HRnmCqnrW6B9EyfQFeuF0L7u2COyly
    QGicewrST784sniSkW7BDm/aH2kv4VDGImCSFxh7sON4CCitEOHlCHQheS2LdjpO
    hPMsMGv85uD7qGmomnezBs36eAYrJMKNM3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524636024; bh=vf9SyEjiMt7F7VPqTn1XWLja7cJDM6
    6VewKbbPW9koU=; b=gZCg9WyPRhZAyU1h5CEJ8wAr7PkJ26tEqiwonxJLk54s3S
    kLjC7YPtPvm8CVke8tYU+eQMB+tho4JZby/BimiFSAoNk3e+PM7ogAQUmMuRlD5d
    xe71WnWu4GTucl8bHsuYvt16bGinFTxpqer/dOiXfU5PsIj4v/Xz39cDm7a7tWkn
    As4qnOAAfPwMrULFq1HBQYYGTryQhgWREVGstWgfvrqeQ9Hq9qFGKcneBzDOjucI
    4A6J4AlMq/tLJ9ryZneQ036NLMW/69zQFMh8y2FySfSucEk0A4wWpPx23RrwLDyS
    v25ekRJj/Yh6j2UTFcYOe7qJhjAjwf8uVP7VupVw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=ny2GiV3o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=ny2GiV3o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMAeY9VzoXh4gbdHxbUxsRa6bdG2GHU8Ve+WsYEYhufuzTip7Hoj3q5UZ2cPvqOpGlD7wBEFS5dtCodfGbRO6FKyPFBhiQAf2JJTUHDzcQuCeMqcz15M
    N8hMDzEbX5BXPzDl4CDTMR3sDG0c64UviGNxFa+9etribVzxYS69KMmpsnWT0Yn6Y9t80IB6ptrpJyVDPwvrhQxvFh8TfR/bZ6IFupih3Ctm73xRr2pPtrog
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=Kd1tUaAdevIA:10 a=bwGhP-tq7ev0FIhoZwoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbeDYGAW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 02:00:22 -0400
Received: from imap.thunk.org ([74.207.234.97]:54582 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeDYGAW (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 25 Apr 2018 02:00:22 -0400
Date: Wed, 25 Apr 2018 02:00:17 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] random: fix possible sleeping allocation from irq context
Message-ID: <20180425060017.GB3412@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20180424034138.23994-1-tytso@mit.edu>
 <201804250046.w3P0kgkd045841@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804250046.w3P0kgkd045841@www262.sakura.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 09:46:42AM +0900, Tetsuo Handa wrote:
> Theodore Ts\'o wrote:
> > We can do a sleeping allocation from an irq context when CONFIG_NUMA
> > is enabled.  Fix this by initializing the NUMA crng instances in a
> > workqueue.
> 
> Offloading to workqueue context itself would be OK,
> but this patch makes linux.git unbootable because
> 
> 	if (crng == &primary_crng && crng_init < 2) {
> 		invalidate_batched_entropy();
> 		numa_crng_init(); // <= Deferred to workqueue context.
> 		crng_init = 2; // <= Not waiting for workqueue context, and oops before console becomes ready. ;-)
> 		process_random_ready_list();
> 		wake_up_interruptible(&crng_init_wait);
> 		pr_notice(\"random: crng init done\\n\");
> 	}
> 
> Please don\'t pretend rng_ready() before workqueue context is processed.

Where's the oops?  It's not oopsing for me, and if the NUMA crng is
not initailized, the code in extract_entropy returns falls back to
using the primary_crng:

static void extract_crng(__u32 out[CHACHA20_BLOCK_WORDS])
{
	struct crng_state *crng = NULL;

#ifdef CONFIG_NUMA
	if (crng_node_pool)
		crng = crng_node_pool[numa_node_id()];
	if (crng == NULL)
#endif
		crng = &primary_crng;
	_extract_crng(crng, out);
}

						- Ted
						
