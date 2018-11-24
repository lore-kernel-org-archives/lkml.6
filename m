Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B489C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3428C20881
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3428C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeKYJGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 04:06:42 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:43942 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeKYJGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 04:06:42 -0500
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 7E8B1200CB;
        Sun, 25 Nov 2018 00:17:13 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 0/5] omap_udc bug fixes
Date:   Sun, 25 Nov 2018 00:17:03 +0200
Message-Id: <20181124221708.31003-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Some fixes for omap_udc making the driver usable again on Palm TE & 770.

	v2: Patch #2 rewritten, now usb_add_gadget_udc_release() should be
	    properly used.
	    Patch #5 added.

	v1: https://marc.info/?l=linux-usb&m=154258778216930&w=2
	    https://marc.info/?l=linux-usb&m=154258778316932&w=2
	    https://marc.info/?l=linux-usb&m=154258778316931&w=2
	    https://marc.info/?l=linux-usb&m=154258778216929&w=2

Aaro Koskinen (5):
  USB: omap_udc: use devm_request_irq()
  USB: omap_udc: fix crashes on probe error and module removal
  USB: omap_udc: fix omap_udc_start() on 15xx machines
  USB: omap_udc: fix USB gadget functionality on Palm Tungsten E
  USB: omap_udc: fix rejection of out transfers when DMA is used

 drivers/usb/gadget/udc/omap_udc.c | 88 +++++++++++--------------------
 1 file changed, 31 insertions(+), 57 deletions(-)

-- 
2.17.0

