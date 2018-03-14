Return-Path: <kernel-hardening-return-12586-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELufObLop17fIBudW0wGxySL9Ob9F055wGJh2ga5coRjyF9IwdtQWeiO70zJUe+HWgzfHEUT
ARC-Seal: i=1; a=rsa-sha256; t=1521030336; cv=none;
        d=google.com; s=arc-20160816;
        b=ON9L3jw3sjjhNNN0mjx7ZPv0RSaZVExz0BLWktJSFA05aD+2nFXzky5upIKF1mshZ+
         NK7SQSpBPtxA6pqVrNChr1iOWDLsJk4TjjECRq7avbWcLEn5ifSEgqxIL3GeWQLHF+/j
         stcoI36y3gAQyjLN7pVKvu6U2NTUUD/isPLy1zI6PP40M87f6jDyj8Jnu15k+lAPZz4o
         4wnXL9tpn7+NvYqfoApj64Cdrs61h5iKlUlagL7u6oTjjMN/SO1B5HN10uqdsXyVA56W
         ThH5FCPLdBtYfaJgEERkImFI+rD1WHQoRxr80Qi7ngZDlj9HJaTcRpIVy6CuoQhYNcQY
         tJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=trWNEOreHAJCP28zCiz9OWCNCTRd5X0Xo7hbrKlrVkw=;
        b=XGM5S/qkBP2IueWZnzB0iE07SjPzdsId1PER1l550IflfYvsGXaKZYGH7Eh6B40sxX
         2N+INhZcdZDR2saIqi1a83IGCIesTbRLluYfH2npO/dFEJqJ+D0XAoG04eArfa2/Lr/E
         QCGe14Mp217LRIcVjM5tLyYdSrbdL9n0jE27iTXExCk4RgQBIx7iRjFAQBZ7Y21ZJ6NF
         kweBVw/9Syh5sule2rr6Q1dttE17zZCsg7A6k40a4tNql4MbStsixpe2yLBSu9SxTbQJ
         z19zL10ZeyTXPYGtfCFDJvLYxW6qY54m/77Yy0loj7Wll6xsZoElXR9q00CCkf5s2EGd
         Xz1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=AtWypP+J;
       spf=pass (google.com: domain of kernel-hardening-return-12586-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12586-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=AtWypP+J;
       spf=pass (google.com: domain of kernel-hardening-return-12586-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12586-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Mar 2018 05:25:12 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: david@fromorbit.com, rppt@linux.vnet.ibm.com, keescook@chromium.org,
	mhocko@kernel.org, labbott@redhat.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 6/8] Pmalloc selftest
Message-ID: <20180314122512.GF29631@bombadil.infradead.org>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
 <20180313214554.28521-7-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313214554.28521-7-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860941197895401?=
X-GMAIL-MSGID: =?utf-8?q?1594915906164058190?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 11:45:52PM +0200, Igor Stoppa wrote:
> Add basic self-test functionality for pmalloc.

Here're some additional tests for your test-suite:

	for (i = 1; i; i *= 2)
		pzalloc(pool, i - 1, GFP_KERNEL);
