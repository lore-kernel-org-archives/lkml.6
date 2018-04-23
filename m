Return-Path: <horms@verge.net.au>
X-Google-Smtp-Source: AIpwx48oE/GmumcDnHQvkAc9M1FhZz36tltXz/bMVu7YkGjvGNc4gz0myZ8tqQ3xYGmmD7dQK6xm
ARC-Seal: i=1; a=rsa-sha256; t=1524469808; cv=none;
        d=google.com; s=arc-20160816;
        b=UJIt13TsiV4mTP+Bn4M+mhdpaWqw9sfMDxPp5T5RxCAriYwG9Qie3xuQv9KIvj80dQ
         KIQ0+rTe+C4dkV3qIjEEMcgj9karykFtwaAOFBf21/6VH9xY/uTHIejyWDJyj88tRACs
         6SgVn0faUixWJSvDw8/ccYl18uZ35P+ipimvlMeCbiVGNJF66Cc2seASpIu5VaHlJ31V
         gDzmBFImrk5max+mQtm9zXZFhxi4P7ut3Q+KlQU5VIa2hjwoQs7E7F04IL2MMzLHTOhP
         oTr/kMtovblEpRn8XJfJyA1tv7m+JUI2V/olN7NS/hZDQqnUn7DwVJq/i61gvOP2hpUa
         e2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organisation:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :dkim-signature:arc-authentication-results;
        bh=gYM/VUuQow3DQj3oG12KZvD3TxGFycY26HIOzegGgvg=;
        b=p+cGjrO10OeMol/Mw2Eojc/MHupVhLR1bFu4yIO1j/T/RcrTws+kb5/kGRZf/PQZx9
         2P/fBlS/37wyOHQSk88BiSFf6D056hUEi1g1VuZtRgMBR/k5Ive3Aml1/8HOk1Fl0FOj
         bKsO+Iwq97DpQhDto6RKm8Z9zaqviRCp3xDa5JuE7WAeIg7eegcLoLSuqe/WcmqP9dcO
         eJDInBjMne2lZviEOB2LxUs2lCaQ629HhphQsvr1xQfJVF6zinfJ2d6RaOtNPNj+3+Qw
         zHfueXfOTvxwnwZ+9zfhToQHmKgfb9ZSHiXMTMT2GBb6lA26UxjzRHqKZ9v3Ms/8tgxx
         cNrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@verge.net.au header.s=mail header.b=bUgfiZ7E;
       spf=pass (google.com: domain of horms@verge.net.au designates 202.4.237.240 as permitted sender) smtp.mailfrom=horms@verge.net.au
Authentication-Results: mx.google.com;
       dkim=pass header.i=@verge.net.au header.s=mail header.b=bUgfiZ7E;
       spf=pass (google.com: domain of horms@verge.net.au designates 202.4.237.240 as permitted sender) smtp.mailfrom=horms@verge.net.au
Date: Mon, 23 Apr 2018 09:50:02 +0200
From: Simon Horman <horms@verge.net.au>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
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
Subject: Re: [PATCH 1/8] arm: shmobile: Change platform dependency to
 ARCH_RENESAS
Message-ID: <20180423075002.bca27fbpffl5sbnc@verge.net.au>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-2-git-send-email-geert+renesas@glider.be>
 <44b6b9a3-5273-54f4-ee72-0d5fcc36348a@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44b6b9a3-5273-54f4-ee72-0d5fcc36348a@cogentembedded.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598271982086435905?=
X-GMAIL-MSGID: =?utf-8?q?1598522453720996809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 05:53:18PM +0300, Sergei Shtylyov wrote:
> On 04/20/2018 04:28 PM, Geert Uytterhoeven wrote:
> 
> > Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
> > is ARCH_RENESAS a more appropriate platform dependency than the legacy
> 
>    "ARCH_RENESAS is", no?

Thanks, applied with that corrected.

> 
> > ARCH_SHMOBILE, hence use the former.
> > 
> > This will allow to drop ARCH_SHMOBILE on ARM in the near future.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [...]
> 
> MBR, Sergei
> 
