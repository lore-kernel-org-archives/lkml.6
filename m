Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C07C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5892184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="QvHuq0tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfAXD2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:28:02 -0500
Received: from forward105o.mail.yandex.net ([37.140.190.183]:57617 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbfAXD2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:28:02 -0500
Received: from mxback3o.mail.yandex.net (mxback3o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1d])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 7F34242011A6;
        Thu, 24 Jan 2019 06:27:59 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback3o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id T6rkOwtRbu-RxDWt9Lr;
        Thu, 24 Jan 2019 06:27:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548300479;
        bh=E0PTDx9283thgZRUi2ZoaXsisqBuRIiyjhMkEBEjofg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=QvHuq0txuW81q7JK3iWDJycMKh6bkLRTK3ixTSD0fAdpG2AsPTQ0f6W2jOwXxKOFl
         TKlq4dymGh7qeP+MDS6ItynA5ogy/UhOA+r/fHestf3WL3GWblvyWsqM9tlwku8ocQ
         aMNj079qKWpoly3d68WF9rE/7UGrSIen1epzbO5I=
Authentication-Results: mxback3o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 2lgYSlYsqG-RqXexUqt;
        Thu, 24 Jan 2019 06:27:56 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: irqchip: Add driver for Loongson-1 intc v3
Date:   Thu, 24 Jan 2019 11:27:28 +0800
Message-Id: <20190124032730.18237-1-jiaxun.yang@flygoat.com>
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


