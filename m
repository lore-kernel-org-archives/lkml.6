Return-Path: <kernel-hardening-return-11800-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227Oy9ctzBpLEhTxtpZ/l8u+zt45kTZW0ER6NNUeTmIlZ+/lD7ae1m5hV/nBpFYrB+kbaZD9
ARC-Seal: i=1; a=rsa-sha256; t=1518711805; cv=none;
        d=google.com; s=arc-20160816;
        b=gYlZKAbbpPE8ni1dXs+d00JRFjeuRbdJGsU2kP2vEnZwpGE8gIhcjxC01vE9zKe98I
         UPepqpFO97yhC7Ul6z78IDN97mBttRPphL1M9doMr2Eo+s1imeaHuZxJglqdoAEzCOBL
         VaeYZSgg8Gs7pw7Vd/pgJzv3Zt+rhpyrnfU9SCK7QOsjyyOq2CyFzPQ+6SKronIw1nf3
         75TnqxdgGZKQH7XHj6MFgWZTfI3yH6xELRxw2yXlGH66LKF+DggXBZo7XKSDEUDjceZF
         qqWrhgy7PPEWNIuLRUhEFRJ/HjTpWZQQcd+RhTFtBpYRD+AFiYbMNyTusarvkQc4d521
         nOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=hFvDSVEInHSM4c6gENfRRGBmiPtPVNer6I94SH6iAbI=;
        b=RSrtFZim4ruPvfDUrT4GMKuotzJdmaP314k9LM0eHQvknm3xksAqItKNkbaG3/qTdE
         d8wYJ+LOutIFt9llajpPjRqWV1wS+G4XErfDUXp8OSz2cWV960lQyOdPjh4CztiPfLPq
         BSYMuVCOQ9CVE0IH9Ei6jBbeqgtSVVdoNsN/8zZHywrlsfEdslQfcd62FyR3oyHnKFrP
         RfeC1srW1bUyNkQZOzSQVgaOoIpois7LCQO2ehgssrbOzpAN0BSIP9IJCKpcU3swBBTA
         cn6rEGPgWv+AuIcdN+j5GBF+9Bb70TQScXlNP2mjqHI7w65ZOidHhWhuI2oO9WT2+2NI
         76/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=HEQHTqzs;
       spf=pass (google.com: domain of kernel-hardening-return-11800-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11800-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=HEQHTqzs;
       spf=pass (google.com: domain of kernel-hardening-return-11800-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11800-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 15 Feb 2018 08:23:03 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christopher Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
Message-ID: <20180215162303.GC12360@bombadil.infradead.org>
References: <20180214182618.14627-1-willy@infradead.org>
 <20180214182618.14627-3-willy@infradead.org>
 <alpine.DEB.2.20.1802141354530.28235@nuc-kabylake>
 <20180214201400.GD20627@bombadil.infradead.org>
 <alpine.DEB.2.20.1802150953080.1902@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1802150953080.1902@nuc-kabylake>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1592484749951776388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 09:55:11AM -0600, Christopher Lameter wrote:
> On Wed, 14 Feb 2018, Matthew Wilcox wrote:
> 
> > > Uppercase like the similar KMEM_CACHE related macros in
> > > include/linux/slab.h?>
> >
> > Do you think that would look better in the users?  Compare:
> 
> Does looking matter? I thought we had the convention that macros are
> uppercase. There are some tricks going on with the struct. Uppercase shows
> that something special is going on.

  12) Macros, Enums and RTL
  -------------------------

  Names of macros defining constants and labels in enums are capitalized.

  .. code-block:: c

          #define CONSTANT 0x12345

  Enums are preferred when defining several related constants.

  CAPITALIZED macro names are appreciated but macros resembling functions
  may be named in lower case.

I dunno.  Yes, there's macro trickery going on here, but it certainly
resembles a function.  It doesn't fail any of the rules laid out in that
chapter of coding-style about unacceptable uses of macros.
