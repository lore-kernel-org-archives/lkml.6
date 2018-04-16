Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4006321-1523908959-2-15470597354640584616
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
    1523908958; b=JaiK46ASLd0n366Sn0ISP2cVrei0Kd01VP71n9TgdDuWFn/RPm
    4EPLMmNL6i3bHEsFNJ+c5BUPBzGkbWV/vWWOyO0YfZh1Jk24n5fjtg1smU0Amkxq
    +eQ93+xK4ihv23eKCQonOEsRArgZOHaGgDSoPu2Rck0fUrxFOWYGEcr+yt/57/HN
    GKOyrkA7rMgWXORsuiZC5dpQYs0TFfZKVzf5FxrHvjSK6wTxruZgkw9iDl9EKdAb
    Pk8A0iPgED2+Xju47DQI5LVVlAnSIMYVZQhYZ3v8gQUlc1kX9ckI8AZ4K9HsGGv+
    l1DifKCUj5zJ7MHWnCBJOAg3EHMdK5vlICRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523908958;
    bh=JTSK97ovT3YNjU/lNJm2dMkkVxgbvCaYDV2QaLX+868=; b=jdFbgY2AbIlF
    AXz6bBr4oVzttdtESP2ETDRgI9IpSqFiAOAHXj2pIRKNXrYYlV8rZSw15bxyOFSg
    Ya47AZOYC7HZ1ZFGABqUWImEw4+k/TtUsI12iGkwYc0U9EKq2mw5QUnsmgRBKmP5
    r22M7pFLTEz1CMkwR6GEVUS2QwJOVSK4PXWq2s8nxyJJhEHB3eixOnDjSQLQhy+r
    WdDXuOk2BFM7zo/g5MK8EYRmok+V4SpTgiC2YuFbbQO6pMvsrXkCRihKT4DtknOe
    6m04LmVx3DXumQapld/gdScYAGi5plkeSETRTTBNd+dPEIB6Tc3u9sgaV8NQGIhF
    CTH4a4sK3w==
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
X-CM-Envelope: MS4wfHxSaKXXDBHDUjeXcGJqokKas2rc51BKQg204x+ITwH1XZUPTvB6Ook8ESgq5SJztaK4/nXzfnWMzbPtmyq0sHUNfTrW7f+7sKvkzdSKLtniVnNKQOGx
    SMyhzOLNLubgLhKSH4pqi4jdeHPfnHw1jSy6fSh3iPPgf1iorKKDE+jQtNps0KW6mCfdnPBuv/nmyRXL7XS2pzhBX4AqvCXrujN1VgTLZAMlHB027xsgj2Fh
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=meVymXHHAAAA:8 a=XgG-ImFv1tqxagarW4sA:9 a=CjuIK1q_8ugA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbeDPUCh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 16:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753244AbeDPUCg (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 16:02:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6D321771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 16:02:32 -0400
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
Message-ID: <20180416160232.2b807ff1@gandalf.local.home>
In-Reply-To: <CA+55aFwXRjgfLfAWSaLBdajjzh4gt8-5M2N-bmjKt8nrJT+vWQ@mail.gmail.com>
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
        <20180416152429.529e3cba@gandalf.local.home>
        <CA+55aFwjSRZDT1f99QdY-Q5R4W_asb_1mZgM69YOqRR9-efmwA@mail.gmail.com>
        <20180416153816.292a5b5c@gandalf.local.home>
        <CA+55aFwXRjgfLfAWSaLBdajjzh4gt8-5M2N-bmjKt8nrJT+vWQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 12:55:46 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 16, 2018 at 12:38 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > But I don't see in the git history that this was ever reverted. My reply
> > saying that "I hope it wasn't reverted", was a response for it being
> > reverted in stable, not mainline.  
> 
> See my other email.

Already replied.

> 
> If your'e stable maintainer, and you get a report of a commit that
> causes problems, your first reaction probably really should just be
> "revert it".
> 
> You can always re-apply it later, but a patch that causes problems is
> absolutely very much suspect, and automatically should make any stable
> maintainer go "that needs much more analysis".
> 
> Sure, hopefully automation finds the fix too (ie commit 21b81716c6bf
> "ipr: Fix regression when loading firmware") in mainline.
> 
> It did have the proper "fixes" tag, so it should hopefully have been
> easy to find by the automation that stable people use.
> 
> But at the same time, I still  maintain that "just revert it" is
> rather likely the right solution for stable. If it had a bug once,
> maybe it shouldn't have been applied in the first place.
> 
> The author can then get notified by the other stable automation, and
> at that point argue for "yeah, it was buggy, but together with this
> other fix it's really important".
> 
> But even when that is the case, I really don't see that the author
> should complain about it being reverted. Because it's *such* a
> no-brainer in stable.

But this is going way off topic to what we were discussing. The
discussion is about what gets backported. Is automating the process
going to make stable better? Or is it likely to add more regressions.

Sasha's response has been that his automated process has the same rate
of regressions as what gets tagged by authors. My argument is that
perhaps authors should tag less to stable.

-- Steve
