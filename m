Return-Path: <kernel-hardening-return-12484-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELugFeOHzeD5n+M086R78cXLtWkP3GAnABfYKkrin+t02vYF4gUHa9u9+QY8zwcN9wCCNc5j
ARC-Seal: i=1; a=rsa-sha256; t=1520899140; cv=none;
        d=google.com; s=arc-20160816;
        b=B0N6WMyq24wxbgEtfNoYP525Rf4JszvYANKE8XhIgV4mZO6jfahuL4ovJsiQ24CHiC
         cZlZ3z6SCgMScfXjfoZ54XusquDzFYEjmxfnRduZFKoe4PiOHnLK4NSfIt+23jgjHMiv
         1QyXLycpxrz7fhLZT2qCU5UVn+R2lKZYwK/hCIjgjAwzmIXK79g3p7l02nhNQHb8bciV
         D227uxOPkOMnMWnBQhK3Xc6LJmz31WdXDnqCRSs5RhRFjALE8u62F8pYPnJgZyw80KjB
         agVyeQZbQVmXSmFQtp/0DU9b+j7Wf1gbSwaY0WBZBlPAnm4cORJdvILtv8yUUM9O+9Wv
         9Wog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=dDx7SwBioHGGfE2CLD5rT5Z2mZ+9BJEYQOy99qg5x40=;
        b=vv6GlbCXRwW3JBtO/nOCPwfvZjaXwWVlZ5byfFz9hc2TnAHsUK1PgmN+ar4QNoo3kf
         /U+GkUgiiDVcBVROpe07h6XJ4/UBvfqnleFVmand4UQVKTgZpuH668OqXw61MzXcwx32
         bh+c+yOvmxlPHrzugIb0xBUn6PuKv/99EyUrKuobTQwXBrl5HnLKTsEG8qJaPQRWepXr
         NvndQ5Gz1R7BXzb2E5tYYRQNVU0Q8LQFDJOuY2c7GuTibyPRMShubE4PQY5PRqIJ869z
         G19aRDynRHwEUdJBCo4qvLF1CB91+SlqJwOfwBkvJ+0TUnv51puR1FZDtZOIzP3tYidQ
         JZGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12484-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12484-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12484-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12484-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:960:966:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:2894:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4385:4605:5007:6119:10004:10400:10848:11026:11232:11233:11658:11914:12043:12048:12438:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21627:30012:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: range77_115edfc0a7f46
X-Filterd-Recvd-Size: 2836
Message-ID: <1520899118.2049.24.camel@perches.com>
Subject: Re: [PATCH] netfilter: cttimeout: remove VLA usage
From: Joe Perches <joe@perches.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Florian
 Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kernel Hardening
	 <kernel-hardening@lists.openwall.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Mon, 12 Mar 2018 16:58:38 -0700
In-Reply-To: <20180312231442.GA22071@embeddedgus>
References: <20180312231442.GA22071@embeddedgus>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594775688476268511?=
X-GMAIL-MSGID: =?utf-8?q?1594778336875615628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-12 at 18:14 -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA and replace it
> with dynamic memory allocation.
> 
> From a security viewpoint, the use of Variable Length Arrays can be
> a vector for stack overflow attacks. Also, in general, as the code
> evolves it is easy to lose track of how big a VLA can get. Thus, we
> can end up having segfaults that are hard to debug.
> 
> Also, fixed as part of the directive to remove all VLAs from
[]
> diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
[]
> @@ -51,19 +51,27 @@ ctnl_timeout_parse_policy(void *timeouts,
>  			  const struct nf_conntrack_l4proto *l4proto,
>  			  struct net *net, const struct nlattr *attr)
>  {
> +	struct nlattr **tb;
>  	int ret = 0;
>  
> -	if (likely(l4proto->ctnl_timeout.nlattr_to_obj)) {
> -		struct nlattr *tb[l4proto->ctnl_timeout.nlattr_max+1];
> +	if (!l4proto->ctnl_timeout.nlattr_to_obj)
> +		return 0;

Why not
	if unlikely(!...)
	
>  
> -		ret = nla_parse_nested(tb, l4proto->ctnl_timeout.nlattr_max,
> -				       attr, l4proto->ctnl_timeout.nla_policy,
> -				       NULL);
> -		if (ret < 0)
> -			return ret;
> +	tb = kcalloc(l4proto->ctnl_timeout.nlattr_max + 1, sizeof(*tb),
> +		     GFP_KERNEL);

kmalloc_array?

>  
> -		ret = l4proto->ctnl_timeout.nlattr_to_obj(tb, net, timeouts);
> -	}
> +	if (!tb)
> +		return -ENOMEM;
> +
> +	ret = nla_parse_nested(tb, l4proto->ctnl_timeout.nlattr_max, attr,
> +			       l4proto->ctnl_timeout.nla_policy, NULL);
> +	if (ret < 0)
> +		goto err;
> +
> +	ret = l4proto->ctnl_timeout.nlattr_to_obj(tb, net, timeouts);
> +
> +err:
> +	kfree(tb);
>  	return ret;
>  }
>  
