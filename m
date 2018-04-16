Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3647214-1523895797-2-6799748120826265954
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523895796; b=P7LqzKo+gjhKf1C7HGRajEvN+oycvEwESAoJhiSRXSXgGRAmFz
    Kk+18vMko6otisJlz7u7192nse1tMFMAOtbfekDitRLENv3Cj5+iEUjVWUKH4eDg
    sEd1BBrIvf2+4mFG4Qdz/BoD/uMjNRtpcL9mqE0EdhVcIOBGJFllxd4d2v+8f09D
    xxzXUkaiAUjdrvIZunH40zd0TZ5YdP9byCnMHyYkIYLw1lkPh6H3Bp+4WGHc+LpW
    LdZZ5NARHKvS3ThpHmn2FW2eDdxqgQz2L9IZy8VTEaKpqs0sRh7aDpsm3+bVcF+U
    apD7DErYVcBBvZjxwXaE38sIRa87mN8JNciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523895796;
    bh=XFDEV+kdd+cLXt76fEZIwnSDX2xbdv+XiB6R4MlBB9s=; b=UnCFsmJhLtxu
    h35PdfLdymswUvDWJTkHZpYtkiEimvWQ/IwFreoMhaKJNGhPElwXB28SZ8CALaka
    94Lgl9RGMfxiPLuikHvUq/8MgUqBR1KpsTAr7w73fB9/fXhFKPi01Y5ZsSj/Q9hC
    9T6YYaz3NdRR8hE8SEb7vFXqXL3UxKUe737SIVFSYNVOatXy1KtyXg6z5NFy2Wr/
    j/wQ9F/QLc1dt8VsvFKh34ClY6TrAjJ8VnCMY5WZpVwlkCYaLVUvChkkOu7FEa2S
    RM0TXZQ51IizmOfex91RGQboHib5/l+XN7vjX7R9nEywS0vquNyBKV1y2FVHNREW
    sdZbC59d6w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNRic45Lk2oOORIUfXvx/oKatfIFFRo6/xGaBA5EWBtUN1NN9hLlrHoU+fAKI7MTPCppdltyH66hLZaO2rMKCz4CrdIzEiBIUKJQblWqCNld2v3QUKCN
    b7dd+hXkM7qex+7YjVGpdTO++sp336sxSzc4glU7fmRu0EwHTIjRITmgwnc4YJn0173C9vJGlxx++QePltlLa/jFTR3wq55RyHp4SjpNQ4T/ArN0TdPRztkT
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=cyGNS5ENNRa7csv-lLYA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeDPQWt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752096AbeDPQWs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:22:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2162175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 12:22:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20180416122244.146aec48@gandalf.local.home>
In-Reply-To: <20180416161412.GZ2341@sasha-vm>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
        <20180409001936.162706-15-alexander.levin@microsoft.com>
        <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
        <20180415144248.GP2341@sasha-vm>
        <20180416093058.6edca0bb@gandalf.local.home>
        <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
        <20180416153031.GA5039@amd>
        <20180416155031.GX2341@sasha-vm>
        <20180416160608.GA7071@amd>
        <20180416161412.GZ2341@sasha-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 16:14:15 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> Since the rate we're seeing now with AUTOSEL is similar to what we were
> seeing before AUTOSEL, what's the problem it's causing?

Does that mean we just doubled the rate of regressions? That's the
problem.

> 
> How do you know if a bug bothers someone?
> 
> If a user is annoyed by a LED issue, is he expected to triage the bug,
> report it on LKML and patiently wait for the appropriate patch to be
> backported?

Yes.

-- Steve
