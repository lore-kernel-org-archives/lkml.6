Return-Path: <tytso@thunk.org>
X-Google-Smtp-Source: AIpwx49qmPWEmRpV0BavYd89jGW1prcT0z3fRESTZcb7O0tHMTbwVOAnr9I6k7RII86uiD6PRpdh
ARC-Seal: i=1; a=rsa-sha256; t=1522189044; cv=none;
        d=google.com; s=arc-20160816;
        b=HvBT+HLe7uYYdgOTKt5GtXNR09cmQAno6i+f5Zy0/RNkBYNiRV4sRhWZiH1PHtx7jJ
         MbAG8pVvOxvyAdAW0QA2A66oy9d/0Pvwzs8VmnwrVs72TIx0HXXIOHTt2KpRDYc2lKKR
         T3VffG1K5PmzKqrTwXFZQD1LukQERyKGaPBYnQEv+4Ot2Jixmr8O/n1p+AqiKkRtA5Rs
         Xlumff/5KgwDRG8sCy29Xlx3jrzpTiqdm/U5d/XP+Ui2RJp58qaUs67kERBHt2nCXuUk
         uywJdJtmtSLm3EyL6EAhxpzTQb1YX25Vh6PkmItJaw+FZoP4k543rFRAPuN3UaMSpXaq
         8qNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Qj2I7BshdUHsbFfEKXQ0bFfkdiDTRJGc48sJd/7D8gQ=;
        b=cfWDzbJL1guUSZaEtB+95cKXdoaTIjZEIKvxBFdR8dSzQxRHsMOH5c0B1XNqjL8O0u
         uLNwuc4lVFP9ASjgUnm2HVEZVB3co0RZAALR7pD35tzMVU6J8HPXW5lBhTRced012haL
         lm0HrJca1AyT50ZDb0q3cgfW7xssf15lmANlshuu/xsQWzbuzaV4QvGVhCBHIPdCx7WG
         zgsFB4pUWivTq+Rjmwx7VKDcgFThd3dxpvVDXy+9t5FpY45evaBjEhFr+stDKHvV+NXN
         pBKsj6SpYm7fQAuaJWZ97aMpJr5uo2CCKZ8m0coYrHLCNhPsJY1tap7f54RvMeUl7nXs
         XanQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=btEd/5pM;
       spf=pass (google.com: domain of tytso@thunk.org designates 74.207.234.97 as permitted sender) smtp.mailfrom=tytso@thunk.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=btEd/5pM;
       spf=pass (google.com: domain of tytso@thunk.org designates 74.207.234.97 as permitted sender) smtp.mailfrom=tytso@thunk.org
Date: Tue, 27 Mar 2018 18:16:35 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Ilya Smith <blackzert@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
	vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
	fenghua.yu@intel.com, ralf@linux-mips.org, jejb@parisc-linux.org,
	Helge Deller <deller@gmx.de>, benh@kernel.crashing.org,
	paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
	dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org, nyc@holomorphy.com,
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
Message-ID: <20180327221635.GA3790@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Ilya Smith <blackzert@gmail.com>, Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, rth@twiddle.net,
	ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
	linux@armlinux.org.uk, tony.luck@intel.com, fenghua.yu@intel.com,
	ralf@linux-mips.org, jejb@parisc-linux.org,
	Helge Deller <deller@gmx.de>, benh@kernel.crashing.org,
	paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
	dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org, nyc@holomorphy.com,
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
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
 <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1596130899513324417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 04:51:08PM +0300, Ilya Smith wrote:
> > /dev/[u]random is not sufficient?
> 
> Using /dev/[u]random makes 3 syscalls - open, read, close. This is a performance
> issue.

You may want to take a look at the getrandom(2) system call, which is
the recommended way getting secure random numbers from the kernel.

> > Well, I am pretty sure userspace can implement proper free ranges
> > tracking…
> 
> I think we need to know what libc developers will say on implementing ASLR in 
> user-mode. I am pretty sure they will say ‘nether’ or ‘some-day’. And problem 
> of ASLR will stay forever.

Why can't you send patches to the libc developers?

Regards,

						- Ted
