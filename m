Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519942118; cv=none;
        d=google.com; s=arc-20160816;
        b=Fx53mziDpteMbIqwoJYNaxi/dgCL2cc0CGipwvvihmGx5+OLJPBG1FHjdQLPe02vpI
         GLp00gg5PracBtz5V+iggAkYtQTtQOwlREMgL7bW/P1LJCAXymPMY0teSh+tpablYQSf
         CFictYLzk+ncmP+wuyo88K0M0oryDe67k3Vku/vTILXJTx85R3lnZCJwn//39dsZ7HBM
         RMSSqLAfd94K8Dugz1eS1QadTq28+kIZhYe/pMd+A9ZCHJyfl3pYYlJ/2p/nba3oCIFg
         FW1Jxe2NzkGtoFdWGwfgYUWDI9xFVRdbti3T6mtiM3JmtaCSxqWdwFNz3KI4GfL6RgVK
         +8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=rrE3V/1s6uhEJA+mAK0pTPRONQTA91dzkQfFPjvMj6c=;
        b=yC80rcaXGJdK6YBoYzkMqsvBTheaiwWfT0HYxY0aShyLDk6QuWp7ZC1jlOYQLgk43j
         iWL//zrliIeAQFCtSX+n+W4zXHwrQMVXVHwFHEgMnIX8wP0+odqMh2lt6GarByE0ZjmR
         UEyRglPR7foUduiJ/kfHSEN9c6SJoqEXiKYGmJeyNGk3LX5R7ETZbddstWXb3Db7Y+s/
         FlkYB8uM4TLzvc9wZNN+t/XcE+56qOLwXp5yYcahgVC9p3bYVQCIm3BsxJmwf2+VXnRT
         QEESYXxLU5V4q6PkNT8aOGi/dv2B3o4lvlxcukyCmc/3MGdGOWQp3i+UvngOkwE2+eZL
         V/yg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AG47ELsB4AzKRygEQ8hYsnqLs4aCfAYgJG7i9zeFS/kDtYvC7KSJiihmLo5PTNQnu7UbXQTvO/eZ+Q==
Date: Thu, 1 Mar 2018 16:08:36 -0600
From: Rob Herring <robh@kernel.org>
To: Mikko Perttunen <cyndis@kapsi.fi>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Rajkumar Rampelli <rrajk@nvidia.com>, mark.rutland@arm.com,
	thierry.reding@gmail.com, jonathanh@nvidia.com, jdelvare@suse.com,
	corbet@lwn.net, catalin.marinas@arm.com, will.deacon@arm.com,
	kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
	pombredanne@nexb.com, mmaddireddy@nvidia.com, mperttunen@nvidia.com,
	arnd@arndb.de, gregory.clement@free-electrons.com,
	timur@codeaurora.org, andy.gross@linaro.org, xuwei5@hisilicon.com,
	elder@linaro.org, heiko@sntech.de, krzk@kernel.org,
	ard.biesheuvel@linaro.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ldewangan@nvidia.com
Subject: Re: [PATCH 05/10] hwmon: generic-pwm-tachometer: Add generic PWM
 based tachometer
Message-ID: <20180301220836.a77o5i5g7g2k7lei@rob-hp-laptop>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
 <1519196339-9377-6-git-send-email-rrajk@nvidia.com>
 <ee03e1e5-bbeb-1238-04ed-b992fe3a3ce6@kapsi.fi>
 <c1192f75-0e6e-c735-67e1-2901624831ae@roeck-us.net>
 <a5db25f7-6999-ff3a-21c2-161cfcf4db35@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5db25f7-6999-ff3a-21c2-161cfcf4db35@kapsi.fi>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992898629636853?=
X-GMAIL-MSGID: =?utf-8?q?1593774827021842338?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 05:20:29PM +0200, Mikko Perttunen wrote:
> On 21.02.2018 16:46, Guenter Roeck wrote:
> > On 02/20/2018 11:15 PM, Mikko Perttunen wrote:
> > > AIUI, the PWM framework already exposes a sysfs node with period
> > > information. We should just use that instead of adding a new driver
> > > for this.
> > > 
> > 
> > I am kind of lost. Please explain.
> > 
> > Are you saying that we should drop the pwm-fan driver as well (which goes
> > the opposite way), as well as any other drivers doing anything with pwm
> > signals,
> > because after all those signals are already exposed to userspace a sysfs
> > attributes,
> > and a kernel driver to abstract those values is thus not needed ?
> 
> The only thing this driver does is do a constant division in kernelspace.
> I'm not really seeing why that couldn't be done in userspace. But if you
> think it's appropriate to do the RPM conversion in kernelspace then I'm not
> greatly opposed to that.
> 
> > 
> > > In any case, we cannot add something like this to device tree since
> > > it's not a hardware device.
> > > 
> > 
> > So you are saying there is no means to express in devicetree that
> > a pwm input is connected to a fan ? How is that not hardware ?
> > 
> > If so, how do you express in devicetree that a pwm signal is connected
> > to anything ?
> 
> If we want to describe that the tachometer is connected to a fan, then we
> should have a fan node in the board's device tree. We don't have a chip that
> has a thing called "generic-pwm-tachometer" attached to it. (We have chips
> that have a "nvidia,tegra186-tachometer", so it's proper to have that.)

We already have some fan control bindings in the tree. Follow those. 
There's only so many ways to control fans, so lets have some alignment. 
And yes, we should have a fan node. 

Rob
