Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD3BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AD6222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kDkmovGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbfBLSxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:53:43 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:41985 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbfBLSxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:53:41 -0500
Received: by mail-qt1-f202.google.com with SMTP id y31so3695862qty.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d989risvbXGddZjllfCNXkTN3mFhC1Eg/EDQAHSJ3yM=;
        b=kDkmovGIl9ITGv7ivdWo6sywOAFhdbTGdyEs7DzgjIzE9vvPpU2HpJBSqPHo7Ihk8G
         DM6tAAjJBNf0WSp1wFfCwusMOdADvp/dy8Z4nmrAs22aPU6CwK+3ZJ23BryoqWPWUx26
         Xr7fR/B2w26/JLPsZzH8TMuHo+oRFD0cwC8z32tY625FLdy8eImJ0PHSbWefZlRXf6Te
         wFHiRgWi14YYWSSXWBI7mqaV+LurIsXp3ZaSfMfRE7oyrb7Gw6s+HduL6USJSbNzdP3v
         gfx1T0zAhuYYL+5Nm5fAPRz9ivNJpRNFJrAUDxfgFReDy8TZ0T6PoyFQTByrfJiRj3wg
         symg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d989risvbXGddZjllfCNXkTN3mFhC1Eg/EDQAHSJ3yM=;
        b=V1JkxYhPMsCD1/zTn1k3ZFJrXDJc0wvfaxo5HagqyAdKDPGbtey6Vk+84MXNqJXqqS
         Twy2jAMokPDEsaODjPIRZAHWfyDk0/9yyCh+ZNgM7BkSlv/DHG0MsGJqaNHVnlUfLeQF
         iWXkY30j1cynspK8uOrpdUNG0Ce/LqMLFInv+5CTc4jt8QSTpzgCOFNNS46olBFxX3Pl
         pl+xv6w/j3fdXjsrkrLbKlYlFNYsaBqg5NUvVBFBKGe9xbnAk4AANHKRygx4Hv9fkKAi
         UQOSQq3X9BiwB0a8djhJ6x2xdZ3dejFSgheTuyORKaXKRMCOvcxHHgi0zuMusW9DIIJw
         AIPg==
X-Gm-Message-State: AHQUAubaAVjQdnWpKbTDDiXra8VM0e1ipNFcEo2oOZqEl6qDZ8v9lfTO
        VK7MgqN+L9tTox07AwlaXj1RwvIwFxIblfhn8oaAOg==
X-Google-Smtp-Source: AHgI3IYeSM7KF3zEI5jSt5oH5y3eDLWa+Sf5/o17qlCItee5kuYnNoL44jm1KfkAH8up5aFmwjfVWz25kzca0+h5nFklaA==
X-Received: by 2002:a37:4351:: with SMTP id q78mr2964333qka.36.1549997620429;
 Tue, 12 Feb 2019 10:53:40 -0800 (PST)
Date:   Tue, 12 Feb 2019 10:53:05 -0800
In-Reply-To: <20190212185305.112847-1-brendanhiggins@google.com>
Message-Id: <20190212185305.112847-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190212185305.112847-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH v1 1/1] of: unittest: unflatten device tree on UML when testing
From:   Brendan Higgins <brendanhiggins@google.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com, mcgrof@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UML supports enabling OF, and is useful for running the device tree
tests, so add support for unflattening device tree blobs so we can
actually use it.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/of/unittest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 84427384654d5..effa4e2b9d992 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2527,6 +2527,9 @@ static int __init of_unittest(void)
 	}
 	of_node_put(np);
 
+	if (IS_ENABLED(CONFIG_UML))
+		unflatten_device_tree();
+
 	pr_info("start of unittest - you will see error messages\n");
 	of_unittest_check_tree_linkage();
 	of_unittest_check_phandles();
-- 
2.20.1.791.gb4d0f1c61a-goog

