Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C41AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2871820644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2871820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeH3CZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:25:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727187AbeH3CZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:25:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8C8140241CB;
        Wed, 29 Aug 2018 22:26:31 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-121-246.rdu2.redhat.com [10.10.121.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66BE1202704E;
        Wed, 29 Aug 2018 22:26:29 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>
Subject: [PATCH v3 0/5] drm/nouveau: Backlight fixes and cleanup
Date:   Wed, 29 Aug 2018 18:26:20 -0400
Message-Id: <20180829222626.15074-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 29 Aug 2018 22:26:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 29 Aug 2018 22:26:31 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next version of https://patchwork.freedesktop.org/series/48596/ . Added
NV_INFO_ONCE and made "Move backlight device into nouveau_connector" use
that instead so we don't print the GMUX warning more then once.

Lyude Paul (5):
  drm/nouveau: Add NV_PRINTK_ONCE and variants
  drm/nouveau: Move backlight device into nouveau_connector
  drm/nouveau: s/nouveau_backlight_exit/nouveau_backlight_fini/
  drm/nouveau: Cleanup indenting in nouveau_backlight.c
  drm/nouveau: Refactor nvXX_backlight_init()

 drivers/gpu/drm/nouveau/nouveau_backlight.c | 220 ++++++++++----------
 drivers/gpu/drm/nouveau/nouveau_connector.c |  20 ++
 drivers/gpu/drm/nouveau/nouveau_connector.h |  33 +++
 drivers/gpu/drm/nouveau/nouveau_display.c   |   2 -
 drivers/gpu/drm/nouveau/nouveau_display.h   |  25 ---
 drivers/gpu/drm/nouveau/nouveau_drv.h       |  10 +-
 6 files changed, 168 insertions(+), 142 deletions(-)

-- 
2.17.1

