Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_SPACE_RATIO,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C26ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4454F2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f63Ex2Vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4454F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbeIQSHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:07:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44942 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbeIQSHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:07:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so7502902pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wl6+X5L1Aye9QfU3nH2Vzj+pWDfLbs8Ax2BDR6xdg1U=;
        b=f63Ex2VpjozUDcmUSwkFC01+brVY6X9C7KmiB51coogHe6dgr++g8uF1+k1VQ0OJ52
         Ctf8aTKyN8C8HVe5pdSCejoEOBMBumxowyrDusx9Uu7r9pVydi0PxPPy5Qs0Xg77GJk2
         FF3BcH7mKM0xlplcAmJyckmq+DWerC27XTgJ9Bu4uhBNYbfQlm1W33LSruGzrqIsY+FS
         qI8MD+bMG48tYD0A77WtlKED9v3Mva6nx6M2oo+l3U5QANxiV6uBeVsKIpXmsVrwSysC
         elpdYKE6+8pXyh91km599VIQbA6FeUxDSXbrLEKEhvNe0esB3DXDZOo4ixIQdsJLnXcZ
         aVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wl6+X5L1Aye9QfU3nH2Vzj+pWDfLbs8Ax2BDR6xdg1U=;
        b=R33+4p21q+tvfAN4OSpyO9AEG/jcBzXk8r/bAWKUmTnAf1ou7xa6n+uIKDBhtBbERD
         2JtIrFqX32lw4WmT4G384mBQT/XVqR63pihLyMuG1QJl+q08FCIcvBZfX5K7tFYAtjyj
         7zWRw/1BqqUaI12oeG5Du4nzmRwML6cj4C2iW+s8QEmDMlHra7tmzacX4Rh37js76aPn
         f8f7ghbqd+bNhhHv0cEGkYLaj1UjUV9NTiCbbX3cAobyVSSFSa/uUKbu67nuvS5LQWOJ
         11GLsAK2yRxZoUnf0XhZZkGOC3iS6y6dRn4PAZQVLBdqZYxx1v5zoqwrneV0JtVs/GDZ
         zXdQ==
X-Gm-Message-State: APzg51DEIK+lXT/LCpBl7u16hf+2yHBO5BKIZk59xilDyf7qaVwOe63q
        LutZESbngATQpLYqk3ssH2g=
X-Google-Smtp-Source: ANB0VdbgBBYsDcXVe/oHwPMJxBR2IAqrZGqx5SXBRbbGDSkru5QMYGLRTng4aAB1zeN2AFO/qd5VFA==
X-Received: by 2002:a63:f4b:: with SMTP id 11-v6mr23713537pgp.100.1537187991717;
        Mon, 17 Sep 2018 05:39:51 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id v22-v6sm26960020pfi.60.2018.09.17.05.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 05:39:50 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 07/10] staging: gasket: fix gasket_free_coherent_memory metadata frees
Date:   Mon, 17 Sep 2018 05:39:02 -0700
Message-Id: <20180917123905.213639-8-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917123905.213639-1-toddpoynor@gmail.com>
References: <20180917123905.213639-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Ewalt <nicholasewalt@google.com>

Free gasket_coherent_page_entries metadata memory, update data
structures accordingly.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 33d98043953a5..c1ce8f984f8e0 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1353,6 +1353,11 @@ int gasket_free_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 		gasket_dev->coherent_buffer.virt_base = NULL;
 		gasket_dev->coherent_buffer.phys_base = 0;
 	}
+
+	kfree(gasket_dev->page_table[index]->coherent_pages);
+	gasket_dev->page_table[index]->coherent_pages = NULL;
+	gasket_dev->page_table[index]->num_coherent_pages = 0;
+
 	return 0;
 }
 
-- 
2.19.0.397.gdd90340f6a-goog

