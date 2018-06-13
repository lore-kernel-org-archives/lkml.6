Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 05A98C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3F5208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3F5208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934667AbeFMQIC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:08:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51769 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934250AbeFMQIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:08:01 -0400
Received: from weser.hi.pengutronix.de ([2001:67c:670:100:fa0f:41ff:fe58:4010])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fT8JP-00053o-V8; Wed, 13 Jun 2018 18:07:55 +0200
Message-ID: <1528906072.21021.22.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/6] add virt-dma support for imx-sdma
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Date:   Wed, 13 Jun 2018 18:07:52 +0200
In-Reply-To: <1528822708.13468.9.camel@nxp.com>
References: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
         <1528714877.2842.3.camel@pengutronix.de> <1528822708.13468.9.camel@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Am Dienstag, den 12.06.2018, 08:58 +0000 schrieb Robin Gong:
> Hi Lucas,
> 	Is the below DEAD LOCK issue same as your side? If yes, then
> I'm afraid that we have to make another patch for uart to split dma
> functions in uart driver out of the code area which protected by
> port.lock. The warning make sense since allocate sdma bd memory
> dynamically in virt-dma instead of static allocated as before. I'll
> make another uart patch into my next version patchset.

Yes, I see the same lockdep splat on my system. Though I'm not sure if
this is really the root cause of the issue I see.

I'm getting timeouts for a serdev attached device and I don't think
this system ever enters memory reclaim, so the issue reported by
lockdep seems to be a mostly theoretical on this system. But lets see
how far I get when you fixed this issue, maybe the real bug is hiding
behind this one.

Regards,
Lucas
