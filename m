Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B7EBAC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774FD208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774FD208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964821AbeFNMzn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:55:43 -0400
Received: from gloria.sntech.de ([95.129.55.99]:54796 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755120AbeFNMzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:55:41 -0400
Received: from wd0940.dip.tu-dresden.de ([141.76.111.172] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fTRmn-0004fj-Go; Thu, 14 Jun 2018 14:55:33 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Vagrant Cascadian <vagrant@debian.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: correct voltage selector Firefly-RK3399
Date:   Thu, 14 Jun 2018 14:55:27 +0200
Message-ID: <19360053.2ABrQ075F2@phil>
In-Reply-To: <20180604171523.28454-1-xypron.glpk@gmx.de>
References: <20180604171523.28454-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 4. Juni 2018, 19:15:23 CEST schrieb Heinrich Schuchardt:
> Without this patch the Firefly-RK3399 board boot process hangs after these
> lines:
> 
>    fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
>    fan53555-reg: supplied by vcc_sys
>    vcc1v8_s3: supplied by vcc_1v8
> 
> Blacklisting driver fan53555 allows booting.
> 
> The device tree uses a value of fcs,suspend-voltage-selector different to
> any other board.
> 
> Changing this setting to the usual value is sufficient to enable booting.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

applied for 4.19.

I've amended your commit message with the info from your reply about
the vendor kernel using the same value and added an appropriate Fixes
tag to possibly get it merged into stable.


Thanks
Heiko


