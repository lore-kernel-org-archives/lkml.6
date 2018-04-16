Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523909846; cv=none;
        d=google.com; s=arc-20160816;
        b=DnmKjlwt0wKXL6R+g/PGws8/gfLKtKq+P1bYhWSBBRqhAa9oEDF0l+oeqLuqbmy0p2
         eXj44Hh/wrLHV+kyvt7r9et7Ius8/6C6dnvsM9n6BjorvAqvSUImoI6zAPTdFCjyszCR
         8uB1wqArSlbLPLmkAyyxXXJTi2JGRBuGd/nIKG6jLKSBqs1YNsqsZKaP2d9i9blXo7YB
         1BqYAggiF45AAmUrvgFju6gft0ZHnrE5MueBUUo+RCl+hI+XCa52hOEhu+Fv/Nh0vHhe
         9gddjRHFtMLjOnge5axV7Lhbkqo8LbRvBfgdS5tFXWhQ34mvdXDs/h1dzipEAKK54dFK
         ZBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=vWV2peSq3WY/yRludhAgaNbl5ZwuoXLiHnN9WuIFwN4=;
        b=Cfzmn0ji4RglIQouWlBzyLv+e045+1rS5WpwUnRODNHshaaGIxqtQgy6/LQeXZO3+a
         M+d7uPXSnJcn6TGwSHTasw2Yz4f5m6vpyeL4iKkgcQweEIDy5qk5OPkb6Jw3uACLAIaP
         UyRNg8YiXPC0r2RN51QuZrfcnxbMAam45bb7m52507aSVT4gCsWuDEV1xmS83bVzDn3E
         Fd8ak43B51ruIyrw8YpAvWny6iXtsnKralNnufeMRIm2uQeaYovg//4+Su4bAOSjhugH
         y6Ckp7pfHfhnOwkSkDtQDn90wBmnWfqzdONYurcu877+ZxNcEojfgkxsogapyobFTs5j
         EXzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=S1Zfvp4F;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Pw9AEwXn;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=S1Zfvp4F;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Pw9AEwXn;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx488SCv3jtYRLHKLLIvZeUUl55o5DOPtXrTadMbXx7WKaEIP5IRH54oUgh7xtnpfxLWqNo+GMaGE7iCnplc3CYA=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180416160232.2b807ff1@gandalf.local.home>
References: <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416122019.1c175925@gandalf.local.home>
 <20180416162757.GB2341@sasha-vm> <20180416163952.GA8740@amd>
 <20180416164310.GF2341@sasha-vm> <20180416125307.0c4f6f28@gandalf.local.home>
 <20180416170936.GI2341@sasha-vm> <20180416133321.40a166a4@gandalf.local.home>
 <20180416174236.GL2341@sasha-vm> <20180416142653.0f017647@gandalf.local.home>
 <CA+55aFzggPvS2MwFnKfXs6yHUQrbrJH7uyY4=znwetcdEXmZrw@mail.gmail.com>
 <20180416144117.5757ee70@gandalf.local.home> <CA+55aFyyZ7KmXbEa151JP287vypJAkxugW17YC7Q1B9=TnyHkw@mail.gmail.com>
 <20180416152429.529e3cba@gandalf.local.home> <CA+55aFwjSRZDT1f99QdY-Q5R4W_asb_1mZgM69YOqRR9-efmwA@mail.gmail.com>
 <20180416153816.292a5b5c@gandalf.local.home> <CA+55aFwXRjgfLfAWSaLBdajjzh4gt8-5M2N-bmjKt8nrJT+vWQ@mail.gmail.com>
 <20180416160232.2b807ff1@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 13:17:24 -0700
X-Google-Sender-Auth: Erv-6kGGes-59l8FJ-LL_mJ7QlI
Message-ID: <CA+55aFxiUhaFVBDhrTGJmgKZid2nO0efh6Mng1NQJ0JK4EHqMg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>, Pavel Machek <pavel@ucw.cz>,
	Petr Mladek <pmladek@suse.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Cong Wang <xiyou.wangcong@gmail.com>, Dave Hansen <dave.hansen@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1597921817292724457?=
X-GMAIL-MSGID: =?utf-8?q?1597935290996013243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 1:02 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But this is going way off topic to what we were discussing. The
> discussion is about what gets backported. Is automating the process
> going to make stable better? Or is it likely to add more regressions.
>
> Sasha's response has been that his automated process has the same rate
> of regressions as what gets tagged by authors. My argument is that
> perhaps authors should tag less to stable.

The ones who should matter most for that discussion is the distros,
since they are the actual users of stable (as well as the people doing
the work, of course - ie Sasha and Greg and the rest of the stable
gang).

And I suspect that they actually do want all the noise, and all the
stuff that isn't "critical". That's often the _easy_ choice. It's the
stuff that I suspect the stable maintainers go "this I don't even have
to think about", because it's a new driver ID or something.

Because the bulk of stable tends to be driver updates, afaik. Which
distros very much tend to want.

Will developers think that their patches matter so much that they
should go to stable? Yes they will. Will they overtag as a result?
Probably. But the reverse likely also happens, where people simply
don't think about stable at all, and just want to fix a bug.

In many ways "Fixes" is likely a better thing to check for in stable
backports, but that doesn't always exist either.

And just judging by the amount of stable email I get - and by how
excited _I_ would be about stable work, I think "automated process" is
simply not an option. It's a _requirement_. You'd go completely crazy
if you didn't automate 99% of all the stable work.

So can you trust the "Cc: stable" as being perfect? Hell no. But
what's your alternative? Manually selecting things for stable? Asking
the developers separately?

Because "criticality" definitely isn't what determines it. If it was,
we'd never add driver ID's etc to stable - they're clearly not
"critical".

Yet it feels like that's sometimes those driver things are the _bulk_
of it, and it is usually fairly safe (not quite as obviously safe as
you'd think, because a driver ID addition has occasionally meant not
just "now it's supported", but instead "now the generic driver doesn't
trigger for it any more", so it can actually break things).

So I think - and _hope_ - that 99% of stable should be the
non-critical stuff that people don't even need to think about.

The critical stuff is hopefully a tiny tiny percentage.

                           Linus
