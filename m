Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DCFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A3421901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499625;
	bh=HRhRoVjiY4AXeOpYYTolFQDU065PZfqg5msLWtyTeqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bonq7YXFdyVLpO9z4BuYHTXStYdUktHLBK16LU5um7kfH7dJUb0OE1G70S/Bd3gzb
	 i8l9/vWQ6HDGteaf/rqVEiL7QHfFXvYE37Xf4S5KEI2EEakkzCmIOsF2KNKhEluoHO
	 tMK/apgpPHhC4+hgeW25Wuq1mQzSwPYsqv/xQt/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391229AbfBROUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:20:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390699AbfBROHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:07:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 761DA204FD;
        Mon, 18 Feb 2019 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498855;
        bh=HRhRoVjiY4AXeOpYYTolFQDU065PZfqg5msLWtyTeqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZZA2BbOGuoDjdepVfj67ES/iJ3cry67kk+aYZ74KHg0saMGJPr83cAYgaK38H6Nm
         hBgtrG7mPRkI1YHrwDM5/yyKxnAwDAx4LbPyZVDzOzbJsTYumeQKaMVRwMmPWXtajm
         W2XoBaLvoWPpy7JVFZdYYUbsI/D9ks2IUa/MF2R4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 125/143] Revert "Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G"
Date:   Mon, 18 Feb 2019 14:44:13 +0100
Message-Id: <20190218133533.566749166@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit f420c54e4b12c1361c6ed313002ee7bd7ac58362 upstream.

This reverts commit 7db54c89f0b30a101584e09d3729144e6170059d as it
breaks Acer Aspire V-371 and other devices. According to Elan:

"Acer Aspire F5-573G is MS Precision touchpad which should use hid
 multitouch driver. ELAN0501 should not be added in elan_i2c."

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202503
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1240,7 +1240,6 @@ MODULE_DEVICE_TABLE(i2c, elan_id);
 static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0000", 0 },
 	{ "ELAN0100", 0 },
-	{ "ELAN0501", 0 },
 	{ "ELAN0600", 0 },
 	{ "ELAN0602", 0 },
 	{ "ELAN0605", 0 },


