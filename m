Return-Path: <david@lechnology.com>
X-Google-Smtp-Source: AB8JxZrH+Ces06mrNjkVwYgq+7FdFAS4flMt4kB89Tdmi6TA8uOvvpp+BYPOBVZu97aqGFg46IgM
ARC-Seal: i=1; a=rsa-sha256; t=1524796128; cv=none;
        d=google.com; s=arc-20160816;
        b=jJF3Qj1BZWZczjcXEZfiL5GiSwerqsFBLhhmle1BdmM6FPqTRjmauF58a8Il28NnFM
         jWG0djURQKoUo7j2YwuM+3Wh+1UdzfC8I4N3agS3+JMBf7Yx5cAYmo3N3hKD9PimTXHa
         Mem9djJ74YPjll0irQ97/PmCVrpklSg4POJqtGnHmWl4T/G/wx6iBK8yLvwW7dqllMDR
         UQEDcVs6wllYQBuWzSiSX6kqCqDCqzMwtk0y3lrimHjRcLTDXdnw0Yyz9QvqTopaUkrm
         hzzphd6ANhoj5TK8yDn9JbUgYjRMfmL+H31D3MngEgtm9fBpHvmm6u4XR4Ph8Ob+eZaH
         g+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=gDo728c5wjv1rTaoWHcE3f+nxb9pl4Knt+E1/P4lkFA=;
        b=u0YnhrKO68ewJjuriau91D0ECGykqhiCR8I3kVQtfY9GnfQdAIaOGCLPd8L8YTpiKD
         KCi1kAD1uklMq3R+GoncpkdvzFBmU0AYaXMp+QaNTTKAQUel4esfCmDsi0kWON1XIM0p
         IJSVYD+R1RixwBpDiVYCkeNjU9MlD4kpJjuFq+MEaQKD418RrjLx7eMTnln6ZWBpl4bH
         duGQJKz6S2oppT47RDfFvABffFyPYkmrBP0NsSkK6iu6iubu2dSAdo24D0+W+kysi/fE
         H2IIrsF5HxMc0QEqGYSbxWC282ZJtnSgexzKZvga+PrDviDwPkbJ9iNYn45Tq1gP1Ozf
         yJkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lechnology.com header.s=default header.b=h2ibzdtH;
       spf=pass (google.com: domain of david@lechnology.com designates 206.190.152.46 as permitted sender) smtp.mailfrom=david@lechnology.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lechnology.com header.s=default header.b=h2ibzdtH;
       spf=pass (google.com: domain of david@lechnology.com designates 206.190.152.46 as permitted sender) smtp.mailfrom=david@lechnology.com
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
To: Rich Felker <dalias@libc.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Frank Rowand <frowand.list@gmail.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Arend van Spriel <aspriel@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Michal Suchanek <msuchanek@suse.de>, Jan Kiszka <jan.kiszka@siemens.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Peter Rosin <peda@axentia.se>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180426152920.21569-1-brgl@bgdev.pl>
 <20180426173151.GJ3094@brightrain.aerifal.cx>
From: David Lechner <david@lechnology.com>
Message-ID: <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
Date: Thu, 26 Apr 2018 21:28:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426173151.GJ3094@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823149958129846?=
X-GMAIL-MSGID: =?utf-8?q?1598864625342607008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/26/2018 12:31 PM, Rich Felker wrote:
> On Thu, Apr 26, 2018 at 05:29:18PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This is a follow to my series[1] the aim of which was to introduce device tree
>> support for early platform devices.
>>
>> It was received rather negatively. Aside from using device tree to pass
>> implementation specific details to the system, two important concerns were
>> raised: no probe deferral support and the fact that currently the early devices
>> never get converted to actual platform drivers. This series is a
>> proof-of-concept that's trying to address those issues.
>>
>> The only user of the current version of early platform drivers is the SuperH
>> architecture. If this series eventually gets merged, we could simply replace
>> the other solution.
> 
> Looking at a quick output of:
> 
> 	grep -r -A10 early_devices[[] arch/sh/kernel/
> 
> it looks like all of the existing early platform devices are serial
> ports, clocks, and clocksources. The switch to device tree should pick
> them all up from CLK_OF_DECLARE, TIMER_OF_DECLARE, and
> EARLYCON_DECLARE. Until that's complete, the existing code works
> as-is. I don't see what problem you're trying to solve.

The problem for us is that clk maintainers don't want new drivers to use
CLK_OF_DECLARE and instead use platform devices. I have just written such
a new driver that is shared by 6 different SoCs. For some combinations of
SoCs and clocks, using a platform device is fine but on others we need to
register early, so the drivers now have to handle both cases, which is
kind of messy and fragile. If there is a generic way to register platform
devices early, then the code is simplified because we only have to handle
one method of registering the clocks instead of two.

> 
> FYI I'm (sometimes-somewhat-absent) arch/sh co-maintainer.
> 
> Rich
> 
