Return-Path: <kernel-hardening-return-11709-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2253+AKFvAPSeT9nzZex8/UL3xFhOhBwk4yEkuz3LU+Ztq7UlvP0XQPJOivHni/VbzAxHrNi
ARC-Seal: i=1; a=rsa-sha256; t=1518383905; cv=none;
        d=google.com; s=arc-20160816;
        b=nG7E36IFlGFxXTwUPWV1H2IFXKA7ebQmZlXPSxasQoDdquiy9CAjgVjLBF54ndhw1Y
         YKqmwYQqRYuhTGrip21EzXOexTS6zKDyPehvhEbZLxfStVKEj2kwNPkiTMn5KWiOpm6k
         TTB/c/XpXpBaCRE/85cN2MNKiY18C4bQGGE+VDAHQObDL7zOzylTmuyC3bKvPuFKx1az
         57KF7BJ99cck6u9+3xaT34pVPaTkX28d0mtN8S0bl1IFRu2VQOHQYHCNK3qxqs/ir/oq
         p9ds8nGHdhtc1OmV57OZf6f8kmWg1R1IU69KLzv+cpM7DQXbUTQatHjlVXxke7SyBcQq
         D6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=6gLZyaJwvEmZDoay8bDM6/vI3+eszSlUVsYThf2cMeU=;
        b=tXVNKhyH6cRvZHRiudMTUzc8zc7sXnUx1MG9SAKUhBJUf2rqFguh0CHaqH8JYZTNt+
         t5cOt81pzBrqC6gmA4JqVIueAS56A6NZFjS4e+bl4ZnCJ9t713qKGoZgPumBAYqbKylM
         u2Avi8uOe6w/a0YF6IdxLOzilHR9t1osowChwrJB7y4AbSM0SUYbZsyOzuyEWDeKOo1g
         4O+2LpZERciTJvLpWRfq31rQ3eGJ5Iig5Ll2UD7WMQ8qVCUIPTTeC/uyGWUA1aG5p4CR
         HQsjc5Nvpxn7M7+hbfxV3WwJCTZ8iaX3Qm0Dwd97K57WYFc9Klfuh7TgWU9pH87LEuPS
         W+Jw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=casper.20170209 header.b=NenAEsP4;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=EWXavrv7;
       spf=pass (google.com: domain of kernel-hardening-return-11709-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11709-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=casper.20170209 header.b=NenAEsP4;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=EWXavrv7;
       spf=pass (google.com: domain of kernel-hardening-return-11709-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11709-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 11 Feb 2018 13:17:41 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: rdunlap@infradead.org, corbet@lwn.net, keescook@chromium.org,
	mhocko@kernel.org, labbott@redhat.com, jglisse@redhat.com,
	hch@infradead.org, cl@linux.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 6/6] Documentation for Pmalloc
Message-ID: <20180211211741.GD4680@bombadil.infradead.org>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-7-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211031920.3424-7-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592073290087141082?=
X-GMAIL-MSGID: =?utf-8?q?1592140921862810212?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 05:19:20AM +0200, Igor Stoppa wrote:
> @@ -0,0 +1,114 @@
> +SPDX-License-Identifier: CC-BY-SA-4.0

You need the '.. ' before the 'SPDX'.  See
Documentation/process/license-rules.rst
