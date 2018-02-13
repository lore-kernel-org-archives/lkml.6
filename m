Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518529091; cv=none;
        d=google.com; s=arc-20160816;
        b=uUsrVF4E9M4ik3mqx3aXNy/W92eEhBgeI9gNFvdsGjDmB6ZibGjteew73sjyopQsiA
         3B5+0QDFh9xYSAD2LhDkhMzDa41JJtQZqYNqv67IDFW4VbTJJ99xa4ytM3CHGPcn8uNm
         E2fXyFOjNM5XCaC8+ZcERKtbwtvGhuwxT7ocNl72bujfeRX1kJtbXB7xEz4ffpZA0M+i
         uE6Owk+1xrn4oPhZJqMdo7xqJaHedwC4v60Z/HRDj1h9XLNlSpjA1w2e72t+IgzuRFDa
         A5LNhgSB6O75FnxRaxcxzRjrsx1LnkSD94N+0VboZ5tIQ3xhfpNnaPYXX0xsuDSbRhgh
         pnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=WOYC2BMJ881ejyyW819Pa1VkSjQTSwyIw4k/Vabdp3g=;
        b=WUn6KSA3ehqNXg6wKoPr6Pg9vLNj2OBgqt8fSb2f3/QgJINFfXDaT/RyWlCuHzCbDl
         XpQD8LPRoxhNp9Vhvu5Ai4cLF33D+AuQDRq4JewPXKnD0gheYnKVZ9PEfllIfLv4g3f3
         Zc3eEMf7xCvmdkQvBDjFQNH0tR+fNMDZxPe5rcbMzieKa/JSqRT/rYAinhwbxsA2+MS1
         +EJUJbFG8Yl7BZBZXpyNXUjU5YWC8zvtBmLfUqZg4fqg4oOtpvnvHqVuULSkKwJt+Mt8
         DjGovg8D7LpNQvi/u5X2xX+ZsFKan+I+u4zIokz7LGOTr+Iytu4hmd5FLrkakds2WD8Q
         7d/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dkhxSe8V;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dkhxSe8V;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x227RQ7+78eb9ktp1TNttXdLFp+jgOH19Y9aycaeslQraYdgOOt+2tJJy2bmubTdJC5ecfkga4w==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 13 Feb 2018 14:38:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, dave.hansen@linux.intel.com,
	bp@alien8.de, tglx@linutronix.de, arjan@linux.intel.com,
	linux-kernel@vger.kernel.org, dwmw2@infradead.org, hpa@zytor.com,
	gregkh@linuxfoundation.org, dan.j.williams@intel.com,
	dwmw@amazon.co.uk, luto@kernel.org, jpoimboe@redhat.com,
	linux-tip-commits@vger.kernel.org,
	Joe Konno <joe.konno@linux.intel.com>
Subject: Re: [tip:x86/pti] Revert "x86/speculation: Simplify
 indirect_branch_prediction_barrier()"
Message-ID: <20180213133807.7tpob7gjil36lja6@gmail.com>
References: <1518305967-31356-3-git-send-email-dwmw@amazon.co.uk>
 <tip-f208820a321f9b23d77d7eed89945d862d62a3ed@git.kernel.org>
 <20180213094132.GF25201@hirez.programming.kicks-ass.net>
 <20180213112838.v2xu4qdnend5tflv@gmail.com>
 <20180213132819.GJ25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213132819.GJ25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592160265203742206?=
X-GMAIL-MSGID: =?utf-8?q?1592293160699224761?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Feb 13, 2018 at 12:28:38PM +0100, Ingo Molnar wrote:
> 
> > Separate would be better, it makes sense and is one problem less to worry about?
> 
> Something like so then?

Yeah, perfect!

> I'm not entirely sure which commit wants to fo in Fixes, I picked the earlier 
> one, but it could equally have been:
> 
> Fixes: f208820a321f ("Revert "x86/speculation: Simplify indirect_branch_prediction_barrier()"")

I'll leave the tag out (in case a rebase has to be done), as these commits are 
close enough to each other and are also in a single backporting block of commits.

Thanks,

	Ingo
