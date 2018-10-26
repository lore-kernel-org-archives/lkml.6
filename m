Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB14C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52E7207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKdzsUU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52E7207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJZTx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:53:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44273 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeJZTx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:53:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id d17-v6so643417wre.11;
        Fri, 26 Oct 2018 04:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZ4YTuB3It2WTh2s9CHheVKlVJx+N83OyNKjw3ja39k=;
        b=qKdzsUU/RJzo/YihJKzjnaYZs1j56JJnmVTkJ347iJ4ahLQyqmhB20iPdle6aS4/2X
         bJ/GoC/sqDnKbxsElbErRLeLGk5y6Ee2PDSUheTNfi3Ew4Tvyr7wZ7Tryq+G+b1oIgyM
         6zTSeUFOa+jpglUe5zpUGBsJurxdSjfUOXP6nGsac4k79Yu3XnfkNgJ5amdB2rARiWt8
         CH6LQyUoxj3i/uJKophCaIQXKKd/14yIMg3XTZSdJYeM0xNNw7g9yNgF85S3mq4pTzrC
         ChygJv6MiDEZRPqSXM85fXy74QtYsAPFI27PVcPUTiwR3/t5y37mP/NSolImrkCS6r70
         aD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZ4YTuB3It2WTh2s9CHheVKlVJx+N83OyNKjw3ja39k=;
        b=cplGJxmlSZwqQc0T00K8LBw9AP97uiOjN+Izf8vSes9MOspDDWkDWYnO2LXQrEJjgM
         qclkFXohcZpC2ZFV/i2hjBKRkgXW/Ifgf7c59uQ25QdbwR8wwEUZ9BTQwSiuIIglBoTP
         ICjRPjoZGVWDbs/Tv4GtS4srcKsMA+ew1ZLpivEgEH2v3YcV/DO75EusCRRd27NRg7Op
         lO3hQ13wrih0hQGx6iRcAqbzg2pePJTKBBTs+8j/lc1MWQT4TnI2+5tO1I5ZyiLAhVry
         t1MpT2FSH1Af/XvH5wtGsV3QtPxyzQoP1K/lhchoknG5xN/QaqM3nNRKFHpeeoICy4mL
         rMqA==
X-Gm-Message-State: AGRZ1gLc9rvlP94jKj0DNIuThZp84XJticclmQ/MQG904cXto7ip2J1a
        wLVsodIpfsCcmtFo3C5iRX5niYJs
X-Google-Smtp-Source: AJdET5dOu+C/2dVlN45lD3RawGcPQNlPD2ESVgv3qCJ8a5Gyv548/8qmAwvU/Zp6DnzMjgxLQFrqPA==
X-Received: by 2002:a05:6000:8:: with SMTP id h8mr5255014wrx.103.1540552604877;
        Fri, 26 Oct 2018 04:16:44 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id q190-v6sm5994451wmg.40.2018.10.26.04.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 04:16:44 -0700 (PDT)
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
Subject: [PATCH 2/9] mailbox: Allow multiple controllers per device
Date:   Fri, 26 Oct 2018 13:16:31 +0200
Message-Id: <20181026111638.10759-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181026111638.10759-1-thierry.reding@gmail.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Look through the whole controller list when mapping device tree
phandles to controllers instead of stopping at the first one.

Each controller is intended to only contain one kind of mailbox,
but some devices (like Tegra HSP) implement multiple kinds and use
the same device tree node for all of them. As such, we need to allow
multiple mbox_controllers per device tree node.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/mailbox/mailbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 0eaf21259874..f34820bcf33c 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -335,7 +335,8 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 	list_for_each_entry(mbox, &mbox_cons, node)
 		if (mbox->dev->of_node == spec.np) {
 			chan = mbox->of_xlate(mbox, &spec);
-			break;
+			if (!IS_ERR(chan))
+				break;
 		}
 
 	of_node_put(spec.np);
-- 
2.19.1

