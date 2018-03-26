Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AG47ELund92KUc3Vqls0RpjBlywEc4MPRHc6+7TMRWp5nAHvI+uRZORP2uD/hl8M2P9MWHyuVWsF
ARC-Seal: i=1; a=rsa-sha256; t=1522054019; cv=none;
        d=google.com; s=arc-20160816;
        b=xfJLGv6N7VwJtl3alxrJTKzIZGipXfgfporfK9yVQlQ9hbLR30MmXgwM9sOM5POTed
         oBNMjNATfUXzWFKjLcD3F96TzTZxeHziWYVAzfkEEju8oHsK7NMRhxhIKQ3r/8A/ZPKi
         LTnFi50IiiM8YVDpq5CA54ArTl7X1DrmQ6f29OAOf4Y6P9oPVVCoeaB3M6jrfY00T6OK
         tx1U3EOQpglxecHhPugHAI697e7xfzceVbzxxFR/xSFzbor6YlLKSi59rD9zJrkADuxX
         2aED+J15LJg9MRQ3sZ/cULuRQxDVxham6Xr179O+b04kIoIrQOIV4E+m6TxBTvZ1wI1d
         yDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=pGkfvXoVNhLYd4duUzwgh2sgbUUx7V5d5EGSjlVnHzU=;
        b=JYJt+XteHqKDaguuevOwVDy7XCfNYnsXgZDYYRLloQeLK4PNlz/z9u+eK6xahPtJHb
         UzRrhVJ5gHZf4pHCMrfzoFsOzVsfBSEoLcS/SDiCPcfJUyJofnlxJslt6FaJT8K3A9/m
         znxz/VCUWgmFLhGnJnxCXxhbu2Cjak1XH/u273gbbr2drI7Weg6KsvuOXIRDFRfPufc2
         nLAIQDneEfSH45nT03khZaQPGb1FozLTlGGNUX1c5p635PCvFcrESUNV2oYpdTsT/V3X
         fXKJ8j0xRZs47iVy8BwVoYCY1cXyoN8u3dY4u24aj/kQJxTYOPqSVB98gJ+xd3kbA6pr
         Lc3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Mon, 26 Mar 2018 10:46:50 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Ilya Smith <blackzert@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, rth@twiddle.net,
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
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Message-ID: <20180326084650.GC5652@dhcp22.suse.cz>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1595989315518083822?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 23-03-18 20:55:49, Ilya Smith wrote:
> 
> > On 23 Mar 2018, at 15:48, Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
> >> Current implementation doesn't randomize address returned by mmap.
> >> All the entropy ends with choosing mmap_base_addr at the process
> >> creation. After that mmap build very predictable layout of address
> >> space. It allows to bypass ASLR in many cases. This patch make
> >> randomization of address on any mmap call.
> > 
> > Why should this be done in the kernel rather than libc?  libc is perfectly
> > capable of specifying random numbers in the first argument of mmap.
> Well, there is following reasons:
> 1. It should be done in any libc implementation, what is not possible IMO;

Is this really so helpful?

> 2. User mode is not that layer which should be responsible for choosing
> random address or handling entropy;

Why?

> 3. Memory fragmentation is unpredictable in this case
> 
> Off course user mode could use random ‘hint’ address, but kernel may
> discard this address if it is occupied for example and allocate just before
> closest vma. So this solution doesn’t give that much security like 
> randomization address inside kernel.

The userspace can use the new MAP_FIXED_NOREPLACE to probe for the
address range atomically and chose a different range on failure.

-- 
Michal Hocko
SUSE Labs
