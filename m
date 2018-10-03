Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F9DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16BE213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIEVLzFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16BE213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJDDeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 23:34:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34779 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbeJDDeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 23:34:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id z25-v6so97911wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9d03DAjZEiRbR3EO/AqAjeNz6X6Q4J6q+tx+ixFvMIM=;
        b=IIEVLzFDdO38pyfhiWyvePeV9Z8ND7T85e93HbSIkRiEhEh/U2QfyEjoFyvKb4W9eF
         PlU/Sa7FUWt5+h4gWQFn8YYFeWEwTCfh4k7yG5CPWPxsTJIo5YKm6oEtDFGTwMBvwbPO
         YIRTKW+ItcYzfxE+tXvw4qbrx3DpW2EM56NMydpQLL01/ertHACzy4USCJwxJV4qS/os
         4XY5PkT/xGzbnLJj1K9dbXte67X/hBFjnZCUuoRcnVO4CjQqoWjGVHfV+N087Tbrluhy
         zGmbHCc1hDq9h9sclvAmRPVl3sReEQmk4KBIkVbTk5FoGhxle2RsLJgCuAb2ZtFH1ipT
         5hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9d03DAjZEiRbR3EO/AqAjeNz6X6Q4J6q+tx+ixFvMIM=;
        b=twBSEmmoIGSno2T5YpnalQL4z6uRsOeiBRwsJukF3zZXpAUfjVdDj1TcMsEVSBASfV
         EIto9Hc0khH4WRLdNE19GYu1cW98r5bfs6B8S998CeNsw/qpR5oFSSAHiQk9v3VAtOwf
         Yi5Kcvme2Br1CTP7CnNmBr565q1O6KO3M4xGqDGcJalewYmuofUON9yrvnXL/HFEkBNk
         nhXXc+S8QjWdBV6PFotojMi/ttVa+ocLtUgtu4Q3LdSudTG4rYKUpl+7r+mvTMeWao6X
         cxh0qhDpOaUf2dyjagqi/4B2VlMogvu6wJg8kb+zhpM0KfQzTKBh5oqk6eRyzBZLtTRB
         +5+Q==
X-Gm-Message-State: ABuFfogQpOV2QGbyljNcYmAEdyOSYH2Y+iof20DH4pDZWY4FPjGWNwyQ
        Rdn5RYHOjcZ+wfPK33Y6UuE=
X-Google-Smtp-Source: ACcGV63CYk2hN+BoLnb36D5FJSHDCh1z/U14bmgCC0aYnaWhgTvBltrn8Eym6dPVszD097hS/SXZKg==
X-Received: by 2002:a1c:8181:: with SMTP id c123-v6mr2489833wmd.3.1538599445770;
        Wed, 03 Oct 2018 13:44:05 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd55.dynamic.kabel-deutschland.de. [31.18.253.85])
        by smtp.gmail.com with ESMTPSA id h18-v6sm2242235wrb.82.2018.10.03.13.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 13:44:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8188eu: fix line over 80 characters - style
Date:   Wed,  3 Oct 2018 22:43:57 +0200
Message-Id: <20181003204359.30676-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line break array declaration to clear a 'line over 80 characters'
checkpatch warning. For consistency replace 0x0 with 0x00.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 4d55bbdf8fb7..f6171f07599d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -39,7 +39,10 @@ extern unsigned char REALTEK_96B_IE[];
 /********************************************************
 MCS rate definitions
 *********************************************************/
-unsigned char	MCS_rate_1R[16] = {0xff, 0x00, 0x0, 0x0, 0x01, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0};
+unsigned char MCS_rate_1R[16] = {
+	0xff, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
 
 /********************************************************
 ChannelPlan definitions
-- 
2.19.0

