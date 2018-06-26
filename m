Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A078BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C9C258C5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C9C258C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965543AbeFZN2q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:28:46 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:35398 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965374AbeFZN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:28:44 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0JfyqA2nA=="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id L06bd3u5QDSVNPu
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 26 Jun 2018 15:28:31 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Sebastian Reichel <sre@kernel.org>,
        anish kumar <anish198519851985@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Anton Vorontsov <cbouatmailru@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 0/2] power: generic-adc-battery: fix out of bounds write
Date:   Tue, 26 Jun 2018 15:28:28 +0200
Message-Id: <cover.1530019688.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set addresses two bugs in the gab_probe() function which are
there since the first commit in 3.7-rc1:

1. there is an out of bounds write access by a miscalculated destination
   address for the memcpy()
2. if iio channels are already represented by default properties, they
   appear as duplicates in uevent


H. Nikolaus Schaller (2):
  power: generic-adc-battery: fix out-of-bounds write when copying
    channel properties
  power: generic-adc-battery: check for duplicate properties copied from
    iio channels

 drivers/power/supply/generic-adc-battery.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.12.2

