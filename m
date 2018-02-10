Return-Path: <kernel-hardening-return-11690-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226H3Jf3Qm/Maq93F5J6TQoPsDNDTS88gf5aaGoSQBx0BCXHTEUujW9cHslfmmT2HU2rTc0x
ARC-Seal: i=1; a=rsa-sha256; t=1518233869; cv=none;
        d=google.com; s=arc-20160816;
        b=0h4z/8CVBNvB6JW4jfLhhg/Y07qe7V3bCi/Fc6Z7AZTtszWVet+X2ht/oJJ/ZPVyzt
         RpFZ1UqfQe+3wFm7XCRCnHqSTGWT7SnJVLpf+ephhjS4a1A22tj32HX5f9YihCzaorDo
         97El7QvqysZ7LXozaCP198gsQQsJeECUHKgVUW6QRgVMmCHPA5j7WEZjYEuVV/ixm8Zj
         IMHq0SFiYMedJ72SUwWAT1UMipibbc6zEHi78l4iiN3z9JooDlN7WpjHPNti6uH6ppL4
         gYjeF4E57MuhAzZnqwvYABb3oH2nr0wyOzVWsvikYMaV3uUrNDkFN0pXxbk/8Kc64Rl6
         W4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=jcWonpSUx1W/0THgoFNPuWwR97dTPBxFp9GGTT6f9N8=;
        b=e0nHZ+9ZhAhHWrsttOPLlBiyi1Ul7+J0JxmDh3NAoBpffQXcv4ggpMX2xQaNSXhH5+
         Pmu5iN2fBs8izEOeGQafvBJ1VgCTbX/j4eK7WFv42HoMHKUx1+PlNDeOkpHZ+P3na77k
         Nd9ea+2jziDvssNGpJWfez7WWo61KDujcH0bIJTTIiEcZIqT9dbBm22xAhebFXJA/kKR
         KccCGWoZJhSfu2TBnHzL5rQ0wFV5eo0kZmI98NfoMuWIzup7LmI2S7P9FQuwymC02OLt
         qerTgDURAmlzXUm8qt/q2T06REYernSPUKi7bxiXuJ5M8+Ws9b+S5ovDqJQ/LiOo4Sl8
         x8Vg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=UsNxCzY5;
       spf=pass (google.com: domain of kernel-hardening-return-11690-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11690-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=UsNxCzY5;
       spf=pass (google.com: domain of kernel-hardening-return-11690-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11690-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Feb 2018 19:37:14 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Jonathan Corbet <corbet@lwn.net>, jglisse@redhat.com,
	keescook@chromium.org, mhocko@kernel.org, labbott@redhat.com,
	hch@infradead.org, cl@linux.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 5/6] Documentation for Pmalloc
Message-ID: <20180210033714.GA12711@bombadil.infradead.org>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
 <20180130151446.24698-6-igor.stoppa@huawei.com>
 <20180130100852.2213b94d@lwn.net>
 <56eb3e0d-d74d-737a-9f85-fead2c40c17c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56eb3e0d-d74d-737a-9f85-fead2c40c17c@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591031095823992296?=
X-GMAIL-MSGID: =?utf-8?q?1591983597211350642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 05:56:29PM +0200, Igor Stoppa wrote:
> But what is the license for the documentation? It's not code, so GPL
> seems wrong. Creative commons?

I've done this as the first line of my new documentation files:

.. SPDX-License-Identifier: CC-BY-SA-4.0

I think this is the CC license that's closest in spirit to the GPL without
the unintended consequences of the GPL when used on documentation.  The
GFDL seems to be out of favour these days.
