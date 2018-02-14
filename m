Return-Path: <kernel-hardening-return-11770-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227GnIMN+8bot+m2C98ctMT5L91nrXDg1rhtvbf9/37ey45q+n7xjopXIXN7fZB0+XPHeHcg
ARC-Seal: i=1; a=rsa-sha256; t=1518638211; cv=none;
        d=google.com; s=arc-20160816;
        b=Qj38QpjKPH8LXVdiEboom0BGwzisfiSxl4oTVqJiHTg0gHmvjdXiGo0UdLxSua5jjm
         SC+fEKALumS0kNk+vK2BtYJdueBoDlpJX73vRJfOzTwIsQieQkiUNQHRvSIcEDN8ajOT
         oRncnuRLinnjgarTNZNmr8Sj3C3Fs7EuNMswe9MdEinXct0WNpkTLMVrm8wyqRCf2S8k
         LUUNASwkKvQi6lUCwzILRvLx6caKzklH2gV46g9xEFehh1BojsnjUcOwd/p+ZU7S0NKI
         u3NNWuI2+y1tWukvrENzc9dBqWzpvoo1tIcfSNfj9PLdRsUTVDQKKd5P4tGzy6AkLYDc
         ge8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=578lu1gZbAtmeOArQERzKmg78fcxNMvw41gcqEm1eYk=;
        b=UWgGyaFqQ+wj8B/+ghw2YWNAX+ZriAPQ1uS00DNpSOgmFcvmk8fe8uELzfDfxrbdXt
         24AOAA0QfgfNzJHpsjpJBdbXfSZDaxL+EOCf8HfNX07KZ90quI5JizrayzS9ksH5+S1W
         giMsaBrc+J5GvQvUNr6SGGIfRVSXsF2yZu3fjL0HZ7JmOXymk4danW5KLgAjmSXq3sOV
         b8QTSJlythwj9vpGfanVolQz2fRRSKQ4qQr0XywyOfFWAWOMTa0Q/yBwf21YI5tPuCbH
         pNvMIAZ3811OLL7Uy1IdDSPbvtctyaoZw8z0eiCjJnIb4f0lBQnXRnp+Tzq+WGO9d2y2
         4jhw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=uq0637Ji;
       spf=pass (google.com: domain of kernel-hardening-return-11770-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11770-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=uq0637Ji;
       spf=pass (google.com: domain of kernel-hardening-return-11770-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11770-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Feb 2018 11:56:31 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Joe Perches <joe@perches.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH 0/2] Add kvzalloc_struct to complement kvzalloc_array
Message-ID: <20180214195631.GC20627@bombadil.infradead.org>
References: <20180214182618.14627-1-willy@infradead.org>
 <1518634058.3678.15.camel@perches.com>
 <CAGXu5jJdAJt3HK7FgaCyPRbXeFV-hJOrPodNnOkx=kCvSieK3w@mail.gmail.com>
 <1518636765.3678.19.camel@perches.com>
 <20180214193613.GB20627@bombadil.infradead.org>
 <1518637426.3678.21.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518637426.3678.21.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401947833736714?=
X-GMAIL-MSGID: =?utf-8?q?1592407581624701478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 11:43:46AM -0800, Joe Perches wrote:
> On Wed, 2018-02-14 at 11:36 -0800, Matthew Wilcox wrote:
> > If somebody wants them, then we can add them.
> 
> Yeah, but I don't think any of it is necessary.
> 
> How many of these struct+bufsize * count entries
> actually exist?

Wrong question.  How many of them currently exist that don't check for
integer overflow?  How many of them will be added in the future that
will fail to check for integer overflow?

I chose five at random to fix as demonstration that the API is good.
There are more; I imagine that Julia will be able to tell us how many.
