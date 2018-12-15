Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94D1C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3602080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyVK/tGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbeLOQqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:46:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36423 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbeLOQqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:46:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so7310736wrp.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 08:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wttd5IcbavuJLTFwliCvxc7KORKUsJL1vgZY0roGIwo=;
        b=fyVK/tGlhKQ6wmmeFmLgEBCzfIB01kYIJAN8uKgdXak/AVfsV1bqT7rnfzbAuD0mxy
         7/bLmDvL6gXRFAXx80Yy5PAttOtNgX6/+MSJpCNQAIrNdPXRWsc0TePM/FsDRzoxvlPn
         I1yGiUqYdFtPSAS6/8b0R18QLQwJMhEe10ndkks/r4OYSZSWTk5/49Df6+Nn3PgX9Fud
         /s3OFxDMXDftErYP2W6bWkjkNAAcagqmQTn8/XT+jMViewXUFp6VhPsJvAY/0QeTytb7
         lzb+moJYXJDQpvyXwGrzI/2bDIxGG+tNHR6JFI3kNoTxYohnLf0F+Xv0OEgldFR7tfEE
         zZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wttd5IcbavuJLTFwliCvxc7KORKUsJL1vgZY0roGIwo=;
        b=LpI0fJpS7HRaDTe6oR+H60ljusEe1R8lYHf1g7C1iBzlbSNoaDKEvWMYrt03wLeSp8
         ZSyln4yImnK9j8Zh+d1S9mHWyYKlZBfZxTevHKEqjPq9HzbiNQ5I3+WMVN/YPnp053ek
         uEXP7Cn8BLjpuFyFOo5vqLXiTY5aO2bt9vAA1Fw6cu6cHMIxiXmnTSOJq/F/NsxLYVMt
         wuWDewUhWeVUd75P5MsxJAKKokp/jZElSG1DSX3k0eZKkglQZycH7pCShd+RayxyZTeO
         r9A/ghE9dK26XSdc5FFvN+J105OQOPuXoWDm4qmJm56eh6B8mOwlWUPV5HKAL531CrH4
         ybXQ==
X-Gm-Message-State: AA+aEWaOAViWmQcpQQohl9zdgWEKni6oWuz61JKtvJxJTH4B/Ucw7026
        tTZ1JbZa1zAKKJdG/Zcourk=
X-Google-Smtp-Source: AFSGD/VyjUIO982WL7WfGXxxImc6BLjKBfQe5Eo4y0NdllCj1GwX68/cAEA8dWEBSU+pvR09bzDr0w==
X-Received: by 2002:a5d:480d:: with SMTP id l13mr6259545wrq.175.1544892394168;
        Sat, 15 Dec 2018 08:46:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i186sm8820935wmd.19.2018.12.15.08.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 08:46:33 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/9] staging: rtl8188eu: change return type of is_basicrate() to bool
Date:   Sat, 15 Dec 2018 17:46:14 +0100
Message-Id: <20181215164616.2643-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181215164616.2643-1-straube.linux@gmail.com>
References: <20181215164616.2643-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is_basicrate() returns true or false, so change the
return type from int to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index cbdb0fae8df8..d7553cc8b418 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -154,7 +154,7 @@ static unsigned char ratetbl_val_2wifirate(unsigned char rate)
 	}
 }
 
-static int is_basicrate(struct adapter *padapter, unsigned char rate)
+static bool is_basicrate(struct adapter *padapter, unsigned char rate)
 {
 	int i;
 	unsigned char val;
-- 
2.20.0

