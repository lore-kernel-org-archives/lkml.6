Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AG47ELtKlzy9z3Avgfm12oK/KN9ifQDjrIn3gqPWvUyHSfKlBqC5q/mJUAtHQ0DcogahG4b2e3N7
ARC-Seal: i=1; a=rsa-sha256; t=1521138541; cv=none;
        d=google.com; s=arc-20160816;
        b=jb/whfJDSkwVxVJiACSvFp0XY7h3nSvJyOTR/h4A0dPTUQzb35OXTRKLonQDq23Zps
         4+RGC1MAo27SXOAZ1vRDDDSpuEbwsVOO6mKLLqGBGrp/teUsjqbQ6T6FEppdQ7I3n3VS
         onIB/mTxkQVRJZ7/TCotfYAAEqC721QbSmLgRO0EfhL/1ScU6plMalCwwpWPgC5l5tWn
         RvOWF7pt/cGZWaI4Bfl4sUjGFfcdq1SHtM/gekkLuNDZguQzKKcIkhT73vXD1fnD0cGb
         G9UHsMaQPQpPbgniw/nFizAWaEhBcSq6IOihkKSXQkG5fd4kuTiVptj+EgBzym1trvSX
         NSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=XdHzW0MvDO9TweucRrTv9t8qQ0vHXyc15OFvqEzRueg=;
        b=FkWNDlA5iEXjRHxTzz5JJtMcV9q3MNG4BCdJCnAU2IboI31Zhphe6UuqmYBC6DcvNn
         2KeyWYYczySu/iLsJsA2OZj8LyYrmIKEGyc+xqbbSDFVgaHm2UWsxtY2JGKLUMU/AgCt
         tXEWID7R8PyRsjS7sILx9IKoXhfeVfzPjVVcr9SdFkncmC5cDSXvGLsPAdzBRUsSTC9q
         g//PG+saF7RIayHANgnqXfSqeHzisOgIiE0JyttgKVmlCo19X+rbvKJkycZyRWWAqRVV
         A67jePSfGohSleBP9f3GqvmTFJNprCGWE3w5SEhStWA47r8Xa1xVGjZr4+DZ5f2vgkuH
         kdmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Thu, 15 Mar 2018 14:28:58 -0400 (EDT)
Message-Id: <20180315.142858.86991621405874666.davem@davemloft.net>
To: joe@perches.com
Cc: inaky.perez-gonzalez@intel.com, linux-wimax@intel.com,
 johannes@sipsolutions.net, pablo@netfilter.org, kadlec@blackhole.kfki.hu,
 fw@strlen.de, kvalo@codeaurora.org, balbi@kernel.org,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org
Subject: Re: [PATCH] net: drivers/net: Remove unnecessary skb_copy_expand
 OOM messages
From: David Miller <davem@davemloft.net>
In-Reply-To: <782fa75ab2e443d275f19d97f2f3a073b6074517.1520867179.git.joe@perches.com>
References: <782fa75ab2e443d275f19d97f2f3a073b6074517.1520867179.git.joe@perches.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594744886116547813?=
X-GMAIL-MSGID: =?utf-8?q?1595029367295499714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joe Perches <joe@perches.com>
Date: Mon, 12 Mar 2018 08:07:12 -0700

> skb_copy_expand without __GFP_NOWARN already does a dump_stack
> on OOM so these messages are redundant.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Ok, applied to net-next, thanks.
