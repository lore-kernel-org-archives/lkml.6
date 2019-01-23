Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91FEC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9451B217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="tfje6CW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfAWGYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:24:08 -0500
Received: from forward105p.mail.yandex.net ([77.88.28.108]:36969 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbfAWGYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:24:07 -0500
Received: from mxback14o.mail.yandex.net (mxback14o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::65])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 474D34D40DEB;
        Wed, 23 Jan 2019 09:24:04 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [2a02:6b8:0:1a2d::25])
        by mxback14o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ejVuwAVKAT-O3TGUFH8;
        Wed, 23 Jan 2019 09:24:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548224644;
        bh=nELIQddOTU1mL7/HQVlFwp31JaaZNYkqR4A5A3+/+Vo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=tfje6CW86j3N3IhO1AO5HxyIJto1kbdmj85gRR/Ed+Bgt/mR3Of7DAssEQsptIhcj
         tqykebyaJ1BLSF2gMDLb7+EdX/LH47E5sk2dZu4Cvb98eb4FJL1Rgp2gH7D7oCCeeG
         ILDONCPM+Cy0IVDmnHSzAuWa4R1XAQAo0sZIIrTs=
Authentication-Results: mxback14o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id uW0qtCYwDN-NsPi3rdG;
        Wed, 23 Jan 2019 09:24:00 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org
Subject: irqchip: Add driver for Loongson-1 intc v2
Date:   Wed, 23 Jan 2019 14:23:34 +0800
Message-Id: <20190123062341.8957-1-jiaxun.yang@flygoat.com>
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


