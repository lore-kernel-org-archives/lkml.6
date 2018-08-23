Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B1FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286FB208FC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286FB208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeHWEtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 00:49:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbeHWEtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 00:49:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDCE0402171E;
        Thu, 23 Aug 2018 01:22:05 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-163.rdu2.redhat.com [10.10.124.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5F682026D74;
        Thu, 23 Aug 2018 01:22:02 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>
Subject: [PATCH 0/5] drm/nouveau: Backlight fixes and cleanup
Date:   Wed, 22 Aug 2018 21:21:45 -0400
Message-Id: <20180823012151.20099-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 23 Aug 2018 01:22:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 23 Aug 2018 01:22:05 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes some issues with nouveau's backlight support that were
causing kernel panics on module reloads, specifically on systems with
nouveau handling the backlight of one of the displays.

While we're at it, let's cleanup nouveau_backlight.c as well

Lyude Paul (5):
  drm/nouveau: Check backlight IDs are >= 0, not > 0
  drm/nouveau: Move backlight device into nouveau_connector
  drm/nouveau: s/nouveau_backlight_exit/nouveau_backlight_fini/
  drm/nouveau: Cleanup indenting in nouveau_backlight.c
  drm/nouveau: Refactor nvXX_backlight_init()

 drivers/gpu/drm/nouveau/nouveau_backlight.c | 193 ++++++++++----------
 drivers/gpu/drm/nouveau/nouveau_connector.c |  20 ++
 drivers/gpu/drm/nouveau/nouveau_connector.h |  33 ++++
 drivers/gpu/drm/nouveau/nouveau_display.c   |   2 -
 drivers/gpu/drm/nouveau/nouveau_display.h   |  25 ---
 drivers/gpu/drm/nouveau/nouveau_drv.h       |   2 -
 6 files changed, 146 insertions(+), 129 deletions(-)

-- 
2.17.1

