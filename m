Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F910C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234A920820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRxTM6Ty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234A920820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437150AbeKWAcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:32:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55236 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405603AbeKWAcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:32:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so9087596wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 05:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KAeCve5jIhvAStRIDsLqjy03AqF3P4Hb1pLKUNC+ZHY=;
        b=YRxTM6Ty62LFQx98B7gTCq2kdOrdN+V0cCBhCDHcMqtM0pWnvptevV97bec5hyM/Cl
         zeijOr1VpOT5uV/e1GP5wmiloNBWwJghkixwTAFMg3kEdBZGZ/32tPfVx75H68a7PBFP
         AwJjnWonwM4XNBFDaLSDvzS/+5xpx5B4JrIR5V99DopqmJ9jsW1sYV3Qq3qkM/zdu9o6
         IcanZdCfqlwCifSVSyQywsVbIRpXBEN5ypI+zClBqk8gaaXvc5anEADxBpO66yPyI/QM
         Nn6VwUkDTtjGJ7ZxTfC3ymnYYS+Q4L8o2stvCpNFXKEBXIypb54nzBy5dDK9IIWRXGeh
         BgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAeCve5jIhvAStRIDsLqjy03AqF3P4Hb1pLKUNC+ZHY=;
        b=aJzUSns7/LSy9B1V7+kvSWBPpE58kJ+R21/37Lefh9KoaAT3AjL3B7h+kjua4Y1j9F
         Z5FZGUDZHdkrn9fncslaX9kKzq3fzW6P3l6J7Cq2EOakSYS4UXVKBzzby5kCdaVQvcws
         GKi0OYn2v/G/l3yA/yJWWrTogAuDGEQf9NeJnKgARKZ+/oJ98ui+fU46D9moH55wpmbs
         0U28F4R6KiO8WCY2HTcUeiaJBHRfpWbo2nisiH2xz4K5D6By3gr5GHZSun0RiZ63uq6T
         zdLKdSdjCUmSPI3X+mmt9qExbSk90ZbJcnZK+T5tmJhz+l1bSeXSpP6e70pLbpqalQQb
         0NYQ==
X-Gm-Message-State: AGRZ1gLlOwr/4VZSQHQfnElG6KPUh+BFlYlt287U/z8wDD6z5j6USF4u
        mkk48xI7SwKKMD5gBfgm6E9+T2XS
X-Google-Smtp-Source: AFSGD/XPffp6XJcoybYRMRyDdIldKO69bg83vNDLIP0TtrLOmu5peE85g3/QGAv8XEOYMGEl51yP4g==
X-Received: by 2002:a1c:27c5:: with SMTP id n188-v6mr10120570wmn.88.1542894754422;
        Thu, 22 Nov 2018 05:52:34 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id c188-v6sm2393285wma.39.2018.11.22.05.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:52:33 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/8] staging: rtl8188eu: remove braces from single if else statement
Date:   Thu, 22 Nov 2018 14:52:13 +0100
Message-Id: <20181122135218.1703-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122135218.1703-1-straube.linux@gmail.com>
References: <20181122135218.1703-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove braces from single line if else statement.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index d792301a5ac2..5a41766bba68 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -259,11 +259,10 @@ static int usbctrl_vendorreq(struct adapter *adapt, u8 request, u16 value, u16 i
 				len, status, *(u32 *)pdata, vendorreq_times);
 
 			if (status < 0) {
-				if (status == (-ESHUTDOWN) || status == -ENODEV) {
+				if (status == (-ESHUTDOWN) || status == -ENODEV)
 					adapt->bSurpriseRemoved = true;
-				} else {
+				else
 					adapt->HalData->srestpriv.Wifi_Error_Status = USB_VEN_REQ_CMD_FAIL;
-				}
 			} else { /*  status != len && status >= 0 */
 				if (status > 0) {
 					if (requesttype == 0x01) {
-- 
2.19.1

