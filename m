Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D27C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAB520857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="KJ7+mRjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfBAGgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 01:36:05 -0500
Received: from forward105o.mail.yandex.net ([37.140.190.183]:45182 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfBAGgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 01:36:04 -0500
Received: from mxback16j.mail.yandex.net (mxback16j.mail.yandex.net [IPv6:2a02:6b8:0:1619::92])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 690324201B50;
        Fri,  1 Feb 2019 09:36:01 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback16j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ygQrf0fulZ-a0LesWaP;
        Fri, 01 Feb 2019 09:36:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1549002961;
        bh=5Q+uYeeotIzMxJouf5A7MKN3AE4TKwV3sI9x4S0HxMQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=KJ7+mRjCNkRiGlyguMeY0xYlqeEwd+DsZDqcTkbEgQTdS35ZmzSFZpN3yxuzT8VTm
         x8TJApHdkbq0ErVWZTpgaj1bn4tfNXh4psPs9ry52uv6TEjyGbEvMQR+ruWbs8GwGG
         3+FkhXllMDRpG+bEx5EjByBd++hBwQZRTw1z8h2w=
Authentication-Results: mxback16j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 5VfXSCstdQ-ZrVOgafU;
        Fri, 01 Feb 2019 09:35:58 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: [PATCH v3 0/3] Enhance loongson-1 clock driver
Date:   Fri,  1 Feb 2019 14:35:37 +0800
Message-Id: <20190201063540.19636-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128152052.3047-1-jiaxun.yang@flygoat.com>
References: <20190128152052.3047-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2->v3: Fix dt-bindings issues


