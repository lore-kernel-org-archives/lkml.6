Return-Path: <kernel-hardening-return-11839-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227IDwcNksAeQkILVAmZOlygFLcfbfpKFRwwRA/cGJG8/aJuB4CZ88QBA0w31KQBtu8TtUsY
ARC-Seal: i=1; a=rsa-sha256; t=1519170993; cv=none;
        d=google.com; s=arc-20160816;
        b=jtUYCXCGL5NyENRDH3ZrbmOr3B5EnkqvJx2Fo/FEZox1caNBdab/M3BXDUzoAv79Ff
         +q0/0987Kz0iMWyK+o5JtGN7uY4V0GH50hxDm/XyjLBFT35VjJTFpYSRSapPZ/DUdDts
         epQJejaLTERmYL1vB6f3t0SgrBN6Ra/NldK3oU2ZTE1BxpDt+NpB8vDYj/abVvPhSmj8
         AfceglG7oNrPdF2ODa9U/PT5cgt9q/x/ffuuTWicVvQtLgbMFhHmyb7ro4bokFigz2yV
         BkOrjsKrvnCpEB7NX7fKndGOYQBGD1rvlZK9EftauBXYrRIN0pNdznjJcA0RyOtJjRBW
         9DOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=uhYTRlEqNS+ZxV3VM5OvEqJO4cq9EQ32LI1u+Lrh3S4=;
        b=Ut0AVBlhSOn401hN75K7XRqHo61YVo26R7LzqMVzDn+atXTPcr8j3XtqoJip95E8kl
         AbZiA0Uny7zNLQPZSOq7io4lrgp92estZZjECYRzBFOqeX4Rm1YQ/jGsfJv9mtFsb9VS
         sTbi1xJC31bSKanDcJtg2033cXv12MqUvt0d4iguA/YxQfQPT+GCUhcdU1W85OI+ucf4
         oJ8A1yqNCfUIfJlqb91du0A/oJ1nsuwEejr3Uk0lf0WF0I35haPCxe2uvkOamXl+1S1h
         49UAdnhzgxRLQw5DMU4g4azT8Vc3iGiJzV55rdMHL9I/gDJROD1MC3MIFmzhNSeu+PZ4
         IEtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=N08RLcP2;
       spf=pass (google.com: domain of kernel-hardening-return-11839-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11839-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=N08RLcP2;
       spf=pass (google.com: domain of kernel-hardening-return-11839-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11839-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 20 Feb 2018 15:56:00 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <dchinner@redhat.com>
Cc: Igor Stoppa <igor.stoppa@huawei.com>, Kees Cook <keescook@chromium.org>,
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
Message-ID: <20180220235600.GA3706@bombadil.infradead.org>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
 <CAGXu5j+ZNFX17Vxd37rPnkahFepFn77Fi9zEy+OL8nNd_2bjqQ@mail.gmail.com>
 <20180220012111.GC3728@rh>
 <24e65dec-f452-a444-4382-d1f88fbb334c@huawei.com>
 <20180220213604.GD3728@rh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220213604.GD3728@rh>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214870438978682?=
X-GMAIL-MSGID: =?utf-8?q?1592966242968937868?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 08:36:04AM +1100, Dave Chinner wrote:
> FWIW, I'm not wanting to use it to replace static variables. All the
> structures are dynamically allocated right now, and get assigned to
> other dynamically allocated pointers. I'd likely split the current
> structures into a "ro after init" structure and rw structure, so
> how does the "__ro_after_init" attribute work in that case? Is it
> something like this?
> 
> struct xfs_mount {
> 	struct xfs_mount_ro{
> 		.......
> 	} *ro __ro_after_init;
> 	......

No, you'd do:

struct xfs_mount_ro {
	[...]
};

struct xfs_mount {
	const struct xfs_mount_ro *ro;
	[...]
};

We can't do protection on less than a page boundary, so you can't embed
a ro struct inside a rw struct.

> Also, what compile time checks are in place to catch writes to
> ro structure members? Is sparse going to be able to check this sort
> of thing, like is does with endian-specific variables?

Just labelling the pointer const should be enough for the compiler to
catch unintended writes.

> > I'd be interested to have your review of the pmalloc API, if you think
> > something is missing, once I send out the next revision.
> 
> I'll look at it in more depth when it comes past again. :P

I think the key question is whether you want a slab-style interface
or whether you want a kmalloc-style interface.  I'd been assuming
the former, but Igor has implemented the latter already.
