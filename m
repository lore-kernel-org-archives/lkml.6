Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEBAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282E02192C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="MwJJHV8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392895AbeLVW6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 17:58:37 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:44050 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbeLVW6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 17:58:37 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 08941D2B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 22:58:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s33XaaZQiY2u for <linux-kernel@vger.kernel.org>;
        Sat, 22 Dec 2018 16:58:34 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id D4936D1C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 16:58:34 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id s3so3205268iob.15
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 14:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+RVLtFgkh5Z2l283ufY+/nPShMplXQB5Pc5K0Ma2aeo=;
        b=MwJJHV8kD5gHklvmEwziMSx6uKiwKj/qkmgIeYONzWwWqERKrQyLKmgggvYe+pAYrT
         lge57nXf9M9BfAjWQbY+fDA4fSMU5jAqF9Nx5jmSvYwnxxGADeZbjW6GTtigwG8QARpd
         Y471jATTQNlJ+xUQyqo8WHo7SnQ9/l6lyYrPEJ1Qyx74c8T6LgVqTfJiaYm1XI3+Bgd/
         QL5CUyWGlYQxwcRS/AMOdkmZtoCQJFEuiKAsd5obMxzLGR1pQ290RKS8VNZYuL2RlMGZ
         iAGAW15i8beBsp3lO1gujOVo1vj4aBE1qroaxcZYOah4VMgGrFl6W/U2UR0boadtVO3b
         YHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+RVLtFgkh5Z2l283ufY+/nPShMplXQB5Pc5K0Ma2aeo=;
        b=VN4rrdWo/u8xsUkzcS/jf66b5esOMx+p3u0hYd4MSZfqhlv5TtGTj0pJa/UHpnilFy
         wcOwyUNXc2jqGUZwL8czWqtn4/NjRju/nQYVBbk4zeM1GYOPrHHcPaYeOFBLcSKKd9xP
         E+M2dXGZG0aIiLy5bPqemKcQ5pvdudrQ2f3cwZjTYbYjaa0FQmTle1YDAqtzLdA7PqS2
         oBzrItzAosctbrK4DxRatM14+XRLUnTOadv0G29Tnvdy4y+DS+LVOasS3oLaLzkAmDzk
         Cl0PeIVSsGO1okSulQIWvCuoUhoRo/3ynYd12uvSRWX+9DWbFgyUsSleibkZa0TqBCa6
         KSTw==
X-Gm-Message-State: AA+aEWbKHnBN+wjYngzwovxcHmt+tMa3zv+x7zeaLo+VdjzVejyqCxWY
        kLXUBx2vVena3wRKVYGJwc9ThLlS5AmlJ6yvhG4HgFbyi2gGnhXAZypuIH/bbB3fjSOP8HbXV79
        XcslUFDKnDsBVdnBN2Ungm7l9IE7K
X-Received: by 2002:a24:4507:: with SMTP id y7mr5504020ita.134.1545519514439;
        Sat, 22 Dec 2018 14:58:34 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UXTjf3GPPR1S1K3Cn27hh5gkMuumGwDrdeYZQNVCoTxWud3gbEMorowWxzYqUt6+thXhwe3A==
X-Received: by 2002:a24:4507:: with SMTP id y7mr5504012ita.134.1545519514180;
        Sat, 22 Dec 2018 14:58:34 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-23.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.23])
        by smtp.gmail.com with ESMTPSA id p19sm11394427itp.13.2018.12.22.14.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Dec 2018 14:58:33 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtlwifi: rtl8822b: fix a missing check of alloc_skb
Date:   Sat, 22 Dec 2018 16:58:06 -0600
Message-Id: <20181222225809.63015-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__netdev_alloc_skb() return NULl when it fails. skb_put() further uses
it even when the allocation fails, leading to NULL pointer dereference.
The fix inserts a check for the return value of __netdev_alloc_skb().

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/staging/rtlwifi/rtl8822be/fw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtlwifi/rtl8822be/fw.c b/drivers/staging/rtlwifi/rtl8822be/fw.c
index a40396614814..f061dd1382aa 100644
--- a/drivers/staging/rtlwifi/rtl8822be/fw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/fw.c
@@ -486,6 +486,8 @@ bool rtl8822b_halmac_cb_write_data_h2c(struct rtl_priv *rtlpriv, u8 *buf,
 
 	/* without GFP_DMA, pci_map_single() may not work */
 	skb = __netdev_alloc_skb(NULL, size, GFP_ATOMIC | GFP_DMA);
+	if (!skb)
+		return false;
 	memcpy((u8 *)skb_put(skb, size), buf, size);
 
 	return _rtl8822be_send_bcn_or_cmd_packet(rtlpriv->hw, skb, H2C_QUEUE);
-- 
2.17.2 (Apple Git-113)

