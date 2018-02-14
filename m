Return-Path: <kernel-hardening-return-11793-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225H+9BwGa1/Xyh30uNvaQVtcVI2m16XiszKidxTqjAM6h4Uq/XB4Z8X6x2B0LJvIvUcZLdP
ARC-Seal: i=1; a=rsa-sha256; t=1518643679; cv=none;
        d=google.com; s=arc-20160816;
        b=z0prufT7T3sregKZzieUvh78Uvuco7wNAAKNwV97qBYPLcwhKLw8HKu4/K99T3trqk
         Qy6doKOOg8qBeFMPQJzYRM71/36r46OehtPvjcMX05fV0/magueepahpzVp5PbenWdYt
         VAP+WN+ijHGZi6UwQ7jfbw0/nutNuFT66fgdqYmuT20IBOPVkJBoUUCLrlWhhAdV/MRd
         MejJZ/cd2Zo2elaxZ5NDEaZQlhDoUEmm/2SGPzbY538Oc4TJplZgOyddveYzdiWhfW8O
         LVzDwVYMIwYXLP2GVvkRx83l+VGqGLIMpN+UQ20SgP/fslRvTQ59UNKuZjtxiqTnT21m
         5wsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=tQZePtnh3huMlLJIprX3Kj1mR/gZJR4UIIhyUseRxFU=;
        b=FHx52k9ChH4S8OO7DlTcM5j/uwlk49kkPZHG/DnUYCoS8IRftO32zsC++V4n44E4mG
         VsHu89lWW7qA5EIsZ5puRVj2LYPv6X3g1YFHgFwrwfwJbDmZS6cpc57gsxSOFk/Bcfjd
         2ERcxDPdGD1tZzEc+RBmCt3SQ+Sg/M2GySccN3k+K09EmfOkpyNnNTs2QCHEtQI/0ebt
         94AG+eiNdWDxIXRPpV23Rdo3OoZDXgllY9Bv//lAnpUkSf85fQIQRnt/Woa8HAll68eZ
         nAKSQE85qklwFV3us3FEWfSgxvO8eCiC4p1YcTqTB+kiTLkvPRgMPyaEP9g94pOIEji9
         OqVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11793-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11793-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11793-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11793-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3868:3871:4321:4605:5007:7903:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21611:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: town38_601e810328109
X-Filterd-Recvd-Size: 1448
Message-ID: <1518643659.3678.34.camel@perches.com>
Subject: Re: [PATCH v2 2/8] mm: Add kvmalloc_ab_c and kvzalloc_struct
From: Joe Perches <joe@perches.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
 <mawilcox@microsoft.com>, linux-mm@kvack.org, Kees Cook
 <keescook@chromium.org>,  linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
Date: Wed, 14 Feb 2018 13:27:39 -0800
In-Reply-To: <1518643449.3678.33.camel@perches.com>
References: <20180214201154.10186-1-willy@infradead.org>
	 <20180214201154.10186-3-willy@infradead.org>
	 <1518641152.3678.28.camel@perches.com>
	 <20180214211203.GF20627@bombadil.infradead.org>
	 <1518643449.3678.33.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408583578566616?=
X-GMAIL-MSGID: =?utf-8?q?1592413314664736924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-14 at 13:24 -0800, Joe Perches wrote:
> Look at your patch 4
> 
> -       dev_dax = kzalloc(sizeof(*dev_dax) + sizeof(*res) * count, GFP_KERNEL);
> +       dev_dax = kvzalloc_struct(dev_dax, res, count, GFP_KERNEL);
> 
> Here what is being allocated is exactly a struct
> and an array.
> 
> And this doesn't compile either.

apologies,  my mistake.
