Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AE9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A5F20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRnHqeTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A5F20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbeGZOrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:47:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52007 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbeGZOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:47:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so1998465wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 06:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DHPSRW0sf4DJlg4JkK+EnUCg+YfXWzUOE1zsfrYiRcc=;
        b=FRnHqeTYbpxO3c/h330jF1KKzQEhJL6ggAE6zE799ehLyLYTQqzbXLWscplmuicH0f
         HqZxvd+fCa56kQUJ5mzijKNzUZeF1cmWbkAuVreBiQtiVbiYj4Iy4QZ/6ulH7+/Fb+dE
         7TG87be/ozyhd+4b0GvWvGVUkmooDWY20KxgdnELq3uSZnztoyQpr2oXNvvzhw0WOmLX
         Dj6ZnB1iV0SnxRpD6aFXYTEx4ncytGffmSyHN4cb6G5Ca8+JQ56hMYqR04UCi/8wnLi0
         nGEcqS/lA84CStKhEabmdrVi2m/zT1oB3ctt1N/Be7LWacRLsg64CwtERFcrNEy9tDkU
         2XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DHPSRW0sf4DJlg4JkK+EnUCg+YfXWzUOE1zsfrYiRcc=;
        b=dBhclXUKIaUsLOkE02ylJc/VF+0j2xPCNrW9KH6+w24iuYBQT6FM+pSVL9PburRNJv
         TXhSZWE5Gsd7MeV/mCx0HRhE7gEzEnLPTmUOLNgKcKWmTML+mpp/a2R/MN8bbexMVtXk
         PDfn2IdnKBrZeGFnOiMiWp80n6pvOS6LxeGRtpZ9nloaCFEc1kuGPZFxHhIPldWFAa6s
         VWzs2mZLflsaCnrTOI/714nuxlTMjmZva7kjeXn9Q0d2uRl0x4kolxc1MHXKGDLCu3WC
         17PFkgEwmklcESj4IgEa/5M9dOMmr4Wok583c58yagZTLOtBRZBFRogbwBdqnBWB9qBo
         Jcyw==
X-Gm-Message-State: AOUpUlELiFyeSAnDqBVRaVczG1ntKG9qql1tpj7tuiN5zfMuM4uDMhy2
        VBx8mXZwgFeej+FCfn5Axeo=
X-Google-Smtp-Source: AAOMgpeNhWPPJ+SvVdoYUz1XrNS0K2Meu4s7YszWai/+C4oGriNhYI461XQvARAm/4pePmQyCKfAGg==
X-Received: by 2002:a1c:d6cf:: with SMTP id n198-v6mr1655273wmg.61.1532611827412;
        Thu, 26 Jul 2018 06:30:27 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id j8-v6sm2126641wru.41.2018.07.26.06.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 06:30:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 9214A6407E7;
        Thu, 26 Jul 2018 16:30:25 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uSpPi7S0SeF5; Thu, 26 Jul 2018 16:30:20 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id E7C536408C7; Thu, 26 Jul 2018 16:30:18 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Staging: octeon-usb: Change coding style of CVMX_WAIT_FOR_FIELD32 marco.
Date:   Thu, 26 Jul 2018 16:30:08 +0300
Message-Id: <37553f45bfb34de4b0af476286b1b782ea834963.1532610629.git.tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1532610629.git.tsotsos@gmail.com>
References: <cover.1532610629.git.tsotsos@gmail.com>
In-Reply-To: <cover.1532610629.git.tsotsos@gmail.com>
References: <cover.1532610629.git.tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing coding style for CVMX_WAIT_FOR_FIELD32 was confusing. Also
encapsulates into parentheses timeout_usec.

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 44 +++++++++++++++++----------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cff5e790b196..c8e0ebf1434f 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -378,27 +378,29 @@ struct octeon_hcd {
 };
 
 /* This macro spins on a register waiting for it to reach a condition. */
-#define CVMX_WAIT_FOR_FIELD32(address, _union, cond, timeout_usec)	    \
-	({int result;							    \
-	do {								    \
-		u64 done = cvmx_get_cycle() + (u64)timeout_usec *	    \
-			   octeon_get_clock_rate() / 1000000;		    \
-		union _union c;						    \
-									    \
-		while (1) {						    \
-			c.u32 = cvmx_usb_read_csr32(usb, address);	    \
-									    \
-			if (cond) {					    \
-				result = 0;				    \
-				break;					    \
-			} else if (cvmx_get_cycle() > done) {		    \
-				result = -1;				    \
-				break;					    \
-			} else						    \
-				__delay(100);				    \
-		}							    \
-	} while (0);							    \
-	result; })
+#define CVMX_WAIT_FOR_FIELD32(address, _union, cond, timeout_usec)	\
+({									\
+	int result;							\
+	do {								\
+		u64 done = cvmx_get_cycle() + (u64)(timeout_usec) *	\
+			   octeon_get_clock_rate() / 1000000;		\
+		union _union c;						\
+									\
+		while (1) {						\
+			c.u32 = cvmx_usb_read_csr32(usb, address);	\
+									\
+			if (cond) {					\
+				result = 0;				\
+				break;					\
+			} else if (cvmx_get_cycle() > done) {		\
+				result = -1;				\
+				break;					\
+			} else						\
+				__delay(100);				\
+		}							\
+	} while (0);							\
+	result;								\
+})
 
 /*
  * This macro logically sets a single field in a CSR. It does the sequence
-- 
2.16.4

