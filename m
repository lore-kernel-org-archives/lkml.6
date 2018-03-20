Return-Path: <kernel-hardening-return-12708-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvlbbL1ugx3eYMJQhOc3zr/yJhQbv4XHwppZ+ar7Iv4iQyqxl34JlQLoyR7s1idfCH4EGPI
ARC-Seal: i=1; a=rsa-sha256; t=1521549440; cv=none;
        d=google.com; s=arc-20160816;
        b=BDH6T30QdJX6L0jNrpAKxOPOqeaOq0/PLoZxtJhD8mxy+g2b1l/ioXxpzf2F5fAmf8
         maQUHw70AKerPjNVk6Yc6QHRQRAus/uCefIr1A4r8alSqet7Ede1rPrFxriumG4SDxtH
         qNOx7jJXgg/XAXbXUDiDCbnv3SJX3z9F2wgjLREqM6jPHsXWaOM6qh7Ta7q3hs+qfSYP
         W5LINmGtw3s2ugPSCE6YOkqJbf056PePSPEvmbqXK9+9djngQA47VEcoLrpflANm2ufP
         pj0Y3/0EKqaZYRg6+3TYLTXs9+w8mtYX5NA0e3+uCNsc8y3nk94G/humEes2iFpm9lBf
         gCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=WjvLrhMRHJp6JGkGM4JY28/wkYO0iUkHbBc+IM7IwHs=;
        b=P9ZmPq+ATko8BIkjCqEBLZaV7thZJFSENQbEz/ZCBlrjwjQQEZ2D8goTHSCxH5Iiuz
         ocNpjYqBIRZHA4VoRcAxOYRSM8zZFFPILmkt/3uSHNTF4l4jGcHPOgvmWagrWxLzgpfE
         KOgE/yCBokJv/RO0XohS0j86G20PQetQyPhS3YzC6frrC848JlXQmx2DnEAIprH3/ChX
         qPVcwwkwITmiv07yVdpAXArzqf9HYKpyQuYEn9fgpQp9PMX5xBWE47BN+e8+hUh2Tuy6
         VZkNVCitvZliKgh9aYQKsAEA7sZTsfwkiTWnZGGax8/xzLFphaQhLNWnvZvAQhmG7EyH
         Px8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12708-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12708-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12708-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12708-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 20 Mar 2018 13:36:55 +0100
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] netfilter: nfnetlink_cthelper: Remove VLA usage
Message-ID: <20180320123655.kugtpftt7nhzvqc5@salvia>
References: <20180313002138.GA27280@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313002138.GA27280@embeddedgus>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594779782164059647?=
X-GMAIL-MSGID: =?utf-8?q?1595460225856620820?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 07:21:38PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA and replace it
> with dynamic memory allocation.
> 
> From a security viewpoint, the use of Variable Length Arrays can be
> a vector for stack overflow attacks. Also, in general, as the code
> evolves it is easy to lose track of how big a VLA can get. Thus, we
> can end up having segfaults that are hard to debug.
> 
> Also, fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621

also applied, thanks.
