Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AIpwx49Y4+b45sxrVb7F7Egjl/URQ7myqnHFRsSuWItPx8klwx6+nQhSqGyi3NT0r6fGse04HgDg
ARC-Seal: i=1; a=rsa-sha256; t=1523398763; cv=none;
        d=google.com; s=arc-20160816;
        b=PEb2Wykwq8m8k3t+utbK4dmrQHjYbYcPAxkxEBMbhCw0GLkGebzfEudWThVvgqb/4k
         Gav5PT2Ys66XPYBEzxQOJ7/LzRioUFOpGq3YdjSOt7DqW+kL0nuRU/iJTQUKVyHUoQue
         rVxHY8U330YwNvbcRIATabOJrlSu0yxvCIrZJpGzn1jnoSrjDjo7ggapBE17mPUMfnTW
         1HUZf3r2Qh86Lz6Y6j4vovvbmCvx2gdwcz0yB5kgBeaXyAdHipfClR6sz6B/ioVsBi+C
         Ncv9gLJwp7XNOxUhiImRHiRCgk8uxtdCzwSa+nCV0L7VqGKbOPXfPKELGcXmbuhj4XKJ
         ADzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Ih0IcVJZXyEI3mZAGB2uSUvHSW3vJ6MDKyKu0RB9lVs=;
        b=gNReHT9VE0egwB9IoUujtHkLDx6lMnMQvEhLfk5GlQtP2pqM9NGBjb+EffW27TVgl3
         HO2pIMU8Sv8jpNHLvkjp4KIl6UXlabs7QTP/dPeLs540YV1M2pNVwDm9jduxVj8BMIU8
         9Ki6MyQjsDonKedNJj1aQjRYLjJSk3hj59C+qoS5PGjqifxIhrfkbgxXxWICXU4mbWKX
         QnPUzk9yRAE6MJBp4JOxGjVXtVnnhFNGvqIEDWeX2rIbMOhHIOZBDprMVaDIlM7+Gfm+
         sAPm+vtuGH2InWYgBpgZ8rkcYmeHrVulZ3Vl9p4iUjc21PxxWa4D39IyN/PA/tmMGMC5
         /C9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=jIPXgXew;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=jIPXgXew;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Tue, 10 Apr 2018 23:19:02 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adrian Salido <salidoa@google.com>,
	Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4]  ARM: amba: driver_override improvements and fixes
Message-ID: <20180410221902.GA16141@n2100.armlinux.org.uk>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365567140567705?=
X-GMAIL-MSGID: =?utf-8?q?1597399381625291010?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 03:21:42PM +0200, Geert Uytterhoeven wrote:
> 	Hi Greg,
> 
> This patch series contains improvements to driver_override handling in
> the AMBA bus driver, including two bugfixes that are based on similar
> fixes for the PCI and platform buses, and which Todd Kjos would like to
> get into the android common branches to fix possible double free.
> 
> Changes compared to v1:
>   - RMK stepped down as amba maintainer.

No, in the same way as I haven't stepped down as ARM maintainer.
I've said that I'm not going to be putting as much effort in as I
have done, specifically I'm not going to be as active reading the
mailing lists.

This is the first time I've seen your patches, they look fine to
me, so please put them in the patch system as normal.

> 
> Thanks!
> 
> Geert Uytterhoeven (4):
>   ARM: amba: Make driver_override output consistent with other buses
>   ARM: amba: Fix race condition with driver_override
>   ARM: amba: Don't read past the end of sysfs "driver_override" buffer
>   ARM: amba: Fix wrong indentation in driver_override_store()
> 
>  drivers/amba/bus.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> -- 
> 2.7.4
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
