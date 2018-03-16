Return-Path: <kernel-hardening-return-12669-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsw6h5RC472A4zAiaqCjX4MLXFCVDD1Xybcw4j8KOeVN0I7yMLD01IaizoF3uyiOrvKojCs
ARC-Seal: i=1; a=rsa-sha256; t=1521224134; cv=none;
        d=google.com; s=arc-20160816;
        b=Ixlk729NHUIeyAjfmlv0y3uXyj+Kb0c+/sKrPfMdi72tYbVzD3y7jbI+G9363E3GmS
         +nuLUToWkrtfoYZ7vV5pQhARaReYh3EZ1xQFi5ZNIWo54eKRla9iYF5NXlBcUyp6Rd9h
         O/yTU3cqTurDgSss5cyyMNVRL8W7C/rrdk3ffiYNr3dyYZFEHGMcAv5FhOR3SpKeKyVj
         WFHYF248jieRoTPIrWo5h0sHzDGwO7+RoVfugsxzIOfW3BaexmdPsHYJHFwPZR97ju/c
         F6fg3Ad9HOhCtC9lh4tt5LCr8V1UhBL4yk5shVl3ehfGSMHXnqVqozMTcdNqjb5tmgLj
         BTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=8WQaSk3VyiXWjmgf/OGmPuQBq32CcvfWUH5yDz28e+A=;
        b=ScCsBEDjNZcwmvCeysRMbmIjvIReXfk8AE/HgAbmTt/nykkdKSqJmfWzZQT8QkVTa7
         kXHICZROJiyUvDVE3PWExrt3OHxIs5BOsli5XZ95lhQtPDahZjxwWcdf+Vve1qmZ/Hgh
         d+1NHTdanmPjJhjx5R74eVeL/U7QGsV6Q5NWuOme3JX3Rr8J4mjCXEffl4qLA+UUY7Dj
         fEak61C5k7DXpFIAVirsxz9GtYeByqgF48RqCJDVcrzfCId5Xvx/GIh04GgfaP86S3cf
         o+whCE2HXjTLqzfxfyUJ9pyV13CkKVjyuM0BPS0V2UWn/HMMUNNLy/JnjZOtgtJ0vIq5
         5BVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12669-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12669-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12669-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12669-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 16 Mar 2018 18:14:59 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
Message-ID: <20180316181459.GF30522@ZenIV.linux.org.uk>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com>
 <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180316175502.GE30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595119118470075480?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 05:55:02PM +0000, Al Viro wrote:
> On Fri, Mar 16, 2018 at 10:29:16AM -0700, Linus Torvalds wrote:
> >    t.c: In function ‘test’:
> >    t.c:6:6: error: argument to variable-length array is too large
> > [-Werror=vla-larger-than=]
> >      int array[(1,100)];
> > 
> > Gcc people are crazy.
> 
> That's not them, that's C standard regarding ICE.  1,100 is *not* a
> constant expression as far as the standard is concerned, and that
> type is actually a VLA with the size that can be optimized into
> a compiler-calculated value.
> 
> Would you argue that in

s/argue/agree/, sorry

> void foo(char c)
> {
> 	int a[(c<<1) + 10 - c + 2 - c];
> 
> a is not a VLA?

FWIW, 6.6 starts with
	 constant-expression:
		conditional-expression
for syntax, with 6.6p3 being "Constant expression shall not contain
assignment, increment, decrement, function call or comma operators,
except when they are contained in a subexpression that is not evaluated",
with "The operand of sizeof operator is usually not evaluated (6.5.3.4)"
as a footnote.

6.6p10 allows implementation to accept other forms of constant expressions,
but arguing that such-and-such construct surely must be recognized as one,
when there are perfectly portable ways to achieve the same...

Realistically, code like that can come only from macros, and one can wrap
the damn thing into 0 * sizeof(..., 0) + just fine there.  Which will
satisfy the conditions for sizeof argument not being evaluated...
