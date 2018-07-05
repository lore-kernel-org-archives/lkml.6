Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFEBC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171B72417D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171B72417D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbeGEFzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:55:11 -0400
Received: from muru.com ([72.249.23.125]:50176 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbeGEFzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:55:09 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F0DDC80BD;
        Thu,  5 Jul 2018 05:58:06 +0000 (UTC)
Date:   Wed, 4 Jul 2018 22:55:06 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, mark.rutland@arm.com, paul@pwsan.com,
        t-kristo@ti.com, robh+dt@kernel.org, bcousson@baylibre.com
Subject: Re: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
Message-ID: <20180705055506.GI26255@atomide.com>
References: <acdfef83-8778-e8f4-e423-ed04a9a8a649@ti.com>
 <20180611060957.GN5738@atomide.com>
 <f460481f-85a9-2a41-a894-6f25122dee8a@ti.com>
 <20180611062904.GO5738@atomide.com>
 <89d55b0b-fe9e-793b-2694-25755ac2bc15@ti.com>
 <20180611070332.GP5738@atomide.com>
 <20180703070743.GG112168@atomide.com>
 <ee54c3ea-6200-33dd-83da-491f5fdd9f5c@ti.com>
 <20180703073139.GN112168@atomide.com>
 <1138704c-b7a4-391f-3404-e1bd25a4a0ff@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138704c-b7a4-391f-3404-e1bd25a4a0ff@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180704 13:37]:
> After taking a second look at this thread, I don't see anything big to
> be modified.
> 
> We both agree that "reset status bit in sysconfig register" is the quirk
> case which can be added once such an IP is discovered in ti-sysc.

Yes agreed.

> All I need to change is SYSC_OMAP4_SOFTRESET to SYSC_SOFT_RESET_SHIFT_0
> for better readability and rebase it to the latest mainline.

Let's not change SYSC_OMAP4_SOFTRESET as only the ti-sysc
driver needs to know that and it can be set based on the
compatible.

How about replace ddata->cfg.quirks & SYSC_QUIRK_RESET_STATUS
test with just ddata->cfg.syss_mask test in your sysc_reset()?

We still need to set SYSC_QUIRK_RESET_STATUS too for pdata
callbacks.

Regards,

Tony
