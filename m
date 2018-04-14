Return-Path: <SRS0=uqI5=HD=gmail.com=adobriyan@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3054875-1523747397-2-5557155548629802272
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=uqI5=HD=gmail.com=adobriyan@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523747397; b=OSzOKAry5Iiz4wAuWCMe87o/0y1+t7JJy2eU72/dgYujHBMKVl
    ciBtgKJNrI7PuWxmmSouDrBpc3BWd0YEOHPcn0E4vCboEp7iuIgCvEpftHf18rwP
    AAlAkvw75qfDYI6FuOpAhQOoZvK4TmEfZrYFjnnjwJlA3UCyk8xTO8LOwfB42ohR
    luayzVV8fqEKDCOniQcBrgZjS04YNrU+BRgAnX/HlZDMas63LOhQq660FmiCb42u
    4VYkF/52pi/4lnZ3C7VPoaLpJL+xTk/X8Q2gcJGQdBcqb4qSNTG595rV9WNW/kyA
    mmPxk8qAtmL8cjjwysO/ivgbAlUnDAa/FIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1523747397; bh=1y3algtFeOsfZ4sVfxQlvQBIuYLWc0xgDR1YpexRNkM=; b=Q
    THi4pNNj9rVqOUMYeKxH+kN48wmfNqMdDzB/1+MAoTedUyDoCJe7ZPO3L42cRNBi
    Dtt6jV9xm8T5wu6lwmsyyQfb1t/v3vhD5FMF30vx8RdSPoBun+pMdnTJRszT6qbT
    JOuIUKkKSJRzUsNsjKCxgRpEy5G1Yn85+5RBx0I+T3A+ceu4FqbbvqOVGE4Lra/B
    q6KEmOaZgQwLUQlrSueHF8bfdN6EB0adhhV8jt0H8Y/MVyh8IW5yIiGHOuNHAPNd
    7LTsRt/wWYhHQU6ATdUtGRydcfH3M3p2BdZsay2ryFost31VC1aV38ISxiKds5NT
    E8gr+h7sQVY1LsY9BMsrQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QLo9AtIU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=uqI5=HD=gmail.com=adobriyan@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JDZXyrkA;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QLo9AtIU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=uqI5=HD=gmail.com=adobriyan@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JDZXyrkA;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMnpr4z3s1N9bhPFHMeTJEJGwPOL4zivXMBpj5JU1EiS0b1e1gYa0PbOWvldGmC233JkbUepmaQjrqGdpEMLB159jNpXAO6cAyGaHRVvjtG+ZgqK6PHI
    MGeGUEvQQCa0cUHR8TJA9uRvaCAoX+XLJWuk9ZfayQNpOD+eaMWHih/PZmLLSo9HUkJV1celaWoGox+d61D2N5BcshLVCzXIuN8=
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=aLjZf_mOksQA:10 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=wam9qgTbhDu0JMQCUGMA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4DB2173B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=adobriyan@gmail.com
X-Google-Smtp-Source: AIpwx4+0FEEiuaozmzesQ3Bii5xuSCP+ZGI5G4Tfvfp0IrmdjLQSdiiTyKVi9SXeg2MYbXNitgFAOA==
Date: Sun, 15 Apr 2018 02:09:49 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Ted Ts'o <tytso@mit.edu>,
	kvm list <kvm@vger.kernel.org>, security@kernel.org
Subject: Re: repeatable boot randomness inside KVM guest
Message-ID: <20180414230949.GA16241@avx2>
References: <20180414195921.GA10437@avx2>
 <CALCETrV2NdGnVose-xRRPG2jDCo6K9MTayYR8XUZFw5j6nU2hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrV2NdGnVose-xRRPG2jDCo6K9MTayYR8XUZFw5j6nU2hg@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 14, 2018 at 03:41:42PM -0700, Andy Lutomirski wrote:
