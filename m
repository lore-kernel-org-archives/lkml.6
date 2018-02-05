Return-Path: <kernel-hardening-return-11587-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2272/+C6Qqq2Kpg77w/Fvx6f05m2jKYCDMH0KViGWvKonEP8qJEzwigFdzvJ7RapLgp5CKSv
ARC-Seal: i=1; a=rsa-sha256; t=1517802359; cv=none;
        d=google.com; s=arc-20160816;
        b=l1tAoY1OAzrdMHbaGGZHoye8CDbPp8O7lrtjZI5bWeQ4ek0ze0d2vXrS+i9pgXnbYh
         dtCp6ELQaNOawQ6qnWDj7X8MTa9FvZ13EVDLj6PjHSKSX0w8fpm+Sslc3e9j76QkwLQJ
         e++1J7mejgv6FilRNNx6NLELEKpmR8HJ38ruYYh3iCSw/EmI5BFcuxRr83oEvdVTbbsy
         dp/h7bUYBlAvTJ/IpVYWmMDXzg7El4wmD1FW2lhXtfyEkb87NqbzK9ynUMp2JaFLL+pr
         YrdeH76g5IUysf2lxBh4lINwqbtO/6zF9ILP8od+SdzQg7yebtPERwzbL6iukkdEaNgn
         SX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=yDO5NKFXo7YZr2gAugAhsTrNKzd3bfVBNJfZNXe2DYs=;
        b=KRtmVsZAcbGTT/CfemUbRdrJgtFKgemj/BUUXPPBR+5qp3ZvZXNcW4KQmAZzeCChxg
         Z84wfp4N//Rl0BPljRfLEO/PN5xYm+b4YJIDGFtru8GEhqQmQT251d+Ki5iCBPCRXBgj
         ptvzotwgNJ2NLDziN6g0xoC+Ewc2cX+xvfP3Z8t3vMKwtqBw2UDUNWFVSQQibw3jk7cu
         Tdr9L6rACDv1PuazH7uuYoe5HLm1ga+NeOVv+0IMcknrA+AAESgaEKBlmTtbD5fdr8CJ
         sZ5cGV7rA44mGlkvcHp0TNokCn6pj+UUrjKtL0v5BYcmfltoIFqGOb5MpD8IPAUogs9x
         gCZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=uolAfdkS;
       spf=pass (google.com: domain of kernel-hardening-return-11587-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11587-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=uolAfdkS;
       spf=pass (google.com: domain of kernel-hardening-return-11587-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11587-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 4 Feb 2018 19:45:31 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Igor Stoppa <igor.stoppa@huawei.com>, jglisse@redhat.com,
	keescook@chromium.org, mhocko@kernel.org, labbott@redhat.com,
	hch@infradead.org, cl@linux.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/6] genalloc: track beginning of allocations
Message-ID: <20180205034531.GA18559@bombadil.infradead.org>
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
 <20180204164732.28241-2-igor.stoppa@huawei.com>
 <60e66c5a-c1de-246f-4be8-b02cb0275da6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60e66c5a-c1de-246f-4be8-b02cb0275da6@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591489766378692364?=
X-GMAIL-MSGID: =?utf-8?q?1591531127143592281?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 04, 2018 at 02:34:08PM -0800, Randy Dunlap wrote:
> > +/**
> > + * cleart_bits_ll - according to the mask, clears the bits specified by
> 
>       clear_bits_ll

'make W=1' should catch this ... yes?

(hint: building with 'make C=1 W=1' finds all kinds of interesting issues
in your code.  W=12 or W=123 finds too many false positives for my tastes)
