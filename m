Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AG47ELt9AjBU2HaWeGXH+AcjHcVoYmpdOMJzIenyjg6gC+yhnk5I36YHXvGqdnJBFCzKPR2Isvfi
ARC-Seal: i=1; a=rsa-sha256; t=1521035508; cv=none;
        d=google.com; s=arc-20160816;
        b=tLXJF4anTgDtoaA+IEhYfhxnKfmaD3OX03FKuAnoqo6LeMzhyqeSR94Dj5mo1kM2rb
         HJwUHuPP0r1aCW7uKI2/ZezHxoqv4Mz2xTTVYlwpF3roksSHtJqS05qH+AstARCWm83P
         jkCVRoW5GI90X2ITNznkNwOJhZZ5AITI8InsptaocsKgKqABLBzZfiVbFv0USE6o5nVG
         OMoap7SMKCiGVqti1RqyEwJodhXLpngEGYjzWj9arMV+1//vArG0v+G0LlBvBxiRX5Rc
         zsaXK5UscG1Nc4T59dRT4ycbwUBtLmGZGGkpEl3qGznexHCsVvWLBgf7irUpHCqdGou5
         z0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=N44kzm5zORH0tcxPlR37l1K1ZJwYI8jlp5zTosPHmkg=;
        b=GkKh+tVW5B3GaeeJy1yXQjSO4IVXFqtWvkjYc2N4a+0f+7gl2MN/KMKE4tPgld0QF1
         lFirh2W97yLHZfh2JYjs6Gnt76ysUFjOj20hZSHdC/y7EqSziLnoASH/VJ48/TMArR7q
         IgPFDCCzfBrN/zBm7eE4Yuy34gc3lW/bfgZUdRLeEKCpF8HCntM4TVIHSpiEJoa8cB/B
         ohrtGDNrm7KG010LMZd0cI67SJi9iCgMXbuYxUJquCO8p7dTswLWrsTLEoMZ+lLND0IN
         2zcJFZnFyUg0dyteqQ7xvIt9h9bss6ZES2J0jJWfnBj0k4efojOX/I8gdIfnZXPGrNcv
         0R3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Wed, 14 Mar 2018 08:51:46 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: tip-bot for Andy Whitcroft <tipbot@zytor.com>,
	linux-tip-commits@vger.kernel.org, hpa@zytor.com,
	dave.hansen@linux.intel.com, arjan@linux.intel.com,
	dwmw@amazon.co.uk, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, apw@canonical.com, bp@alien8.de,
	luto@kernel.org, dan.j.williams@intel.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, dwmw2@infradead.org,
	peterz@infradead.org
Subject: Re: [tip:x86/pti] x86/speculation, objtool: Annotate indirect
 calls/jumps for objtool on 32-bit kernels
Message-ID: <20180314135146.o5pb434qwftkhui5@treble>
References: <20180314112427.22351-1-apw@canonical.com>
 <tip-a14bff131108faf50cc0cf864589fd71ee216c96@git.kernel.org>
 <20180314130329.cmsc7mqnfrm2iop2@treble>
 <20180314133943.t5dorqzvlieotljx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180314133943.t5dorqzvlieotljx@gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594916116672090070?=
X-GMAIL-MSGID: =?utf-8?q?1594921329256845733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 02:39:43PM +0100, Ingo Molnar wrote:
> 
> * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Wed, Mar 14, 2018 at 05:28:01AM -0700, tip-bot for Andy Whitcroft wrote:
> > > Commit-ID:  a14bff131108faf50cc0cf864589fd71ee216c96
> > > Gitweb:     https://git.kernel.org/tip/a14bff131108faf50cc0cf864589fd71ee216c96
> > > Author:     Andy Whitcroft <apw@canonical.com>
> > > AuthorDate: Wed, 14 Mar 2018 11:24:27 +0000
> > > Committer:  Ingo Molnar <mingo@kernel.org>
> > > CommitDate: Wed, 14 Mar 2018 13:24:31 +0100
> > > 
> > > x86/speculation, objtool: Annotate indirect calls/jumps for objtool on 32-bit kernels
> > > 
> > > In the following commit:
> > > 
> > >   9e0e3c5130e9 ("x86/speculation, objtool: Annotate indirect calls/jumps for objtool")
> > > 
> > > ... we added annotations for CALL_NOSPEC/JMP_NOSPEC on 64-bit x86 kernels,
> > > but we did not annotate the 32-bit path.
> > > 
> > > Annotate it similarly.
> > 
> > This patch has no effect because objtool only supports 64-bit kernels.
> 
> Yeah, indeed - but it's still a good change for completeness, right?

Yeah, it's fine.  Objtool won't use it, but I suppose it makes the code
less surprising and more consistent for humans.

-- 
Josh
