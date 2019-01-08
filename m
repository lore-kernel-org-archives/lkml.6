Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73034C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40392218A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPd6yM5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfAHD1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:27:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40827 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfAHD1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:27:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so1198406pfo.7;
        Mon, 07 Jan 2019 19:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V6r5z1m44vGJIMnH4eYtFW94TsnIfykJ3wCDu4bZ2YU=;
        b=uPd6yM5ODMh3qR2EMmT0hoG/gM49k/h4u/gLrjF2Q++iWKpFMElbF6/y3PDlI53B8r
         6J0bUVkTOSMmW4RP+o1DBG1zcFj2Ey0tVS+BxTUgX297K0VRhe6t/9wr2COuuqH+qUFb
         fMA22jOrZAooQE8fJ0JsLwNvghDX66a6asSB/l+WpNMyEzD1bjoMTGTUDypmDVGMSffY
         zOKSn8DtWOuTXpiBp1xgzoTFdfZboNq2VhcTFqr1m/b6brR6nTl5Y8v890ISmj5nHs9m
         OM9oYroRGLZaBR779uTi1/RfVVOQdxlGDiV68lBcTEi7M4jd5lhc03vXraMqaKCvTMY6
         /C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V6r5z1m44vGJIMnH4eYtFW94TsnIfykJ3wCDu4bZ2YU=;
        b=gaGapvo1sWVhSjKNPA+E/LkGMXtO8jzwWt5M4sKaH7adF/S1qUsNjg3PGlmLJGNQWX
         /kzlk57TAocp9qeQWbVXuHQe8l/3ybjsREQeQxI+5Uv68YPIlLyXsBFNtmwUdMVdKOwm
         b3iLORits6K9KHl5Ylr78FraZcd6jRp9eCH0ZfQtPy6SeZk8J8+eLknW4kBiWThPw9YI
         KTFiL9zcDvNI1MWE+/SflVABfiOFrFXPKStWYkRfDpTxzP7ovs9lPsDsiwj1jnjy7+J4
         fEbMWsqbdfR5CuftMGxgaAdwRJs2XfitPpKxfIF97ZxkiIebcVXQ0RLTLpLmvAJmqhhy
         yG+A==
X-Gm-Message-State: AJcUukfC3+/Eo/tn6Y0cDKG1+uvy5t4RDQys1Ad/L6OtPKwbVQAM5nCg
        ZPLVERZTyKQEPG2lDrIdxtg=
X-Google-Smtp-Source: ALg8bN5lcQh74Q8rC6xPdueT0ih5AxwTVsc8HjUIdFGqh38oUAhhVI4P0uxBOWMEsYPFtdjvuq6SGA==
X-Received: by 2002:a63:de46:: with SMTP id y6mr96896pgi.198.1546918069138;
        Mon, 07 Jan 2019 19:27:49 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id v5sm117327735pgn.5.2019.01.07.19.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 19:27:48 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH v3 5/8] socket: Add struct __kernel_sock_timeval
Date:   Mon,  7 Jan 2019 19:26:54 -0800
Message-Id: <20190108032657.8331-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108032657.8331-1-deepa.kernel@gmail.com>
References: <20190108032657.8331-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new type is meant to be used as a y2038 safe structure
to be used as part of cmsg data.
Presently the SO_TIMESTAMP socket option uses struct timeval
for timestamps. This is not y2038 safe.
Subsequent patches in the series add new y2038 safe socket
option to be used in the place of SO_TIMESTAMP_OLD.
struct __kernel_sock_timeval will be used as the timestamp
format at that time.

struct __kernel_sock_timeval also maintains the same layout
across 32 bit and 64 bit ABIs.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/uapi/linux/time.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 04d5587f30d3..b8ad1b86b942 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -70,6 +70,11 @@ struct __kernel_old_timeval {
 };
 #endif
 
+struct __kernel_sock_timeval {
+	__s64 tv_sec;
+	__s64 tv_usec;
+};
+
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers):
  */
-- 
2.17.1

