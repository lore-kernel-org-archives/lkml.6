Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC423C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B56F214C1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/3OJOW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B56F214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbeKVClV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:41:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33763 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbeKVClU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:41:20 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so6152465plo.0;
        Wed, 21 Nov 2018 08:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=15CBHc4LfPIPHaj3tA3fI5dNAgKyfqROLgd/vwyWEb8=;
        b=Y/3OJOW+Vur3T5Zg8W7z+OancXXF5zFQezttVBzWIsq5jjPd9GZS49XFe2PXNJQLYj
         kD8KOATBi4fCcK1n9LYdlvzKqkZf3pVXKiw8T9DDw9a1SJ0b/e6PE1vcNEbJh1MjtFGx
         IZ3xalMoYaYJzj/LwYF2/Xb6Fkb5Q8J0sYHk7GZBUFwNwbsZuFcSOhAYqQjBsjKNt7CC
         MIxLYt7ks3w0lzkAPmcm0sD4eNssH0rvz0Onh7wF7h2mXSnQtm4YHi75Ms1eTiILbv7R
         h/zO7LF5qqniKdIGmAgzEnl8H3qidXTbbjv+HwOqUjMCtUiL6B8lmBkiFmXaZJ1uiKoX
         zUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=15CBHc4LfPIPHaj3tA3fI5dNAgKyfqROLgd/vwyWEb8=;
        b=iqj88IAEGL2INu4UpLpoBTxfkOnqyB28RnKju7TNzurfeY/9KINO7tajQFjT+rDnWG
         jnjz7omoikg1uira57Rz/NHky3ANUv7DvBuvkCGk990NHhbHnnOmjSNxzOSQ1SkwDwIo
         BOWkoO9WajhqIk2WwBuHtJrVPRegkl0mgpguVDZyOkES6RbCP6RaGwcZL0fHSKC92ODV
         MKe5WBR7sygfyJprpwQHGqZDPDQJ8FE7aPoHoel2I5cSLAXxATlC8ikb+nvAMI4HX99V
         +9SULMHYs9OVLdmEjPbZ+6LcYzElwYX6Hy+sf/SOiBJ7rMsnsLQMImM/cDro7JdsiIhd
         GYVQ==
X-Gm-Message-State: AA+aEWZ2nPnnNm/CoKrYaik9PQ5YReJZ/7ruc5SMq8lnqcB0ieOvYgtV
        LQ2Js4vBZ8UQM4tRDnmhNiQ=
X-Google-Smtp-Source: AFSGD/WP1hB94PuTOo1BWEkNQQ/3QL0FL/W5OX2i4p0jaSe634O5DMpqwLj28+uDwzMCa1erSMZ7+Q==
X-Received: by 2002:a63:af18:: with SMTP id w24mr6545151pge.385.1542816378388;
        Wed, 21 Nov 2018 08:06:18 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 85sm63334459pfw.17.2018.11.21.08.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 08:06:17 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     sparclinux@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] serial/sunsu: add missing of_node_put()
Date:   Wed, 21 Nov 2018 11:06:15 -0500
Message-Id: <20181121160615.23666-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
This place is not doing this, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/tty/serial/sunsu.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 6cf3e9b0728f..4a27c0114d50 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1394,22 +1394,32 @@ static inline struct console *SUNSU_CONSOLE(void)
 static enum su_type su_get_type(struct device_node *dp)
 {
 	struct device_node *ap = of_find_node_by_path("/aliases");
+	enum su_type rc = SU_PORT_PORT;
 
 	if (ap) {
+		struct device_node *tmp;
 		const char *keyb = of_get_property(ap, "keyboard", NULL);
 		const char *ms = of_get_property(ap, "mouse", NULL);
 
 		if (keyb) {
-			if (dp == of_find_node_by_path(keyb))
-				return SU_PORT_KBD;
+			tmp = of_find_node_by_path(keyb);
+			if (tmp && dp == tmp){
+				rc = SU_PORT_KBD;
+				goto out;
+			}
 		}
 		if (ms) {
-			if (dp == of_find_node_by_path(ms))
-				return SU_PORT_MS;
+			tmp = of_find_node_by_path(ms);
+			if (tmp && dp == tmp){
+				rc = SU_PORT_MS;
+				goto out;
+			}
 		}
 	}
 
-	return SU_PORT_PORT;
+out:
+	of_node_put(ap);
+	return rc;
 }
 
 static int su_probe(struct platform_device *op)
-- 
2.17.0

