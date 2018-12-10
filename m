Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EB7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BB92086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544434210;
	bh=EbA3f2T8b0tvME/Coe/Z2QAl4c63NipcaMym3iYiLtM=;
	h=From:To:Subject:Date:List-ID:From;
	b=DIiOKtiUFUitXfmNZh6zLV0+I0w93Ca6AD4lXs0MfTtAh+bPwthuuU726HiIODTNd
	 xpCBGl3zU6kthyXC/BgwoltXXq1cSOBVX4e2QS9Eq//NEW3AYhnorCjZ07K5SNKuWY
	 qS6A04hnJ6ZU3dxKFjLnXG1NxEXNFyfsIq58ic34=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BB92086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeLJJaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbeLJJaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:30:08 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34A7920821;
        Mon, 10 Dec 2018 09:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544434207;
        bh=EbA3f2T8b0tvME/Coe/Z2QAl4c63NipcaMym3iYiLtM=;
        h=From:To:Subject:Date:From;
        b=glkcF2CW64Q/16eXyMVSwNbbDOH8bqYmeUfbqhRTJdxld9z9w63x3poh6aAo6Ay+y
         oMePSonFiDKStPtblempc0L4XtskJnYvrq428sKuIIUFnM7FyK+PDXlm9deERWZYvC
         SYwvTCco8EuANB2rz+2k3/okwkq6yxFNMvLWR8Gw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] leds: trigger: Add pattern initialization from Device Tree
Date:   Mon, 10 Dec 2018 10:29:56 +0100
Message-Id: <1544434201-14190-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I rebased on top of Jacek's patches and, as I could not find them on git kernel
tree, I included them here. Also with small fixup.

Changes since v1:
1. Rebase on Jacek's patches.
2. Add patch 3/5 for fixup of Jacek's solution.
3. Drop first two patches from the series (applied).
4. Patch 5/5: Use LED_INIT_DEFAULT_TRIGGER (suggested by Jacek Anaszewski).
5. Patch 5/5: Return-on-error and log warning (suggested by Pavel Machek).


Best regards,
Krzysztof


Jacek Anaszewski (2):
  led: triggers: Break the for loop after default trigger is found
  led: triggers: Add LED_INIT_DEFAULT_TRIGGER flag

Krzysztof Kozlowski (3):
  led: triggers: Initialize LED_INIT_DEFAULT_TRIGGER if trigger is
    brought after class
  dt-bindings: leds: Add pattern initialization from Device Tree
  leds: trigger: Add pattern initialization from Device Tree

 Documentation/devicetree/bindings/leds/common.txt |  7 +++++
 drivers/leds/led-triggers.c                       | 10 +++++--
 drivers/leds/trigger/ledtrig-pattern.c            | 32 +++++++++++++++++++++++
 include/linux/leds.h                              |  1 +
 4 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.7.4

