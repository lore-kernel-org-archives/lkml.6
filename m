Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63F4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82AE20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SU26MecQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbfAORvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:51:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35151 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbfAORvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:51:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so1548393pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 09:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cqvQ5qnSqVJi7E6qwXhfoA1QxQKD9GVe2GYg4Ei1SR4=;
        b=SU26MecQUztZ1a0Yway0TWM392YZ49DNBzuiKehZzW2QO3Pxhk5fo78F2NVXzOSnEU
         8ajFWtUDB5fNRNxF/ZbE3Fr2sLmmUMKDuU06LROxkGZdAp7C6Q3du5wtjrDTzMJWotEq
         Y/lAw28qldeixO20icmUAhz8JJSVe2vxHphdEiSngmQWDfErZqFAUg6c462K3ALjOFfM
         KWV20LSzDz/XP3zRw+g+JRcvhMrDkEKe750ep/B2+Mpy5YYwGKgwdF6T7hlmtn+92ENb
         TSLgu2nlIzgwMyd1ErmPCunHe67cPSBD4JIDfBVnH4u26rQz9pCYCV3apOdP93i6nx0j
         a9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cqvQ5qnSqVJi7E6qwXhfoA1QxQKD9GVe2GYg4Ei1SR4=;
        b=TI6ItoiVeJYzC1RkQJFJdoRoY53HrQygIL+QZk0ZeWpD5CKIk13i41Iy+XRV5XcjAi
         FVpWFF7HHiJsmx74zXSTMBKKdtY7kR5ss4Qfwae+EsmEVrCWI4qncwJpX4qQafsBh/wf
         Ex08tzDmWr7QOomykBTSn8FsR33TMvIhut/fwo+HyjAcqxLiwWOaNpdUfzjVgVunrN+3
         TCBR4IADKu8wnHUCzHT+jMXl9Jnm/9mLw7f2gfze4qUJzqEMMqCJH5vvcwA3AIW44maU
         YUHCl7Ju4m6lDFnV4ZpcugM22XxXYnDYuIZXcRSywsx6XzLcqWj2J8kSHS9yMTnXN9mI
         5MiA==
X-Gm-Message-State: AJcUukdVnW/8zDcWvKFBAQzotv4xjS/VHOyZlgbOPsxlp3t/0C+8mWeV
        lQXGsluz6PfD2tl/EmC7Qk9Mww==
X-Google-Smtp-Source: ALg8bN59nxqvtd7FkHAlh4XEYj9aRe7QrZSo0amDxGfZFPD8+I7d/ShJkjyAYAV+4etnTn6llCOZLw==
X-Received: by 2002:a62:109b:: with SMTP id 27mr5117431pfq.227.1547574675803;
        Tue, 15 Jan 2019 09:51:15 -0800 (PST)
Received: from google.com ([2620:15c:17:4:f0b1:8ff5:16a0:5f15])
        by smtp.gmail.com with ESMTPSA id f32sm4182760pgf.80.2019.01.15.09.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 09:51:15 -0800 (PST)
Date:   Tue, 15 Jan 2019 09:51:11 -0800
From:   Tom Roeder <tmroeder@google.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] kvm: x86/vmx: Use kzalloc for cached_vmcs12
Message-ID: <20190115175111.GB68985@google.com>
References: <6f79d9be-fa76-3a06-2612-f44f3a18ece7@redhat.com>
 <20190114234728.49239-1-tmroeder@google.com>
 <20190115024304.GD5141@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115024304.GD5141@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 06:43:04PM -0800, Sean Christopherson wrote:
> On Mon, Jan 14, 2019 at 03:47:28PM -0800, Tom Roeder wrote:
> > This changes the allocation of cached_vmcs12 to use kzalloc instead of
> > kmalloc. This removes the information leak found by Syzkaller (see
> > Reported-by) in this case and prevents similar leaks from happening
> > based on cached_vmcs12.
> 
> Is the leak specific to vmx_set_nested_state(), e.g. can we zero out
> the memory if copy_from_user() fails instead of taking the hit on every
> allocation?

I don't know if the leak is specific to vmx_set_nested_state.

This question (and the rest of the thread from November) goes to the
heart of what I wanted to get feedback about; hence the "RFC" part of
the subject line.

I'm new to the kernel, and I don't know all the idioms and expectations,
so the follow analysis is an outsider's view of the issue at hand.

What I see in this case is a field that is intended to be copied to the
guest and is allocated initially with data from the kernel. I'm sure we
could figure out all the current paths and error cases that we need to
handle to make sure that this data never leaks. Future reviewers then
also need to make sure that changes to the nested VMX code don't leak
data from this field.

Why not instead make sure that there isn't any data to leak in the first
place?

I understand that there's a cost to kzalloc vs. kmalloc, but I don't
know what it is in practice; slab.c shows that the extra code for the
__GFP_ZERO flag is a memset of 0 over the allocated memory. The
allocation looks very infrequent for the two lines in this patch, since
they occur in enter_vmx_operation. That sounds to me like the allocation
only happens when the guest enables nested virtualization.

Given the frequency of allocation and the relative security benefit of
not having to worry about leaking the data, I'd advocate for changing it
here.