> On Sat, Apr 14, 2018 at 12:59 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > SLAB allocators got CONFIG_SLAB_FREELIST_RANDOM option which randomizes
> > allocation pattern inside a slab:
> >
> >
> >         #ifdef CONFIG_SLAB_FREELIST_RANDOM
> >         /* Pre-initialize the random sequence cache */
> >         static int init_cache_random_seq(struct kmem_cache *s)
> >         {
> >                 ...
> >
> > Then I printed actual random sequences for each kmem cache.
> > Turned out they were all the same for most of the caches and
> > they didn't vary across guest reboots.
> >
> >         int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count, gfp_t gfp)
> >         {
> >                 ...
> >                 /* Get best entropy at this stage of boot */
> >                 prandom_seed_state(&state, get_random_long());
> >
> > Then I searched internet and turned out KVM can pass randomness via
> > virtio-rng or something. So I linked /dev/urandom.
> >
> > And it didn't help!
> >
> > The only way to get randomness for SLAB is to enable RDRAND inside guest.
> >
> > Is it KVM bug?
> >
> > For the record I'm using qemu 2.11.1-r2 and whatever F27 ships now.
> 
> virtio-rng doesn't really do that.  I have an ancient patch set to do
> exactly what you want, and I should dust it off.

Please, do. Here is a list of caches which aren't exactly randomly
randomized with my setup. Many important ones are there :-(

XXX name 'dma-kmalloc-96', r b1e6718e2e7147d4
XXX name 'dma-kmalloc-192', r a7664a0d69968019
XXX name 'dma-kmalloc-8', r 662c2e986443235c
XXX name 'dma-kmalloc-16', r 770a9b620ae4cd62
XXX name 'dma-kmalloc-32', r 2e200073d5fa9f46
XXX name 'dma-kmalloc-64', r d8538fda83c74168
XXX name 'dma-kmalloc-128', r 9e4b956d09dd7d44
XXX name 'dma-kmalloc-256', r 8b14bcb58f9e18f5
XXX name 'dma-kmalloc-512', r 2bbace4b7120624a
XXX name 'dma-kmalloc-1024', r 7cdf44406db52f5b
XXX name 'dma-kmalloc-2048', r 18fe0ebf6bcfdf43
XXX name 'dma-kmalloc-4096', r 9f1a5eee118facf7
XXX name 'dma-kmalloc-8192', r f514d72a1cc441a2
XXX name 'kmalloc-8192', r 14843df817b556cc
XXX name 'kmalloc-4096', r 52ed85fa9c691bbe
XXX name 'kmalloc-2048', r fa81aa9222ff65a7
XXX name 'kmalloc-1024', r ae355c02d31f21d3
XXX name 'kmalloc-512', r 5fe0d22aaf2ef8d9
XXX name 'kmalloc-256', r 336d07a06917b95
XXX name 'kmalloc-192', r 6b6cd5399dd06d95
XXX name 'kmalloc-128', r 893b9e85369964ab
XXX name 'kmalloc-96', r 179e185395d2612
XXX name 'kmalloc-64', r 29cf688b37eccea7
XXX name 'kmalloc-32', r fb7b4e7dca6de00a
XXX name 'kmalloc-16', r a2a441fdc499d0c7
XXX name 'kmalloc-8', r e5454c7095ddd2be
XXX name 'kmem_cache_node', r 500dc6126a47b229
XXX name 'kmem_cache', r 816c8c7bcde08372
XXX name 'task_group', r c09c4d1c1436ce97
XXX name 'radix_tree_node', r 4dd9540b830a4ea8
XXX name 'pool_workqueue', r 88b1e9d9a1f0b570
XXX name 'Acpi-Namespace', r 3e34d55f8f1cb140
XXX name 'Acpi-State', r b94e04635e77b48a
XXX name 'Acpi-Parse', r d5374863b90f2a4c
XXX name 'Acpi-ParseExt', r eefb2fff892f64a9
XXX name 'Acpi-Operand', r ce51949bcc80af13
XXX name 'pid', r cd6d8ee9e5209156
XXX name 'anon_vma', r c3a9273a68127ac7
XXX name 'anon_vma_chain', r a7cec15033c31a9b
XXX name 'cred_jar', r fe4cc38c6d99cf63
XXX name 'task_struct', r eecb8895c6b7dbdb
XXX name 'sighand_cache', r e5243c5eb2ce3a63
XXX name 'signal_cache', r 88b2e108d8ef81c7
XXX name 'files_cache', r ee29814e58dc909c
XXX name 'fs_cache', r bc700a5f8fc28ff8
XXX name 'mm_struct', r f5230f99c7447359
XXX name 'vm_area_struct', r e30f3f8e648a9f88
XXX name 'nsproxy', r ae7c08b524a0f4d4
XXX name 'uts_namespace', r 6b1266178968ed99
XXX name 'buffer_head', r b24c10679dc55a11
XXX name 'names_cache', r 2e023b54e3ca5b8f
XXX name 'dentry', r 83cc18634fbd74e8
XXX name 'inode_cache', r ff9a0ff3b4665cf5
XXX name 'filp', r 4fdad214b7ca7fc1
XXX name 'mnt_cache', r 8e726d32470b23e0
XXX name 'kernfs_node_cache', r 929c5f56778d365d
XXX name 'bdev_cache', r 8a5520036bd0a464
XXX name 'sigqueue', r 2cf75c4d16191efb
XXX name 'seq_file', r ec3ba1fe514524d5
XXX name 'proc_inode_cache', r b0c76cbbda5bb41f
XXX name 'pde_opener', r 5f82f8e7100a517c
XXX name 'proc_dir_entry', r ebabc4e93b52d7b8
XXX name 'shmem_inode_cache', r 2b25a3eb9aa32973
XXX name 'net_namespace', r 95793a7eae08a33f
