Return-Path: <kernel-hardening-return-11836-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226sL6tOTN4N4tWbU0Fwf6cER9RdM/0fhxTk1MJzr35KU46XDZzWyxYPy8mq/cC292LR7gKF
ARC-Seal: i=1; a=rsa-sha256; t=1519163459; cv=none;
        d=google.com; s=arc-20160816;
        b=YB2K3GIC7uuxSYYDWEjAdE2T3cogpVJfkBk85N1vSCVBMZxWZ/Ef692cKLQuAhMEg+
         djBg1Mk3J+O3IOdn1Ct46x9x+e8lzX6jdCw+NXSQ536hxtxn8mdO4SF0GrkxY9ba0/dB
         QBPBhVveTU/Hg+gJkflF1A72/38Iyrw3sAyJqCjAgduKRmEY1oenfEfG+hXzyn4LDReo
         a2vKrShMOseHIpa0MKt/fbr1zAWA9UEtO4clGHTPRPUpsJP0DFuS4KcUm9QchRtBTmft
         jYuKDjTWrR94+xFPl+2o4M7D+d2Vu8aZW9bawEtpoPR0UQN51wsc0CGdtdPh44qqtStJ
         Iz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=YGdi/S4+WSGTDs9Cc+dMhOXqD7VNlNKqfdWvp8dwbuc=;
        b=YPzrKAC76U1QD4c7oF1QkVB46su076A3eHlWoeadqA1YLRi77kl58FxHTFclVyYGQ4
         PUQ6FJaFXzJOO6p5ciLdzgPDIoOHwAwRfvz4zRfSNzj/fzdG3Sa/RuEs0lzbbwDjSHn6
         yL6RIG6nrLgFTYT1jlUIJmkj81zdtM9mrw3g/rtDxb2/3prWPKs1IT+th2Ml7bsU5/WK
         OaD9L49uiM2q55QjIeI4M3qZ3med9sqwIEK+CpYGP4WSyvX1izjUnPv3UzO1oMCq/9Cw
         kpgyEmhDv0cILYl6vHzI1ppWquFDQcbHH1wAdC5rYD4K05/rv+4pyf57FpZu9kKOomKG
         Tp2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11836-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11836-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11836-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11836-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 21 Feb 2018 08:36:04 +1100
From: Dave Chinner <dchinner@redhat.com>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Laura Abbott <labbott@redhat.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <cl@linux.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC PATCH v16 0/6] mm: security: ro protection for dynamic data
Message-ID: <20180220213604.GD3728@rh>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
 <CAGXu5j+ZNFX17Vxd37rPnkahFepFn77Fi9zEy+OL8nNd_2bjqQ@mail.gmail.com>
 <20180220012111.GC3728@rh>
 <24e65dec-f452-a444-4382-d1f88fbb334c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24e65dec-f452-a444-4382-d1f88fbb334c@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214870438978682?=
X-GMAIL-MSGID: =?utf-8?q?1592958343926305908?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 08:03:49PM +0200, Igor Stoppa wrote:
> 
> 
> On 20/02/18 03:21, Dave Chinner wrote:
> > On Mon, Feb 12, 2018 at 03:32:36PM -0800, Kees Cook wrote:
> >> On Mon, Feb 12, 2018 at 8:52 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> >>> This patch-set introduces the possibility of protecting memory that has
> >>> been allocated dynamically.
> >>>
> >>> The memory is managed in pools: when a memory pool is turned into R/O,
> >>> all the memory that is part of it, will become R/O.
> >>>
> >>> A R/O pool can be destroyed, to recover its memory, but it cannot be
> >>> turned back into R/W mode.
> >>>
> >>> This is intentional. This feature is meant for data that doesn't need
> >>> further modifications after initialization.
> >>
> >> This series came up in discussions with Dave Chinner (and Matthew
> >> Wilcox, already part of the discussion, and others) at LCA. I wonder
> >> if XFS would make a good initial user of this, as it could allocate
> >> all the function pointers and other const information about a
> >> superblock in pmalloc(), keeping it separate from the R/W portions?
> >> Could other filesystems do similar things?
> > 
> > I wasn't cc'd on this patchset, (please use david@fromorbit.com for
> > future postings) 
> 
> Apologies, somehow I didn't realize that I should have put you too in
> CC. It will be fixed at the next iteration.

No worries, If you weren't at LCA, you wouldn't have known :P

> > so I can't really say anything about it right
> > now. My interest for XFS was that we have a fair amount of static
> > data in XFS that we set up at mount time and it never gets modified
> > after that.
> 
> This is the typical use case I had in mind, although it requires a
> conversion.
> Ex:
> 
> before:
> 
> static int a;
> 
> 
> void set_a(void)
> {
> 	a = 4;
> }
> 
> 
> 
> after:
> 
> static int *a __ro_after_init;
> struct gen_pool *pool;
> 
> void init_a(void)
> {
> 	pool = pmalloc_create_pool("pool", 0);
> 	a = (int *)pmalloc(pool, sizeof(int), GFP_KERNEL);
> }
> 
> void set_a(void)
> {
> 	*a = 4;
> 	pmalloc_protect_pool(pool);
> }

Yeah, that's kinda what I figured. I'm guessing that I treat a pool
just like a normal heap allocation, but then when all the objects I
need to allocate are fully initialised, then I write protect the
pool? i.e. the API isn't using an object-based protection scope?

FWIW, I'm not wanting to use it to replace static variables. All the
structures are dynamically allocated right now, and get assigned to
other dynamically allocated pointers. I'd likely split the current
structures into a "ro after init" structure and rw structure, so
how does the "__ro_after_init" attribute work in that case? Is it
something like this?

struct xfs_mount {
	struct xfs_mount_ro{
		.......
	} *ro __ro_after_init;
	......

Also, what compile time checks are in place to catch writes to
ro structure members? Is sparse going to be able to check this sort
of thing, like is does with endian-specific variables?

> I'd be interested to have your review of the pmalloc API, if you think
> something is missing, once I send out the next revision.

I'll look at it in more depth when it comes past again. :P

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com
