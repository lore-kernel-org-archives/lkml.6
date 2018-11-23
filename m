Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB8EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B26A20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7JJWLPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B26A20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeKXH1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:27:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33449 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbeKXH1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:27:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so7796479wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 12:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ayl57y57txfnJnVTIfh4Y1jm17Inqx5LntnG3yRMBh0=;
        b=s7JJWLPpZ/w5ADKqfRXBUqKhxl4rcTaSxIzTpmJS/QB3gnxgXBtQtFujbTCnvWMdeV
         9Y6BLAdaGn6bk0qlRd/V8Rr3ogVRjbGFwylGdoi00TOA+xj/bXARxaGgpuGS8dCXryv7
         f4VIJYv5gInRNAf1rYsYd/9wLtfTFHyWRvCYWQr/WCQJBVVQ5n8z34QRAiHJWiU+tu5r
         aLR0PAkgApm+ogZ04LhxTcklG/O2sNqcv9yZ84X+4bsCpsl8slXrxBpSnWsVNCSuHvTo
         DaSzbcoPrgLagChbFt7XDNNtnA2UfV8KYOV5tgSj0KuSWFYOz1K12VRrrjvOKW7CUHgO
         CZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ayl57y57txfnJnVTIfh4Y1jm17Inqx5LntnG3yRMBh0=;
        b=ObbykJUnHs9W4uJIm0657YcAO8ROJv9rlPLdtn1ssSHom/WZTWymxOhW9YBOjHuW2p
         snhLbL2RSP5maSzfryE6bgXnmABDNq7h9zq0NkDTS0MqfoFfFqitgkEM9Da3nJ+vXumG
         vkcv7OXo4QpcKn1e08kzRkhunaSyDpJtT5uB44VbPV4E4sQnhXPqeQOZaigAWgfcajcy
         K7dzMnq1uMRMBWYl5gxkxMoJk+4RXAo/sc8UQ533jof3uw1xMexPFQBZeBp7XfxQyDom
         KBrToyIvhQhh/86DGQSb2BiZkAtmM6F232PqIR0OCS4ngWJDeZ/wWW13ZXe3K0mBgXdl
         SNGQ==
X-Gm-Message-State: AA+aEWaNLvy6ZQSmyAbwtROzmrj1FYpepD044M9y9//M+p0KHgGsT19/
        qJQ2MKMPYn5Dvli6Hx+XRxEhxAjr
X-Google-Smtp-Source: AFSGD/USP8bvrHf3PE9W6XM1NbWVtJBILBxer64uw1BOXUjt6JaBdZfPO6vJ7lL6LzcO5UqNUmKxkQ==
X-Received: by 2002:adf:9205:: with SMTP id 5mr4677939wrj.189.1543005681116;
        Fri, 23 Nov 2018 12:41:21 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i9sm24598906wrs.34.2018.11.23.12.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 12:41:20 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/9] staging: rtl8188eu: remove rtw_android_set_block()
Date:   Fri, 23 Nov 2018 21:41:01 +0100
Message-Id: <20181123204106.2284-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181123204106.2284-1-straube.linux@gmail.com>
References: <20181123204106.2284-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_android_set_block() just returns zero. The only user
is the function rtw_android_priv_cmd(). The variable bytes_written is
initialized to zero and not changed before the use of
rtw_android_set_block(). Remove rtw_android_set_block() and it's only
use.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/rtw_android.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/rtw_android.c b/drivers/staging/rtl8188eu/os_dep/rtw_android.c
index 34080c0ce14a..2ea2af3286bc 100644
--- a/drivers/staging/rtl8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/rtl8188eu/os_dep/rtw_android.c
@@ -127,12 +127,6 @@ static int android_get_p2p_addr(struct net_device *net, char *command,
 	return ETH_ALEN;
 }
 
-static int rtw_android_set_block(struct net_device *net, char *command,
-				 int total_len)
-{
-	return 0;
-}
-
 int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 {
 	int ret = 0;
@@ -186,8 +180,6 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 							priv_cmd.total_len);
 		break;
 	case ANDROID_WIFI_CMD_BLOCK:
-		bytes_written = rtw_android_set_block(net, command,
-						      priv_cmd.total_len);
 		break;
 	case ANDROID_WIFI_CMD_RXFILTER_START:
 		break;
-- 
2.19.2

