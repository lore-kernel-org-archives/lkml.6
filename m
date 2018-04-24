Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx4+m2n1JPmjPmY89Y4vPsNshZa+dWF1jhn/s6HN3UbF+RlzlrVDx01GXtA3J912O8eAFEujI
ARC-Seal: i=1; a=rsa-sha256; t=1524598361; cv=none;
        d=google.com; s=arc-20160816;
        b=QNN5aaR7BreDaatU18Z9nYO9SRT7D0OuvMXJqYlWQyMc6LhsP5oSkALExOaI+Mz/gI
         JUydSxt+EO3rPoRKU04H+zVjpQKhGXakqCghWi8MEtd9eHvyBZy+gLO6RMsta8vaUT9Q
         DFQN0zg4jL5AhhrxdjZeQAidVCbdNhQAzgFlEtD3v60kehDedG/UC4y0stxHTZkNwbee
         ikWGnDKGrKaW5WeZFQAowfgiWJw/uR+Qx5zR4veKvGzf8QGZ+BBrHeNIOtOgPb4LLVN/
         Hr8F1ax27pXer67Rp+O0TyG4oXrKajrypuCsA0rZ1Z34fP/V/7ImdEXft3y0P2u10nj9
         jsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=owcjKRSS7UeyfaOZG8AwZzwjN+ahpXC8Q2bTRlNgodY=;
        b=eLQIX/ac+EeIJu/MK8PGa4MYTvButp+uEKTW15EUS274/zbixDnWpDyh0wBpswByOI
         2L6k1ZzclNHv27q2calcJtSv8vof0XMMsu5NLyGwO+iltJOqrCyzuJCC4b6m0fTlIJUS
         9G3KXh9/e9xLlR+r4wRk9XqzaSg6pSmiZj8TI8s1X4K4VnjArC8b4UuO4wxmthltXYZn
         CsUdywlFNGhkah63RWczKdMxB6s7qC+FtCtfRjhx5Sv99MYYXgqb8VHG3T8Dnu0I6Bbs
         0dCvuCCUJccgKByFQCFUWom2Ro1iipvXP+G7fEcpHarbMIPOMdzd6csO/+HBB0eReoaP
         c2EA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=aihBpba9;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=aihBpba9;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 03/11] platform: make support for early platform devices
 conditional
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Arend van Spriel <aspriel@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Michal Suchanek <msuchanek@suse.de>, Jan Kiszka <jan.kiszka@siemens.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180424173051.15099-1-brgl@bgdev.pl>
 <20180424173051.15099-4-brgl@bgdev.pl>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <aa459c94-bfc2-5cf8-0197-6487ea9152a8@infradead.org>
Date: Tue, 24 Apr 2018 12:31:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424173051.15099-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649611911110790?=
X-GMAIL-MSGID: =?utf-8?q?1598657251091672312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/24/2018 10:30 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/sh/Kconfig                 |  1 +
>  drivers/base/Kconfig            |  4 ++++
>  drivers/base/platform.c         |  3 +++
>  include/linux/platform_device.h | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 40 insertions(+)

> index 29b0eb452b3a..37de5e1d6217 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -205,6 +205,10 @@ config DEBUG_TEST_DRIVER_REMOVE
>  	  unusable. You should say N here unless you are explicitly looking to
>  	  test this functionality.
>  
> +config EARLY_PLATFORM_DEVICES
> +	bool
> +	default n

The default value is already 'n', so we usually ask people to omit that
value.  OTOH, you could combine those 2 lines into:

	def_bool n


> +
>  source "drivers/base/test/Kconfig"
>  
>  config SYS_HYPERVISOR


-- 
~Randy
