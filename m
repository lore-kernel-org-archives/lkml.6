Return-Path: <kernel-hardening-return-12672-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuvjonjsYui5K36qWIBw6Yudyk7joL11RBgBtrvag8qxLDoFDeq8i2ag5gBFHbHmV9XngjX
ARC-Seal: i=1; a=rsa-sha256; t=1521231168; cv=none;
        d=google.com; s=arc-20160816;
        b=zMwc3ZN076PzqxEAE9BN2jQyBlXB/uMj/kad4w8SLIEVDQWWV6x1advNfmDxKlgchd
         XcaJe9Uu3ZImrmBRnOvVRbRjxc31XQKaoM+wWIF0j6eBZVKKPYtBdmhJDI90bulTcXSz
         eBQewoBIOxfyLqsHWp2RsqNJxvY/KD93CE0el2C2E6u/EkLmCU9gCb/veT6oEmGvBEZk
         PHNohB51ZtIgx4LuNTbkwyY6uwgMM2TUK5jMX3ypIANrf8QzAcD4h50OhJEL3EUJpOwf
         JhXJ9RpezLcp7tQiFw6HFPFzzoB8wp6gPPVsE5zSOmtnZy5OPQaHAI7RoD0i5GR2bHrr
         82uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=nH8KNmMkFHa8evlmWJ3rCG8FeeVjIvPqpZsmckvI3Ag=;
        b=Di/6NSYqLTREeR/OqI5kq8TEYeClx7rL1QAhM3OYGyb8sAw+fhPak591ZJg4u+Eux6
         tMcf/if6cFTZC9ZGOp7NrPpql7nPSFLauJFuN+lSOSnJ7LaVh1sta4RSKKmlotSynlx/
         GPZ9J35/CPkNWMdT0HgJi9chfzZhVmYu4+1O8+MyG9inzgLDhpo769WY9f3KaMaBcP5J
         2mk8JUjkNnL7EjSNl4GtoDTza1Itj/YsqnS1+gq297qtrIDsGVVDtMXxG4vWH6nSIQJC
         YRfZzuISUfws5P57T7Xyluj6yCM7gnmwOoaxiLeIQvA0Lyx61SvWSCiet6xBme+zWuj/
         vPXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12672-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12672-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12672-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12672-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 16 Mar 2018 20:12:15 +0000
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
Message-ID: <20180316201215.GG30522@ZenIV.linux.org.uk>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com>
 <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk>
 <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595126493720932591?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 12:27:23PM -0700, Linus Torvalds wrote:

> But it sure isn't "variable" either as far as the standard is
> concerned, because the standard doesn't even have that concept (it
> uses "variable" for argument numbers and for variables).

Huh?  6.7.5.2p4:

If the size is not present, the array type is an incomplete type.
If the size is * instead of being an expression, the array type is
a variable length array type of unspecified size, which can only be
used in declarations with function prototype scope [footnote]; such
arrays are nonetheless complete types.  If the size is an integer
constant expression and the element type has a known constant size,
the array type is not a variable length array type; otherwise, the
array type is a variable length array type.

footnote: Thus, * can be used only in function declarations that are
not definitions (see 6.7.5.3).

That's C99, straight from N1256.pdf (C99-TC3)...
