Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC24C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831612184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BraoATOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfAWToL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:44:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43732 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfAWToK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:44:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so3889336wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 11:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L7E5s2faLUvFouJyNzWtK64dj/0fRKj9h4yiNMIbrZ4=;
        b=BraoATOQ0xC48uoV22t9n3l1wrqHy0d2h2LLfxAgBA79PZL0rCHYGEWgE0fULrzoGS
         tGkdaauyuoeECEPfPnBpbP+KRlfjB7do6yvO4weh598oOVDS++YQEVDRRMG322mHvh9M
         ONxhf/eFwNdTD/zXXyKMr2bFuvd35Iw2F4Rf3EaeEReCJunybmFrJhCJr2E5DXXxgeR7
         jEe3nfwzeta+Wlv9FrdPCybltmfrvfawmD+mvFFD9H2nNLGud85UKKxUaE0sbTh/Amwi
         fequp9ilPxmGMNHQqrgVvkH2QT3yxlkwvho13utxsYaAm2B5s4vqk0IfCR1b+W1KaeqT
         lfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=L7E5s2faLUvFouJyNzWtK64dj/0fRKj9h4yiNMIbrZ4=;
        b=cWcdceImrhKAeS1c4V3cmNSrVPK6qbCZ/OKyb7XJoICFAvZrTKqPtjPt84iQSJDCil
         u5yRyLnnlDdLOXTfGX6NwCIVvOevTq80cnSvAUBAMwDsBnB8C3zYBF5ky11vJg4ulSs+
         H+bxo/tThwnQ1zdxbZzOkj+agdTyd+R99OxSJRIyUWoBWVqnol8+Q0klosirUTlPw+T6
         WtI7ng66dbJ6j25DlN7VSMUsu5vZ5IoPOfVSIRkgtYaihlxaRlrSkCl6N1VJxwcd9Fxs
         U3iB4Z3gHfbHWl1dX1umxJD1fQ/vvzzlSZGvZcPcSQvffiTv+G0MYvLJiQOXSwRVdCfe
         K4bA==
X-Gm-Message-State: AJcUukf2EbLYgBqu2Yr/rY49/qX9juMMdhFYxfgyJggt5uZXmGI89BfB
        1C5uI9ejUCGa28pDXM8tXUgoS+MI
X-Google-Smtp-Source: ALg8bN5b4JcEXoM9jw3kaklngo5eQTdPBwxRXyANvUS2tMYOb/oeAhvLBYPONanSPQ24S1+MnbwJKA==
X-Received: by 2002:adf:9123:: with SMTP id j32mr4343262wrj.122.1548272648936;
        Wed, 23 Jan 2019 11:44:08 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id 67sm153033500wra.37.2019.01.23.11.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 11:43:36 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 329E0114246D; Wed, 23 Jan 2019 20:43:35 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: base: Use __printf markup to silence compiler
Date:   Wed, 23 Jan 2019 20:42:00 +0100
Message-Id: <20190123194200.19698-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence warnings (triggered at W=1) by adding relevant __printf
attributes.

  drivers/base/cpu.c:432:2: warning: function '__cpu_device_create' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/base/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index eb9443d5bae1..de74d7d93558 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -409,6 +409,7 @@ static void device_create_release(struct device *dev)
 	kfree(dev);
 }
 
+__printf(4, 0)
 static struct device *
 __cpu_device_create(struct device *parent, void *drvdata,
 		    const struct attribute_group **groups,
-- 
2.19.2

