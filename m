Return-Path: <laurent.pinchart@ideasonboard.com>
X-Google-Smtp-Source: AIpwx48S8+cm2JljNzg3JMR9Khraa8v5pMnK1yMBOMRvThNC/Yy4BpbOO19JPfEUnkGGv4rNhqGf
ARC-Seal: i=1; a=rsa-sha256; t=1524298020; cv=none;
        d=google.com; s=arc-20160816;
        b=xEukOmIE8FpssBkqBOvI2TPFOgoJcWwmnSpOiWHdNPEF5AU/evHmCIlbbQYZNpY9SZ
         8sao7lvJGPAHkSUQLPGGi6MRnomkgwFErRy82GRZbCqeZrMvsW0TNqbyCKlYqV5NmwMe
         XUYEbXH5DyLTUh2u/hD3W1x8ey4HjCQ2pMTgV03sa55S+Mol1hUTAQYaSSwzj0r4Bj/Y
         /RjK9HZ2DlKB3BmXfkUP17ewL34Xx11vSUS/h9zywllSWhdpLNpZXLhGvkvCtOTzpmHZ
         eLFzmRt5iSsZNnqeLWObVN2VoVWKwq3yfYZBdqLLtex+CCJ84wWKdmZdw4nO/JlWi5YC
         SbPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :organization:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=OO1k9TeC7MyJuGeK1ZWhR/pQW+xMN8ardvitHpQi2ig=;
        b=QfQYtq8W0Q71zDzofaikqOuUv4Ut0ULWgL2v0T6vDriurDKb1Z5ddJT19P8W2XBv13
         ssM3G9kUu+ovrtHOU31GfSe/o8GN8UXIgsSjXK0L83T1khLcqP75Mw+JraXKY+t1zaS4
         HRDB9NI+KjPtSXmv9t4nlGsSkxXMxvIWPDbZ0kzhC4VwPNBKMCpHqI6DsWdLsHtaTY5n
         V+jID1d9U7usVzD5cnLwf94kIBQE6V+Q2HESlU5j2rF2BAlQdh++uxIum2kjsU3VhBll
         eHQf1fe3CxiivQoaZxRmAgbTB4ekAuLMQNWFHK0gek3JBvq7SpYpTq2/zvqfJmRHNUET
         CydQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@ideasonboard.com header.s=mail header.b=nWfhMDXc;
       spf=pass (google.com: domain of laurent.pinchart@ideasonboard.com designates 2001:4b98:dc2:55:216:3eff:fef7:d647 as permitted sender) smtp.mailfrom=laurent.pinchart@ideasonboard.com
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@ideasonboard.com header.s=mail header.b=nWfhMDXc;
       spf=pass (google.com: domain of laurent.pinchart@ideasonboard.com designates 2001:4b98:dc2:55:216:3eff:fef7:d647 as permitted sender) smtp.mailfrom=laurent.pinchart@ideasonboard.com
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "David S . Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] [media] v4l: rcar_fdp1: Change platform dependency to ARCH_RENESAS
Date: Sat, 21 Apr 2018 11:07:11 +0300
Message-ID: <3039853.rivznOVBTv@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1524230914-10175-4-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be> <1524230914-10175-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598271981483558502?=
X-GMAIL-MSGID: =?utf-8?q?1598342321981250176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Geert,

Thank you for the patch.

On Friday, 20 April 2018 16:28:29 EEST Geert Uytterhoeven wrote:
> The Renesas Fine Display Processor driver is used on Renesas R-Car SoCs
> only.  Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce
> ARCH_RENESAS") is ARCH_RENESAS a more appropriate platform dependency
> than the legacy ARCH_SHMOBILE, hence use the former.
> 
> This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
> future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

How would you like to get this merged ?

> ---
>  drivers/media/platform/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index f9235e8f8e962d2e..7ad4725f9d1f9627 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -396,7 +396,7 @@ config VIDEO_SH_VEU
>  config VIDEO_RENESAS_FDP1
>  	tristate "Renesas Fine Display Processor"
>  	depends on VIDEO_DEV && VIDEO_V4L2 && HAS_DMA
> -	depends on ARCH_SHMOBILE || COMPILE_TEST
> +	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on (!ARCH_RENESAS && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
>  	select VIDEOBUF2_DMA_CONTIG
>  	select V4L2_MEM2MEM_DEV

-- 
Regards,

Laurent Pinchart
