Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x226zc/U/Qdvjo9WMkhmqzFYHLl8w1hfOEDDI/CqDR/0vemoy9v0mOgCNC/tAg1OXuuoZmTMt
ARC-Seal: i=1; a=rsa-sha256; t=1519303610; cv=none;
        d=google.com; s=arc-20160816;
        b=Y2avQ1uKq5YCX+2iVjWh2dzDppmso90KFsBZ6VNamImKBZOuVfhBpfi7nGvBkNvDfx
         PovIX44TOYZttVweM+Cd2OTqPHfx0RQ2/plT/SdiqR8jhblZ1sd43RS99mpsjFzH3lW9
         2ZIt5Gqd1qx7th5nWuxR5b2BrQcKFBqGRnUfSLCGLJescRYPpD7kwuyfGw86Z9IEj3Fn
         UlvsKMiMcEISPwbF95HXOYNCUqoPl85ICfG6OqujTqeSAuGuedbbahwsQpMkRwLwMMNd
         y6dJohYGTr1z49qjOm7ue61pV3V27jHNpYm+Fl1+h8Q85jATt4IGLw8w5TTvm/0Onia0
         aEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=zmrQg7mqByIeThhQSiVdwI3I++qknKUXQS/P+OeAQd8=;
        b=kcSY4EjFXpz4vGRlzDzaqB0vvh6vghCmQOxK6WzyE7Rnl3vBL3zUXHEeAFuM47at2o
         a91184uz62aDCTPq3rmw0O8cu0rsA47NRdlHouRqrW7WnVL2kZ8OVHbIh2MiPV3LIF6a
         oXYBLjiFQVYkziVhuYC+U2afS7nj4Wadqd4DkiQ0gKPE2wfVLvNX/Ldy3lukSqjlUxbQ
         E4mgRt2s44uGGxRyRK/2vrTUx1UGqgNpLrN7bKWznL13fl2wSzqMUtqkaXFcODDCf9ZX
         Lv01Tvb2HeHREAqDWCPlVMHYJ5hYI1CaGYUJFDXt9l5yO4TfOq5Ic1vhaEO8BuzDplt9
         4fGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="22187804"
Message-ID: <1519303604.10722.80.camel@linux.intel.com>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Joe Perches
 <joe@perches.com>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew
 Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,  Mark Salyzyn
 <salyzyn@android.com>, Bartlomiej Zolnierkiewicz
 <b.zolnierkie@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Ingo Molnar <mingo@kernel.org>, Jason
 Wessel <jason.wessel@windriver.com>, Jonathan Corbet <corbet@lwn.net>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding
 <thierry.reding@gmail.com>
Date: Thu, 22 Feb 2018 14:46:44 +0200
In-Reply-To: <CAMuHMdX6HeqB6wUSUCT4L9S2G6YCB9-r6Q4B3dojEUv0iY+duw@mail.gmail.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
	 <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
	 <1519170907.4326.17.camel@perches.com>
	 <1eac0dc6-93b0-2e01-075f-cf62c85318c5@prevas.dk>
	 <1519219410.10722.25.camel@linux.intel.com>
	 <CAMuHMdX6HeqB6wUSUCT4L9S2G6YCB9-r6Q4B3dojEUv0iY+duw@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957911897092414?=
X-GMAIL-MSGID: =?utf-8?q?1593105302639759938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-21 at 15:19 +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 21, 2018 at 2:23 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, 2018-02-21 at 08:38 +0100, Rasmus Villemoes wrote:
> > > On 2018-02-21 00:55, Joe Perches wrote:

> > > Well, on the one hand, I like to reduce the size of the kernel
> > > when
> > > possible and ideally make all new functionality guarded by config
> > > options, but OTOH, how much does compiling out the datetime
> > > formatters
> > > really save?
> > 
> > https://lists.01.org/pipermail/kbuild-all/2017-June/034950.html
> > 
> > I understand that half a year time allows us to increase kernel text
> > size by 750+ bytes unconditionally.
> > 
> > I would really like to not use any option.
> 
> Agreed.
> 
> FTR, growth of my atari_defconfig kernel between v4.7 and v4.15:
> 
> add/remove: 351/155 grow/shrink: 691/429 up/down: 63095/-38665 (24430)
> add/remove: 394/156 grow/shrink: 595/709 up/down: 61173/-31092 (30081)
> add/remove: 1315/711 grow/shrink: 1269/442 up/down: 172871/-92075
> (80796)
> add/remove: 525/266 grow/shrink: 914/510 up/down: 116115/-46240
> (69875)
> add/remove: 443/222 grow/shrink: 906/456 up/down: 77807/-40657 (37150)
> add/remove: 536/296 grow/shrink: 1043/652 up/down: 97366/-65459
> (31907)
> add/remove: 413/176 grow/shrink: 711/479 up/down: 75678/-41356 (34322)
> add/remove: 311/145 grow/shrink: 898/438 up/down: 51655/-26851 (24804)

The concern was emitted from one who cares about tiny config, i.e.
i386_tiny_defconfig.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
