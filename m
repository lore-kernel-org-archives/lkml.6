Return-Path: <kernel-hardening-return-12508-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuhE/yWdsfajkleK18QFaMhuNmE2XsLa8VrObR1HNiEnkj1vA6e5Q3tOhZkSCvLe7tKWHQp
ARC-Seal: i=1; a=rsa-sha256; t=1520957651; cv=none;
        d=google.com; s=arc-20160816;
        b=j+XlLOK8+kenFZE94kH/QeYDIWudC1Yct2aVcL5qbUem2bzQuRo6kJQSYE8jp7yz+a
         t5aiDDsr1rVI+N5+jtZjGXSXtSMFk/O3jf27HwsuWr7W1wVEoIof1kB39dzip9G925cV
         5LuEWfPZiif2nDuRQT9GmsdLS2K7xPekKWP2q6jJ8WwhfScHtVi7iV93Nq8Jc0acNhwe
         4PZBoRUZ3IVNNeubagSi4ZkomjNw9Xrk7jn85flCvXpfrapau5Tw0GcUJ5b/ogWY0+yU
         GQCgtgu0MXcmUQ3lI/s7dUgUOz+7fgAz99WwiftXbSFy1W0Y5tNo+9foM9E9SlHcmiVB
         G53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=P5y63aY+vUejlY0Tc7Mvh6L8i9auGDx9h/jRNZGwRBs=;
        b=iym+Hu79eZLxszAc50qhtitaUAmoUftP5Edws/6HCsYgNJrhzmK5sUZjW5r7q9kA/K
         1Nv8hjbv6npbe9NZy2iOgCRqHpwjlRw7Jr/tQQexfeaAV5WiyMf9BGPX8bRAInsYgv5X
         k1XkSz/r2uB1b15RHuahEhPahWVthjEYAD4n9ZDivv1+EPzq8qduMx9NGRRXJu7rWlqE
         rLMaaM9PmOTIFxcmhm9fUPT4DPrusKwlT+KH5gaf7gtWlZIK4qOL10s+xIKXqlUeL5JD
         YoqCbgDZOpC0qbEviMvQmKzgPoZETr4MyKvTTPhepunBL6Xnku/d7BrsPuIqyrI8L6wl
         uSww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12508-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12508-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12508-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12508-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2894:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:5007:6119:6742:9389:10004:10400:10848:11026:11232:11658:11914:12043:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30012:30054:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: skin35_5b889f845551f
X-Filterd-Recvd-Size: 2751
Message-ID: <1520957627.2049.37.camel@perches.com>
Subject: Re: [PATCH] netfilter: cttimeout: remove VLA usage
From: Joe Perches <joe@perches.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Jozsef Kadlecsik
 <kadlec@blackhole.kfki.hu>, Florian Westphal <fw@strlen.de>, "David S.
 Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kernel Hardening
 <kernel-hardening@lists.openwall.com>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Tue, 13 Mar 2018 09:13:47 -0700
In-Reply-To: <20180313145947.tpekwvyioaft5auc@salvia>
References: <20180312231442.GA22071@embeddedgus>
	 <1520899118.2049.24.camel@perches.com>
	 <20180313145947.tpekwvyioaft5auc@salvia>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594775688476268511?=
X-GMAIL-MSGID: =?utf-8?q?1594839690095323692?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-03-13 at 15:59 +0100, Pablo Neira Ayuso wrote:
> On Mon, Mar 12, 2018 at 04:58:38PM -0700, Joe Perches wrote:
> > On Mon, 2018-03-12 at 18:14 -0500, Gustavo A. R. Silva wrote:
> > > In preparation to enabling -Wvla, remove VLA and replace it
> > > with dynamic memory allocation.
> > > 
> > > From a security viewpoint, the use of Variable Length Arrays can be
> > > a vector for stack overflow attacks. Also, in general, as the code
> > > evolves it is easy to lose track of how big a VLA can get. Thus, we
> > > can end up having segfaults that are hard to debug.
> > > 
> > > Also, fixed as part of the directive to remove all VLAs from
> > 
> > []
> > > diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
> > 
> > []
> > > @@ -51,19 +51,27 @@ ctnl_timeout_parse_policy(void *timeouts,
> > >  			  const struct nf_conntrack_l4proto *l4proto,
> > >  			  struct net *net, const struct nlattr *attr)
> > >  {
> > > +	struct nlattr **tb;
> > >  	int ret = 0;
> > >  
> > > -	if (likely(l4proto->ctnl_timeout.nlattr_to_obj)) {
> > > -		struct nlattr *tb[l4proto->ctnl_timeout.nlattr_max+1];
> > > +	if (!l4proto->ctnl_timeout.nlattr_to_obj)
> > > +		return 0;
> > 
> > Why not
> > 	if unlikely(!...)
> 
> This is control plane code - not packet path - I think we should just
> let the compiler decide on this one, not really need to provide an
> explicit hint here.

I don't have an issue with that, but it should probably be
mentioned in the changelog as it's unrelated to VLA removal.
