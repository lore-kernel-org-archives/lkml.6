Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9904CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0A02077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0A02077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeICVev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:34:51 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:34563 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbeICVeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:34:06 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue105 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0LrsY2-1flM4k0ikQ-013hKG; Mon, 03 Sep 2018 19:12:56 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Woojung Huh <woojung.huh@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 0/4 next] net: lan78xx: Minor improvements
Date:   Mon,  3 Sep 2018 19:12:35 +0200
Message-Id: <1535994759-8938-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:iaYb6Yl5Rgd7rOQdd66bapyvGaqEm1+C4/O9ka3x+1jdvgT8vmJ
 uKhr46AEASqGkKm4AKB5wm0cI7guOMSKc7n5j3Ay9ydZr45+RClmSCstlrI+EyG2hsIUV23
 ZYBgwIRnxfGbcHU7+nUUb4ICy6Iq1Rdi7cJZyaxvkktCDMadYDIWdK6Z60B7ArGiMib3HjR
 I1vLWuvC8+ttS4ST1/W8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/tZ2/1CVmsk=:nYlLXOqEOjFxcWQ0vvNIqY
 luAXElPltNZmxUVEhJprfwnVEtceVJPLaKmdnAQU9V/8S35xF20NsxTP3wkd3ZE4STw1Fro5h
 HVPRtLjP4kBs7K+x/fx3VqkNas/0DSVbrrgjtrm+04dDs03wr9am9Q0TyCeRc80pHXeGH8DFa
 oePSYsOE7ry1gQiJq8OpyekhFtJUq7MN9MzXBWIHuw5hK/LRjfg4PmRrlWOrM22tZceNUmkKq
 2XnRDJxrEssizFjILKxzSIG7qHpPvnJBaep9yyBUUf5M7lB7TSubzqgb0QuU+6CnjLcmqk2/b
 DQfz87oFHHIBODuEXshO8Zb4latXwFeP5CslCgm4PwoYKudTkjF1dhkFuBVz5tY/M20AG7Rh6
 OKIv/CH2qPGtVs5+s0D8U67H6N4t4GKq3MVMI0A4DUw4r/9Fm+dJdQPh4R+Zrol/TbjnS/fRu
 qDhSDWu49DkcL6C9Tb3yULulfmsMKyvPoh2dFN3f1m5uqaNiE4nRfw9cadWW1byc56ANH/piP
 dHA7wrQR1LWnXKoMr9+rkjoITy5BCGhe7w0elTxlkgrNlid5T8tZOTqXtMpbwv0EgCWWp/RWe
 VYEb2NpkAY+JJMiwhTMy31DIbCZiSsrPym85Dkl7b8oeXqkrcWqTG1cpuXXiYLWCUp+3v0Idc
 RfnJQZV0WQcnFbobw0/hi3+qiFwWvIDSVNVzFrIhHTY8vgSoQmI3coc6Qtx9M6FjqGts=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains some minor improvements for the lan78xx
driver.

Stefan Wahren (4):
  net: lan78xx: Bail out if lan78xx_get_endpoints fails
  net: lan78xx: Drop unnecessary strcpy in lan78xx_probe
  net: lan78xx: Switch to SPDX identifier
  net: lan78xx: Make declaration style consistent

 drivers/net/usb/lan78xx.c | 38 ++++++++++++++------------------------
 drivers/net/usb/lan78xx.h | 18 ++----------------
 2 files changed, 16 insertions(+), 40 deletions(-)

-- 
2.7.4

