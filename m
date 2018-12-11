Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59C0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACA520879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544774;
	bh=MzOpA+GqLe/yhoIycbPjUXtE3sBG5Y7ThFfBKkGbrKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y2r9Ya48Ju8TFKweK3VXtdk1v409ScHwO7rysEU2B7AjPtUY2HCbkqRmpS+ynAy38
	 BIgmqLk2oM/JV8Ctsdr590AlDDTLbvu2MCI8xtEzVW8F0Vg11VJ3kGjcUCivDjiGgS
	 lscC1Y8ZOIVYMKBtWRuV4j6kvjkw4+QsCB3JvlyI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACA520879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbeLKQMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:12:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728710AbeLKPuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:50:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D9972084E;
        Tue, 11 Dec 2018 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543412;
        bh=MzOpA+GqLe/yhoIycbPjUXtE3sBG5Y7ThFfBKkGbrKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zJ5bxyQ1NHig82Isb/qae2qMlAxsrfvMwFzBArKAbQFMLd5pDrkkJdawI0/4l4JF6
         VS/c4PciRaD7DvaETIvlnv89yxOidZBAo/NapJ3gup9Prb2Lu9bF26fSXJS5lGojqD
         FZaK3m5oNZHI7hSF8v+IR7YemI8/H8juLGbCGqu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Young Xiao <YangX92@hotmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4.9 41/51] staging: rtl8712: Fix possible buffer overrun
Date:   Tue, 11 Dec 2018 16:41:49 +0100
Message-Id: <20181211151617.382563819@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Young Xiao <YangX92@hotmail.com>

commit 300cd664865bed5d50ae0a42fb4e3a6f415e8a10 upstream.

In commit 8b7a13c3f404 ("staging: r8712u: Fix possible buffer
overrun") we fix a potential off by one by making the limit smaller.
The better fix is to make the buffer larger.  This makes it match up
with the similar code in other drivers.

Fixes: 8b7a13c3f404 ("staging: r8712u: Fix possible buffer overrun")
Signed-off-by: Young Xiao <YangX92@hotmail.com>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8712/mlme_linux.c   |    2 +-
 drivers/staging/rtl8712/rtl871x_mlme.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -158,7 +158,7 @@ void r8712_report_sec_ie(struct _adapter
 		p = buff;
 		p += sprintf(p, "ASSOCINFO(ReqIEs=");
 		len = sec_ie[1] + 2;
-		len =  (len < IW_CUSTOM_MAX) ? len : IW_CUSTOM_MAX - 1;
+		len =  (len < IW_CUSTOM_MAX) ? len : IW_CUSTOM_MAX;
 		for (i = 0; i < len; i++)
 			p += sprintf(p, "%02x", sec_ie[i]);
 		p += sprintf(p, ")");
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -1365,7 +1365,7 @@ sint r8712_restruct_sec_ie(struct _adapt
 		     u8 *out_ie, uint in_len)
 {
 	u8 authmode = 0, match;
-	u8 sec_ie[255], uncst_oui[4], bkup_ie[255];
+	u8 sec_ie[IW_CUSTOM_MAX], uncst_oui[4], bkup_ie[255];
 	u8 wpa_oui[4] = {0x0, 0x50, 0xf2, 0x01};
 	uint ielength, cnt, remove_cnt;
 	int iEntry;


