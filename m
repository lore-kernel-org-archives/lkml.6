Return-Path: <kernel-hardening-return-11756-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226LlkowqawBu5cgkClf1D8algefwJsfGBnRYWo4VNrccaYU8eblA1pNs/16QmTwGaXtIKB6
ARC-Seal: i=1; a=rsa-sha256; t=1518634092; cv=none;
        d=google.com; s=arc-20160816;
        b=jRb5XBw3wq2tg1G7WbGWwIabhrSmhxmfruMwhAq9FJl1BrTUA7k63d30NNYGvdZxed
         zJWRuEKaeHgYzX8wbXkwSUz1pKhZ9gvMdxTaSPO1Ufz/m/PrHMYsERBRwBYLxIpPmUG2
         kJuGHEiDz0uZVd3fVj4mW/R/GiCNJJt6Tb3uOXQxK7OYUoZlqXhze78y++OW5gd0fzRS
         YN/U83LfuTHofybKt7EZ6i7906PSEG3s1fIKFBexC0bXE5vlW83z7ZSPorV6yRDt1jZF
         jw1JaJtnPY93+2Q/iagH2ZO5tJIlwUNvpV/hcoFli8k4pGWcbmHxN0CVm9BDsFq0SUuJ
         bTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=b+XWGIlL7+tvcCc/cLxR+NWaQdcA+R6d2SmYJ8HhBRs=;
        b=GAWJgIkYUIIPUq7G5/EkfOpDsrUvVAhTRxC1Qbm5qQkcvJLQzM9DdhLS2OvNfHfFLx
         z3WWytymDD1sfZRBXKBi4acfU9VSgpEjs3CSBT/ofCw3UGnXSy2+dZahRmC6ab9w1EGE
         A/cD4yokr5UmpATiupsf+ruNwrJMQvc4QskmR5DpYrljry2TC7TShWVn08EY2Lu9Uc/A
         4vXML++r4TfEUuxPge5icNYaAghEtUstjX2xJ5ZJOgSoAXFthnbsxtV+WHSxctq4D0hU
         Syg2Q671XM1uvB3/Vkbnw6FZxvUmKZPlNQXpoEl9qnoR8Qd9qz2nEY6TFLbeLJWRcXFL
         /bpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11756-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11756-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11756-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11756-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6119:7576:7688:7903:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21611:21627:30034:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: goose17_8c03ece9ff50
X-Filterd-Recvd-Size: 1456
Message-ID: <1518634058.3678.15.camel@perches.com>
Subject: Re: [PATCH 0/2] Add kvzalloc_struct to complement kvzalloc_array
From: Joe Perches <joe@perches.com>
To: Matthew Wilcox <willy@infradead.org>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org, Kees Cook
	 <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Date: Wed, 14 Feb 2018 10:47:38 -0800
In-Reply-To: <20180214182618.14627-1-willy@infradead.org>
References: <20180214182618.14627-1-willy@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401947833736714?=
X-GMAIL-MSGID: =?utf-8?q?1592403262424755371?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-14 at 10:26 -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> We all know the perils of multiplying a value provided from userspace
> by a constant and then allocating the resulting number of bytes.  That's
> why we have kvmalloc_array(), so we don't have to think about it.
> This solves the same problem when we embed one of these arrays in a
> struct like this:
> 
> struct {
> 	int n;
> 	unsigned long array[];
> };

I think expanding the number of allocation functions
is not necessary.
