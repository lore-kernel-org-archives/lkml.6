Return-Path: <dalias@aerifal.cx>
X-Google-Smtp-Source: AB8JxZoxXnaxt9O5nL0+7gI0WeT2TgIyhKrOPQPhhPximd61oHTWh0F2ZDKa5PIgDmt70L5BGkKq
ARC-Seal: i=1; a=rsa-sha256; t=1525106625; cv=none;
        d=google.com; s=arc-20160816;
        b=HFwNt+SVJ2u5+5FeHXH+x1a5jfLyb4qBnCSvPIB62WsrQQvLWq88GiO0IjV69UJ5PL
         Ht1C9hd5s0e6rkCa0xcq8AEUBxFg+pUZFxT173uTeGI6AEvxXdx68VmRitNuSNrQkIaJ
         zG9HTQxMug4BGPAzXDaYNSC85qs54F8bgstR/BSCdCfmeJGgA+5fHcU+uFMTXkAnMPsa
         LaEUhnbl0r+P6eTfDgiZkJlrPRJA9CwflsOBVcZ0VgIyt+19QvpV5jRsfbbICjPd1WbV
         RIvuz8f+BmzqDljLHnJYJ+PXDDz0obJ99bm55gpSVXCrD61q6pZUdj4kMUfhYgiCk4Q4
         DCbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=T2N9m+2WTg98n96/Eec9mhr2OCvuBDCJxnqNStPxUHE=;
        b=EXqcWzLLZ6kch08kzA925jwNzXfWGQJ9LmxVX7hndyKO88fqiwdwvVtmmjbcvfsd/X
         FRzJChu3fKM5y1HCN8ZfixmdnVaQm8QDeQk6cOovOq/Cuj1QDHe8zwdZtDpfyP3VTHFT
         3oEJ9QffOazk0cE2mWMFDwy/2gpTRoJI3XanwsTaGIPftfIQmfXlsCosSS5T0GzfG1Nr
         xGAjIPPlmk/5xGhJOHE1flAsXmqdEk0+AS4Wy1paAeaBNIr/ltNprVYIMgLVaJCgbAQ1
         9liICy8D5eEVH8EsuafQii4SoepJ5PqvOkTb7B0F9lmAnzSdp9ggAUf/z1xPRCdmnSuL
         hlYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Date: Mon, 30 Apr 2018 12:42:50 -0400
From: Rich Felker <dalias@libc.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 0/3] sh: make early_platform code SuperH-specific
Message-ID: <20180430164250.GN1392@brightrain.aerifal.cx>
References: <20180430163556.2560-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430163556.2560-1-brgl@bgdev.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: Rich Felker <dalias@aerifal.cx>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599189742028891763?=
X-GMAIL-MSGID: =?utf-8?q?1599190205194810472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 06:35:53PM +0200, Bartosz Golaszewski wrote:
> I recently started a discussion about the need for a proper early device
> probing mechanism[1]. One that would be based on real platform drivers
> and support both platform data and device tree.
> 
> While we're far from reaching any consensus on the implementation, Arnd
> suggested that I start off by moving the SuperH-specific early platform
> drivers implementation to arch/sh[2].
> 
> This series is the first attempt at making way for a new, less hacky
> implementation.
> 
> The first patch removes the last instance of a non-sh driver using the
> early_platform API. It can be removed since ARM no longer probes early
> drivers.
> 
> The second patch moves all the early_platform code to arch/sh.
> 
> The last patch prefixes all early_platform symbols with 'sh_'.
> 
> [1] https://lkml.org/lkml/2018/4/26/657
> [2] https://lkml.org/lkml/2018/4/27/239
> 
> Bartosz Golaszewski (3):
>   clocksource: timer-ti-dm: remove the early platform driver
>     registration
>   platform: move the early platform device support to arch/sh
>   sh: add the sh_ prefix to early platform symbols

I can't say I like it, because I really want to be just removing all
this code, but I don't necessarily object and it might be the most
appropriate short-term action to clean up this mess without breaking
things.

Rich
