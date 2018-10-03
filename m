Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C552BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBFA213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aenqPoBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBFA213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJCWjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:39:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36659 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:39:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so6716684wrw.3;
        Wed, 03 Oct 2018 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3HsSq1Q8lmNNHgciic6w0v1D3I0bXYf/WF93oAE/Cu8=;
        b=aenqPoBQHb8nTYir6GL/YHApul6UpOxQRDgzTbK9wvlEwlbU5mKygiE4ReI1c+4lWY
         nnq43dRfAKO/C6hmczDmlQKH4FjxpNjPpJR4DzHDlDwwZXNBB7j9pCSVmWE5AIYMuD+M
         ucmZV+oo6mzGFoVtxFiqkBqfdznDmCYZ4kQrdTmSWmGKpY0gLn8mmQJRJojyXb8K0erJ
         0mHjktA4TFCFOK3WBtdIt+7BqbWHQ0VrwuDAXup2yjGBTqiIN+S7eOBUaLdiQneQggnO
         /1Q7rPk7LtGCxQ9K54ecYcMWYqubPIEr1VMI5BWbSeVwsJzynjvv2KsZ3TcF2F4NQKJo
         0QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3HsSq1Q8lmNNHgciic6w0v1D3I0bXYf/WF93oAE/Cu8=;
        b=ju65Yn71bxJMMWig/pVHrN+BffGYfb8M4bDTFGzVVCiLBUaMgCPAK9rXaSbLCOZ/Rw
         y+7t1fXUs7keRSLbLTMcFuAReUzdnjgLCkKRCfjZVA3G0kBp9kWnZ+IAyn3+JdQFyWlj
         g2TBWZHY0mKUDy8LLwp+6makQ7ES5f2WMzj2A0RlZrdhV+pAVDFbqu19l5vRkM1w9B5r
         qNz1rckwboNQ1UsjlEim0haxjDiOs0T8OTFjJ1YSyon1r4zcAtZ1w+QwVGHaEQM6K/+9
         vzcZzxqlgiIXPCgYYx2nNXzJPa+Syeqonl8CmJmfW2hojAwOZXF9H+16rgmg3w4L4QWy
         33Fg==
X-Gm-Message-State: ABuFfoj/F0aaEq1e/X5LXMSi/V9XZkBWaWZcf9uktss/xqQ3EGgiA0jJ
        u+nJbjJNlyvkrPMMgYoVMRKEl6EV
X-Google-Smtp-Source: ACcGV60PphuUV9feKdBuwrHMab2atFYgDyUnDlZhOWG32DmIhDD7UBncPxrwzMJ/xjMxOyEOMIbn3A==
X-Received: by 2002:a5d:4605:: with SMTP id t5-v6mr1701882wrq.52.1538581850592;
        Wed, 03 Oct 2018 08:50:50 -0700 (PDT)
Received: from pc-ceresoli.dev.aim (45.11.168.109.cust.ip.kpnqwest.it. [109.168.11.45])
        by smtp.gmail.com with ESMTPSA id h18-v6sm1707614wrb.82.2018.10.03.08.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:50:49 -0700 (PDT)
From:   Luca Ceresoli <lucaceresoli77@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Peter Rosin <peda@axentia.se>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH v2 3/3] i2c: mux: mlxcpld: simplify code to reach the adapter
Date:   Wed,  3 Oct 2018 17:50:24 +0200
Message-Id: <20181003155024.16024-3-lucaceresoli77@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003155024.16024-1-lucaceresoli77@gmail.com>
References: <20181003155024.16024-1-lucaceresoli77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca@lucaceresoli.net>

struct i2c_client has a direct pointer to the adapter, no need to dig
it out of the struct device tree.

Suggested-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/i2c/muxes/i2c-mux-mlxcpld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
index f2bf3e57ed67..5ed55ca4fe93 100644
--- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
+++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
@@ -132,7 +132,7 @@ static int mlxcpld_mux_deselect(struct i2c_mux_core *muxc, u32 chan)
 static int mlxcpld_mux_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
-	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adap = client->adapter;
 	struct mlxcpld_mux_plat_data *pdata = dev_get_platdata(&client->dev);
 	struct i2c_mux_core *muxc;
 	int num, force;
-- 
2.17.1

