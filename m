Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x224WDlrrlk6N4tMQY0XLHpj0arJji96BrG8HtND3as3CR58CjsRoJVqS6ht4obxwbql4XRK3
ARC-Seal: i=1; a=rsa-sha256; t=1519219416; cv=none;
        d=google.com; s=arc-20160816;
        b=il3onectzbqV8tueem2qNn3FDkiaAc80NfF7/cgEjbd4F05Rfv/w/16q3vLHMOgKcY
         sXQfr9bPv7xn4txxTgfAxmLyRJxXGiMUXFQN/YHl8HWDfhAEYnt8KROSu3MEcz62n45p
         8dVv90fkm+B4o5rQa6Z9z1Ah6qOWMDZcC5oDkNye7QnfioCg3QtHf8870Hm8qASZvG7b
         GhO6Ec/tlyn0jOOs2Dnpg2b2cbMTBfyVEmgrvh0vd1zmX2vRmGIaerVi2djdrjcvOmqh
         YLpdNKHe1ENu42tVW7rPs91NKeLReVbSDEJzhSEhgyocmNY+MgxvbIL3h0KlSq549+qh
         Y89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=RQYYOIcWVbt0x/OdbgUoAwIP5cyhcghpiUWT4Y68MyE=;
        b=ZlhtFnr/uxBmxCbn8KEZjM8OxHGy7qXYnTR/upXom3NapJI7PT601DfVQKWu45Ptyg
         480pHHOj5/RwGjF2kqVVroxe1gJo6OxIJrhnnKbILVL+DpQNb92tf6DmHlIIYt4YV9kI
         niC/AzLYG2OyJzBWdW+mtpkl+SeaikWFCTLcV5pJVQjsg6COSJ7qZb9UC92r/MyMRY6b
         /pYN8TdkTIwU+eCDG+YZcYR9ew6LLyoHqhzn7uWmVlouZ1U8tOgw2NIZx1fYDpsonsfX
         RKWeOG77ymA+7Yjqp/KYNcho9gf/kyMWVSodvrrMG7ZfJbhZsU1DsfqdPeMCsh3xcxFi
         lvSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="28750723"
Message-ID: <1519219410.10722.25.camel@linux.intel.com>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Joe Perches
 <joe@perches.com>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew
 Morton <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org,
 Alessandro Zummo <a.zummo@towertech.it>,  Alexandre Belloni
 <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>,  Mark Salyzyn <salyzyn@android.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Ingo Molnar <mingo@kernel.org>, Jason
 Wessel <jason.wessel@windriver.com>, Jonathan Corbet <corbet@lwn.net>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding
 <thierry.reding@gmail.com>
Date: Wed, 21 Feb 2018 15:23:30 +0200
In-Reply-To: <1eac0dc6-93b0-2e01-075f-cf62c85318c5@prevas.dk>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
	 <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
	 <1519170907.4326.17.camel@perches.com>
	 <1eac0dc6-93b0-2e01-075f-cf62c85318c5@prevas.dk>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957911897092414?=
X-GMAIL-MSGID: =?utf-8?q?1593017019091888399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-21 at 08:38 +0100, Rasmus Villemoes wrote:
> On 2018-02-21 00:55, Joe Perches wrote:
> > On Tue, 2018-02-20 at 23:43 +0200, Andy Shevchenko wrote:
> > > There are users which print time and date represented by content
> > > of
> > > struct rtc_time in human readable format.
> > > 
> > > Instead of open coding that each time introduce %ptR[dt][rv]
> > > specifier.
> > > 
> > > Note, users have to select PRINTK_PEXT_TIMEDATE option in a
> > > Kconfig.
> > 
> > Not sure this is a great option.
> > Not just the name, the need to select it.
> 
> Bikeshedding first: If you do keep the config option, please use
> PRINTF,
> not PRINTK - vsprintf can be and is used by lots of code other than
> printk.

OK.

> Well, on the one hand, I like to reduce the size of the kernel when
> possible and ideally make all new functionality guarded by config
> options, but OTOH, how much does compiling out the datetime formatters
> really save?

https://lists.01.org/pipermail/kbuild-all/2017-June/034950.html

I understand that half a year time allows us to increase kernel text
size by 750+ bytes unconditionally.

I would really like to not use any option.

>  Also, I agree with Joe's concern about the need to select
> it.

So, what exactly you are proposing?

>  Maybe if we had a gcc plugin that did %pFOO validation it could also
> warn about %pBAR being used without a corresponding config option
> being
> set. But we don't have that currently...

We have not, so, it's out of scope. If it's a big impediment, then I'm
not the guy who will do the job.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
