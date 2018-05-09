Return-Path: <adobriyan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525884814; cv=none;
        d=google.com; s=arc-20160816;
        b=K5P4v1rTGrdtsw/ExDirJoWCVuUQF+ty7US7rCwnwdp1NdTHXZikuZiX5AEcLPWi8k
         PmUlnuT5Xvk3mRH5tv8YjkM7RQNykLnj5S3j/Rubw7OMB/ldSx60QPCOmA2/2aREn0n1
         EJAmddn02MqKFf2TTD6LVtSNqrwE3MmLupS6XfkI9yZY6k/qPZtJu+wni3ysZnB+4fGj
         7qCByEu6JK1rKy6lcEPnqVveIh2wh935BiDkIiHhQagmxrgVSle5i53qAmfZ05aN2x5y
         HO5+a4MLOVWbTOtYHLcYeDC/Jw4p3ldw55zNOHCN+PeanF+sgubqrWNAs6Sp4FqQxOlq
         k2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=EyxVyRxgkUjVBc10QVnzt2HADPxdcMg26Ol20GVWdjU=;
        b=STylTYHdsfc7TO2AxPrdRmiIlId846f6c/FnzfVSqnsZ8976nslFLHfu+e068FH/zv
         ItQKwKahzGZH8THxxIUmjcPtbcv1NIS+iEIRw5Zhwwt4b52BIkd2o9sQA2oRwTI4fL/+
         59shZQ+dq4HfieEjAy+vpMKe8s9EVMBTTEliX3Uxgs96Hf+Xw+HmF7H3KjP83kWE0rI7
         EaW/IP0HsoNUBJdMOu9J6iTde8B8HkPuwUjLmjobKJPuTR+FcZ0XAxR3O6UitE3n3FRW
         UJ64A/QcdoOciyZXS8Sb0mu1jsKAWK8t0cyp+Ng/TvyLn9L1/y+ChYxK0UTmnnqNXZxg
         sxPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lqsOwVAS;
       spf=pass (google.com: domain of adobriyan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=adobriyan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lqsOwVAS;
       spf=pass (google.com: domain of adobriyan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=adobriyan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpaqJooJuE5V0VpPl2DmyIod2drMKx3TMp//uzzaIBrNtROeTCvHAQ41DPpBzBwQ9Ya2VJgKQ==
Date: Wed, 9 May 2018 19:53:31 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-acpi@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: simplify procfs code for seq_file instances V2
Message-ID: <20180509165331.GC16034@avx2>
References: <20180425154827.32251-1-hch@lst.de>
 <20180506171948.GA769@avx2>
 <20180506174531.GK30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180506174531.GK30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598733748805898460?=
X-GMAIL-MSGID: =?utf-8?q?1600006195168604948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 06, 2018 at 06:45:31PM +0100, Al Viro wrote:
> On Sun, May 06, 2018 at 08:19:49PM +0300, Alexey Dobriyan wrote:

> > @@ -62,9 +62,9 @@ struct proc_dir_entry {
> >  	umode_t mode;
> >  	u8 namelen;
> >  #ifdef CONFIG_64BIT
> > -#define SIZEOF_PDE_INLINE_NAME	(192-139)
> > +#define SIZEOF_PDE_INLINE_NAME	(192-155)
> >  #else
> > -#define SIZEOF_PDE_INLINE_NAME	(128-87)
> > +#define SIZEOF_PDE_INLINE_NAME	(128-95)
> 
> >  #endif
> >  	char inline_name[SIZEOF_PDE_INLINE_NAME];
> >  } __randomize_layout;
> 
> *UGH*

I agree. Maintaining these numbers is a pain point.
Who knew people were going to start adding fields right away.

> Both to the original state and that kind of "adjustments".
> Incidentally, with __bugger_layout in there these expressions
> are simply wrong.

Struct randomization is exempt from maintaining sizeof as they are already
screwing cachelines and everything. But if patch works with lockdep and
randomization -- even better.

> If nothing else, I would suggest turning the last one into
> 	char inline_name[];
> in hope that layout won't get... randomized that much and
> used
> 
> #ifdef CONFIG_64BIT
> #define PDE_SIZE 192
> #else
> #define PDE_SIZE 128
> #endif
> 
> union __proc_dir_entry {
> 	char pad[PDE_SIZE];
> 	struct proc_dir_entry real;
> };
> 
> #define SIZEOF_PDE_INLINE_NAME (PDE_SIZE - offsetof(struct proc_dir_entry, inline_name))
> 
> for constants, adjusted sizeof and sizeof_field when creating
> proc_dir_entry_cache and turned proc_root into
> 
> union __proc_dir_entry __proc_root = { .real = {
>         .low_ino        = PROC_ROOT_INO,
>         .namelen        = 5,
>         .mode           = S_IFDIR | S_IRUGO | S_IXUGO,
>         .nlink          = 2,
>         .refcnt         = REFCOUNT_INIT(1),
>         .proc_iops      = &proc_root_inode_operations,
>         .proc_fops      = &proc_root_operations,
>         .parent         = &__proc_root.real,
>         .subdir         = RB_ROOT,
>         .name           = __proc_root.real.inline_name,
>         .inline_name    = "/proc",
> }};
> 
> #define proc_root __proc_root.real
> (or actually used __proc_root.real in all of a 6 places where it remains).
> 
> > -	size_t state_size = PDE(inode)->state_size;
> > +	unsigned int state_size = PDE(inode)->state_size;
> 
> <shakes head>
> You and your "size_t is evil" crusade...

[nods]

        unsigned long           flags;          /* error bits */
        unsigned long           i_state;
        unsigned long           s_blocksize;
        unsigned long           s_flags;
        unsigned long           s_iflags;       /* internal SB_I_* flags */
