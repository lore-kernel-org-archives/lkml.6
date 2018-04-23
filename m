Return-Path: <horms@verge.net.au>
X-Google-Smtp-Source: AIpwx4+qo04W9J2JN3H5MHm8vw38TyOoMpXBoRtolnxHUz4NzugeXI4BY14ES3kG0Qv8E6xnZu1l
ARC-Seal: i=1; a=rsa-sha256; t=1524470023; cv=none;
        d=google.com; s=arc-20160816;
        b=pZ0DGDg9zDFtlPN4y6pMierMkrjhQU5JjoTYPqLNaPp8Y4MkU3quDWgGVHhEisa96w
         DlrZ5o1TLkT40qAywYTjDSBcgJWccmbKlDqscof+rejC5Vr3CO4RuXBxyodOAPWtmZEl
         lmmMGAVEjbdr0pJr8BkuG9QJVBzZQrQk9u7UeJzC8Mara1eC0e0kEmWfQpV2eyvvjV5E
         w48sEYgAJ5dj5gLGNzVjWj6RjU9GmPiYbiieSzA2M/KhXakyrbrKHqXWyAn2o+4aamj6
         LCa2jRFqseGLps/xUabP/Mqtbr/RAPs+05AXwNQwdNBIqS7N+1RVf1C9ug3FFtzDQen9
         E4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organisation:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :dkim-signature:arc-authentication-results;
        bh=uGivU3HBlaIEPPNSwa2kczlgWfTNOimB0enPO4twrvs=;
        b=tEKLjw0kTL43NG8qVq4YEsZAkGbHxu3dKjzkB611PMXMfr+HA7mob1boIl716xy6F9
         KbNWfqvGC+F9AMSTRpYmLcz6Xyc52rWuFKs9hi00vhf7YHDtOJhc4oH8hUsd+XeP4gEK
         IZJyPW8RDBGGePK3pvlayZ9uHAfcPIJ7I96LpQtKeLAk5HA3EkMeJcQ7bZk6sopcBFr+
         xLuI+jAjTVaofgQoz+7ieIl9EPWXIMmzBWSo7yd8pPNMu1IvCDyHfnuXH299ZytgS1BV
         TajE0QPd4f6xpqr/Ef9ByQo4ZHwVH2YKB4imRQgvnPTGeNxQBIWXmoV3IVZRF3TieyU/
         zYsg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@verge.net.au header.s=mail header.b=ooQWqv4p;
       spf=pass (google.com: domain of horms@verge.net.au designates 202.4.237.240 as permitted sender) smtp.mailfrom=horms@verge.net.au
Authentication-Results: mx.google.com;
       dkim=pass header.i=@verge.net.au header.s=mail header.b=ooQWqv4p;
       spf=pass (google.com: domain of horms@verge.net.au designates 202.4.237.240 as permitted sender) smtp.mailfrom=horms@verge.net.au
Date: Mon, 23 Apr 2018 09:53:39 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	"David S . Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] dmaengine: shdmac: Change platform check to
 CONFIG_ARCH_RENESAS
Message-ID: <20180423075338.riknxyjugnv5grjb@verge.net.au>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524230914-10175-3-git-send-email-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598271981637066006?=
X-GMAIL-MSGID: =?utf-8?q?1598522679030059056?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 03:28:28PM +0200, Geert Uytterhoeven wrote:
> Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
> is CONFIG_ARCH_RENESAS a more appropriate platform check than the legacy
> CONFIG_ARCH_SHMOBILE, hence use the former.
> 
> Renesas SuperH SH-Mobile SoCs are still covered by the CONFIG_CPU_SH4
> check, just like before support for Renesas ARM SoCs was added.
> 
> Instead of blindly changing all the #ifdefs, switch the main code block
> in sh_dmae_probe() to IS_ENABLED(), as this allows to remove all the
> remaining #ifdefs.
> 
> This will allow to drop ARCH_SHMOBILE on ARM in the near future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
