Return-Path: <kernel-hardening-return-12689-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtmOc13hepVS4dg817HkpM5Tt2ODfLZcOdENbDnQ3thTQ6gYF0HWr7slAaA+jXMzhvfEv7v
ARC-Seal: i=1; a=rsa-sha256; t=1521381659; cv=none;
        d=google.com; s=arc-20160816;
        b=mR9vgaI0gjxM1dR3czXmrc1iXPifBe1aBm61tlpM+BLRQnLEsMnEEmGivMQwKL65r9
         QB6M/9nVeSXppUfyW7A+F0txqEqVNZvFN2Wa8dA/ByNK1JZgTPHAt0OPIplLK8omkAXu
         0j3M4rwRfvG0j/qRwXCCozrNzZ67strFRnBNQeO/t09dpA0AbpPIIW1665IAgJijIEZH
         +w22/AjkBdO79C2lDAyQ3/UZeHx3BG++aSvDlfAV65R2v7IbWr2zfZUcJnmNOpca3TkK
         ZBEJfqwaOGrHM6/0ftouhvC1SDDGTOMX7Tdmodd86/LsmI07Q1xT11f2o9vCpvjd/xun
         0bgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=msuVFOXpUOwUWjT0CCqlGZMhy/yQInSChr9P+mHHFeQ=;
        b=eFvlnurobKC2QlCWVmk5jOYI/KYK/aRWRMAGoGMlaUgZMYEY2aeyvAMa8hZcLMTHu5
         iB5RhGWIBa3/X644LNq3rXQ8VWaiIrJXjU6JM+fD35itRYjRZQla9MKMnbdUn/0M20XU
         fvoE3R11X8huwCX8WtSmXgyOsDttHalGOYWUT4DNPrkEGcloiDvfeezAOR+P/0hFMV2w
         5o20mv1A9ah8KP/F8vAFuMqLOeryyr7hWXsnbpJk03SOvzT5KDvNzb14+uYhtZ2hHl5A
         65UGJpr3wafp5ZYHXxvXYYXwJfm1FTScX+RCu9UGXJ5IcmYUTBzjTTqFE6FGvL8twVUw
         6tTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12689-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12689-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12689-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12689-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 18 Mar 2018 07:48:36 -0500
From: Rob Herring <robh@kernel.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] of: unittest: Remove VLA stack usage
Message-ID: <20180317235304.eohpmrii3htlmann@rob-hp-laptop>
References: <1520828843-22289-1-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520828843-22289-1-git-send-email-me@tobin.cc>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594704660258031955?=
X-GMAIL-MSGID: =?utf-8?q?1595284295129415523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 03:27:23PM +1100, Tobin C. Harding wrote:
> The kernel would like to have all stack VLA usage removed[1].  This is a
> test function so the execution speed is not critical.  We can allocate
> memory for this buffer instead of using a VLA.  If kmalloc() fails just
> return.
> 
> Allocate buffer with kmalloc().
> 
> [1]: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
> 
> Kees is this annoying you, CC'ing you an all my VLA patches?
> 
>  drivers/of/unittest.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Applied.

Rob
