Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4150847-1523911417-2-12100743978338903212
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523911417; b=f7VbYVMtv1dB8SmHEJ/VP20CUWcXid0fOKopq1eouGSfeXo82/
    cXGY96qZqAIqRSO21GxmcxVLtdUvciQCW9yP+YmH0EDVzc2HHuWJShwmc0c7bnVc
    Uo6ifU1NVZRMY/+pyw1KMLBaG/DVqaYW4obyOQ8mRg3Y0TGVD2mYHaa6kHcCAGMN
    o8ravjkun0cYJbE+FVGFkA5UBmowiXPamSkAk2JP6wyTQISc3eF/6GI4QlgHDKPG
    qOH/siMXSdWcyEhidZBkQcgEBalc9GBSumq+hiqolMKsC1Hr8qxRRm6HoUEx+8IE
    jIpczUg7Zdm60BBuuu32i2VY5lQZgfEH3YVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1523911417; bh=haUKgQ0DbHArKZhJbOuF7blwdlVHnTiGJhDDrUb
    W9fo=; b=GttCvq+dQApVT5EZRqF44sW7rFfyf2ERkt+gpNYNaSuNhU2xaY1O05N
    ZmmdvdPMwICc2g9t7Ae3Bu419CMIvNZHbWjNICBTeeSwx5KtFSvkfIYQwsmKyQFF
    cIM/horDb77M6lpawmApLOzQhKX6cpPlrPvbhhwn1SSHjuwo3vVnhKqPALcTDOoV
    1diG0Nxb5vPOG5XRhcOsfmQlhwPWQFemrBGY/A4OcdjNc8aPpAIFYVSUXoEJqbfg
    KqtFNccWt8QlwX9wK51t3v48JvHzYIZ2KfEJ8CNM0SxDUJy68EATRfO0Lj8LnY3O
    zORpnfozThXbru2nmF2XNk3RiDEzT7g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL1+5BdLt1ql+k0SscL2LcA14yILVN0YrVcwW3t9FWbpl2hd9clAtKPXs1fBz0jmAKGyEJyYaZDK+ETGUGEC5Fi9zn6StQYn9L7rpSmI7RTbmd0PeIG7
    UqnkcNW791yIb31/mvOZP4Armwz/rJ2OdgkZmWQk0Er5xaPp7bFzufKJIAziVRluRg2AKbHbUHDMaVNWfiAPbz10dbfkefkSFttfvCLPrvT8+PKdPrDtWRr9
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=7UgmWEL2dgdRE0VeEg8A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeDPUne (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 16:43:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:57901 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeDPUne (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 16:43:34 -0400
Date: Mon, 16 Apr 2018 22:43:28 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
cc: Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
In-Reply-To: <20180416203629.GO2341@sasha-vm>
Message-ID: <nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm>
References: <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home> <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com> <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm> <20180416160608.GA7071@amd>
 <20180416161412.GZ2341@sasha-vm> <20180416170501.GB11034@amd> <20180416171607.GJ2341@sasha-vm> <alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm> <20180416203629.GO2341@sasha-vm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018, Sasha Levin wrote:

> So I think that Linus's claim that users come first applies here as
> well. If there's a user that cares about a particular feature being
> broken, then we go ahead and fix his bug rather then ignoring him.

So one extreme is fixing -stable *iff* users actually do report an issue.

The other extreme is backporting everything that potentially looks like a 
potential fix of "something" (according to some arbitrary metric), 
pro-actively.

The former voilates the "users first" rule, the latter has a very, very 
high risk of regressions.

So this whole debate is about finding a compromise.

My gut feeling always was that the statement in

	Documentation/process/stable-kernel-rules.rst

is very reasonable, but making the process way more "aggresive" when 
backporting patches is breaking much of its original spirit for me.

-- 
Jiri Kosina
SUSE Labs
