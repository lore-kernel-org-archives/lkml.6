Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDCAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1B020857
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHx4VYUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfA3W6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 17:58:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42355 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfA3W6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 17:58:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so1231169wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 14:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Cqq42ZqMai8IvxjCVYjion/nan7g3+V9IKfKMUhD8M=;
        b=sHx4VYUk30UdPi88Sk5g/JByuSwSg/hISFGoqFgadOrHTYIos8nDpjg4As3OCr5SRm
         nHLLWX66nfqpf4AW3CrRomYVHXiMhtQqQ4rxC8dC4NI3xmem+sPR2tIxCNR/9Lc4HiKc
         9Ent+dhwQdtc+SJSG5JXjHam9o0oK7H+yuCXp8uk6nXnvmIoC99+abuhleDd0vz4d5SK
         VcyShbXeDFpEMSJbjbBEQ/53yMmXPaaN7eSqazA+KlrWudEBF1L0T6Gb22B8HjN6Kapj
         7Sr36azxwnp8DhSnyRpDbO+MyaOKA9d/+UyZbwkcevu9LUDypj7z8hh+lu0i6ESt88vK
         ZUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Cqq42ZqMai8IvxjCVYjion/nan7g3+V9IKfKMUhD8M=;
        b=BWMwUxngJwXruuQiQjaALejAUqusRwjkwdatl6WTy+xcDZvBvdYidcp4Qmo3gf9Yrn
         c91ewnHK61a7oWIhltrSbAkCSpN4e6tHHvN/yP2ielQ/Qsu+B8cLdCY2NIBB6JCYWFRX
         ACtRe3gwRh14LcFSbroyneu3qFuxf3SFkp/wsxP6+7iQQFub6fiMCBui7Hk4Ayq+EvXL
         379h0ptZ8qAFJsHfSN8zV95NjMZqndmtv0C/UMQ6bJl0zyLkFi0VYKjF00FV+neRLwNC
         LhUztRNHiboQ0Z8G9Gj+YdZfOY6W9F0/SsqvONq2Gtc/1tBPqkUCQnPavwM/a0AtZtFf
         +gGA==
X-Gm-Message-State: AJcUukfpE+LoTPNJkDZWCecJBQo8hRsAtoihDq0eXcWlPveYQcGfC+b0
        9YrmworT0B6S/9Yka4ipGP/oCORK
X-Google-Smtp-Source: ALg8bN6RM8zUgauL/AsPvdwUlavWV4USg2NaU1x3SbCWnCp8HIYFtlJxHRt9zvpV4H6VtHleKl4mzw==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr31015718wrr.271.1548886067523;
        Wed, 30 Jan 2019 14:07:47 -0800 (PST)
Received: from oded-ubuntu-des.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id b13sm2341349wrn.28.2019.01.30.14.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:07:46 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, rppt@linux.ibm.com
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v2 15/15] Update MAINTAINERS and CREDITS with habanalabs info
Date:   Thu, 31 Jan 2019 00:06:17 +0200
Message-Id: <20190130220617.4862-16-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130220617.4862-1-oded.gabbay@gmail.com>
References: <20190130220617.4862-1-oded.gabbay@gmail.com>
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
index 9f64f8d3740e..33b7e4e67c0b 100644
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

