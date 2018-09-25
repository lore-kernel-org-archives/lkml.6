Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77BBC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4C82087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4C82087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeIYR0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:26:09 -0400
Received: from gloria.sntech.de ([185.11.138.130]:59248 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbeIYR0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:26:09 -0400
Received: from wd0156.dip.tu-dresden.de ([141.76.108.156] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1g4lMa-0006Bb-9U; Tue, 25 Sep 2018 13:18:44 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Damian Kos <dkos@cadence.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, pgaj@cadence.com,
        ltyrala@cadence.com, rafalc@cadence.com, jartur@cadence.com,
        piotrs@cadence.com, quentin.schulz@bootlin.com, jbergsagel@ti.com
Subject: Re: [PATCH v5 2/5] drm/dp: fix link probing for devices supporting DP 1.4+
Date:   Tue, 25 Sep 2018 13:18:42 +0200
Message-ID: <18095829.BFmvNaydv0@phil>
In-Reply-To: <1537866837-4408-3-git-send-email-dkos@cadence.com>
References: <1537866837-4408-1-git-send-email-dkos@cadence.com> <1537866837-4408-3-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damian,

Am Dienstag, 25. September 2018, 11:13:32 CEST schrieb Damian Kos:
> From: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
> DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
> DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
> DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
> DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
> "true capabilities" of DPRX device.
> 
> Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
> might falsely return lower capabilities to "avoid interoperability
> issues with some of the existing DP Source devices that malfunction
> when they discover the higher capabilities within those three
> registers.".
> 
> Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
> and read 0 so it's safe to check against it even if DP revision is
> <1.4
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Signed-off-by: Damian Kos <dkos@cadence.com>

in v4 you received a
	Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>
for this patch. If a patch is largely unchanged from one version to another
please add these previously received tags to the commit message.
This prevents people from reviewing needlessly stuff twice ;-) .

So the above should read

----- 8< -----
Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>
----- 8< -----


Heiko


