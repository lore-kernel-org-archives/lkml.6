Return-Path: <horms@verge.net.au>
X-Google-Smtp-Source: AIpwx4+rW4g90QbKIE/ZZ3kRPi7wyuQpyysGpsUbSVBbdkbvYAjbTivyXbk4heLkjr8I/GRj70gW
ARC-Seal: i=1; a=rsa-sha256; t=1524470086; cv=none;
        d=google.com; s=arc-20160816;
        b=CAXnvTMpfIKJzO6CFEQmm8rTgIuPITB1wLOsq/f8cE/RhG8ILLYEz2mONRLfPrClZv
         u3eYZlxqQawBAqK0XwIdNGlX+UEHvRv/cKHa1bhn/wJLN+A5RCFJMNkNCp8FGJo1YeBB
         5s1zObKbwON3rpfEUAzkRGnusu3JAKSaKwZ3RZvwiD3TG3STFsF56+2qnrq1IhChNUh2
         /hpIAL0OmOaSxzve57wrnqx6wWyrPSwJc6gpCmQT/U4etGOUrn0qmTPIZvXFcmuWomm1
         K+56U+Sy1cLKehhokpEFbWKzU7qm72fJbYaEy1yucMkgy1J0T69+HeARXz1D8lTlb5lb
         g6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organisation:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :dkim-signature:arc-authentication-results;
        bh=ZUD0ehOW9VKCkeLWBDvsJmb5MPaHIvkYju8dk7EQS5A=;
        b=J8eSI06P0f56GyRA35xiIBoEe/MYwfeOmOtJDx5B9pjpfTVmxrdQMb03t6rAFUQuO+
         dxzJHhGlXIKPdk9Ewzw1Dp1NeoE7ObkTUOJLoRAvRzRgSwQWIXKxvm5jwaFompoKDUZe
         uy8ufkPJfoh90pWO260NsmBuY+9y4CLR9X3llyXN5kA0eJ+hWVKzIaOHaNAwoEqbsrin
         bvt2hHH/yMFhSzwsJkiH1e015GicED06cts12IxbVgvoXJyr2eL7Yu2Z7tMsluUaV2xp
         djxzLLR+7dwZWQfpNzxpbHdg3SOkXt+0Q9WWLoHNqRPj92zlCZReKmVaUcgoh1N4+uet
         eBQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@verge.net.au header.s=mail header.b=U5i3PIP2;
       spf=pass (google.com: domain of horms@verge.net.au designates 202.4.237.240 as permitted sender) smtp.mailfrom=horms@verge.net.au
Authentication-Results: mx.google.com;
       dkim=pass header.i=@verge.net.au header.s=mail header.b=U5i3PIP2;
       spf=pass (google.com: domain of horms@verge.net.au designates 202.4.237.240 as permitted sender) smtp.mailfrom=horms@verge.net.au
Date: Mon, 23 Apr 2018 09:54:41 +0200
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
Subject: Re: [PATCH 3/8] [media] v4l: rcar_fdp1: Change platform dependency
 to ARCH_RENESAS
Message-ID: <20180423075441.pbopbimq5m75apgz@verge.net.au>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524230914-10175-4-git-send-email-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598271981483558502?=
X-GMAIL-MSGID: =?utf-8?q?1598522744696593939?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 03:28:29PM +0200, Geert Uytterhoeven wrote:
> The Renesas Fine Display Processor driver is used on Renesas R-Car SoCs
> only.  Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce
> ARCH_RENESAS") is ARCH_RENESAS a more appropriate platform dependency
> than the legacy ARCH_SHMOBILE, hence use the former.
> 
> This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
> future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
