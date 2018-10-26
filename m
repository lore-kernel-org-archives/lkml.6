Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23BBECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FBD2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5D30Hpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FBD2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeJZTx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:53:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36312 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeJZTx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:53:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so948175wrw.3;
        Fri, 26 Oct 2018 04:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UzI7QItBboJycH/HpslvTFG94WVjeSBxpsz6zXZa7wE=;
        b=M5D30HprenHJK/ckhe7p0gHlRpkigXk2QIUfgYl0OD7y0Yljv0vqeSAB+jkuu6coMx
         zD1y2f3GjYPoBnidp1pr2g2etACqgr3rnhd8GwLIhUcVgmtWwT7imeDZHvuaUbb5V49Z
         UHyF3TiDqxtaSPSPYmpTA7VKdz7YgU7WyfG1FFuVF8FSBHi0PObynPCiwpyhWOg/wWY7
         EgU8xV5/ZYlY2PWO58RD7wBa1nbJRGbAWujtn0i6iARr18WR6ddPppzejkoKZQHroeqt
         jJeac8iTZdOduzi0Z0n5ZfhJzv82RozYt/E+FH0vZ5tig98m+bkMWF7gEe18OaE4ikod
         69DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UzI7QItBboJycH/HpslvTFG94WVjeSBxpsz6zXZa7wE=;
        b=aDm64JF0jP60HJrc4RZO6CVm5cgIEnzAwrgMHjyGvCJQl7bmaWdGs54vYdYKs+5JYP
         MXGN1Yc2L5vJoIoyW4NkukG+GmsDVLO6XX791SWM1ilAzHN1sIJlpGDrSgfdQXo38rOr
         zYn9N5fyZi+UXDYdrTRGBsY/1wVWjY4hefLHCkenNEz/b27NsKju/jFCngBiUozyrQwg
         hkL3lL1cAdHi1QLwaIvt2uHXqjt6UnIE9XpfQIHOr3QuHnsL6wqpFCrU6x9IGjGvQncr
         FydEVtIfk1gda7JSYKQoS171vNrN9s5KdTTi4NaN1AduFqbnxsR8uNs2B7DPt0GN0De6
         5iYA==
X-Gm-Message-State: AGRZ1gK/WKO1w6mj91j6JsXjRJyjCyAtvGf5Mlgx4RoLbuLh3jRKakgi
        0j3zb1zBNX1woAOfKhqvrrI=
X-Google-Smtp-Source: AJdET5cdQ/3a1bsJOFPGEEIX2i/kqhKCshjOa85p5giWBZN1TxTH9euVtLC4lDAq4MzoNmSnwpEakw==
X-Received: by 2002:adf:fa92:: with SMTP id h18-v6mr5369795wrr.74.1540552603274;
        Fri, 26 Oct 2018 04:16:43 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id t66-v6sm3224263wmt.5.2018.10.26.04.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 04:16:42 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] mailbox: Support blocking transfers in atomic context
Date:   Fri, 26 Oct 2018 13:16:30 +0200
Message-Id: <20181026111638.10759-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181026111638.10759-1-thierry.reding@gmail.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The mailbox framework supports blocking transfers via completions for
clients that can sleep. In order to support blocking transfers in cases
where the transmission is not permitted to sleep, add a new ->flush()
callback that controller drivers can implement to busy loop until the
transmission has been completed. This will automatically be called when
available and interrupts are disabled for clients that request blocking
transfers.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/mailbox.c          | 8 ++++++++
 include/linux/mailbox_controller.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 674b35f402f5..0eaf21259874 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		unsigned long wait;
 		int ret;
 
+		if (irqs_disabled() && chan->mbox->ops->flush) {
+			ret = chan->mbox->ops->flush(chan, chan->cl->tx_tout);
+			if (ret < 0)
+				tx_tick(chan, ret);
+
+			return ret;
+		}
+
 		if (!chan->cl->tx_tout) /* wait forever */
 			wait = msecs_to_jiffies(3600000);
 		else
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 74deadb42d76..2a07d93f781a 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -24,6 +24,9 @@ struct mbox_chan;
  *		transmission of data is reported by the controller via
  *		mbox_chan_txdone (if it has some TX ACK irq). It must not
  *		sleep.
+ * @flush:	Called when a client requests transmissions to be blocking but
+ *		the context doesn't allow sleeping. Typically the controller
+ *		will implement a busy loop waiting for the data to flush out.
  * @startup:	Called when a client requests the chan. The controller
  *		could ask clients for additional parameters of communication
  *		to be provided via client's chan_data. This call may
@@ -46,6 +49,7 @@ struct mbox_chan;
  */
 struct mbox_chan_ops {
 	int (*send_data)(struct mbox_chan *chan, void *data);
+	int (*flush)(struct mbox_chan *chan, unsigned long timeout);
 	int (*startup)(struct mbox_chan *chan);
 	void (*shutdown)(struct mbox_chan *chan);
 	bool (*last_tx_done)(struct mbox_chan *chan);
-- 
2.19.1

