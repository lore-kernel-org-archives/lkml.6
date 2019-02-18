Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A125C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF28217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlPuPyf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391241AbfBRRXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:23:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41103 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391110AbfBRRW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:22:56 -0500
Received: by mail-qt1-f194.google.com with SMTP id v10so20023569qtp.8;
        Mon, 18 Feb 2019 09:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wnd0daOjkL1mxcba7BCdyMifBpTS8qKynRF6o0d3oE8=;
        b=rlPuPyf5SrZuZepi5oNcgzAN3HM0ltOeom+SFnIPr/y8soDL1hzJQbB7GcuYQc77Wf
         x4b6JsXUOwiaGQWepP5d3RLM7P1WKfk5rluhNGMiewuoX+uq7mkM1uDZLPPQDbKkTP1B
         CAtqooVE2PLkoLQyduqQQBczFGMoiSzCxnGJrRxApX8DrLzidFzFM6thNwsu1ixq0iLw
         bRboTiC22fcIrQorc6BRPHtW9GEQe8tJGmo3t/xKQWbrWIhZLF4H+pVgglqZscZlyQVb
         +S38vW+GVwTqjUfek8tAz6iEuubht2EBVVF7SuKL+CnRxFFe/jwu+yq3gDary8WpZsOb
         Pxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wnd0daOjkL1mxcba7BCdyMifBpTS8qKynRF6o0d3oE8=;
        b=RCyUFH5ynvF3nhP1m8C/EuZ9HXwaZPfVYz/WKB38BcrZWNd7Nd1jL0uqjjuDf/Ne4j
         rXgpSgQuaFqPkn6AesmfWQGlWloQ0e6/gL5GyXnFswzN5smG9dDwHBndEZjMpkCVn5/Z
         cUKl53bORfmyGm+fZ0WJulujtKkQVf4LvX4/2WSrSmTEHIrjdgaP3HNxOwh3B41hLC7p
         eZ6WzwjtpKHQHXMIswBNs9XDqRNXMSquFtuAQ9oD10KrP6PC3g96EbQwgxBeSDzZNey7
         wZv1LAD+dc8v6U4O5gm4PQ5O7234IrGHvSC9o75gxlksXnND//uKGdmQMay7y3FTC3PA
         sSKw==
X-Gm-Message-State: AHQUAuYm7iqivS/9X5PkeKk0AcSAzTiF/hkBLuvf8zHdoD+FzGJpxusF
        mAtE4OHG+GhWVH3NXOejVL8=
X-Google-Smtp-Source: AHgI3Ia9fr1hBOPYc5iEnc1+POqVGP4rCPzxI7bxXNEIfCNbFICz8W1jVtw69lfFY9szRdPPD2jJ3Q==
X-Received: by 2002:a0c:d1f4:: with SMTP id k49mr18582970qvh.164.1550510575386;
        Mon, 18 Feb 2019 09:22:55 -0800 (PST)
Received: from wall-e.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v18sm6525275qkj.13.2019.02.18.09.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 09:22:54 -0800 (PST)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
Subject: [PATCH 2/5] iio:potentiostat:lmp91000: insert braces around if arms
Date:   Mon, 18 Feb 2019 14:22:33 -0300
Message-Id: <20190218172236.7781-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
References: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Insert braces around all arms of if statement starting on line 214,
and solve these checkpath.el CHECKs:

- lmp91000.c:214: CHECK: braces {} should be used on all arms of this statement
- lmp91000.c:216: CHECK: Unbalanced braces around else statement

Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
---
 drivers/iio/potentiostat/lmp91000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 03d277621861..ca31be510940 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -211,9 +211,9 @@ static int lmp91000_read_config(struct lmp91000_data *data)
 
 	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
 	if (ret) {
-		if (of_property_read_bool(np, "ti,external-tia-resistor"))
+		if (of_property_read_bool(np, "ti,external-tia-resistor")) {
 			val = 0;
-		else {
+		} else {
 			dev_err(dev, "no ti,tia-gain-ohm defined");
 			return ret;
 		}
-- 
2.20.1

