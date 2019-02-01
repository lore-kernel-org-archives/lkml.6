Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6372C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8134020B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="hHCXXace"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfBAGWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 01:22:55 -0500
Received: from forward105o.mail.yandex.net ([37.140.190.183]:55851 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbfBAGWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 01:22:55 -0500
Received: from mxback6o.mail.yandex.net (mxback6o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::20])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 743484200D8B;
        Fri,  1 Feb 2019 09:22:51 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback6o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id QgR4u7u38R-MjnO37YZ;
        Fri, 01 Feb 2019 09:22:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1549002165;
        bh=D3iEDfFMckEvkSivAykL2jvpWAc2SmvIlIddrMtOBw0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=hHCXXaceq+L2b1/JbE/Ol21P2WxPj6j5Cu7d9u0lZ0adAo0dNqdSpPYOw0hf7W0P/
         emwpAr1XS9KV9Svm/oMdbiw8A/orKUzWh1Scuo/XjOlK3gHO85EwzE1zuP9RbSlTSw
         xGuJtfdweftIZWBzOzoZ8udV9kIp1iThiV+x0EHU=
Authentication-Results: mxback6o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 0W2FVbEhhw-Md1ekNh8;
        Fri, 01 Feb 2019 09:22:43 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: irqchip: Add driver for Loongson-1 intc v6
Date:   Fri,  1 Feb 2019 14:22:34 +0800
Message-Id: <20190201062236.17903-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122154557.22689-1-jiaxun.yang@flygoat.com>
References: <20190122154557.22689-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2: Fix SPDX-License-Identifier
v2->v3: Rework according suggestions from Marc Zyngier, Thanks.
v3->v4: Rework the driver into a single chip driver.
v4->v5: Fix minor issues.
v5->v6: Fix doc and collect Rob's review tag.


