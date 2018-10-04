Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C41C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FAD2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2ZZDXNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FAD2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJEAvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:51:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51325 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbeJEAvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:51:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so9831236wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wc92kr+YKmNGYeEmGzagpGhircm67o5iooia0Ykmwuk=;
        b=F2ZZDXNQZ+Nwb2v2x2zuYJpUw5O/qd9PhwtTJZ3IGhYXmp004CKqwttXpOtMo6nQfY
         JPH2cEP3+Q0rYC9V0jEfzU2YOdvOSx8gZV12OLUpS5B1jax/jz8mHmOs5hDpBEZRXuBy
         PzO18Uue20rJL6hasP5mPIFx1Dx78ItbcG41ksYSLBOKz5OAmMI6HwJ3ovR8PWU2xPUC
         VHlrz4eCor/38NsApMfKJZy3h9ONDAr3SC3ZbX0yqsoCvw6JyrLFgyDtevdmcxYphsJX
         oEUy15ag5JZa5Im80r2HtL6K3KYgVidQOtbB+KYr7ri1p/06F4qWg70s5QFEG3pxEi/c
         kavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wc92kr+YKmNGYeEmGzagpGhircm67o5iooia0Ykmwuk=;
        b=iuC9OXV3xBfxPnplMFfQlXFRZWXLXRvo24RFBK5lF7CTuMnYCTYp6DUfUBB6S4cdKR
         4Ho32UXhAxbW9Djht6kqGAZNCgOJK556teUA9TcPmrJqPM62xqh7SEmBwqlpt6Iieqln
         Qd73whU5QZKnW+kQ0BeH2cByZDO8A7TdskSl5lWRTgv1njLOc0GNYnv6nIZ+Rkf00vI2
         PUb2BFDcD1U6oAHZaqfV5BJxoSsH2vJn/gh77qZF17DDURGaVK+PPaK1XTbWkWTj/kRE
         6jQ7IauWjhvDy0nB+vKwYGwy7VDt62ufQf0wSd9Ox7I59eT1cKXIpQ9NOhYeO9bQTReK
         tBnA==
X-Gm-Message-State: ABuFfogvXEr0p+ITE9VVJQdfuDTEHm5DdxYTwU6xeVDEbNktV2sJXm4S
        R7llbD2aUiin0m4d1JEVJ40=
X-Google-Smtp-Source: ACcGV63i5+o40xehD8cEjWGUWzf5iIIT4yHFjTtrdu8C23bOgoaj2shSLfkiZFEXdomoD/Dr04FPrQ==
X-Received: by 2002:a7b:c08c:: with SMTP id r12-v6mr1981644wmh.108.1538675839432;
        Thu, 04 Oct 2018 10:57:19 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa7d.dynamic.kabel-deutschland.de. [31.18.250.125])
        by smtp.gmail.com with ESMTPSA id o63-v6sm3697353wmd.3.2018.10.04.10.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 10:57:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: rtl8188eu: make struct field of action_handler const
Date:   Thu,  4 Oct 2018 19:56:59 +0200
Message-Id: <20181004175700.1500-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004175700.1500-1-straube.linux@gmail.com>
References: <20181004175700.1500-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strings in the use of struct action_handler are constant.
Change the type of field str from 'char *' to 'const char *'.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 3e8a0ab46ff2..38911a7daa95 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -238,7 +238,7 @@ struct mlme_handler {
 
 struct action_handler {
 	unsigned int   num;
-	char *str;
+	const char *str;
 	unsigned int (*func)(struct adapter *adapt, struct recv_frame *frame);
 };
 
-- 
2.19.0

