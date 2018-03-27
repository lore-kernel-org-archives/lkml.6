Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AIpwx4+Dwy9e3Aj13395jEfVGrs99ukRx59LtAOYTznGX2zApUUB9u4bK0aG1gn4wA9qgUXs5Le/
ARC-Seal: i=1; a=rsa-sha256; t=1522194599; cv=none;
        d=google.com; s=arc-20160816;
        b=U115EGT71zpykkgJJF30DjhNZWzLzCa/khzCpjPTKzlKKdOf+QE1Gun78T5VW8JKnL
         A4dECkLCODDfqAfX+rvle5vL+yR8VC2RB4VQ3J3AC/DEw45k9h7gF9yL5fw+5T4WNY++
         Z1rgbhCt9dIQU6hx0RBBW8s8KX194zbzg4K7onKqFxhbiOTEZQnTkXBA3+hRYQhFOloB
         ++HJ5iicPyaG7OBhQYMYwj4am4c8mplRqSlAh9tYUm0U1FcMfXnd+l1xmHV752iRZ1re
         GlUEqMr9xwDCvnQDP1hlzKjaUQVLNm8qQxLoWrOE2hvmCd8Sq+T77oZWd0QOOzB0d6po
         s87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=8veZ3hdBuONE88dwnYxt9Yf9LP1bUAGz+kemQISA/LA=;
        b=s2tTenvAHLdeT8ya7UDcsSHia3ay1/aNk+wPrTHG9VFTCYxXn87ryJOVPPhkne0sGV
         tzYFX5EI9xDVrJZGtgEF8napH2iT5GNsE2lzGgf5K0+jJTcHxkDXX8AIebt7B6/pvV34
         5vXw9tROuX696Z9JoiA79KOXTzh9biHZ/2p+eTdwC3+SYR4oT4eSdkjTZL39o2fjlFIq
         Zgi78yJYRpgl3lqXQNLyyzWXeDlAooQE3eFL1074Bggt+Zv2HvsZePPh8B07HHkPCW+z
         w4sg+FnETKdHRDkMhG1K0OcXnBV5MNjN+l3jeEEufTDbDEIJU+kDRzxlfHmFMS9BBxBC
         LkYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=fjkGm1Qu;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=fjkGm1Qu;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Tue, 27 Mar 2018 16:49:04 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Ilya Smith <blackzert@gmail.com>, Michal Hocko <mhocko@kernel.org>,
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
	Rich Felker <dalias@libc.org>,
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
Message-ID: <20180327234904.GA27734@bombadil.infradead.org>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
 <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
 <CAGXu5j+XXufprMaJ9GbHxD3mZ7iqUuu60-tTMC6wo2x1puYzMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+XXufprMaJ9GbHxD3mZ7iqUuu60-tTMC6wo2x1puYzMQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1596136724900325204?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 03:53:53PM -0700, Kees Cook wrote:
> I agree: pushing this off to libc leaves a lot of things unprotected.
> I think this should live in the kernel. The question I have is about
> making it maintainable/readable/etc.
> 
> The state-of-the-art for ASLR is moving to finer granularity (over
> just base-address offset), so I'd really like to see this supported in
> the kernel. We'll be getting there for other things in the future, and
> I'd like to have a working production example for researchers to
> study, etc.

One thing we need is to limit the fragmentation of this approach.
Even on 64-bit systems, we can easily get into a situation where there isn't
space to map a contiguous terabyte.
