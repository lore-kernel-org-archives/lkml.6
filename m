Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PNq+CcJhHlv5RwAAmS7hNA
	; Mon, 11 Jun 2018 11:55:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 773C2607E4; Mon, 11 Jun 2018 11:55:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVenX1Xa"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EA3C460351;
	Mon, 11 Jun 2018 11:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA3C460351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933304AbeFKLzX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:55:23 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38472 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932893AbeFKLxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:25 -0400
Received: by mail-lf0-f65.google.com with SMTP id i83-v6so30085689lfh.5;
        Mon, 11 Jun 2018 04:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hg88Wzl5zGWc4tPtZJAg8u0955QkUDLn494gEpnUIxk=;
        b=pVenX1XawER8HQyLZLqw0h3oNSdiQR8U5TltD5Imuu+T3ivfVmKAniWJZo+S6DTfkT
         C0hpKxp8IvCSDAUEWomGP1MQcX1M27ADbZMA/VB+NrqLCiry0eyAQSZCvl/Vs4DDmyW8
         1umhJJS1g3lLivYl/SGfWxDSSrNDDmYXboSnBZLP4fbFDBSqsfFw29GRri6eSQPJUZ4L
         SfSyvgZMbS2HgQEdafL1/dkXtoCNNKoXSVT68XWM+03uu986qpuCHBAy33q1NDJu4ohS
         DRz2LiJvUCn00J0aWhwbikUU5IrKGacLMdixZlBr2h7xitcJ1y2rh9ZusfCya2LhokJe
         Howw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hg88Wzl5zGWc4tPtZJAg8u0955QkUDLn494gEpnUIxk=;
        b=GgrdTPxLSdZt1YHfJNgHffs1ypkCU9nqj7SMN+fFkrgtsg4i6QV2DypTIFOtQ8iPF8
         lvdSsxCNZ5PBeWp76fkkppBZU/mkdpmYB+ELVExoTNw74fBBRvCfbqKsAJ3XwOFAp3cf
         ZsUQIsUfLa4o2GFcaiIVYC96nAQk92ExIGNpNCEpUNsm26YenokI+ZsY222IluaJ9DVm
         +GNd1ybZK2S9Zi0r8a27YBRL66qHCicaG7jVCnesUGCy5l2yfuQvLKgSJWpr9NiNCYq+
         aWrL/8OJX2QqVkrMxPskWXfPBe1Y65ZxHk1uXWGj0wjQLoHpR2doXUfpc3WJ2s5vpFSa
         1OoQ==
X-Gm-Message-State: APt69E0v3ItxGs3OPBcIl2uptuuFXesTocvHZBsaO/IvvG5kpVJcvk20
        Xnwms5hJu3L613wkKVFthlwd3ixs
X-Google-Smtp-Source: ADUXVKJG0E7tZMSYKOcs4fmKZVHJEDZ2HTJTQU84QtRho7YEMYw5lR5LDeqlMsENvAGgU5pHJWurow==
X-Received: by 2002:a2e:8951:: with SMTP id b17-v6mr12203612ljk.111.1528718003505;
        Mon, 11 Jun 2018 04:53:23 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:22 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 17/24] serdev: Mark controllers compatible with ttyport
Date: Mon, 11 Jun 2018 13:52:33 +0200
Message-Id: <20180611115240.32606-18-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to treat differently this controllers, by creating a tty
compatibility layer.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/serdev-ttyport.c | 1 +
 include/linux/serdev.h              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 4acc5f41dc67..ae961260e4a4 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -276,6 +276,7 @@ struct device *serdev_tty_port_register(struct tty_port *port,
 	serport->tty_drv = drv;
 
 	ctrl->ops = &ctrl_ops;
+	ctrl->is_ttyport = true;
 
 	old_ops = port->client_ops;
 	port->client_ops = &client_ops;
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index bb3b9599c652..07d63933bdb9 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -116,6 +116,7 @@ struct serdev_controller {
 	unsigned int		nr;
 	struct serdev_device	*serdev;
 	const struct serdev_controller_ops *ops;
+	bool			is_ttyport;
 };
 
 static inline struct serdev_controller *to_serdev_controller(struct device *d)
-- 
2.17.1
