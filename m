Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9E6C26641
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BFE20861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfATR0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:26:03 -0500
Received: from shell.v3.sk ([90.176.6.54]:47302 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfATR0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:26:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6C489C9B22;
        Sun, 20 Jan 2019 18:25:59 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1-vqslEF-aWF; Sun, 20 Jan 2019 18:25:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 29DD3C9AF5;
        Sun, 20 Jan 2019 18:25:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1wXWVHPELn6b; Sun, 20 Jan 2019 18:25:51 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 48D67C9A93;
        Sun, 20 Jan 2019 18:25:51 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Bindings for Armada display subsystem
Date:   Sun, 20 Jan 2019 18:25:28 +0100
Message-Id: <20190120172534.24617-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch set extends the bindings documentation of Armada LCDC to
cover the rest of the display subsystem.

It is based on what was implemented by Russel's patch set that
implements the dt bindings for armada-drm [1].

[1] https://lists.freedesktop.org/archives/dri-devel/2018-July/182893.htm=
l

There are some differencies though:

* Compatible strings for the MMP2 platform were added
* The compatible strings for the display-subsystem node and the
  framebuffer node include "marvell,armada-display-subsystem" and
  "marvell,armada-framebuffer" since they are hardware agnostic and
  supportable with the same driver code.
* The "bus-width property" was added.

More in the individual patches.

Thank you,
Lubo



