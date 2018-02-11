Return-Path: <kernel-hardening-return-11708-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224wu9fjk+c/pD4tH8C/cW1ZpFZx2FqwF+EFHBXYFmaYLdQ1VstdW09K9CA//fpkmqWv6F9W
ARC-Seal: i=1; a=rsa-sha256; t=1518382950; cv=none;
        d=google.com; s=arc-20160816;
        b=L1g2EmjUHlaSnImHueGR3aRwMa7lVKOW/Sg4ASFj/gKHMJjGdACXeACb6wKHlC34Tf
         KPdSFC/3qRKZzlE0oOd9NmF/AVdtcRx8HcrE7qRSL9F4pxtPftnNVQFOg7mmVMD7+uoe
         TWtPhwaF8QQ9vBGTIXxywAyb3LaLOXXT42KFyKZGtoffegs+juya50WK7tEraXUMO3ON
         egUNs4gpsRMs7UA+WcohfWX7AKVTH1jInBPeS0gQlfO7AnsjGs+PEgBWH89wwnIaOT9X
         TUFUi59jtW0/t7ZKOp5qWyRElIik+oJCigwALKPYIceiD3OQvIdmHk42Hu9MMOGB8w8K
         TNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=y1sUaAxxFgwlDEJCd8G6gSBg6RiCAZRanN6wpJ2mqDE=;
        b=UD38gc6RTz0SPIft764VVO9e3zL4bHGiKINuUqOzQoYlngmKvpbp4ZF0qO9A57zea7
         UotTZzyRP0ozxGs5MqAIeCvfundrvyijqpdZRItBGpAEqf2rNHuYIgt2jANELQrLXYYE
         oAslghD3BzN4oRufljaCvUuMIWOM8jXp/9HIv3IVZpLCU/QRDqrSWxUe4/9LSk46TlzF
         mqAKJaanSAMyMeNigDaMsdqTw2Qd8+6pwfJxq1iuggyznq5NZ5GY7SW+n7aP//wDWw4b
         hQxqkyaDVOHav4Vk+nf6TEqImHooGlq1EsKBqNfDj7F7ibM5emFfgPKq9rXiCedDlbjY
         JACA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=casper.20170209 header.b=uwtCRRGg;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=c/s0JH/7;
       spf=pass (google.com: domain of kernel-hardening-return-11708-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11708-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=casper.20170209 header.b=uwtCRRGg;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=c/s0JH/7;
       spf=pass (google.com: domain of kernel-hardening-return-11708-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11708-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 11 Feb 2018 13:01:57 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
	Igor Stoppa <igor.stoppa@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
	mhocko@kernel.org, labbott@redhat.com, jglisse@redhat.com,
	Christoph Hellwig <hch@infradead.org>, cl@linux.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 2/6] genalloc: selftest
Message-ID: <20180211210157.GB4680@bombadil.infradead.org>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-3-igor.stoppa@huawei.com>
 <CAOFm3uGNVu87qYzPufu+gGbTwuhp3cjfhKuNDkcmwn3+ysKTdg@mail.gmail.com>
 <f95a064d-75e9-6ff3-2c11-4158a0ad1ca9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f95a064d-75e9-6ff3-2c11-4158a0ad1ca9@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591489783349137888?=
X-GMAIL-MSGID: =?utf-8?q?1592139920381215802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 12:27:14PM -0800, Randy Dunlap wrote:
> On 02/11/18 12:22, Philippe Ombredanne wrote:
> > nit... For a comment in .h this line should be instead its own comment
> > as the first line:
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> 
> Why are we treating header files (.h) differently than .c files?
> Either one can use the C++ "//" comment syntax.

This is now documented!

Documentation/process/license-rules.rst:

   If a specific tool cannot handle the standard comment style, then the
   appropriate comment mechanism which the tool accepts shall be used. This
   is the reason for having the "/\* \*/" style comment in C header
   files. There was build breakage observed with generated .lds files where
   'ld' failed to parse the C++ comment. This has been fixed by now, but
   there are still older assembler tools which cannot handle C++ style
   comments.

Personally, I find this disappointing.  I find this:

// SPDX-License-Identifier: GPL-2.0+
/*
 * XArray implementation
 * Copyright (c) 2017 Microsoft Corporation
 * Author: Matthew Wilcox <mawilcox@microsoft.com>
 */

much less visually appealling than

/*
 * XArray implementation
 * Copyright (c) 2017 Microsoft Corporation
 * Author: Matthew Wilcox <mawilcox@microsoft.com>
 * SPDX-License-Identifier: GPL-2.0+
 */

I can't see this variation making a tag extraction tool harder to write.
