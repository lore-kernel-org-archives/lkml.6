Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AB8JxZqL/pTboVw5osm0VsWgXoYQ305keFPLZ6TZiQw1KSq7Mtk2d6vmbOi75syLWh8EQnoI6u/D
ARC-Seal: i=1; a=rsa-sha256; t=1525455574; cv=none;
        d=google.com; s=arc-20160816;
        b=vZSgiu0YgUFYHG1RCAccEMdDoiNMT/+G44IR3hEiFlNGozG16wdPdAf4ImhfH58nDE
         vwXs0cWXXlRoql11ezGKWlKiJQn1nOBcza9mVMLoZTJLmuY+dtZoZ+8VowSuiWovUSmY
         JEuYZHC0FPeJxJiPEB+2olXPhrwfIcpkcdwFHCbZPwYHJwfwljzsX+96/F3/q0VCxpos
         L2TwjHHUXTbWO9pfgSVTGq9YeTNnqMpSo7aL//YHxNxBBzkmn9wIWW2NvkVzswzAR4Q3
         V17p05UU687QNJjwox2qUwocbkcIPPi90+Xh2VKBQWwJFLDbin/8TO9yYH6Ed5aCF/F+
         JRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=RlaZXnm8C+QH1ZPJLqO8f4r59UVNYMstPzovIgWRIzc=;
        b=Z3FdrRb6BTODMBXxPjBYJ8sFVRZfZwqgxzkLUFWTZWKB/cp9CTZWoDM7yGMipw5mqx
         vuMpud2nVLTB0lhbfqeumtZJuMyWAyqGAYl7EaOnv69FhRnskCdTQPGBRMvE+nZKA3mx
         TXFy6eIAWCUmHJ/rvaS3buX9k7/XJmfTurBgRf+Lr7uHkPxOM+PVKlFjoD4xKFtlXrs7
         HvbuHNOFNXRvEj2CAc142piMpu/aL7MEmEHrfufkp1md5abouMHcHvKMXWI10/b1V8yy
         V1bxiCqKEFXBalnqDbvY9JqJ42WJMGJoC/jyiJmaTXAJEiXM3YGaWgfklG8x8HepM6FI
         b5/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Date: Fri, 4 May 2018 10:39:31 -0700
From: Tony Lindgren <tony@atomide.com>
To: Peter Hurley <peter@hurleysoftware.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh R <vigneshr@ti.com>, linux-serial@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	Keerthy <j-keerthy@ti.com>,
	Matthijs van Duin <matthijsvanduin@gmail.com>,
	Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2] serial: 8250: omap: Fix idling of clocks for unused
 uarts
Message-ID: <20180504173931.GD98604@atomide.com>
References: <20180504173103.73881-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504173103.73881-1-tony@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599555575142976735?=
X-GMAIL-MSGID: =?utf-8?q?1599556104703403074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [180504 17:33]:
> I noticed that unused UARTs won't necessarily idle properly always
> unless at least one byte tx transfer is done first.
> ---
>  arch/arm/mach-actions/platsmp.c     |  6 +++---
>  arch/arm/mach-exynos/platsmp.c      | 12 ++++++------
>  arch/arm/mach-hisi/platmcpm.c       | 22 +++++++++++-----------
>  arch/arm/mach-omap2/omap-smp.c      | 10 +++++-----
>  arch/arm/mach-prima2/platsmp.c      | 10 +++++-----
>  arch/arm/mach-qcom/platsmp.c        | 10 +++++-----
>  arch/arm/mach-spear/platsmp.c       | 10 +++++-----
>  arch/arm/mach-sti/platsmp.c         | 10 +++++-----
>  arch/arm/mach-sunxi/mc_smp.c        | 20 ++++++++++----------
>  arch/arm/plat-versatile/platsmp.c   | 10 +++++-----
>  drivers/tty/serial/8250/8250_omap.c | 16 +++++++++++++++-
>  11 files changed, 75 insertions(+), 61 deletions(-)

Uhh sorry I managed to commit also a patch I was testing while
updating patch comments.. Will send out v3 shortly, this can be
ignored.

Regards,

Tony
