Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526454709; cv=none;
        d=google.com; s=arc-20160816;
        b=0KL7f1akjlR+RoIkWXu0GvijKDj47ZVru5GOqt+oUUwfuyYRHTChmS5+dM+nF4lkIj
         3s0O5hhbC84lJxQO3O2w6Ieu1vtR5PH2Vq6hgm7PdKMziuNrsQjI+5gFmA7yT5C2WF+7
         NuMNYQEFPo5VJdpysOOdy2Xcq27PxX4c/OoAsL4A6CAHmThBAUDKvck1/OCB2SYMLczT
         uMURp8YQLYO230DyPDXEeGatksvLydfIahbKcrWOqhJZotm94KncR1TGaJJXQwbgQU5e
         3KnItr6P5ZNltu8fsX6qG9GtR1hq4kC9b0HJiiF+NsPAn+W42bKiAy/kMS3AwQR2M9FA
         k3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=9rKm/LcBBOKAHUDVd/bdojTdxyo14XspTYe9uQdbA4k=;
        b=Mq2foJPoQR58UuN4yGID7gGglxlxc/plbB2kbUkQfNh5ISHYoRjPjUZpinZVQxIh1U
         t5O/AYQek5AoRHL58Iv5tteW/uEKOeweq1woO+ZicWc6lZ9Kmo/0A5LGQ1SmxlvYe9Ay
         bWlEVnScbkPAKu9rXlW7h4BzitffP3adq++E8FcvJWKn/sKXINTmcQD8tBsv1G2vo+gF
         cTYd6Ck5HxK89sBg/jUdBC0UarFiGLVQxF79XY69CfsVJk1LfuiuUlZW2K3tKh80AYob
         jWUBHjJaeHlAvJS05qBql2k9J0frX5Xu4SESgK28W7IigPyyN+FyB1ASUu+s5NcA9eUq
         guSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=H3QV3zGg;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=H3QV3zGg;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpM2LbuCSMy1XSC0JC9SchRT6whvA11rPs5YDSQM1jInlgyIPfos1n8fZDWm4q82yoe+LMCCtxh2E+RnU50OlE=
MIME-Version: 1.0
In-Reply-To: <CAMz4kuJjhhty7HigPEA6Gm4HtFk_3t1aCwbX3c0mLLQF8SZBLw@mail.gmail.com>
References: <cover.1526285602.git.baolin.wang@linaro.org> <20180515102715.GO29062@mai>
 <CAMz4kuJjhhty7HigPEA6Gm4HtFk_3t1aCwbX3c0mLLQF8SZBLw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 16 May 2018 15:11:48 +0800
Message-ID: <CAMz4kuJomy9Lkjm47qdKrTTmohaGYZNAUG5gV7kf+L46bQfpdg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] Add persistent clock support
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi,
	linux@armlinux.org.uk, Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>,
	Paul McKenney <paulmck@linux.vnet.ibm.com>, mlichvar@redhat.com, rdunlap@infradead.org,
	Kate Stewart <kstewart@linuxfoundation.org>, Greg KH <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Thierry Reding <thierry.reding@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, peterz@infradead.org,
	douly.fnst@cn.fujitsu.com, len.brown@intel.com, rajvi.jingar@intel.com,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, x86@kernel.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-tegra@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429141477472075?=
X-GMAIL-MSGID: =?utf-8?q?1600603773689988201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16 May 2018 at 10:20, Baolin Wang <baolin.wang@linaro.org> wrote:
> Hi Daniel,
>
> On 15 May 2018 at 18:27, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> On Mon, May 14, 2018 at 04:55:26PM +0800, Baolin Wang wrote:
>>> Hi,
>>>
>>> We will meet below issues when compensating the suspend time for the timekeeping.
>>>
>>> 1. We have too many different ways of dealing with persistent timekeeping
>>> across architectures, so it is hard for one driver to compatable with different
>>> architectures.
>>>
>>> 2. On some platforms (such as Spreadtrum platform), we registered the high
>>> resolution timer as one clocksource to update the OS time, but the high
>>> resolution timer will be stopped in suspend state. So we use another one
>>> always-on timer (but low resolution) to calculate the suspend time to
>>> compensate the OS time. Though we can register the always-on timer as one
>>> clocksource, we need re-calculate the mult/shift with one larger conversion
>>> range to calculate the suspend time and need update the clock in case of
>>> running over the always-on timer.
>>
>> First, can you elaborate what you mean by 'suspend state' ? On which power
>
> What I mean is the high resolution timer will be stopped when the
> system goes into suspend state.
>
>> domain the clocksource belongs to?
>
> On Spreadtrum platform, It belongs to one power domain named
> "APCPU_TOP", that will be power down when the system goes into suspend
> state.

Sorry, I made a mistake here. Our high resolution timer is on one
always-on power domain, but it's clock will be shut down when the
system goes into suspend.

-- 
Baolin.wang
Best Regards
