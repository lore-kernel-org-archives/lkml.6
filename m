Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB14C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031CA2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7YkR345"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031CA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeLKU22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:28:28 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43952 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeLKU2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:28:21 -0500
Received: by mail-yb1-f194.google.com with SMTP id d136so2976197ybh.10;
        Tue, 11 Dec 2018 12:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V6r5z1m44vGJIMnH4eYtFW94TsnIfykJ3wCDu4bZ2YU=;
        b=Y7YkR345MfZ3nrPlq4SL3rdvvp+dO0LfLf1YTpEmXHGnmqds//pYCCos4rL495/SNR
         8OuvPxLDcaYFlD+Ayg3rAZjp++m8J9+e8lmGWGLHro+F8MHXHrLjekKh1lGV7SZDb/dy
         eCRB3aProyE5m5CkPbBTYPFaKf2MorKRvIthnGE6yjaHqGcXUCohYB59JEfboEuJsYfo
         XeJokYkvN5clzocerbOkJGfnW3mT92uNUimhu3AqIR6VRafApSQz2ZI7ksOGuD9CqrOU
         zCs7yq/ogSpcbzaGBVnmPxKJwKZXMkzw0cpm0/5vKgn7+eobgjZajqpLqKMfhIG/o1+t
         K60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V6r5z1m44vGJIMnH4eYtFW94TsnIfykJ3wCDu4bZ2YU=;
        b=Bn6wzpoWjy5djuJFiLS/GNsKGKBtVn/3pnlUu2FGikOU9Ui941W2X1JdeMhV7a/yj0
         br3nOD2d50Tc9BjvPfHuULPyJ7gdmP0l8SstLXuxDogMumFFNuz8QDrVOhDmfdFuNCLT
         1vwrhyAUXDBtxIMYOYggWh7JTijQ8nRxHIBgxnZDz4PM+dZ7ZZcujChr/KTHiWGncbwO
         3zLqb7d2qrvLPHR3RgfXY36ijTo547KIOEuE3sTsSYP8KBVnEpVjW2zoViottgoXTAxH
         EBb3WYMuhfV3LigErC4hKcQBzZI2NNdYYrrXAhU5RaTr/S3u1KwaSekpJKFwRIo0x9Fl
         1vcQ==
X-Gm-Message-State: AA+aEWZixHDqkBKahfT+dB59hUf/uCjwr20aRutWroNnrFyOK7oVKuWz
        pCQ66pKPEeshiLH2iBCQKec=
X-Google-Smtp-Source: AFSGD/UTkKVj+m6QAfAxxYg4FWktkT11aYE6qvRO4mxpkff2BMGjrE0yPFx/5U/E8lQ+uBjaudHIIQ==
X-Received: by 2002:a25:b002:: with SMTP id q2-v6mr18525474ybf.397.1544560100300;
        Tue, 11 Dec 2018 12:28:20 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id l35sm5415078ywh.48.2018.12.11.12.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 12:28:19 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH v2 5/8] socket: Add struct __kernel_sock_timeval
Date:   Tue, 11 Dec 2018 12:25:17 -0800
Message-Id: <20181211202520.16799-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211202520.16799-1-deepa.kernel@gmail.com>
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
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

