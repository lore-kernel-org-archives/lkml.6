Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6223AECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2842B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2842B20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeGRHIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:08:39 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:43941 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeGRHIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:08:39 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.32.110]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0MD8M0-1fpa1f1Yui-00GaWz; Wed, 18 Jul 2018 08:32:19 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 0/3] net: qca_spi: Minor bugfixes
Date:   Wed, 18 Jul 2018 08:31:42 +0200
Message-Id: <1531895505-26971-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:wuCRho5iAZbiW7wDQDdbPFMsqQVaXhBjS4pEh/n6tMFkP/o2NhR
 MJLcG1T//cRz+wRSWvqNLTFeV2craaRslz2XPOLUdYfCaIakQprnW2IRN3v/5+tVVMIje7j
 1hEpqhLGusJn5sCQVywitno4AChtXes8bE5yVrgxeYoYQiU9Ejb8BhO7G7BkRh0nwsAHCPH
 dW/FtTAN/Ud3F8RjkRM6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BekwiSbPdn0=:/W/Tn4axyVRml29b3q+zza
 o2+qMBRbbs0zxExZjGGM3UUPcau6XROJb5l1oYl+RNyEDQguxctegvg2suFD4222ouiEM2tzn
 tq4cJqUiPzgILJ+SuW0Cw1k1xmalGZsFpkN304kftZf02oJmah4i9r8rv3tee2nr2rkWUNrKS
 UG15qEEC5Gw8dO4KMrPw6yIsIkBnCQAExCPj8xo0VWvCafSH9hShaczIsmNKuMccfUnTmX3uh
 trHXDM6PcSmf/CNYjAa+M6vCMsX35l3Axm9b9Pt8cnYrxzW7/ZwwDr5eZ5MKYhnMQyHB6448N
 mbijiQEADr4FIGmvtXzh1vBKT5g0+rvxZ3kIWaPbe4Qfkbot/u4j1ejrxZraIJykkcs0BWYnn
 Cn3Z6T7+O2/FkCtK+1m7cW4qYyZVE6ONw7FlXgT9ZLURtU+o25jx/P1pRNs2G8gCIiW+haddm
 JymUdmkd7J7afdjSQMcxZCa7ABGwg6H00w/fZFNfpjhncq3eRyf3Edc1pj6x4Ck0mA+aFQTtf
 QmmOTMtcjXv+UlErXgj//KeYSh+rK5385RZOe8BiaHtvigr4+s4a4mdiUN+GLvjUkUYSprnef
 ySh7T3ZoU3Z/I9UhXn0oTVZivDENbZ0ZFAhVB8XcKN+XGuu355EFi8kt1wbuSNF0YM1f8s5Mj
 YeWoT+0h5g4fCRU6zQz8gpm4Vgsk67AYLwbTYgPV1oF7pnyf04C7TfRQvGaSRiZ+KRSg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains some minor bugfixes for
the qca_spi driver.

Stefan Wahren (3):
  net: qca_spi: Avoid packet drop during initial sync
  net: qca_spi: Make sure the QCA7000 reset is triggered
  net: qca_spi: Fix log level if probe fails

 drivers/net/ethernet/qualcomm/qca_spi.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

-- 
2.7.4

