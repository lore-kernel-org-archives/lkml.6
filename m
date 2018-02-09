Return-Path: <kernel-hardening-return-11666-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2242o/chRD1CmT0WsL20eWTq3x2t5ueg7XNZjw6MAFxcIA29xKGREyy81WOGznWTFn2BqE4T
ARC-Seal: i=1; a=rsa-sha256; t=1518150391; cv=none;
        d=google.com; s=arc-20160816;
        b=MVECwDHF12S5QNeEKZJQh6x5W2uMcE2ilVQbX5m3jTvINvbuMVr+oQfsrohrPVUOy4
         UvHYoszIw/jHOZLjrAhdk1VYkKCTjYdWZDoYWsP4wYAly55bwOtRGMhrvzq5tCBcINmp
         fbJX2NR29Q1CkORdpuuXV6NahjSsTBzu/7HmVkCE6zbMek1kvilvVsHmkXuRmMhtcRK6
         DWantrKD5AXovCv90KL66SZduBFpGsDLYmITqGliDyjA+LIoyZT8R4B5Gz3gsfP+5QEe
         fGkk1Xo8DlGo3kjp+p1YbQ9M7xvKNCxZoS7WBBcRFDI5vt3oEF9QDLVJUHzNyNWFWVby
         3Z/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=r3sgS2BZTUK9oJ1iMBlXg+riVkMsgo5zKcCAWn+/05E=;
        b=b1FoAI0ppfsTAeKuvE30UVAEfSQo9vD5lCzd4TTZzbyApsv5R3yzTJQV/3AsVHm/+S
         YUQuBusSqMyAwcNEqfMzBF0fM8aghdcvfa5f5XpQ4fKX/S1NESAbrIk9G8cfw9TCrNeU
         EXtkohiP0d0XT3FOS3PLI7yd/7KDA1d+9CbFvfR+d09SohTTpqa1jGKax0CTcIPQMv4R
         iYu3ZXmLu8oZOZmRCOhaUiQ8bkvsLK0Oc+G70SiRVbzNxc1iYRP6TN0ft0o3bas37NKJ
         EcOrAecBPCTjajl+09Xj9MvYnQ8JLt7CqqUkSQORfahCO454Y7FAL31z6B9zYlV3nwjm
         28MQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@shutemov-name.20150623.gappssmtp.com header.s=20150623 header.b=wCDupEbO;
       spf=pass (google.com: domain of kernel-hardening-return-11666-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11666-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@shutemov-name.20150623.gappssmtp.com header.s=20150623 header.b=wCDupEbO;
       spf=pass (google.com: domain of kernel-hardening-return-11666-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11666-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Feb 2018 07:26:09 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
Cc: Daniel Micay <danielmicay@gmail.com>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC] Limit mappings to ten per page per process
Message-ID: <20180209042609.wi6zho24wmmdkg6i@node.shutemov.name>
References: <20180208021112.GB14918@bombadil.infradead.org>
 <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
 <CA+DvKQLHDR0s=6r4uiHL8kw2_PnfJcwYfPxgQOmuLbc=5k39+g@mail.gmail.com>
 <20180208185648.GB9524@bombadil.infradead.org>
 <CA+DvKQLHcFc3+kW_SnD6hs53yyD5Zi+uAeSgDMm1tRzxqy-Opg@mail.gmail.com>
 <20180208194235.GA3424@bombadil.infradead.org>
 <CA+DvKQKba0iU+tydbmGkAJsxCxazORDnuoe32sy-2nggyagUxQ@mail.gmail.com>
 <20180208202100.GB3424@bombadil.infradead.org>
 <20180208213743.GC3424@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208213743.GC3424@bombadil.infradead.org>
User-Agent: NeoMutt/20171215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591870366530801102?=
X-GMAIL-MSGID: =?utf-8?q?1591896064191473985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 01:37:43PM -0800, Matthew Wilcox wrote:
> On Thu, Feb 08, 2018 at 12:21:00PM -0800, Matthew Wilcox wrote:
> > Now that I think about it, though, perhaps the simplest solution is not
> > to worry about checking whether _mapcount has saturated, and instead when
> > adding a new mmap, check whether this task already has it mapped 10 times.
> > If so, refuse the mapping.
> 
> That turns out to be quite easy.  Comments on this approach?

This *may* break some remap_file_pages() users.

And it may be rather costly for popular binaries. Consider libc.so.

-- 
 Kirill A. Shutemov
