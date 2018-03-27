Return-Path: <dalias@aerifal.cx>
X-Google-Smtp-Source: AIpwx4+w/IInoNzCaRffyM230D+PE2M3/udZ/y/6JyXwCxKNFGO6KPel4/SrEPXXkJ0aR9Bo7SR6
ARC-Seal: i=1; a=rsa-sha256; t=1522195274; cv=none;
        d=google.com; s=arc-20160816;
        b=L8qzMq2sfwxtu3HC73jLZmZp9YQLcn6DHoccTcfdz1Z1PmDs2+735WR41HHS850wIg
         br1IBkzm3hPpLn1KvEmEIIiB8udUVqDmAXXWkq8vQtdYR+tgGia5mdU/p2awIYJ9rn4k
         r7vG+7j63fcIwlO3Y14Mmpd4nHtXFeFtURAR9n8QZ3AdMwaDtvgS4namKnLxHLWkijYI
         G4SIFQvtIx52cNK5X0EaTbI/aV+phHCW687hQbzeAQ0yg0zX0iO8QYOYp7GjPJQWr3ws
         kWJP3H8QapiqqGBaae/ovvX/jn8+MgvrQmfi56bt5tge04tnBXVtIlH0n40GKFSHjnif
         sTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:to
         :from:date:arc-authentication-results;
        bh=RuXjzbAoJOpFSvaQrOaKCSME79nh/qehfYprtUNcN+0=;
        b=dWK408vH7PlIia3lhKrmPY41FoobNVTyS2gbOYTbWJFAKTQSFwLNVCQZf5Mh3CS7sM
         miJamPnFfYDm1XX6Erlf1mz4jCUR1n0dpSQGYGsRGTZ701svWL8u1ZxsXwJVXQ4XFX0z
         HfqPc7s7zgUI8DXgz2EJG7KZ2/AOUiyCO5lyIyOO1Zj0SM3KFvUJ5ixRvw5ZdSQRuO7Z
         DdK4r+OVCmi9u4l1WdZnFoy18V3VSE/rx0dObR3W5Ox4vjXiJNao6XZvJdLRZh7irwNr
         8lAyRAIYAzRkemVcebQTFGEPKeFWeGrVdn5P7gPIy0AF2es4OJm936lLpc2uh8+AC4b0
         XnSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Date: Tue, 27 Mar 2018 19:58:52 -0400
From: Rich Felker <dalias@libc.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Ilya Smith <blackzert@gmail.com>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, rth@twiddle.net,
	ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
	linux@armlinux.org.uk, tony.luck@intel.com, fenghua.yu@intel.com,
	ralf@linux-mips.org, jejb@parisc-linux.org,
	Helge Deller <deller@gmx.de>, benh@kernel.crashing.org,
	paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
	davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, nyc@holomorphy.com,
	viro@zeniv.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org,
	deepa.kernel@gmail.com, Hugh Dickins <hughd@google.com>,
	kstewart@linuxfoundation.org, pombredanne@nexb.com,
	Andrew Morton <akpm@linux-foundation.org>, steve.capper@arm.com,
	punit.agrawal@arm.com, aneesh.kumar@linux.vnet.ibm.com,
	npiggin@gmail.com, Kees Cook <keescook@chromium.org>,
	bhsharma@redhat.com, riel@redhat.com, nitin.m.gupta@oracle.com,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
	ross.zwisler@linux.intel.com, Jerome Glisse <jglisse@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
	linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-ID: <20180327235852.GL1436@brightrain.aerifal.cx>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
 <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
 <20180327221635.GA3790@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180327221635.GA3790@thunk.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: Rich Felker <dalias@aerifal.cx>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1596137432087839140?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 06:16:35PM -0400, Theodore Y. Ts'o wrote:
> On Tue, Mar 27, 2018 at 04:51:08PM +0300, Ilya Smith wrote:
> > > /dev/[u]random is not sufficient?
> > 
> > Using /dev/[u]random makes 3 syscalls - open, read, close. This is a performance
> > issue.
> 
> You may want to take a look at the getrandom(2) system call, which is
> the recommended way getting secure random numbers from the kernel.

Yes, while opening /dev/urandom is not acceptable due to needing an
fd, getrandom and existing fallbacks for it have this covered if
needed.

> > > Well, I am pretty sure userspace can implement proper free ranges
> > > tracking…
> > 
> > I think we need to know what libc developers will say on implementing ASLR in 
> > user-mode. I am pretty sure they will say ‘nether’ or ‘some-day’. And problem 
> > of ASLR will stay forever.
> 
> Why can't you send patches to the libc developers?

I can tell you right now that any patch submitted for musl that
depended on trying to duplicate knowledge of the entire virtual
address space layout in userspace as part of mmap would be rejected,
and I would recommend glibc do the same.

Not only does it vastly increase complexity; it also has all sorts of
failure modes (fd exhastion, etc.) which would either introduce new
and unwanted ways for mmap to fail, or would force fallback to the
normal (no extra randomization) strategy under conditions an attacker
could potentially control, defeating the whole purpose. It would also
potentially make it easier for an attacker to examine the vm layout
for attacks, since it would be recorded in userspace.

There's also the issue of preserving AS-safety of mmap. POSIX does not
actually require mmap to be AS-safe, and on musl munmap is not fully
AS-safe anyway because of some obscure issues it compensates for, but
we may be able to make it AS-safe (this is a low-priority open issue).
If mmap were manipulating data structures representing the vm space in
userspace, though, the only way to make it anywhere near AS-safe would
be to block all signals and take a lock every time mmap or munmap is
called. This would significantly increase the cost of each call,
especially now that meltdown/spectre mitigations have greatly
increased the overhead of each syscall.

Overall, asking userspace to take a lead role in management of process
vm space is a radical change in the split of what user and kernel are
responsible for, and it really does not make sense as part of a
dubious hardening measure. Something this big would need to be really
well-motivated.

Rich
