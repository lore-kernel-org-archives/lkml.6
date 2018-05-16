Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526437220; cv=none;
        d=google.com; s=arc-20160816;
        b=SOOHPi6W/c171JZVmwdaESS1dfQC2TIjZ6cnFSI6UEqUUTtr/kCHb4ILQ93GD6sL4m
         ccVSQy4oTTg99FAJXjg77W7yoBw2vMCCkctjrKjLGZQTEvTlItEQhOSNlBtq9vUnJV4j
         DIpagEPls5Z0me8WtdzlBhmnSLIL3FTtMr/n7xN7N/P20iZAO+utLllp2dnxsZI1HiWZ
         NOT5tqsShnO5BJAOnNGbDXFoZIJjhsRceZNf3sZ/1MjzBb6nA4PJtiWX+lrCvvEg06vc
         JvCYWFqoyQOWDM31VKiC7J3Cmi1Q542J4UtIJOjacUzObY0c5AXaADA25L5YUu1/9GfA
         qVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=dR88xZKmkENuH6VkK1zNkHUK8aPsVDL94vF9o+eaqlo=;
        b=SaQEnIGS8yC3/u9ctOXfd40MN+1OPmD+8kFP0TGZ7L7VsU6lxDRUUMnzAjG4qvDO8X
         n/7hKGKB0yTRdOxqnqNNTdJAFFxFMgVNi28uqxUuQnuzETPPXuTo889M1x80LefWAcYx
         bLG9F2ItCVstE6/rS6mDI3SMcF75l4b6A7dxDuH3S1nPphsLlY+tZizm9eqwX+LCGg9v
         6RFhvEt28ddXyCCCdLIvv9JIzE0r/tGtalumi8A16WDx8U+Q287iiIEd4j2dgE8Dlm+x
         Eued6EpksOnt7mZtzoxeM2B9/2jr6pTe8UJW6RtN6f2P8Zb1q9Qrl7ATYT/B/pLpVf3b
         qN2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ks85CwdM;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ks85CwdM;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZo2J6DFLVngxKkIGc0UmvmM0rz96hZ2q0+wHOJxp11bBjh/t4ReNlObDBP8TKD1cYXba/65qx+z+fvDoDNvF10=
MIME-Version: 1.0
In-Reply-To: <20180515102715.GO29062@mai>
References: <cover.1526285602.git.baolin.wang@linaro.org> <20180515102715.GO29062@mai>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 16 May 2018 10:20:17 +0800
Message-ID: <CAMz4kuJjhhty7HigPEA6Gm4HtFk_3t1aCwbX3c0mLLQF8SZBLw@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1600585434387754989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Daniel,

On 15 May 2018 at 18:27, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On Mon, May 14, 2018 at 04:55:26PM +0800, Baolin Wang wrote:
>> Hi,
>>
>> We will meet below issues when compensating the suspend time for the timekeeping.
>>
>> 1. We have too many different ways of dealing with persistent timekeeping
>> across architectures, so it is hard for one driver to compatable with different
>> architectures.
>>
>> 2. On some platforms (such as Spreadtrum platform), we registered the high
>> resolution timer as one clocksource to update the OS time, but the high
>> resolution timer will be stopped in suspend state. So we use another one
>> always-on timer (but low resolution) to calculate the suspend time to
>> compensate the OS time. Though we can register the always-on timer as one
>> clocksource, we need re-calculate the mult/shift with one larger conversion
>> range to calculate the suspend time and need update the clock in case of
>> running over the always-on timer.
>
> First, can you elaborate what you mean by 'suspend state' ? On which power

What I mean is the high resolution timer will be stopped when the
system goes into suspend state.

> domain the clocksource belongs to?

On Spreadtrum platform, It belongs to one power domain named
"APCPU_TOP", that will be power down when the system goes into suspend
state.

-- 
Baolin.wang
Best Regards
