Return-Path: <dalias@aerifal.cx>
X-Google-Smtp-Source: AG47ELsiwhsbFTzKYp/nTwsqF5Y2ZHMgTIQvQgNKBwIJwdJyb4FJB8wmcMmCzTPj02tr4apA1T3B
ARC-Seal: i=1; a=rsa-sha256; t=1521832701; cv=none;
        d=google.com; s=arc-20160816;
        b=BsNmXi8Uk4Eq/PHUGmoQcsBshRssmOHQ7SS7AQx8f06dj/zYbJ/kf8WPNtsktFFke8
         agKZe072M7S+pSxTFQSCBJdI6jaPBOWDmkVZKt2UeMf1amFGT69kFYyOhBs4k+mv/GWv
         pp7ASOfl7B5NuYY2zhIMCXiYLayb/rR3eocgCl5fbuPLuDw71E8M6oPP0CIZFKdY+zWA
         Go2pCu5a3Q+p8eFO77A1/6lCEoJ+iFWHcUQPV7OPEt2EFWBDrgOkkYruddZhOCzW3ZHt
         RE2i07/jIroLkWWMhWDOkb4PJDRfrShh5XFZCmXgODHhHCnHxxWbBjv5ysYnbMezZmC6
         NoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=IRbfwXOCwEkTDlB0HaYbtwOBasi6KDA57JZSsfsOtks=;
        b=vG70+35ZxpEbKX/ugv2F6T5sVqirSTbTHD98UhiVr9I88lvXELw0l0ENUWFvMZo8Qe
         /H4WDt7Z3+tI39lAP1Dp8uSbDqVFTiVuvO2OacjuNxWKsjbUXU3i4L07larivSTBtcDq
         sh5Jp0CN4I3cUip7yV4NBQH/CXgOBSKVY7N6vD8zWtOKFy7VNIdfIUveIscOIT+34QOC
         ZiV4i8pZFWMKEbqhPk+k9WfrNtwjC5X5ySXec6hEO3Xw//R/3DtpkTppBdc8mow2vH44
         sIxh03e3OupveA3TrKy9RNMjQDBNgK8yHkrepMfnKn46UTVo/0nbU72oAGHbv5N3E3MO
         ViSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Date: Fri, 23 Mar 2018 15:16:21 -0400
From: Rich Felker <dalias@libc.org>
To: Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20180323191621.GC1436@brightrain.aerifal.cx>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <20180323180024.GB1436@brightrain.aerifal.cx>
 <20180323190618.GA23763@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323190618.GA23763@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: Rich Felker <dalias@aerifal.cx>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1595757246815231096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 12:06:18PM -0700, Matthew Wilcox wrote:
> On Fri, Mar 23, 2018 at 02:00:24PM -0400, Rich Felker wrote:
> > On Fri, Mar 23, 2018 at 05:48:06AM -0700, Matthew Wilcox wrote:
> > > On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
> > > > Current implementation doesn't randomize address returned by mmap.
> > > > All the entropy ends with choosing mmap_base_addr at the process
> > > > creation. After that mmap build very predictable layout of address
> > > > space. It allows to bypass ASLR in many cases. This patch make
> > > > randomization of address on any mmap call.
> > > 
> > > Why should this be done in the kernel rather than libc?  libc is perfectly
> > > capable of specifying random numbers in the first argument of mmap.
> > 
> > Generally libc does not have a view of the current vm maps, and thus
> > in passing "random numbers", they would have to be uniform across the
> > whole vm space and thus non-uniform once the kernel rounds up to avoid
> > existing mappings.
> 
> I'm aware that you're the musl author, but glibc somehow manages to
> provide etext, edata and end, demonstrating that it does know where at
> least some of the memory map lies.

Yes, but that's pretty minimal info.

> Virtually everything after that is
> brought into the address space via mmap, which at least glibc intercepts,

There's also vdso, the program interpreter (ldso), and theoretically
other things the kernel might add. I agree you _could_ track most of
this (and all if you want to open /proc/self/maps), but it seems
hackish and wrong (violating clean boundaries between userspace and
kernel responsibility).

> > Also this would impose requirements that libc be
> > aware of the kernel's use of the virtual address space and what's
> > available to userspace -- for example, on 32-bit archs whether 2GB,
> > 3GB, or full 4GB (for 32-bit-user-on-64-bit-kernel) is available, and
> > on 64-bit archs where fewer than the full 64 bits are actually valid
> > in addresses, what the actual usable pointer size is. There is
> > currently no clean way of conveying this information to userspace.
> 
> Huh, I thought libc was aware of this.  Also, I'd expect a libc-based
> implementation to restrict itself to, eg, only loading libraries in
> the bottom 1GB to avoid applications who want to map huge things from
> running out of unfragmented address space.

That seems like a rather arbitrary expectation and I'm not sure why
you'd expect it to result in less fragmentation rather than more. For
example if it started from 1GB and worked down, you'd immediately
reduce the contiguous free space from ~3GB to ~2GB, and if it started
from the bottom and worked up, brk would immediately become
unavailable, increasing mmap pressure elsewhere.

Rich
