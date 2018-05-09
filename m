Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AB8JxZoj0o4MpiX5se0zJ4NhVNuLbJAh0BVSGiMhdtwWeF4tWiRcJoPoV6DKZRL9zDGehzOShDD9
ARC-Seal: i=1; a=rsa-sha256; t=1525829978; cv=none;
        d=google.com; s=arc-20160816;
        b=wpg2m2vdDuSh8smwlqJtWMRHJ64oCcfBVaDhvEahD1fMl53sXEfnaYdXoHVvNuMSlx
         1+k2UdnHeoJ9kAlxAjW7XsKScmr90Lu/5eCoaKv3uErqtJkfUvKM0r/TeZs3+mVTbzOQ
         2zJP+5QtI4+WTNn0rEFwLU9/sBNjsrhHOgJMHwKD00swbN1LFLM/PZ/RJeHE4IVl26eh
         XBHjMzgzr1kkfhCaPl+QDGyAp6bYZUz6UFFWP1ynlVW8ouuc7MKtaqXcYpIkYYU5EzYi
         LSBrmF0gupSOTuUZISAGlIDu/XJeFt0CKf0a+tqeiBxtRgwFZe9ICdno6chM7MzFoSi8
         L6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=8PmwyW5IUu5NzBXGt9KFTxExjS6LV2JS61w/64TeX84=;
        b=kFIcINI0MXffTyLwJOEX59UStNIH3GLJBeLk4TDLJQYw11HdVXJiqNcCQDWj3DAx7n
         dwfi3WZ2dvJNbN3g0GA3jzZBGZL1SkaNOd8q39Hk9V/GRUsD8dAWAaRA76nKP74Hy/Nh
         WIFYaYpVaH0lKq7gzW3kaKXMwo44895xU8YHJh9RL1wSAu+Z/77ekTG8rr9MWs1n93hn
         IWapzgMP0M4oMEfOxa5VtMFGKQXEMAXouZhkcubooS7mi7HBFAZU7xIPLfJwSwZPHJjY
         vtIZe748rWLAbGunf5Qef5kSv5wlQG2ptf6MbG2xVp7clOF30ubvlrd9DMzxPYq+A8ru
         9OYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=VLb2RoYu;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=VLb2RoYu;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Tue, 8 May 2018 18:39:35 -0700
From: Matthew Wilcox <willy@infradead.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	linux-ia64@vger.kernel.org
Subject: Re: [PATCH] mm: provide a fallback for PAGE_KERNEL_RO for
 architectures
Message-ID: <20180509013935.GA8131@bombadil.infradead.org>
References: <20180428001526.22475-1-mcgrof@kernel.org>
 <20180428031810.GA14566@bombadil.infradead.org>
 <20180509010438.GM27853@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509010438.GM27853@wotan.suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598946836077947117?=
X-GMAIL-MSGID: =?utf-8?q?1599948695139755213?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 01:04:38AM +0000, Luis R. Rodriguez wrote:
> On Fri, Apr 27, 2018 at 08:18:10PM -0700, Matthew Wilcox wrote:
> > ia64: Add PAGE_KERNEL_RO and PAGE_KERNEL_EXEC
> > 
> > The rest of the kernel was falling back to simple PAGE_KERNEL pages; using
> > PAGE_KERNEL_RO and PAGE_KERNEL_EXEC provide better protection against
> > unintended writes.
> > 
> > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Nice, should I queue this into my series as well?

A little reluctant to queue it without anyone having tested it.  Heck,
I didn't even check it compiled ;-)

We used to just break architectures and let them fix it up for this kind
of thing.  That's not really acceptable nowadays, but I don't know how
we get arch maintainers to fix up their ports now.
