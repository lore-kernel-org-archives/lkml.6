Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2CAC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589F9214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfA1XOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:14:17 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46521 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfA1XOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:14:06 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 207a204f2f892271; Tue, 29 Jan 2019 00:14:03 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 0/4] driver core: Managed device links rework and "consumer autoprobe" flag
Date:   Tue, 29 Jan 2019 00:03:59 +0100
Message-ID: <2405639.4es7pRLqn0@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg at al,

This is on top of the series I posted on Thursday last week:

https://lore.kernel.org/lkml/2493187.oiOpCWJBV7@aspire.rjw.lan/

and the purpose here is to (1) clean up the remaining device link management
issues mentioned in the cover letter above and (2) make device links support
the "composite device" use case mentioned during the recent discussion on
possibly using device links in the DRM subsystem (see for example
https://marc.info/?l=linux-pm&m=154832771905309&w=2).

Patch [1/4] simply makes two IOMMU drivers pass DL_FLAG_STATELESS to
device_link_add(), because the cleanup part of their device links
handling will not work any more after patch [2/4] and there is no
reason why those links cannot be stateless AFAICS.

Patch [2/4] can be regarded as a fix as it cleans up some link management
issues related to device links reference counting and stateful (managed)
device links.

Patch [3/4] add a "consumer autoprobe" flag causing the driver core to
probe consumer drivers automatically after binding the supplier driver
for persistent managed device links.

Patch [4/4] is just another fix on top of the previous series of device
links patches and it doesn't depend on patches [1-3/4].

For easier testing I have created a git branch containing these patches
along with the previous series (including the v2 of the 5th patch) which
can be pulled from:

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 device-links

(not that this branch may be rebased in the future).

Cheers,
Rafael


