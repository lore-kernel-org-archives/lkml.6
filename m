Return-Path: <kernel-hardening-return-11792-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227Q3I/6VxyPyoIrzgRAPHYeyLTBROHGk3oE062qx/uZ951pHUv43iPHkJofE3YqyJ8Ska6B
ARC-Seal: i=1; a=rsa-sha256; t=1518643470; cv=none;
        d=google.com; s=arc-20160816;
        b=1FZSSloAeP41UUiZhTOw1Rgf/boZzSeC/jjhLREUsUgro299IsFGo0daCjwL4qeIKW
         w/ldDNONmKyRhRNqU9vK1s/lALsn6la0nvQRBwbKM0rABhUle1fgHKt0/DH/+TrhU1bo
         2trjSWX7bMpfWz7YmkbE/jDmEaEQjTlDxATTM363tbWSngaUXRN9oUMPeOXBdcVdEFD4
         0y2xVGJTQCSpIv6tcarUVvIytyx2v1kKGuGTFzLnCCK48qVqYJFdVgREbiL68GDWlPOm
         cubyAlNJYxUyPR4CCeDapa5Lw3BCCafmdPoGL+OlBjiyXRra4T3QgVDRH20PtyzoeaXK
         vNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=mP0F1n3y/L4JGy4c/We2YtWqxkbeASS1RoWoh98F0IY=;
        b=flevAQkl4d9GtUgpw5aWsS+VrwLb4Q6Jb7W7w2pyAnfCOrBlTzWcIqLx8jhc618Lcl
         bBx9iWFtwRRyuRNdb+25tC0ekUJX0lFLdc8XUmbp/EH4sENHqL80cExHOPAOCflMSli+
         ejlwR8TDmlk2d81t2ef7bPvVtXU20lICi/1N/jbNjIfmsVwlCrxEAI+lwXBUszCQhHFc
         CrXnlPu4pZO8KeH9AukH8V85EuylCbIo6s2aF8nXisC/5bMFfmXFI1tkH4glKwWigjJN
         OwzcKIghVZjGQJ6gk3neyso6ShMd1WGOGvA5cwsxMdE5liUq+tOv3c70gleYhzYXDKVk
         OhWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11792-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11792-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11792-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11792-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2553:2559:2562:2731:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:7808:7903:7904:8603:8660:9108:10004:10400:10848:11026:11232:11658:11914:12296:12740:12760:12895:13148:13230:13439:14096:14097:14659:14721:21080:21611:21627:21740:30029:30034:30054:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: cord58_41b0e43e6505c
X-Filterd-Recvd-Size: 3470
Message-ID: <1518643449.3678.33.camel@perches.com>
Subject: Re: [PATCH v2 2/8] mm: Add kvmalloc_ab_c and kvzalloc_struct
From: Joe Perches <joe@perches.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
 <mawilcox@microsoft.com>, linux-mm@kvack.org, Kees Cook
 <keescook@chromium.org>,  linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
Date: Wed, 14 Feb 2018 13:24:09 -0800
In-Reply-To: <20180214211203.GF20627@bombadil.infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
	 <20180214201154.10186-3-willy@infradead.org>
	 <1518641152.3678.28.camel@perches.com>
	 <20180214211203.GF20627@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408583578566616?=
X-GMAIL-MSGID: =?utf-8?q?1592413096607144032?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-14 at 13:12 -0800, Matthew Wilcox wrote:
> On Wed, Feb 14, 2018 at 12:45:52PM -0800, Joe Perches wrote:
> > On Wed, 2018-02-14 at 12:11 -0800, Matthew Wilcox wrote:
> > > We have kvmalloc_array in order to safely allocate an array with a
> > > number of elements specified by userspace (avoiding arithmetic overflow
> > > leading to a buffer overrun).  But it's fairly common to have a header
> > > in front of that array (eg specifying the length of the array), so we
> > > need a helper function for that situation.
> > > 
> > > kvmalloc_ab_c() is the workhorse that does the calculation, but in spite
> > > of our best efforts to name the arguments, it's really hard to remember
> > > which order to put the arguments in.  kvzalloc_struct() eliminates that
> > > effort; you tell it about the struct you're allocating, and it puts the
> > > arguments in the right order for you (and checks that the arguments
> > > you've given are at least plausible).
> > > 
> > > For comparison between the three schemes:
> > > 
> > > 	sev = kvzalloc(sizeof(*sev) + sizeof(struct v4l2_kevent) * elems,
> > > 			GFP_KERNEL);
> > > 	sev = kvzalloc_ab_c(elems, sizeof(struct v4l2_kevent), sizeof(*sev),
> > > 			GFP_KERNEL);
> > > 	sev = kvzalloc_struct(sev, events, elems, GFP_KERNEL);
> > 
> > Perhaps kv[zm]alloc_buf_and_array is better naming.
> 
> I think that's actively misleading.  The programmer isn't allocating a
> buf, they're allocating a struct.  kvzalloc_hdr_arr was the earlier name,
> and that made some sense; they're allocating an array with a header.
> But nobody thinks about it like that; they're allocating a structure
> with a variably sized array at the end of it.
> 
> If C macros had decent introspection, I'd like it to be:
> 
> 	sev = kvzalloc_struct(elems, GFP_KERNEL);
> 
> and have the macro examine the structure pointed to by 'sev', check
> the last element was an array, calculate the size of the array element,
> and call kvzalloc_ab_c.  But we don't live in that world, so I have to
> get the programmer to tell me the structure and the name of the last
> element in it.

Look at your patch 4

-       dev_dax = kzalloc(sizeof(*dev_dax) + sizeof(*res) * count, GFP_KERNEL);
+       dev_dax = kvzalloc_struct(dev_dax, res, count, GFP_KERNEL);

Here what is being allocated is exactly a struct
and an array.

And this doesn't compile either.
