Return-Path: <kernel-hardening-return-12707-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtjXaB77BXWuA7S8rJW+qaPu+dN+JURI5PR+trNHAa84qYHG31Rx9YjKSQC5Lix4CkkLMAK
ARC-Seal: i=1; a=rsa-sha256; t=1521549429; cv=none;
        d=google.com; s=arc-20160816;
        b=vRUde6IwWr/AqPeN9kogFTdsZ6s+YzMkx4G/G4++XgeZAyMsU9OlAaoXp9qr6Eo8U+
         m+7pmJkm78DJ3xqRmjXSU3cpQsH7E7Rpb5Nj6HiP8EEHD+u1mcpAJfTNUG72AiCtwqzA
         aU1jUYi3aDpxWNFp+1pRI5E8xxJ+BcySNrOIjG6149ojjgE1kXfdIG8sDpkTLcFrkZdB
         N7RYEIgRjtkVJfmKgCxp8vCVIMLMIlIUsMy64gGS4WV9PaqOUJyspo7YGAKqK3l5BLob
         iG+bYBebHfm0yDSQDdMhvPq+7Ddbidx9wSh7VZVexl6lyHHPufXfK+MnAu/Tnt1tLfPn
         cP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=lsqAFg0gEC0qOGYS153zsGIzCruKkqZsbMkqq9pnH4g=;
        b=a4wE0GDmEi5yI6qyUwiFo2gloCPLGioMMYGcJwxKnuc8g5yxR2lUj4LeNV8iKDUkPx
         eTyIxCZZ5d4ScqufDAyWxKPuQ9ArMEr20tbHCVLNB096Neb5j0oQjc7ECcqWPCiqS9qv
         o1WHn+oT+F6/96kY5IuMdImdsDRo/wq0kh97TaWADtjY3ggi1rdKN4Esp0tzZpG/v4i/
         U7nuzyvI+K7tqu5UolBgObUiFfto5QDkPMyW943Qfrr3M7nxX9ecE0KvsP4YkIxl4mwH
         aZyVHjPZ2ewG1jG+GFZue/Ew+IwoFOakAjuj0jjS/vwKqCpQLMmWeUe9F828MOudueYZ
         5++g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12707-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12707-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12707-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12707-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 20 Mar 2018 13:36:42 +0100
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
Subject: Re: [PATCH] netfilter: cttimeout: remove VLA usage
Message-ID: <20180320123642.5cqzpaoxqvrpwi2h@salvia>
References: <20180312231442.GA22071@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312231442.GA22071@embeddedgus>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594775688476268511?=
X-GMAIL-MSGID: =?utf-8?q?1595460214377246483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 06:14:42PM -0500, Gustavo A. R. Silva wrote:
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

Applied, thanks.
