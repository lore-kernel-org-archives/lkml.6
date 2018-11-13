Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62E2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B927F22360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B927F22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbeKNCy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:54:57 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34201 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbeKNCy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:54:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6AEAA20746; Tue, 13 Nov 2018 17:55:59 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 084B420743;
        Tue, 13 Nov 2018 17:55:59 +0100 (CET)
Date:   Tue, 13 Nov 2018 17:55:58 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Hans Verkuil <hansverk@cisco.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 0/5] media: Allwinner A10 CSI support
Message-ID: <20181113175558.3bfa3e8d@windsurf>
In-Reply-To: <cb504ffc-b74c-d6e3-7bde-6c5840c87997@cisco.com>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
        <df54f2e6-e207-92de-767a-e356345a1a56@xs4all.nl>
        <20181113135259.onutfjtoi25afnfe@flea>
        <f07a0460-cdba-c1a5-acfd-66a39f447a5a@cisco.com>
        <20181113155227.62jjs3mpomwgr7xd@flea>
        <cb504ffc-b74c-d6e3-7bde-6c5840c87997@cisco.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 13 Nov 2018 17:00:25 +0100, Hans Verkuil wrote:

> Weird, if I build directly from that tarball, then v4l2-compliance should say:
> 
> v4l2-compliance SHA: not available, 64 bits
> 
> So that's what I expect to see from buildroot as well.

Indeed, that's strange, I see that the v4l2-compliance Makefile does:

version.h:
        @if git -C $(srcdir) rev-parse HEAD >/dev/null 2>&1; then \
                echo -n "#define SHA " >$@ ; \
                git -C $(srcdir) rev-parse HEAD >>$@ ; \
        else \
                touch $@ ; \
        fi

which correctly uses $(srcdir), so it shouldn't go "up" the libv4l
build folder and pick up the latest Buildroot commit SHA1. I'll have a
quick look.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
