Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BD2C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B542082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B542082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeIDVzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:55:51 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:49657 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeIDVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:55:50 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0MGRCi-1gAUhW1uxE-00DCWl; Tue, 04 Sep 2018 19:29:38 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Woojung Huh <woojung.huh@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 0/4 next] net: lan78xx: Minor improvements
Date:   Tue,  4 Sep 2018 19:29:08 +0200
Message-Id: <1536082152-3669-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:neeKdDj8bFNFdaNEaqwkC8QNWr9r2mdhKW3gFLKNEQa01xvMxPR
 Vp+Zde8DygSU28bWeH2eWHoEUt/6YJrQjkgFRppHZT+cixRIbBSaYMq1lLDxezIcFmHj7hb
 JdBsQRA+ecwWvaA3Cc3ugCBxekIXpjdP2Utq0Qihf2ZDYEPXdFMVDXKYl5LbFgnXIr0uSqg
 7Nb09eathVDi6J1x4+60g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8bH49XuG3EY=:FaxRyIyB1RKRmBcwkLd1Qr
 ApCkdOdnvoJXQ4RD8TZaU2U3d7QzFl9BlzJYxTXmIk9a4eAdgS5nSCTKm3gzL3UsjDt1i/6gH
 rIlSSXx9xYyHXrW90zeuNOASlBU6xoMFGR0DW5TEZRicEarCq7VO2HoIdhPHpWe6Bnwzvi/s2
 smeBifMjD2K3gXHWDh7h5F2f4olXEUBlAH2esjFz7pGNpUcwOh1Kuj8Bn+NPJA+M/afuIwpjx
 yYLKOiYEXDLJ+vZ7LQoC6+Spy5Rkm91RYhSgAiQaVVgTOTyRSY6iSb+wjLAsg4jd/XHj8kCcF
 FLxW21rn7MuHMcKIcITpGPKdpjIghfLdjw6uzHvDtpc7QS4kdAb+D8p2CEPs4Kn0LP4bLMhr6
 AmUvNXxY8xBjCbR04oDS9uQTRPuFFEXRqNDE7FpKA78G+PcpAJ8x2TLY8sJAvKTnhgkx4AKXO
 st6sXbzhsA90864Uei39MlkFY3J+0C+7VqgKWhPWEOQg5iLOUVvJLeIUZEjDWmYtWlw2NgSJ0
 QSJZWw2vywT87Xbx/TAM6cCN69YsUblcTlo0Ul0+mRYpE6/6NqDq/bbI+AT7Yzm8Qq34GivnB
 qpTs4ihlSQEnl8EK4SlUbSFyMmAvtZschS9EIOg3Qxlb76JygKwmDwaUMJu7hs0/JLFi0aSEo
 A5J0MtDqJHFXR6508ngY6vSUwp7QFlLyMeLbyi6PMD+hG7DCgTBvtEgjXpiK0qMuh1Y4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains some minor improvements for the lan78xx
driver.

Changes in V2:
- Keep Copyright comment as multi-line
- Add Raghuram's Reviewed-by

Stefan Wahren (4):
  net: lan78xx: Bail out if lan78xx_get_endpoints fails
  net: lan78xx: Drop unnecessary strcpy in lan78xx_probe
  net: lan78xx: Switch to SPDX identifier
  net: lan78xx: Make declaration style consistent

 drivers/net/usb/lan78xx.c | 34 +++++++++++++---------------------
 drivers/net/usb/lan78xx.h | 14 +-------------
 2 files changed, 14 insertions(+), 34 deletions(-)

-- 
2.7.4

