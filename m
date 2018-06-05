Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeFEEp6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 00:45:58 -0400
Received: from muru.com ([72.249.23.125]:46070 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751320AbeFEEp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 00:45:57 -0400
Date: Mon, 4 Jun 2018 21:45:54 -0700
From: Tony Lindgren <tony@atomide.com>
To: Maciej Purski <m.purski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: Regression in Linux next again
Message-ID: <20180605044554.GC5738@atomide.com>
References: <20180530144505.GB5705@atomide.com>
 <CGME20180604135952eucas1p292f7bcec405e6a1a6261031df36cad32@eucas1p2.samsung.com>
 <1528120764-14316-1-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Maciej Purski <m.purski@samsung.com> [180604 14:02]:
> Tony, please apply this patchset and test it on your Beaglebone. It'd be
> great if you could try to find out, which patch causes failure. They should
> be appliable on the current next.

It seems beagle-x15 boots for me except with the last patch in the
series with compile issue fixed. With that applied after modules
get loaded it just hangs with:

[   25.925607] regulator_resolve_supply: 1608
[   25.930620] regulator_resolve_supply: 1608
[   26.098449] lib80211: common routines for IEEE802.11 drivers
[   26.446713] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   26.514834] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   26.525311] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   26.534250] cfg80211: failed to load regulatory.db
[   26.998736] regulator_set_voltage: 3381
[   27.007662] _regulator_do_set_voltage: 2913
[   27.012593] regulator_set_voltage: 3381
[   27.016969] _regulator_do_set_voltage: 2913
[   27.022847] regulator_set_voltage: 3381

Not sure what module gets loaded at that point, I'll test again
with initcall_debug once you post a compiling version of your last
patch.

Regards,

Tony
