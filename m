Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AG47ELuq+RKK1eRELVesbrnsREJOqZmJQJpEBO9jIKE6WeVH/kz5zLncXB1ViO/2t2yXZ8/apX5x
ARC-Seal: i=1; a=rsa-sha256; t=1521833428; cv=none;
        d=google.com; s=arc-20160816;
        b=wpGdu/ATWzMyyW2W34yI3LjJLxK52NtMDfIuBne/d5KSerTRYEmB6gSwmWdvvIL7Zs
         1qRNADEMt06HbePwoVkX0ziUCxLall23iBS1KjQN4T2l5GhQiOr4Pyg7FHc9/yOYLCXz
         /kC2AtnL5G0TSHp6TDPmipYt5Put6U7CGdISrcr2CkFmLL1yCkKkb3El7sLdVhFKhp7r
         1Pwy92rvsknfhovIrnfsjKnL0e2bwokfHLAfrn/q6HScYml2PbemaKDw1K5M7DoMQuKS
         y3Lh9Ia5Q3E+Ca4Qi/OdkhB/tHTJdKRu56TPNCA3EBYvXirLcSwtS06/KUHDDT/cKX0c
         vFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=MirZhxLY8cA+YArmokNLxWyxSkmZVZH0lgxlZu/6dFA=;
        b=As/bQvsd3Jqo5HRduPKCjyAGlCB8z1BuScQrJ6FUMpk3ot33zTATPG3hCQIC0Qo7CP
         LGApCPK1IMpH6IcRH1wL4/F2y6/zraW28B5J4YobXXvzp6LJi+2W2OYrvzHTnlTF0vga
         qtdYLsezmL62GQoYNDggSrbg+H9N0ksud7eqT5R9Mq7Ddeqz1GrNSFG2U1TbeH30weBt
         NcD8JRFod57aoNMF4UcePSvaLhMnhgoZO291IoCU/xf10Gb9j+gQn1OlGmSwI3y+tHwd
         BEUdhdMSURMo09cmRWigdVagVw9VcAxrKbg307oF8PZD+aq7MgnKUdingj8IFQkhxZjP
         yB/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=taouZ44F;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=taouZ44F;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Fri, 23 Mar 2018 12:29:52 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Rich Felker <dalias@libc.org>
Cc: Ilya Smith <blackzert@gmail.com>, rth@twiddle.net,
	ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
	linux@armlinux.org.uk, tony.luck@intel.com, fenghua.yu@intel.com,
	jhogan@kernel.org, ralf@linux-mips.org, jejb@parisc-linux.org,
	deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
	mpe@ellerman.id.au, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
	davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, nyc@holomorphy.com,
	viro@zeniv.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org,
	deepa.kernel@gmail.com, mhocko@suse.com, hughd@google.com,
	kstewart@linuxfoundation.org, pombredanne@nexb.com,
	akpm@linux-foundation.org, steve.capper@arm.com,
	punit.agrawal@arm.com, paul.burton@mips.com,
	aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
	keescook@chromium.org, bhsharma@redhat.com, riel@redhat.com,
	nitin.m.gupta@oracle.com, kirill.shutemov@linux.intel.com,
	dan.j.williams@intel.com, jack@suse.cz,
	ross.zwisler@linux.intel.com, jglisse@redhat.com,
	aarcange@redhat.com, oleg@redhat.com, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
	linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-ID: <20180323192952.GB23763@bombadil.infradead.org>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <20180323180024.GB1436@brightrain.aerifal.cx>
 <20180323190618.GA23763@bombadil.infradead.org>
 <20180323191621.GC1436@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323191621.GC1436@brightrain.aerifal.cx>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1595758008956081766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 03:16:21PM -0400, Rich Felker wrote:
> > Huh, I thought libc was aware of this.  Also, I'd expect a libc-based
> > implementation to restrict itself to, eg, only loading libraries in
> > the bottom 1GB to avoid applications who want to map huge things from
> > running out of unfragmented address space.
> 
> That seems like a rather arbitrary expectation and I'm not sure why
> you'd expect it to result in less fragmentation rather than more. For
> example if it started from 1GB and worked down, you'd immediately
> reduce the contiguous free space from ~3GB to ~2GB, and if it started
> from the bottom and worked up, brk would immediately become
> unavailable, increasing mmap pressure elsewhere.

By *not* limiting yourself to the bottom 1GB, you'll almost immediately
fragment the address space even worse.  Just looking at 'ls' as a
hopefully-good example of a typical app, it maps:

	linux-vdso.so.1 (0x00007ffef5eef000)
	libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007fb3657f5000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fb36543b000)
	libpcre.so.3 => /lib/x86_64-linux-gnu/libpcre.so.3 (0x00007fb3651c9000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fb364fc5000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fb365c3f000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007fb364da7000)

The VDSO wouldn't move, but look at the distribution of mapping 6 things
into a 3GB address space in random locations.  What are the odds you have
a contiguous 1GB chunk of address space?  If you restrict yourself to the
bottom 1GB before running out of room and falling back to a sequential
allocation, you'll prevent a lot of fragmentation.
