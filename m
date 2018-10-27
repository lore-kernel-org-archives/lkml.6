Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13D7ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F6C20664
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr/1nGlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F6C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbeJ1FLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 01:11:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40183 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeJ1FLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 01:11:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id b203-v6so4376528wme.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 13:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=29CJNq50toriWOyuS95JQY3+onZWv8JuO1OoyJl6vLg=;
        b=Cr/1nGlFD1CXTGLX6kzo8O9P2QXfEH0dtz72ihQnexk+qHn6JVDzSmjFan4yAJ85cv
         G/fymOyOxyFH8lfH/nl/bGHB02rwS276baBggz04WTF1e8IBr8lh0tjJSQa8XcGa9J/g
         3B8Wa/1X1I5yCpeI3CzD9dLR5Qb4C23gQxc2/uUSID9T6bYSoIHa2G16Op2h/PlhLmu1
         yGRgNbXnINMX1aEMjk3YHWuWz1LysApUfwgYcumdOdkkJwZOUmskpZKtpF7DJR4AHims
         OTTHabaQyKVHkF00dfcae+gCJSxHufNJAOsqTgGLax0SDjPlGWy976SpM1tjadlWQcCx
         uNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=29CJNq50toriWOyuS95JQY3+onZWv8JuO1OoyJl6vLg=;
        b=VwZ9e4QpY87oDDC9sK7DeNOLkJ9QKYPQtPKel5ow/UXbDkviUPwS8MGaQrlKdjFgRh
         tlLZlXUh+30bKpEX5OTYepfNbc+bNIi4gGBqY/k/gcptVRY3r5Y7NdkdNdG/V3Kw01FS
         6vSdyLVStDnUK5ziiMUDJalFi8n1VjwL7F4eW640tiWvnBXVlncTE54OmnEyfMtqj67f
         pPVI5JEMo5jINFEGSRO7F49koRwSsecNyYXjo0vfa0lLLz0NllaeLr50lvpfisVCEi4I
         qSXpm48znuvLZI/KPWLJF9S5ND6ryAtGqcuYO4KY4GHk8+NPceb5l4sjLNNt8vJ45DXD
         Jb+w==
X-Gm-Message-State: AGRZ1gL8neJO6JdnrWeV9ikNnEl6xdRd04g0Lb/b6NTgFB5M8ZGSuBvp
        lI35HoCUUZFDFB8XBZw8z2Y=
X-Google-Smtp-Source: AJdET5duglaR4/MU+j8nE0gJQDlcYY7rVuF49O7lY7/7hm9NlIzTAXgG1iVeYWizopFp4MrEtkbDTA==
X-Received: by 2002:a1c:2ecc:: with SMTP id u195-v6mr9614366wmu.137.1540672141318;
        Sat, 27 Oct 2018 13:29:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id v16-v6sm5335784wrt.32.2018.10.27.13.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 13:29:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: rtl8188eu: change type of a struct field
Date:   Sat, 27 Oct 2018 22:28:47 +0200
Message-Id: <20181027202850.25636-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027202850.25636-1-straube.linux@gmail.com>
References: <20181027202850.25636-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field enable of struct recv_reorder_ctrl is only used for boolean
values, so change the type from u8 to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/rtw_recv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_recv.h b/drivers/staging/rtl8188eu/include/rtw_recv.h
index 54b7ba367293..8fc500496f92 100644
--- a/drivers/staging/rtl8188eu/include/rtw_recv.h
+++ b/drivers/staging/rtl8188eu/include/rtw_recv.h
@@ -27,7 +27,7 @@
 /* for Rx reordering buffer control */
 struct recv_reorder_ctrl {
 	struct adapter	*padapter;
-	u8 enable;
+	bool enable;
 	u16 indicate_seq;/* wstart_b, init_value=0xffff */
 	u16 wend_b;
 	u8 wsize_b;
-- 
2.19.1

