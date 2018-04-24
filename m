Return-Path: <dalias@aerifal.cx>
X-Google-Smtp-Source: AB8JxZq4jDDnkOXO9Q5clWehrtW4/p9fUUxrpb97YIudP4JDOj2Wd9tdmgX79UEGFtH2mwSVEaQe
ARC-Seal: i=1; a=rsa-sha256; t=1524592729; cv=none;
        d=google.com; s=arc-20160816;
        b=w/fFN6f3HuhrnX5z5GElzjHtE/Lky6dXzSB4hJLBQpTWXKkl9dEreKNYHe40usTecx
         nx9nTHwU53GkJ5IbIlVlNXL3sPViZoQ4QQNyZ/9RKV45voEVEld8Qs2DKpoTJamHja5I
         B+n2p8xqGxm59PerVBCa++hcmjDocJX5cBkSvSjJCPvDI2t05ekxNDyE05EaU1q2Ut5M
         FFeNSVTP43vnzX9RGvswhgkzCHCOQK7gbyYNgb/gTkEa9QnzjQFpLGVElP+gWEk06tEt
         iIwmu2iW3nWSAcvAD+Qv/6jrRQ+OWp1OmA/Kx6yWLQddJ8rTs7pltuRu2Ojaq+0CX+ZH
         s52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=6rLbWN6hzK3s7LnO82jzIV3W1tAvVPZxrKW1SQ1FTAE=;
        b=cTMP+MFC9vsEgD5yPks3T4jpK1fK+fznYT+aqQumiAlc3P8Jt81xaHrLPyHSjpWJ/5
         YrZU56o0J9vBzq2gJWNanQoGRGMFfGB0A6dBxL3BiJbfya4/t4b5Qm4Op8eotWjNlqJj
         snuXFtjA1G98mVxz9tbXDr8sTCHn8KTFFKMxn821UgBmdL2cZiN1b/QR/GiqMdbjMQX5
         c7fEz4n5/bZpx9qby41NXGqgxYFa2TU6ZkujbEKYvNu00IA1JnV4YSN62ph7Ngf8rnFi
         nxc2YvOuuIRi/EpdTfZU2xfIIPOev5RLxfsXgdsH6ddEJQ9lDR0LQrPCyHJqkeQwaxCB
         tNlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Date: Tue, 24 Apr 2018 13:57:52 -0400
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
Subject: Re: [PATCH 00/11] platform: device tree support for early platform
 drivers
Message-ID: <20180424175752.GC3094@brightrain.aerifal.cx>
References: <20180424173051.15099-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: Rich Felker <dalias@aerifal.cx>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649607100825317?=
X-GMAIL-MSGID: =?utf-8?q?1598651346170106418?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 07:30:40PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Device tree based systems often use OF_DECLARE() macros for devices
> that need to be initialized early in the boot process such as clocks,
> timers etc. However platform devices are more desirable.
> 
> This series aims at introducing support for early platform drivers for
> OF-based systems.
> 
> The idea is to have a special compatible fallback string: "earlydev"
> that similarily to "syscon" would be added to device nodes that need
> early probing. We then need to call of_early_platform_populate() early
> in the boot process to actually probe the registered devices.

This makes no sense to me. It's not the device tree that should
contain the knowledge that these need to be registered/probed early in
the boot. That need is a property of the operating system/device
drivers, and so the *drivers* should be the ones that contain the
knowledge.

> I am aware that this new compatible does not strictly correspond with
> the "hardware description only" rule of DT, but we already have many
> functionalities that break this rule: syscon, gpio hogs etc.
> 
> The first user of this new functionality will be the DaVinci platform
> for which we want to probe the pll, psc and timer drivers early in the
> boot sequence but keep them implemented as platform drivers.
> 
> In the future, if this series gets accepted, this could become and
> alternative to TIMER_OF_DECLARE, CLK_OF_DECLARE etc. and could lead
> to deprecating of those macros in favor of early platform drivers.

This seems completely unacceptable, in that it would render new
kernels unable to boot on existing device trees (which may be
hard-coded in rom on existing devices).

Rich
