Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03BCC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9D320863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9D320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeLAAIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:08:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45395 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLAAIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:08:24 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so4013126lfa.12;
        Fri, 30 Nov 2018 04:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3PBES0o25j0R3KuNWiCqbV0Pcf3QS+yZgteXEsuSXZ8=;
        b=mpcOqmBeVdN2sQoSuf/8w69Y/WxUsj3gBa/dVdvs2cOBAzzMYd3w8vKYWZ27WnVCMp
         +dwoy0UJvK9wTD7r+8rrTT5lRTejk5GC7vQPfIBpEfWqhqMYoG5AnIoIYL0aePN/biXY
         pQp6FtNkeCPlcRDkFJB5+7sgWcHU96oarfJdS1D12Nxcl9fFBgwATB06RNcL/8ahC9kY
         riLpTiINvlp5e8y0DaMsym4ODgrXifjzi0UZXYHDTI0eE5P3PbRGxDPV1mwIN0B3TERP
         Ce/fxGkNEs77p0dXq50zFLSgSXWc3ZZFOOvGrO6qX4thq54wS/zeoX/7aGvmpoXvkiQN
         EtRw==
X-Gm-Message-State: AA+aEWbC96qcxigmXjp4IyKg5o+ieHqLHtJ2mWwXnmkUL/SevQahqv2k
        MQYx/vZZplFNRdYhrBuTRSw=
X-Google-Smtp-Source: AFSGD/XUiaAMpzZfguwDPiwPS9jtMBxEXbXIneh2pJooWUG0IcYe98IX/NgzNHlX+gA7em5dYlAcRA==
X-Received: by 2002:a19:518d:: with SMTP id g13mr3492997lfl.143.1543582748224;
        Fri, 30 Nov 2018 04:59:08 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi. [84.253.205.125])
        by smtp.gmail.com with ESMTPSA id m77sm805038lfg.3.2018.11.30.04.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 04:59:07 -0800 (PST)
Date:   Fri, 30 Nov 2018 14:59:04 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Stephen Boyd <sboyd@kernel.org>, mazziesaccount@gmail.com,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Message-ID: <20181130125904.GB15388@localhost.localdomain>
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
 <20181130105022.GA15388@localhost.localdomain>
 <20181130110653.GF30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130110653.GF30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:06:53AM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 30, 2018 at 12:50:22PM +0200, Matti Vaittinen wrote:
> > Hello Stephen,
> > 
> > Thanks a bunch for taking the time and reviewing this!
> > 
> > On Fri, Nov 30, 2018 at 12:54:10AM -0800, Stephen Boyd wrote:
> > > Quoting Matti Vaittinen (2018-11-13 03:55:58)
> > > > With MFD devices the clk properties may be contained in MFD (parent) DT
> > > > node. Current devm_of_clk_add_hw_provider assumes the clk is bound to MFD
> > > > subdevice not to MFD device (parent). Add
> > > > devm_of_clk_add_hw_provider_parent to tackle this issue.
> > > > 
> > > > Also clkdev registration lacks of managed registration functions and it
> > > > seems few drivers do not drop clkdev lookups at exit. Add
> > > > devm_clk_hw_register_clkdev and devm_clk_release_clkdev to ease lookup
> > > > releasing at exit.
> > > 
> > > Please split this into clkdev and non-clkdev devm functionality.
> > Allright. I'll split this to two patches.
> 
> Definitely, please note that clkdev is separate from the common
> clk stuff, and is actually maintained by a different person (me)
> although I currently defer much of the review to the common clk
> guys.

Right. This clarifies how clkdev is maintained. Thanks for letting me
know. Is it still Ok to do these changes through linux-clk tree or is
there some other tree where the devm portion should be submitted? If so,
how should the dependencies be handled?

Br,
	Matti Vaittinen

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
