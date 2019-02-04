Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1636BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45912073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn+libLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfBDUdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:33:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52157 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbfBDUdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:33:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so1328474wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 12:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bdlq8Nm8w6ZWg2m+slmPE4EkRSKMNcBBO5OKq/m0/CQ=;
        b=Sn+libLScntaN2PkuY+C3t8lbawM+hygvgmEB1pq+2Hp1hCgz2CHp/uXo545+Z0V+B
         x1RahN2V0q1rY+BS95ikv4gQTyA8Ze/QWreijpCoh1Qw/WwfQoJIsLErCiPp0fb9Aizt
         Le1Hlo4OLYGdC6JCmF5tJz9TL2ssHctqdK0EMELT966fN4jf3f69ggdwXbFJp1mNFfJ8
         0bLazcHvn//GQdZWfwSFgxSpD2DeIVXpn+x7Yc/TsMqoMAjZteKXhKbPT85WJVyc/W01
         4w4VufCcMxioiumUbzPESnq14MIAxCT9pUOm8sXa71HgAwbELtNj7SPEdJhG0V8mPtLH
         u+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bdlq8Nm8w6ZWg2m+slmPE4EkRSKMNcBBO5OKq/m0/CQ=;
        b=Q2FC5vmS8Ut8Ot4XMVbST4cH+RdFLt5MHreWvjKwhZ6XAh2yuaeYuatV7JP6XQl9mo
         unTZsF9lbGxWzyBqEgu1mJTnLC4cbYXchbltghjq1s1T7/8C1UvMzHowPt8o5n04lnpc
         ePvvO8WjLXJP9kmr45VQXqfnqykEOP1rZDIbmOm/2Fqq44HAtPdA2PvqJV23fNekOLQB
         ewDlrN4XJtRGS0zSP+Xkbp1fStLffRSRllCtsnIgg8AjFk39VsmJGmy1MZaU4fBfiXo9
         Cdg2SNT4q7Ej8A2wTGqo145o9YJ0zgDXSqvvhsVnhiRadEaxiYA1mDaVRfWZMrB84t/t
         hgSg==
X-Gm-Message-State: AHQUAubW3xVvWdb+1+TX+SA07czoprQ5oIIaminULLqpsD3PeorC/nRf
        tvqcVDCuIVCQmPfHPGXEr+U=
X-Google-Smtp-Source: AHgI3IYKMzYY0hWRbSSvI3DvOxESgpOZlEvlVDEl7wtmLdfHE3HdohxmkCuuJYe232gbfBdWNXITNA==
X-Received: by 2002:a1c:f707:: with SMTP id v7mr926516wmh.18.1549312410071;
        Mon, 04 Feb 2019 12:33:30 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j24sm19990792wrd.86.2019.02.04.12.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:33:29 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, rppt@linux.ibm.com
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v3 15/15] Update MAINTAINERS and CREDITS with habanalabs info
Date:   Mon,  4 Feb 2019 22:32:54 +0200
Message-Id: <20190204203254.4026-16-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204203254.4026-1-oded.gabbay@gmail.com>
References: <20190204203254.4026-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The habanalabs driver was written from scratch from the very first days
of Habana and is maintained by Oded Gabbay.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 CREDITS     | 2 +-
 MAINTAINERS | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index e818eb6a3e71..03f3d67126fc 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1222,7 +1222,7 @@ S: Brazil
 
 N: Oded Gabbay
 E: oded.gabbay@gmail.com
-D: AMD KFD maintainer
+D: HabanaLabs and AMD KFD maintainer
 S: 12 Shraga Raphaeli
 S: Petah-Tikva, 4906418
 S: Israel
diff --git a/MAINTAINERS b/MAINTAINERS
index 8c68de3cfd80..814170776325 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6642,6 +6642,15 @@ F:	drivers/clocksource/h8300_*.c
 F:	drivers/clk/h8300/
 F:	drivers/irqchip/irq-renesas-h8*.c
 
+HABANALABS PCI DRIVER
+M:	Oded Gabbay <oded.gabbay@gmail.com>
+T:	git https://github.com/HabanaAI/linux.git
+S:	Supported
+F:	drivers/misc/habanalabs/
+F:	include/uapi/misc/habanalabs.h
+F:	Documentation/ABI/testing/sysfs-driver-habanalabs
+F:	Documentation/ABI/testing/debugfs-driver-habanalabs
+
 HACKRF MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

