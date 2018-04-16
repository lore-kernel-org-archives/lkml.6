Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3972417-1523906678-2-7595688897718568283
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
    1523906678; b=UixWYBXSoxxXA5vuA/fKB0lAu/Q5ZjPJDT4aeOHsKGiJzOi75U
    VrIuym4I5Q5ik286AB2KtOPHexo6EV6AXcnAYmp/1kOegOdc8sn0ibBrvdBXhTNH
    toYYz8hnRkDp9r5ttnshH6tEMW+VBvtevtjgLYHpyfTDGzSSm9HTwR3mSsjz6wLL
    Zy1AnLVnsorJWdDSXLQ7fxWqm7QurZv+zMWEfCqd/BpGTHKEGm47KT/NU0jJ7tfC
    gZepZQOZWUUftR91fqlz6aVHFFKLcremOUOAVVCUy/P1DnJvBF5ONkmCb9ybx+l1
    LnynqFlkjZ4wMNHeyoMyVb13gSP9EhO3Z0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523906678;
    bh=2B4h+mLjyoD+QYwGTdw4cZPvZ/Gi6HNYhMQ/JHSiMqo=; b=RxfqAoddUeDH
    /0RSCwwv/qTUjEsQm4ba7HNm5BUNVzu6eLrBhRT+ldHSVl+MNKGoapU2OHpYhthK
    dIwaOBZqoiSUmJwS4BKdyv1FYVajiBrYJa32Hj3OOiwCGg345UQoRD6O+iPHTbxC
    /MR3CWeofrH0mpfCIOMMcvpdDoOCQXRQFMm3wzdpv70LC2g0reV4HlDEJX9QG+8Z
    yLInlSfx7Ym+23Li42zTRLHOGXSaktuNqjc4Tu0naw1gPA8LhlgS8erZp4CGNHXw
    7er7YOahuY9Sm6gOdXMetoxzJScT7toSABZPhQG+SqeUE+y9arWOSwR05IL4DyL5
    WNKKd+SE/g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfCMn5CpQTrjBsohkSolylMv4gp4fR1RNCer4lqaDoN7sOK43/ypE31ue4rkKjCdMxA4VqxL40i8fNoI+dDrtKkVW3jPYMe+RWEGtjWoS+DgjWz6eLYeq
    HZ6TxpF5wXQlOS20zMCk3a1iIxJl7p8rRwDbDlZNornQDLtlCGiw7z7om72hYzjWoOCzLRRt6XoZb3QjKrmJJPeXDEZkuoUXT931jYQj2CWbqWu6Wkhz4zNl
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=meVymXHHAAAA:8 a=x9O4WdnaUFRk-6_JRwcA:9 a=CjuIK1q_8ugA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeDPTYf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752308AbeDPTYe (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 15:24:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44D52175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 15:24:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>,
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
        Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180416152429.529e3cba@gandalf.local.home>
In-Reply-To: <CA+55aFyyZ7KmXbEa151JP287vypJAkxugW17YC7Q1B9=TnyHkw@mail.gmail.com>
References: <20180416153031.GA5039@amd>
        <20180416155031.GX2341@sasha-vm>
        <20180416160608.GA7071@amd>
        <20180416122019.1c175925@gandalf.local.home>
        <20180416162757.GB2341@sasha-vm>
        <20180416163952.GA8740@amd>
        <20180416164310.GF2341@sasha-vm>
        <20180416125307.0c4f6f28@gandalf.local.home>
        <20180416170936.GI2341@sasha-vm>
        <20180416133321.40a166a4@gandalf.local.home>
        <20180416174236.GL2341@sasha-vm>
        <20180416142653.0f017647@gandalf.local.home>
        <CA+55aFzggPvS2MwFnKfXs6yHUQrbrJH7uyY4=znwetcdEXmZrw@mail.gmail.com>
        <20180416144117.5757ee70@gandalf.local.home>
        <CA+55aFyyZ7KmXbEa151JP287vypJAkxugW17YC7Q1B9=TnyHkw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 11:52:48 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 16, 2018 at 11:41 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >I never said the second
> > bug fix should not have been backported. I even said that the first bug
> > "didn't go far enough".  
> 
> You're still not getting it.
> 
> The "didn't go far enough" means that the bug fix is *BUGGY*. It needs
> to be reverted.

It wasn't reverted. Look at the code in question.

Commit d63c7dd5bcb

+++ b/drivers/scsi/ipr.c
@@ -4003,13 +4003,12 @@ static ssize_t ipr_store_update_fw(struct device *dev,
 	struct ipr_sglist *sglist;
 	char fname[100];
 	char *src;
-	int len, result, dnld_size;
+	int result, dnld_size;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	len = snprintf(fname, 99, "%s", buf);
-	fname[len-1] = '\0';
+	snprintf(fname, sizeof(fname), "%s", buf);
 
 	if (request_firmware(&fw_entry, fname, &ioa_cfg->pdev->dev)) {
 		dev_err(&ioa_cfg->pdev->dev, "Firmware file %s not found\n", fname);


The bug is that len returned by snprintf() can be much larger than 100.
That fname[len-1] = '\0' can allow a user to decide where to write
zeros.

That patch never got reverted in mainline. It was fixed with this:

Commit 21b81716c6bf

--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -4002,6 +4002,7 @@ static ssize_t ipr_store_update_fw(struct device *dev,
        struct ipr_sglist *sglist;
        char fname[100];
        char *src;
+       char *endline;
        int result, dnld_size;
 
        if (!capable(CAP_SYS_ADMIN))
@@ -4009,6 +4010,10 @@ static ssize_t ipr_store_update_fw(struct device *dev,
 
        snprintf(fname, sizeof(fname), "%s", buf);
 
+       endline = strchr(fname, '\n');
+       if (endline)
+               *endline = '\0';
+
        if (request_firmware(&fw_entry, fname, &ioa_cfg->pdev->dev)) {
                dev_err(&ioa_cfg->pdev->dev, "Firmware file %s not found\n", fname);
                return -EIO;

> 
> > I hope the answer was not to revert the bug and put back the possible
> > bad memory access in to keep API.  
> 
> But that very must *IS* the answer. If there isn't a fix for the ABI
> breakage, then the first bugfix needs to be reverted.

It wasn't reverted and that was my point. It just wasn't a complete
fix. And I'm saying that once the API breakage became apparent, the
second fix should have been backported as well.

I'm not saying that we should allow API breakage to fix a critical bug.
I'm saying that the API breakage was really a secondary bug that needed
to be addressed. My point is the first fix was NOT reverted!


> 
> Really. There is no such thing as "but the fix was more important than
> the bug it introduced".

I'm not saying that.

> 
> This is why we started with the whole "actively revert things that
> introduce regressions". Because people always kept claiming that "but
> but I fixed a worse bug, and it's better to fix the worse bug even if
> it then introduces another problem, because the other problem is
> lesser".
> 
> NO.

Right, but the fix to the API was also trivial. I don't understand why
you are arguing with me. I agree with you. I'm talking about this
specific instance. Where a bug was fixed, and the API breakage was
another fix that needed to be backported.

Are you saying if code could allow userspace to write zeros anywhere in
memory, that we should keep it to allow API compatibility?

> 
> We're better off making *no* progress, than making "unsteady progress".
> 
> Really. Seriously.
> 
> If you cannot fix a bug without introducing another one, don't do it.
> Don't do kernel development.

Um, I think that's impossible. As the example shows. Not many people
would have caught the original fix would caused another bug. That
requirement would pretty much keep everyone from ever doing any kernel
development.

> 
> The whole mentality you show is NOT ACCEPTABLE.
> 
> So the *only* answer is: "fix the bug _and_ keep the API".  There is
> no other choice.

I agree. But that that wasn't the question.

> 
> The whole "I fixed one problem but introduced another" is not how we
> work. You should damn well know that. There are no excuses.
> 
> And yes, sometimes that means jumping through hoops. But that's what
> it takes to keep users happy.


I'm talking about the given example of a simple memory bug that caused
a very subtle breakage of API, which had another trivial fix that
should be backported. I'm not sure that's what you were talking about.

-- Steve
