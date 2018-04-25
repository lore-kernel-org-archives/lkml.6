Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754265AbeDYKz6 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:55:58 -0400
Received: from hermes.aosc.io ([199.195.250.187]:33621 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752520AbeDYKzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:55:54 -0400
Date: Wed, 25 Apr 2018 18:55:10 +0800
In-Reply-To: <20180425105309.GC24769@sirena.org.uk>
References: <20180423144657.63264-1-icenowy@aosc.io> <20180423144657.63264-3-icenowy@aosc.io> <20180424170733.GD22073@sirena.org.uk> <C0C1F042-221A-420F-A8C1-5FADCFC687F1@aosc.io> <20180425105309.GC24769@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 2/3] regulator: add support for SY8106A regulator
To: Mark Brown <broonie@kernel.org>
CC: linux-arm-kernel@lists.infradead.org,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi@googlegroups.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <15C93A9B-6EEB-49EB-A942-35F761E86569@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年4月25日 GMT+08:00 下午6:53:09, Mark Brown <broonie@kernel.org> 写到:
>On Wed, Apr 25, 2018 at 07:41:35AM +0800, Icenowy Zheng wrote:
>> 于 2018年4月25日 GMT+08:00 上午1:07:33, Mark Brown <broonie@kernel.org> 写到:
>> >On Mon, Apr 23, 2018 at 10:46:56PM +0800, Icenowy Zheng wrote:
>
>> >> --- /dev/null
>> >> +++ b/drivers/regulator/sy8106a-regulator.c
>> >> @@ -0,0 +1,176 @@
>> >> +// SPDX-License-Identifier: GPL-2.0+
>> >> +/*
>> >> + * sy8106a-regulator.c - Regulator device driver for SY8106A
>
>> >Just make the entire thing a C++ comment so it looks consistent and
>> >joined up.
>
>> SPDX identifier is special -- it should be in a seperated
>> comment block.
>
>No, it just needs to be a C++ comment on the first line to ease machine
>parsing.  The rest of the file doesn't matter for that.

Okay. Thus I will use a seperate /* */ block for it in the
next revision, to follow the rule.

>
>> >> +	if (reg & SY8106A_GO_BIT)
>> >> +		return reg & rdev->desc->vsel_mask;
>> >> +	else
>> >> +		return (chip->fixed_voltage - rdev->desc->min_uV) /
>> >> +		       rdev->desc->uV_step;
>
>> >You could use the standard get_voltage_sel() if you provide a
>mapping
>> >operation that set everything with _GO_BIT set to return the fixed
>> >voltage.  Though looking at this it seems that the fixed voltage
>will
>> >always be one that could be set via the register anyway so I'm
>> >wondering
>> >if the easiest thing here isn't to just have the driver turn off
>> >_GO_BIT
>
>> Do you mean "turn on" here?
>
>Yes.

Okay. I will do it in this way and drop custom get/set_voltage_sel.
