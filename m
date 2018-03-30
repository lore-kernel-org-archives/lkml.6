Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AIpwx4+qU9+y7WfXDEVH9iR8CKldOoaXPxxBGInomK7Kj/gYFPN/YQ/BM3kwJ68YNblDALUkT1DI
ARC-Seal: i=1; a=rsa-sha256; t=1522436948; cv=none;
        d=google.com; s=arc-20160816;
        b=0RJTk7VGhZNCWoo4545nh3XTywNGRSeomw0IzXXqAFRmwCNSJb5k0TFCWc6Hj6bi1w
         UctotNhmkSSf35iGO4EuQCsoiEqqE+25stCfJ3bGeyid5vacH2oW12HXMW0/yVFnNiUc
         pr3tx2TKoJW0gMIY0MVr9EGpVmoUaH+h7BabiH8sJ/V3OsAV0jo1cYUOAN8z8KgCrR58
         EDeqtGPw7TqF3LOYlZrlSgj7yghIkgcVEMmLPjXy5cvn9kHymsHANFY2bYGtjpmWaej2
         nE08Hd739SzUigN6HOifNd/oIEfVEgoBdq3sRMleIvc3M1ESxLYPcx9te6tTsAzEjHpN
         ls+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=2hmay/6as3MCbfnIuSeHvpnnoesM5F8DcOk5IZYjBB8=;
        b=i+1al6LnaoeklLh0RIKA8bqlQvhBfrHoJBG4RlR+HGUv8rWIUHGs17XU8ZE8k/MW73
         TtURte/NjIzo3UURSYzG0IEVDja8sIEv9ooCBo1aKA98ByYEYJolVUeCGLBVr2/SanLO
         hiCWSyjYxlHkq6dU4qvnPGg8ys6sQll67wz6DzoXXyx1DPzhYPgbEAUFgWkv3+ZJbMQU
         iEYLOFQTaRyVOO+GZJG2aB21eVe68Jbol4R+H4eulryupsf0m/AfwzOQmGKObb7szz3K
         gwvgx1BgtqzU53XsErwNWD4LaP9wUjPPzj4rEuoKaPX5ltlEAy16VguCKFJpBcROVoYH
         cjUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=kFbxsdrA;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=kFbxsdrA;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Fri, 30 Mar 2018 20:09:04 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 03/17] staging: lustre: LNET excludes USERIO
In-Reply-To: <152229760832.27689.17304570282712555631.stgit@noble>
Message-ID: <alpine.LFD.2.21.1803302008260.9681@casper.infradead.org>
References: <152229732768.27689.4800156943561963977.stgit@noble> <152229760832.27689.17304570282712555631.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180330_200904_550850_B80A4885 
X-CRM114-Status: GOOD (  16.04  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244781744369072?=
X-GMAIL-MSGID: =?utf-8?q?1596390845958955441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> LNET_MINOR and USERIO_MINOR are the same value, so
> they cannot both be used in the same kernel.
> Until this is resolved, don't allow them to be built
> together.  This saves automatic testing from noticing this
> known problem.

Nak. I have the proper fix for this. Will push right away.
 
> Reported-by: kernel test robot <fengguang.wu@intel.com>
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  drivers/staging/lustre/lnet/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/lustre/lnet/Kconfig b/drivers/staging/lustre/lnet/Kconfig
> index ad049e6f24e4..fe4b24acf075 100644
> --- a/drivers/staging/lustre/lnet/Kconfig
> +++ b/drivers/staging/lustre/lnet/Kconfig
> @@ -1,6 +1,6 @@
>  config LNET
>  	tristate "Lustre networking subsystem (LNet)"
> -	depends on INET
> +	depends on INET && !USERIO
>  	help
>  	  The Lustre network layer, also known as LNet, is a networking abstaction
>  	  level API that was initially created to allow Lustre Filesystem to utilize
> 
> 
> 
