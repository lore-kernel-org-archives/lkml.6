Return-Path: <dalias@aerifal.cx>
X-Google-Smtp-Source: AB8JxZoJNl73QoaC8CsySImU1e/iaEaum6H3HepPv3MHm4iNycCeUUAT/PRc7xvCcXT5gHjiEyX5
ARC-Seal: i=1; a=rsa-sha256; t=1524664994; cv=none;
        d=google.com; s=arc-20160816;
        b=DOs5SQ/9LJA9g/umGQlfE+B3yIEEIGkXVe8EAHlHok+aIKup17zBkerOde0N/nJTk2
         NW99EDjdYKs/Sn6I4lkwQRcjClGDoR6qOCm20bxBoA1DXt0kYkMtH4z04+odwRxYvqk4
         3xNa4PdJOVIQmZXDcDWaEqX+SP71vbUwpATn2CYdcylN+5zZlPWJBoBQuClMjN/8ysQq
         FwnaAT43BBRzr3NHlQm6QX0jR9bbz1dEPP8HeVdzJS/i9ysR5XtMOBASu0srpsExnVX3
         Je6aXtvdnHiwpCgDc/lRotEbmxmE99t+wSodBkNB2i5rXwTE8d+20Fd1OCEOdKYYj1yk
         KNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=gfRyPjQ9iUS4Wm5TJOGH/vGC/ZDp+cVwGULJrnml2Ss=;
        b=dTRGeiold6/ffMzYHA7Gsqkoq/LHu9t/VQ5panm0IZrmcfAUNVySvhFqHhP8SOiPDl
         2t1iWy1HS5mNyggcw+sMk9gvSKky48kCX7Pd1XKJ4+RWiIFaKQOhAhQ8tyuaV7aboH/l
         dywIqkeqcN4Zkm7DqZC1CF8J1ysGTYjF8xGcGrANNA3SqS52TRWwocTsr9p3n6SA6oKy
         YOo+YeekDleSD0KDSXBqHyYJN3MEU0F87g5orYfEXuh2kKdC1DehTQuqxpalJym+vDfI
         LJAIIMFx6P7IlgI6tmh12bbXu8Y47GnR/XnnPyjpq0SPr3JnAmf0emisIOoheX04LYry
         AdGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Date: Wed, 25 Apr 2018 10:02:01 -0400
From: Rich Felker <dalias@libc.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Frank Rowand <frowand.list@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 03/11] platform: make support for early platform devices
 conditional
Message-ID: <20180425140201.GE3094@brightrain.aerifal.cx>
References: <20180424173051.15099-1-brgl@bgdev.pl>
 <20180424173051.15099-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424173051.15099-4-brgl@bgdev.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: Rich Felker <dalias@aerifal.cx>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649611911110790?=
X-GMAIL-MSGID: =?utf-8?q?1598727120941667127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 07:30:43PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We want to add support for device tree based early platform devices.
> 
> In order not to introduce additional bloat for all users when we extend
> struct device to accomodate early platform DT support, let's make the
> current machine code support conditional.
> 
> The only current user of the early platform infrastructure is SuperH so
> make it select the appropriate Kconfig option.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/sh/Kconfig                 |  1 +
>  drivers/base/Kconfig            |  4 ++++
>  drivers/base/platform.c         |  3 +++
>  include/linux/platform_device.h | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 40 insertions(+)
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 97fe29316476..1b2c0b2ce402 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -50,6 +50,7 @@ config SUPERH
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_FUTEX_CMPXCHG if FUTEX
>  	select HAVE_NMI
> +	select EARLY_PLATFORM_DEVICES
>  	help
>  	  The SuperH is a RISC processor targeted for use in embedded systems
>  	  and consumer electronics; it was also used in the Sega Dreamcast

If SH is the only user and only intended user for this, don't add it.
None of the devices using legacy board files full of platform device
declarations are using device tree yet, and when we do convert them
they should use device tree correctly, not with hacks designed around
OS behavior rather than abstract hardware declaration.

Rich
