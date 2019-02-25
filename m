Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34221C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C6B20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131071;
	bh=pt2eVn4DAC3st1eCzDVNBXXjr6JgPC2dOoEVMlQ8YEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=casV8CIQ6s4GjfT7Qhjhj99QJ7Tbpi1pRSeRm9OtijcAsa1N5DNcXmCsSQo+EFX0z
	 t6fVcDCF3yldsok1wyNpPutUVCzNj0RbnlnPilqqWXFRm94By/kbKvnvFzWNlC7SM1
	 ewuRSOsk9WItJNyjyPK3H7y7ATKGnDEBMVcUkkUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbfBYVaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:30:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731402AbfBYVaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:30:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF6CA21841;
        Mon, 25 Feb 2019 21:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130211;
        bh=pt2eVn4DAC3st1eCzDVNBXXjr6JgPC2dOoEVMlQ8YEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5siFJhGcSzJ+EGAx89YcKRNi35Rsuozf5HrjXUuATWcQr6n/KxzIoeIiEWtr8Opl
         7zaZ3+eAR2b3naU+4vPGttgvoDKP1sj+Sy9/Mtg5JJ4vDnun93GS7ljYC9myLbagyU
         l/JkthYbFo7kJIlsDk3REiSHL7OMN65bwYSBddvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Cook <mcook@mackal.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 048/183] hwmon: (nct6775) Enable IO mapping for NCT6797D and NCT6798D
Date:   Mon, 25 Feb 2019 22:10:21 +0100
Message-Id: <20190225195102.663524572@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9de15c95a63f527c8f7a968cd95e6ec71fc6891d ]

Similar to other recent chips from Nuvoton, IO mapping may be disabled
by default. Enable it when instantiating the driver and after resume.

Fixes: 0599682b826f ("hwmon: (nct6775) Add support for NCT6798D")
Fixes: e41da286a2fd ("hwmon: (nct6775) Add support for NCT6797D")
Reported-by: Michael Cook <mcook@mackal.net>
Cc: Michael Cook <mcook@mackal.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 8f91e366866f3..4adec4ab7d066 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -4508,7 +4508,8 @@ static int __maybe_unused nct6775_resume(struct device *dev)
 
 	if (data->kind == nct6791 || data->kind == nct6792 ||
 	    data->kind == nct6793 || data->kind == nct6795 ||
-	    data->kind == nct6796)
+	    data->kind == nct6796 || data->kind == nct6797 ||
+	    data->kind == nct6798)
 		nct6791_enable_io_mapping(sioreg);
 
 	superio_exit(sioreg);
@@ -4644,7 +4645,8 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 
 	if (sio_data->kind == nct6791 || sio_data->kind == nct6792 ||
 	    sio_data->kind == nct6793 || sio_data->kind == nct6795 ||
-	    sio_data->kind == nct6796)
+	    sio_data->kind == nct6796 || sio_data->kind == nct6797 ||
+	    sio_data->kind == nct6798)
 		nct6791_enable_io_mapping(sioaddr);
 
 	superio_exit(sioaddr);
-- 
2.19.1



