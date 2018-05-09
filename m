Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZrqFU3mwefLdgghdOyeDONNEWmORlkJ9omLYroV0EtEmgwuUEfYpjxoy/qXTTPgp66wXhDL
ARC-Seal: i=1; a=rsa-sha256; t=1525827882; cv=none;
        d=google.com; s=arc-20160816;
        b=It+I2pFvtKO6+HcFnhULVzFK8Umfxxgf6oe+0ISLuT3WYeDe2i2eCwNXv1nqN+cfct
         JdXo/Vv9JClEhMk1C4Z5duMBFiwx5a0Cc2//CGz1/j1TyWG3Za0HNRgAM/CMs4N6sOR7
         FawRYyo3b2eeNUdXsHu+f2kv2YHFJWO07k81ajUHSDRobUEgpQnokUv0DmPNCgTmsOf+
         WVejCg7M2yHHx6cokcJabPuju3poionuuaW28/JjRawme929rnwGYdmk40B1GicZHCTR
         1y/zTdxWAGfoFtzCNqe4y6m940LYT/g43qODp5E8fC0JRwWOSHNan0+T0OiGgId2wcNz
         r1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=lUYmrenrPAq3Bp52Xs0y/iQGCXmD/qa3EsVSB53ep80=;
        b=nIxa21LGFVVb/DTjOPVB2UZ13pmHpqvFb8fvmMatsTy68r0OIzCb0WywpICFD0QPSQ
         uJe0cJ1yGcvVucun6G0w0YNwbifbSFBf/HuEV3EZ8VXnhcL2cb1NRpNxtleYzlv7WKfH
         UNeezeA8F2+Lngp5EvwezqJphFiWhqYLKwwv6gSwx00u8AGSTfeaUBt0wMzKiWniTjU3
         4uqjpi2gWEYLwhQUhSrgCXYaMw7q7OsbPfSuhY+ygenMvJFFh5Hb6DSvwv/zN5ETHsZT
         p48YFf9ixCdtXwk8LOxeezMlmzJeeHpgCl2CEfV8hWNQu6fkj8Im8RUwSy6/BJ5Zvsjn
         56AA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 01:04:38 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>, Tony Luck <tony.luck@intel.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	linux-ia64@vger.kernel.org
Subject: Re: [PATCH] mm: provide a fallback for PAGE_KERNEL_RO for
 architectures
Message-ID: <20180509010438.GM27853@wotan.suse.de>
References: <20180428001526.22475-1-mcgrof@kernel.org>
 <20180428031810.GA14566@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428031810.GA14566@bombadil.infradead.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598946836077947117?=
X-GMAIL-MSGID: =?utf-8?q?1599946497494670661?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 08:18:10PM -0700, Matthew Wilcox wrote:
> On Fri, Apr 27, 2018 at 05:15:26PM -0700, Luis R. Rodriguez wrote:
> > Some architectures do not define PAGE_KERNEL_RO, best we can do
> > for them is to provide a fallback onto PAGE_KERNEL. Remove the
> > hack from the firmware loader and move it onto the asm-generic
> > header, and document while at it the affected architectures
> > which do not have a PAGE_KERNEL_RO:
> > 
> >   o alpha
> >   o ia64
> >   o m68k
> >   o mips
> >   o sparc64
> >   o sparc
> 
> ia64 doesn't have it?
> 
> *fx: riffles through architecture book*
> 
> That seems like an oversight of the Linux port.  Tony, Fenghua, any thoughts?

Poke *Tony, Fenghua* ?

> (also, Luis, maybe move the PAGE_KERNEL_EXEC fallback the same way you
> moved the PAGE_KERNEL_RO fallback?)

Done. Will queue in the generic PAGE_KERNEL_EXEC patch to my series.

> --- >8 ---
> 
> ia64: Add PAGE_KERNEL_RO and PAGE_KERNEL_EXEC
> 
> The rest of the kernel was falling back to simple PAGE_KERNEL pages; using
> PAGE_KERNEL_RO and PAGE_KERNEL_EXEC provide better protection against
> unintended writes.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

Nice, should I queue this into my series as well?

  Luis
