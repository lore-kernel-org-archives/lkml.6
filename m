Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A939C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BB525C80
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BB525C80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030277AbeGBK1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:27:44 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36170 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965482AbeGBK1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:27:37 -0400
Received: from wd0142.dip.tu-dresden.de ([141.76.108.142] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fZw3P-0004Ek-7X; Mon, 02 Jul 2018 12:27:31 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     thierry.reding@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        briannorris@chromium.org, hl@rock-chips.com,
        emil.l.velikov@gmail.com, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 0/4] Innolux P097PFG panel
Date:   Mon,  2 Jul 2018 12:27:17 +0200
Message-Id: <20180702102721.3546-1-heiko@sntech.de>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Innolux p097pfg is one of two possible panels used in the
gru-scarlet ChromeOS devices.

This v5 mainly addresses the very valuable comments from Emil
regarding power-supply and delay handling as well as documenting
the (unsatisfying) source of the init commands.

Individual changelogs inside the specific patches.

Tested with the recently resurrected Rockchip dual-dsi patches
on a gru-scarlet.


Lin Huang (2):
  drm/panel: p079zca: add variable unprepare_delay properties
  drm/panel: p079zca: support Innolux P097PFG panel

huang lin (2):
  drm/panel: p079zca: refactor panel driver to support multiple panels
  dt-bindings: Add Innolux P097PFG panel bindings

 .../display/panel/innolux,p097pfg.txt         |  24 ++
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 353 +++++++++++++++---
 2 files changed, 328 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt

-- 
2.17.0

