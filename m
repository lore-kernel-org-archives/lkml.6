Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC54C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467EA20811
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfAXLZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:25:14 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53188 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfAXLZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:25:12 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 392be53e9a0646d5; Thu, 24 Jan 2019 12:25:10 +0100
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 0/6] driver core: Fix some issues related to device links
Date:   Thu, 24 Jan 2019 12:13:06 +0100
Message-ID: <2493187.oiOpCWJBV7@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg at al,

Recently I have been looking at the device links code because of the
recent discussion on possibly using them in the DRM subsystem (see for
example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
found a few issues in that code which should be addressed by this patch
series.  Please refer to the patch changelogs for details.

None of the problems addressed here should be manifesting themselves in
mainline kernel today, but if there are more device links users in the
future, they most likely will be encountered sooner or later.  Also they
need to be fixed for the DRM use case to be supported IMO.

This series does not fix all issues in device links that have become
apparent (generally speaking, the idea of returning an existing link
in case there is one already for the given consumer-supplier pair
doesn't play well with stateful links and their flags), so there will
be a follow-up series of patches to clean that up.  Still, I don't see
a reason to sit on these fixes while working on the other patches, so
here they go.

Cheers,
Rafael

