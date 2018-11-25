Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC23C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54132086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqTSXYBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54132086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeKZDMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 22:12:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38626 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeKZDMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 22:12:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so5010125pgc.5;
        Sun, 25 Nov 2018 08:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Omlkkwv0msPmZtThXMkJDsvh3cmK0KZre5FygCF5oVA=;
        b=lqTSXYBDM3nVfEuliT1hheT5MGrh4hTc1uK718BM1aWQpIeONRz9c+NQluhCE5Y3kN
         upjcf3t6u/mmkSuYQCbPZQFaHWEBTybRTdsbB6hjehIkZp8YONBeboUkuqjHvoisQGB9
         dz5hl2J6KXdjqz39Bn8ib5Jd9OHzdJiCuYTb+Z9ULYUisL/WjhS4827AqgBQ6efD00IX
         q+REItCL1IOGm1KCMPd/Rkm8C0uHiVuP0qAjAqahR9n6q8qavaFy7QYbnbtIKewhFBXM
         MBkwvSseWExhYsDeUtFGd/oDpy9AXumnsS8Tzp0fidFY7QqFZ7YCqMS4Yi9lgQQLSnhk
         ivmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Omlkkwv0msPmZtThXMkJDsvh3cmK0KZre5FygCF5oVA=;
        b=c+Hf9ER+GQjjAl9e+9J46HSemFpHKpLe4TUyoaqxnIVSlTVz1regfQiNDB0x/m4z8a
         QjlLGHGgN6GiYhdHleUXaAWGd16SEXvOPQpkaY3pYPZ+g8eXOlFEr4MNupQxpv/kHRmD
         oFqtPrirQ/ir/3HRQY2vFkt3+6N4SQNmZhBY5iSvCGGILe+9Q2LSbLmMbg+K3ZDyy7pj
         vd54XIdgv2SLmqNIRXJM3ePtUsBCHjIufhnOGHGzz6omminfCsqsKwq6J3aL6Vb22Bzj
         UM+BzE9A8dQH8nqh+VAsDuGxkG6rLUu8JHTc2a6XFBI6CbvpTC/U5kPXbKmjq6gFXjT7
         vptQ==
X-Gm-Message-State: AGRZ1gIRQejPYrATkP8ZDe9psJ0jORLgDKAWJ+E1qCPRul2kH0FUnp3w
        LtXZwzA41XQSrVt1QYBCbOA=
X-Google-Smtp-Source: AJdET5ciYiampuBjjEcVYaTQGagu+wjsA6VHFu5dMyVjTlj1Xtn2vreUdqcqlusZNdRHJNK/uuSudQ==
X-Received: by 2002:a63:7d06:: with SMTP id y6mr21319483pgc.171.1543162885225;
        Sun, 25 Nov 2018 08:21:25 -0800 (PST)
Received: from arx-s1 ([116.238.148.251])
        by smtp.gmail.com with ESMTPSA id o189sm44994655pfg.117.2018.11.25.08.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 08:21:24 -0800 (PST)
Date:   Mon, 26 Nov 2018 00:21:18 +0800
From:   Hao Zhang <hao5781286@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, thierry.reding@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com,
        hao5781286@gmail.com
Subject: [PATCH v3 4/6] DEV: CLK: add function to check the using clock name
 of driver.
Message-ID: <20181125162118.GA5358@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some situation we want to check clock whether is we want
and after the driver been probed use to change different clock source.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 drivers/clk/clk.c            | 6 ++++++
 include/linux/clk-provider.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d31055a..3d2c2cd 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3466,6 +3466,12 @@ static int devm_clk_hw_match(struct device *dev, void *res, void *data)
 	return hw == data;
 }
 
+bool devm_clk_name_match(struct clk *clk, const char *string)
+{
+	return match_string(&clk->con_id, 1, string) == 0;
+}
+EXPORT_SYMBOL_GPL(devm_clk_name_match);
+
 /**
  * devm_clk_unregister - resource managed clk_unregister()
  * @clk: clock to unregister
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 08b1aa7..5cd2eed 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -764,6 +764,7 @@ struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw);
 int __must_check clk_hw_register(struct device *dev, struct clk_hw *hw);
 int __must_check devm_clk_hw_register(struct device *dev, struct clk_hw *hw);
 
+bool devm_clk_name_match(struct clk *clk, const char *string);
 void clk_unregister(struct clk *clk);
 void devm_clk_unregister(struct device *dev, struct clk *clk);
 
-- 
2.7.4

