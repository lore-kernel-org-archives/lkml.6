Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68748C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F542175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="wf7COqBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfA2DFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:05:14 -0500
Received: from forward101p.mail.yandex.net ([77.88.28.101]:41261 "EHLO
        forward101p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbfA2DFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 22:05:14 -0500
Received: from mxback20j.mail.yandex.net (mxback20j.mail.yandex.net [IPv6:2a02:6b8:0:1619::114])
        by forward101p.mail.yandex.net (Yandex) with ESMTP id 726C13280D32;
        Tue, 29 Jan 2019 06:05:11 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback20j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id KHzc9VIM7M-5BSq3DWv;
        Tue, 29 Jan 2019 06:05:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548731111;
        bh=/pUp6A1JezoVrZTmPlCF0kAgOzau3EX6e7rre2ti+7I=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=wf7COqBcKUzVXCVOgX1kXex4A8Tv2nWhjpqzzPfCMVFfK0HDoaV3eaEtStO64+Ghe
         kNxg4xX03KCFcuT/H5DWHFb6XFGbaj3yOaNOSCAgYfLRvGmpzxt8TpuLfcGnZe3xau
         A3ZeLOgf8/rLPTxKgB+HVS0fFfNKcZHUdCoV9qhs=
Authentication-Results: mxback20j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id xt9oXyCTqZ-56wGjB9A;
        Tue, 29 Jan 2019 06:05:08 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org
Subject: irqchip: Add driver for Loongson-1 intc v5
Date:   Tue, 29 Jan 2019 11:04:59 +0800
Message-Id: <20190129030501.29791-1-jiaxun.yang@flygoat.com>
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


