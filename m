Return-Path: <dalias@aerifal.cx>
X-Google-Smtp-Source: AIpwx4+WGdeJYIlnwliJcm5MbiE0BHcYPfzIDI7VBAkHq4YAtmKgspiPVWbjd+eQI+EbzHu9rARr
ARC-Seal: i=1; a=rsa-sha256; t=1522195317; cv=none;
        d=google.com; s=arc-20160816;
        b=I1VSRbutAu7yelOyapOtSxHONjLbFdiQLCz5iRb0C9FVEkXy/d+IMr95eaQStmkWDD
         HHHapmGI0J5WOtRKQv2ilnoMxl++wY9GYSJcUvBde+1iTx1sSEFUtjT98nCPnIn8fuA/
         dg1X1faCLkxR0VUyk/2L4ATiemZtCFOrrviBYzAojzp9fEhgO1bpew/WTB3LcBLdJahi
         HuSjcXMPJL5x6KLFdpi6zKC47IlTiJHBx52gUyw2MeAsJsKp6MpGgwMy2CWDQvEbM2Gb
         XyLOK6htGSetSbpXqpGiV1aQ4knKsOIwub07fo/7kSfCXQ9a/LxKYzSFQf0Gw5l1guCS
         OAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=GIHT7+4oLxKJ4ZBLqj7u4zbWy3hu7I52FsSBPTAGwe8=;
        b=eoC4h7QGPc889mgogVPqBPoaT5dpx24dMoSQvbaIDBiw+ZG6xqX8ugBbds7kR1gSBx
         Qus7WcUIf1S3IGcpakKqD8dLsG7E+6viVQ6w23gK9XxCrVHpf/saRdB+NEdKcw4FUd4q
         s3Kh9gv+dwIO3RPmDVeWK/NaQ84UYlWoSFNwCQr8RzEQpnOyzn7ywLZo2u4UebUJ2cbF
         5PXLnB0F3HJ/3jcOXsK8+l7P4fp/FrgoOzyjhB2qIOQinFX4eSK3rTBXBZYyNQenyuC7
         UhWlZlw5QWwIs2lfeq2hLx7Lo9goT7oIib5uh6ZbzgZpXT+QL9Eb+QLNF0amFb5zG3aT
         haSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Date: Tue, 27 Mar 2018 20:00:25 -0400
From: Rich Felker <dalias@libc.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, Ilya Smith <blackzert@gmail.com>,
	Michal Hocko <mhocko@kernel.org>,
	Richard Henderson <rth@twiddle.net>, ink@jurassic.park.msu.ru,
	mattst88@gmail.com, Vineet Gupta <vgupta@synopsys.com>,
	Russell King <linux@armlinux.org.uk>,
	Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	"David S. Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	X86 ML <x86@kernel.org>, nyc@holomorphy.com,
	Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	Deepa Dinamani <deepa.kernel@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steve Capper <steve.capper@arm.com>,
	Punit Agrawal <punit.agrawal@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Nick Piggin <npiggin@gmail.com>,
	Bhupesh Sharma <bhsharma@redhat.com>,
	Rik van Riel <riel@redhat.com>, nitin.m.gupta@oracle.com,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
	linux-metag@vger.kernel.org,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>,
	linux-parisc <linux-parisc@vger.kernel.org>,
	PowerPC <linuxppc-dev@lists.ozlabs.org>,
	linux-s390 <linux-s390@vger.kernel.org>,
	linux-sh <linux-sh@vger.kernel.org>,
	sparclinux <sparclinux@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-ID: <20180328000025.GM1436@brightrain.aerifal.cx>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
 <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
 <CAGXu5j+XXufprMaJ9GbHxD3mZ7iqUuu60-tTMC6wo2x1puYzMQ@mail.gmail.com>
 <20180327234904.GA27734@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327234904.GA27734@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: Rich Felker <dalias@aerifal.cx>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1596137477624166170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 04:49:04PM -0700, Matthew Wilcox wrote:
> On Tue, Mar 27, 2018 at 03:53:53PM -0700, Kees Cook wrote:
> > I agree: pushing this off to libc leaves a lot of things unprotected.
> > I think this should live in the kernel. The question I have is about
> > making it maintainable/readable/etc.
> > 
> > The state-of-the-art for ASLR is moving to finer granularity (over
> > just base-address offset), so I'd really like to see this supported in
> > the kernel. We'll be getting there for other things in the future, and
> > I'd like to have a working production example for researchers to
> > study, etc.
> 
> One thing we need is to limit the fragmentation of this approach.
> Even on 64-bit systems, we can easily get into a situation where there isn't
> space to map a contiguous terabyte.

The default limit of only 65536 VMAs will also quickly come into play
if consecutive anon mmaps don't get merged. Of course this can be
raised, but it has significant resource and performance (fork) costs.

Rich
