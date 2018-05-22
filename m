Return-Path: <BATV+a8c6d037863aa87ae187+5385+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AB8JxZoOZPlmMUPVa7ItR7At01bs2BS86xys04z5Kl5qMXDUeDdyvJZqbJu3sBws0/ISmKZ2aywR
ARC-Seal: i=1; a=rsa-sha256; t=1526981893; cv=none;
        d=google.com; s=arc-20160816;
        b=kxNd3lXD7YpjQ6WoWqzPxjarKkhVv3dfwi69wjHH4wZPFENQNbgAlG+5ahLF8ih/iE
         0XqRGarI+iZnxebHFUZIzYP4nk4jOvajNMEAJilMTYIpHZxOnDyGhnUmY90v9ZKFdnda
         BH67MRh7QGVX38t0olnqSBJbBYoEM8VNmCP75asgR6h5OH319dYkAp3AN22M92MW0yko
         INjnEoHEFSMaNTw9Ixm/EEsG60Hm3PXQLcUT5+qLr2ACZ48FWezCLA5xgA1RNzONIPYr
         QoBd+jTaoB/1KBrARW5ciezIlNKpao5+sXR5+YtzxTjiFKGlILx2xUo7uMErykgjwN01
         iPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=M4INESxLyxjFPAvAEVW7iyUCKIST3o6noPHpwPPFByU=;
        b=SMW0P7NA60/v78QIERv9+FMU3CI5SVansEE/6ptGWEn9uSQJ3EwbFLi4m0zb1tdvSS
         CiCqE9mT/Cfvi+oCHqUoLbPhmBQsdO44zWfOTCoedmjSL9SF2n4ZM2DwvDjccblN6Klt
         OcvG8ByKFpEEZ4z8PdgO9b7k1JZFGZd4orpWS99rnAFDjC6ojsTflLhageCtmJREG+wi
         +jVo0surqBLJZP3wxw5E3ti1LLmZ00oUFepmepKiYi642Z6o88DmVyd7hdDxPo452mo0
         zxnD4EYWjasMjeqSNhUBG55sKU5p9PVa9oFPjyPtWdwfMHDqewhgQW9TcSWfrzK3Y+aY
         WHWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=BswMr4tM;
       spf=pass (google.com: best guess record for domain of batv+a8c6d037863aa87ae187+5385+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+a8c6d037863aa87ae187+5385+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=BswMr4tM;
       spf=pass (google.com: best guess record for domain of batv+a8c6d037863aa87ae187+5385+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+a8c6d037863aa87ae187+5385+infradead.org+hch@bombadil.srs.infradead.org
Date: Tue, 22 May 2018 02:38:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Huaisheng Ye <yehs2007@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, mhocko@suse.com,
	willy@infradead.org, vbabka@suse.cz, mgorman@techsingularity.net,
	kstewart@linuxfoundation.org, alexander.levin@verizon.com,
	gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com,
	hehy1@lenovo.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
	linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH v2 02/12] arch/x86/kernel/amd_gart_64: update usage
 of address zone modifiers
Message-ID: <20180522093806.GA25671@infradead.org>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
 <1526916033-4877-3-git-send-email-yehs2007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526916033-4877-3-git-send-email-yehs2007@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087527015520115?=
X-GMAIL-MSGID: =?utf-8?q?1601156565621522474?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This code doesn't exist in current mainline.  What kernel version
is your patch against?

On Mon, May 21, 2018 at 11:20:23PM +0800, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> Use __GFP_ZONE_MASK to replace (__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32).
> 
> ___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
> bitmasks, the bottom three bits of GFP mask is reserved for storing
> encoded zone number.
> __GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated by OR.

If they have already been deleted the identifier should not exist
anymore, so either your patch has issues, or at least the description.
