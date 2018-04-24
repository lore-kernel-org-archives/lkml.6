Return-Path: <robh+dt@kernel.org>
X-Google-Smtp-Source: AIpwx49GaoFi4WnyuX7fMwU/MLkFDQ6+M2cHF3a19ViWQq+Y+4yVMFub8QuWq+TtnSDmsJuAmFLx
ARC-Seal: i=1; a=rsa-sha256; t=1524598807; cv=none;
        d=google.com; s=arc-20160816;
        b=NliI59iv3S2f6HaawMtEus93mqvpVSFgAvBS2FkjgpCvbP2Zql1wX8wismnv1JOjd5
         6qARMOT7Vd+wFjF1l5mRKjZB/Q8skAa59X9ShEbEq2I10bji71pnZJ24nLDwGHDSPnAz
         ePn8JQWvFippOg5oc+4GPOzUrgrnxvbG+c4E7tsaSzlIYe7Ynpq5o2VdJhztLAqSZZyL
         tzATXDvHQjNm7f/W+j/BR0fXKknqe8b1M4GhMVP4gQHOX9183SAYRPkv3/bA73xSgCAU
         QbCvxzTBLEYJN1r7YNO7yhK2qrgi1joJzXpepg7FTA65EsAT2i51xhMgUXze+us8/tl7
         xyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=Z2X5BfjWJ/f6cPh5IZllg/EALVyg66CJygQrSIRYPTs=;
        b=nHpP5i64xqgeTNSncn9kRM+9DkIFhYpdaEndVxi3O1t23lhgAL8P0aeEptH/+WHtYQ
         g6MNwWtclUsP1+JEstR1QYZfxx7BmWyZ+2eqDTncWbbwVzpiIrW0VtKdvsdCDWlX+IFy
         lDromE3hHtkrm970nceUpSm9YkGvaTpLgsELVlrC/JpGGX0l1HoJk2W6eUYI/S9duYhK
         TdTBbxwRYhIrGbq+nq8X5B6r29kvbL3m2piz2BCdPXUTQTDUahjQSpo7YwT83pcWkTU4
         qeRaLaVo5FvbkDc6TwmTTjB8ey9lY4dOOfYiIsYsTuSM/BhcE+7Wg3eFG+b5jI3oeWlt
         6YnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2B121774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 24 Apr 2018 14:39:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLcoPK-dDWjwrS82RRG-WLKePfDgHJcBKRQWZG5PszrKg@mail.gmail.com>
Message-ID: <CAL_JsqLcoPK-dDWjwrS82RRG-WLKePfDgHJcBKRQWZG5PszrKg@mail.gmail.com>
Subject: Re: [PATCH 00/11] platform: device tree support for early platform drivers
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
	Frank Rowand <frowand.list@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649607100825317?=
X-GMAIL-MSGID: =?utf-8?q?1598657719313738135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 12:30 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Device tree based systems often use OF_DECLARE() macros for devices
> that need to be initialized early in the boot process such as clocks,
> timers etc. However platform devices are more desirable.

Yes, platform devices would be more desirable, but ...
>
> This series aims at introducing support for early platform drivers for
> OF-based systems.

... the whole early_platform_device infrastructure is not really a
platform_device. Rather it kind of looks like one and I guess gets
converted over during boot.

This is not the first attempt to add DT support to early platform
devices[1]. I think the same objections still apply. It has been
pretty much only an SH thing (which as an arch, I'm told is pretty
much unmaintained and broken).

> The idea is to have a special compatible fallback string: "earlydev"
> that similarily to "syscon" would be added to device nodes that need
> early probing. We then need to call of_early_platform_populate() early
> in the boot process to actually probe the registered devices.

Others have sufficiently explained why this won't fly for DT, so I
don't have more to add.

Rob

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/054529.html
