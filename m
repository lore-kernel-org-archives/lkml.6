Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F85C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096D62082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErG6nnib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbfBDOHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:07:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55233 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbfBDOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:07:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so13334447wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 06:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1KWxzyTDMuTaSqzxY9JcVAwSW6wIwz4u1vjM/C45ooo=;
        b=ErG6nnib+16FJlKRtC8J7tJgFOLYqvHE1zlBbsl30LX/ugt0nrRUC+CnsNuwXPp+P0
         0LbmKw2+Gkk8RZvWby/UpoZ8V+n3CKYGHxIG7EU49+8zVVNxjNUN/FwFTNSGNYEamcXn
         tmT/3jXMTs0v6RH3Kz32kfyRBthsgLVrU5KO83w3d3AZ9NIe3Iy8+GJHje1BDK9RXp5B
         s/9Nn2p1KzQg+rAw/MAoIEj+aXGQTVJLfjygPuee+KA0KC9pVfsJG5oVvJAOzxCjwV2m
         TxR+bikvOlRStikq0O1NncN/ItUTaGEimjLaRzvBi+27CE6JM/P/O/86LvwXALNgq7+0
         5xRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1KWxzyTDMuTaSqzxY9JcVAwSW6wIwz4u1vjM/C45ooo=;
        b=dJgBQmZIMY5QhSRVnyJSgWjDA+8ZVkWcbtmSRQuS4zqDkGhucMg14t7GaqaOHm9FLV
         +YFfYGaI98XQOykGXlUPpjkPL94XJ73erEwTYnXC423B3FRwweTA2tB/efNG5gY6J7ie
         f5OEeYrav9X3irtOeseJFewu3idVHLKuOUL4qLm3aJwfGWWN75ZsYGT9yb00Cd3Q6ZO2
         T/O2srtpQm5ICaQJSwJtFTJdCaou8R3tsDvi8yiYVu4JEjATs/iv1Mzw27TkvfH0Kv25
         +qhXyLyoLsdVzuf9acn4S3TQrE3QSjlpyslTGtCpNw37iKAYI8IatX9hRjt76Ow8qRKp
         5UUA==
X-Gm-Message-State: AHQUAubaOnKa2T2Xyc/Tp/23gZkzWtlGS+oR8utT811u7/76ECAVn8HP
        mrw7mmuDmGLkiwbsSoXdONw=
X-Google-Smtp-Source: AHgI3IZAU3S5K3J2grfRYw+OFWS8WuEECu/GATWYtESpoX8J2CpEr2gY1xnTnVvzjXxLy2eiY1xK/w==
X-Received: by 2002:a1c:c008:: with SMTP id q8mr12397132wmf.99.1549289228320;
        Mon, 04 Feb 2019 06:07:08 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id v132sm10867418wme.20.2019.02.04.06.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 06:07:07 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: Export mbox_flush()
Date:   Mon,  4 Feb 2019 15:07:06 +0100
Message-Id: <20190204140706.15498-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The mbox_flush() function can be used by drivers that are built as
modules, so the function needs to be exported.

Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index c6a7d4582dc6..38d9df3fb199 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -310,6 +310,7 @@ int mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mbox_flush);
 
 /**
  * mbox_request_channel - Request a mailbox channel.
-- 
2.19.1

