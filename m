Return-Path: <jesper.nilsson@axis.com>
X-Google-Smtp-Source: AG47ELuHkHC99Jdf4QRrShuS8D/+sPA93wSLW+kVwYD3Onxc98Mnua2QOwgL09T9XiKKtjlPQ2+O
ARC-Seal: i=1; a=rsa-sha256; t=1521116343; cv=none;
        d=google.com; s=arc-20160816;
        b=wLYykRsf1zqi845cS9DBW90cWM+1OPLZzb56oRos/BdAxyWx7LHE1iDbq14+7yoOxv
         tPnQstVgmb0I+OfX0KxpHtBkqYPirUve8Q8CSnCiTxN+eFkdWu2ojhcxBWt2RWTMYEmK
         cSrtSdOCu5+uw2Z1ZU2+RlUU+6Soj9vZ2yBR1NpvFn+qfVdxz0qYrEvmx4yqmPsJ6TkD
         HxhGz7u3ARKs15JAoenAOfm8w649BRiRKFKHsuon6pfpJT6zKckYsfvaZZ3ZZO6RiCAn
         U/xJ8fPDNPgv8QN3vzPqibSzRM45RSAixumUbv9heLrq6U8RIDzNZ2HW19opPodpgHxy
         ICow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=39q961bny0QV0y4IplqaihGifitNPih8j5mWWpnRsG8=;
        b=EyGqLsOYlE+NJ4u3oM/HgAYj9KcCAHV3Y+IkbnAOLX33oIkc01adYIH3sBzDU/N+Jg
         ggohJMEeEdK7XSl1y0ut08ilGXN4/cPmHUrFnqJAKDwoZr4WE5B23Tcib+1SeJsexNPW
         uMTDNRPttIK2Jg+gXW0nekLc7/teDnr/fIO94n1ykgr/UMiS5UvWN8d8J0LsX7EKr/85
         QtTP6xw4IhjnXK/aMolw4qzJU1c/Ud3IjVWXrh1QKVEiVfnFcOeMh6A89sYnJswiNUW7
         98cOmClVxdlMCz4zhgtP3aUOzzw43CJHXztioXPu5BaKNZ0cQyhILKjaO1+41xoZKmcw
         N17g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jesper.nilsson@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=jesper.nilsson@axis.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jesper.nilsson@axis.com designates 195.60.68.11 as permitted sender) smtp.mailfrom=jesper.nilsson@axis.com
Date: Thu, 15 Mar 2018 13:19:01 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Quentin Monnet <quentin.monnet@netronome.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <jakub.kicinski@netronome.com>,
	Amir Levy <amir.jer.levy@intel.com>,
	Gerard Garcia <ggarcia@abra.uab.cat>, netdev@vger.kernel.org
Subject: Re: [PATCH 05/47] net: remove cris etrax ethernet driver
Message-ID: <20180315121901.GQ17177@axis.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-6-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594928369846121813?=
X-GMAIL-MSGID: =?utf-8?q?1595006090839909734?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:18PM +0100, Arnd Bergmann wrote:
> The cris architecture is getting removed, so we don't need the
> ethernet driver any more either.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  drivers/net/Makefile       |    1 -
>  drivers/net/cris/Makefile  |    1 -
>  drivers/net/cris/eth_v10.c | 1742 --------------------------------------------
>  3 files changed, 1744 deletions(-)
>  delete mode 100644 drivers/net/cris/Makefile
>  delete mode 100644 drivers/net/cris/eth_v10.c
> 
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 04c3b747812c..91e67e375dd4 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -40,7 +40,6 @@ obj-$(CONFIG_ARCNET) += arcnet/
>  obj-$(CONFIG_DEV_APPLETALK) += appletalk/
>  obj-$(CONFIG_CAIF) += caif/
>  obj-$(CONFIG_CAN) += can/
> -obj-$(CONFIG_ETRAX_ETHERNET) += cris/
>  obj-$(CONFIG_NET_DSA) += dsa/
>  obj-$(CONFIG_ETHERNET) += ethernet/
>  obj-$(CONFIG_FDDI) += fddi/
> diff --git a/drivers/net/cris/Makefile b/drivers/net/cris/Makefile
> deleted file mode 100644
> index b4e8932227b6..000000000000
> diff --git a/drivers/net/cris/eth_v10.c b/drivers/net/cris/eth_v10.c
> deleted file mode 100644
> index 8b1a859f5140..000000000000
> -- 
> 2.9.0

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
