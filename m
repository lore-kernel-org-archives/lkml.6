Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A3FC282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F46C217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVXK9NF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfA1JwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:52:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35861 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfA1JwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:52:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so17266194wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 01:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8GMmZ9+WoCt1uUw+HZunc65T6fBcrY7Ya4IL60Ec2D4=;
        b=BVXK9NF0Z24bDUJZpaoNvmOcP0GVpMIVfsn/0y8Wt/Goue2L2rnmYnUhBTEMtN8wnC
         w5nv9rZYS5KmKQz27x+YfYs+LbMwTbRZ+YKFKKwOPialzoJ7KZPnGu1mU+yOQFaFNWjK
         xqwVeNMTeUoZkWDTK07AGGBuJftQd8baWYvJOrtFyCbaOpaNuR+fEh//shESfv2pUtGA
         FvhRm0ppSA/DW3Ay70xfWaIL/M2ujjnWZGW05QtGuGEVPTUilvoAeZ73LyNYqfqLzzrR
         OjHKxETXzsx+eB52CfCCTG04umrOYUiwDskLuUNr3uBen1It4HOUCKsYmUUw38QoEHgS
         IlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8GMmZ9+WoCt1uUw+HZunc65T6fBcrY7Ya4IL60Ec2D4=;
        b=DFghUCxAaeSNDh69GtHGaUk8+8kWXFsPJPxpA22uZlH0Gq8Q1ai5kUtuSSV6PGWX5J
         Z3qU5t9E1q9T6jjqa4f7sFx7mIzJxDWouz4Yw38ja/KpgG9l0eOzud1cPsxoYwKs/rHi
         rxPcgt5XW+TOp/+q2+mhixyfPp43lOLHxC9N7khX6+G9l3J+CM9A77ArCyeqpRB2ROIy
         HO9PGTTXKAM/nyVbkO+WCcKs0RyFNDIZ8wXe7rquCiI8V0NLso71ecAgpD6ZGEU4vYVe
         FBVyoq/6sZEoGHXGwcD3CZU7vYo0+3RPvx3FCyU/sMuhImSZZMQAHs2CyCeOb+1P5GmV
         HYtQ==
X-Gm-Message-State: AJcUukdhYO+xavi2DH1LE6V2BwYNb7Qj+/lYKmQ0kNlBtzpJ+B8HeiNZ
        1qAyTyTVoB0laI5Pj5uq8Kk=
X-Google-Smtp-Source: ALg8bN77rsjp5N2phuFvAYqfirJIkRlxs7VOlCnwNcD4BsoOe3aqzREqZWSf1uMS6AlMXxjmBYXJTg==
X-Received: by 2002:adf:c7cc:: with SMTP id y12mr21634881wrg.52.1548669122826;
        Mon, 28 Jan 2019 01:52:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id a18sm139023711wrp.13.2019.01.28.01.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 01:52:01 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: rtl8188eu: remove unncessary asignment to cleanup long line
Date:   Mon, 28 Jan 2019 10:51:35 +0100
Message-Id: <20190128095137.26815-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128095137.26815-1-straube.linux@gmail.com>
References: <20190128095137.26815-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of first asign 'wrqu.data.length = p - buff' use 'p - buff'
directly in min_t() in the subsequent asignment. Clears a line over
80 characters checkpatch warning.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
index 142f8f9f6b1a..03d4cfefc9bc 100644
--- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
@@ -109,8 +109,7 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 			p += sprintf(p, "%02x", sec_ie[i]);
 		p += sprintf(p, ")");
 		memset(&wrqu, 0, sizeof(wrqu));
-		wrqu.data.length = p - buff;
-		wrqu.data.length = min_t(__u16, wrqu.data.length, IW_CUSTOM_MAX);
+		wrqu.data.length = min_t(__u16, p - buff, IW_CUSTOM_MAX);
 		wireless_send_event(adapter->pnetdev, IWEVCUSTOM, &wrqu, buff);
 		kfree(buff);
 	}
-- 
2.20.1

