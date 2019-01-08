Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EB4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56FC2183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFtlL5CH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfAHD2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:28:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33724 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfAHD1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:27:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so1179058plo.0;
        Mon, 07 Jan 2019 19:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ROXjCNh7/+j87gFjI2xFwFTr444MTdpI+cCI3EnBUs=;
        b=YFtlL5CHtoga5pwRvtOLOWeA09oVqE1mW9T6pSTzYtM3FvKkHlcwvJIcP/Ux6mfPTI
         4LvWpAkUKl0JKaCDRO4I/WFf0e7pMjDJdk/Hb7rdPztux+v9OhM9OZnOU4ScGur0k5fb
         gYEPIjX42Xg0TOhthgbgHb3qsStcDCAObGcsCD6RyBjywjkAr1ZJfNndlV1vwAATZPmO
         loGLIBlkxhSRfeophxEGpwQ97YjQp42AppKwgiIdk+iYui1ZHRl5ffaiM5zp7bPH6ouy
         HMe7RE7otffaTACaFRdDpIYZVKMKJ8HbEhLhfWZAiY/Bjvt+D8ITcql8vo7O5Hvpjv8E
         Sidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ROXjCNh7/+j87gFjI2xFwFTr444MTdpI+cCI3EnBUs=;
        b=fl2ndTk+zaXqCdaNAQVJNDQ2157gOin5Fm7AXqvTmABUxeRZWYnGEMS9Hh9AF3X4/7
         gH9cOpBlcs8V+XMtdg4pBPuyeXYKhbvbjat+p+j+je8EGWzEuaKv+ns0sSVegOPn11I+
         QY82w2+7DvQV6hP/IDSUZGB4u+5vZV27QKyVB1w58mWZqkNTS4+YEkDZFTJ74zv+36N6
         UndJ74X20CHcioWzVPazJ6kKd2Plk/gqz47pKLJx6jelpL/HFba5iqVyr2yZ37gMezxh
         mBd5Z57bCBLjvkbntrJq/houvZaB7W9UclDkoAt04iNIymsh/SqUnvVs0rHESa7sneFs
         jPtQ==
X-Gm-Message-State: AJcUukfLdd9ITYZi5okD3xd2Kvy8JTtdfbatuxepKY/USkbeFB35WhNf
        HRftwOdhrxPSkxc4LIFmOa4=
X-Google-Smtp-Source: ALg8bN4zoU3PadxAs/6xPpJPCxgDjm2B3+AEwuZP1fgpRsaJJGwmzjDRBWvBM8NCBvmhi1GeRoW3aw==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr88934plb.169.1546918073768;
        Mon, 07 Jan 2019 19:27:53 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id v5sm117327735pgn.5.2019.01.07.19.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 19:27:53 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH v3 8/8] socket: Update timestamping Documentation
Date:   Mon,  7 Jan 2019 19:26:57 -0800
Message-Id: <20190108032657.8331-9-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108032657.8331-1-deepa.kernel@gmail.com>
References: <20190108032657.8331-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new y2038 safe timestamping options added, update the
documentation to reflect the changes.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/networking/timestamping.txt | 43 ++++++++++++++++++++---
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/timestamping.txt b/Documentation/networking/timestamping.txt
index 1be0b6f9e0cb..67e4ab3cdb86 100644
--- a/Documentation/networking/timestamping.txt
+++ b/Documentation/networking/timestamping.txt
@@ -6,11 +6,21 @@ The interfaces for receiving network packages timestamps are:
 * SO_TIMESTAMP
   Generates a timestamp for each incoming packet in (not necessarily
   monotonic) system time. Reports the timestamp via recvmsg() in a
-  control message as struct timeval (usec resolution).
+  control message in usec resolution.
+  SO_TIMESTAMP is defined as SO_TIMESTAMP_NEW or SO_TIMESTAMP_OLD
+  based on the architecture type and time_t representation of libc.
+  Control message format is in struct __kernel_old_timeval for
+  SO_TIMESTAMP_OLD and in struct __kernel_sock_timeval for
+  SO_TIMESTAMP_NEW options respectively.
 
 * SO_TIMESTAMPNS
   Same timestamping mechanism as SO_TIMESTAMP, but reports the
-  timestamp as struct timespec (nsec resolution).
+  timestamp as struct timespec in nsec resolution.
+  SO_TIMESTAMPNS is defined as SO_TIMESTAMPNS_NEW or SO_TIMESTAMPNS_OLD
+  based on the architecture type and time_t representation of libc.
+  Control message format is in struct timespec for SO_TIMESTAMPNS_OLD
+  and in struct __kernel_timespec for SO_TIMESTAMPNS_NEW options
+  respectively.
 
 * IP_MULTICAST_LOOP + SO_TIMESTAMP[NS]
   Only for multicast:approximate transmit timestamp obtained by
@@ -22,7 +32,7 @@ The interfaces for receiving network packages timestamps are:
   timestamps for stream sockets.
 
 
-1.1 SO_TIMESTAMP:
+1.1 SO_TIMESTAMP (also SO_TIMESTAMP_OLD and SO_TIMESTAMP_NEW):
 
 This socket option enables timestamping of datagrams on the reception
 path. Because the destination socket, if any, is not known early in
@@ -31,15 +41,25 @@ same is true for all early receive timestamp options.
 
 For interface details, see `man 7 socket`.
 
+Always use SO_TIMESTAMP_NEW timestamp to always get timestamp in
+struct __kernel_sock_timeval format.
 
-1.2 SO_TIMESTAMPNS:
+SO_TIMESTAMP_OLD returns incorrect timestamps after the year 2038
+on 32 bit machines.
+
+1.2 SO_TIMESTAMPNS (also SO_TIMESTAMPNS_OLD and SO_TIMESTAMPNS_NEW):
 
 This option is identical to SO_TIMESTAMP except for the returned data type.
 Its struct timespec allows for higher resolution (ns) timestamps than the
 timeval of SO_TIMESTAMP (ms).
 
+Always use SO_TIMESTAMPNS_NEW timestamp to always get timestamp in
+struct __kernel_timespec format.
+
+SO_TIMESTAMPNS_OLD returns incorrect timestamps after the year 2038
+on 32 bit machines.
 
-1.3 SO_TIMESTAMPING:
+1.3 SO_TIMESTAMPING (also SO_TIMESTAMPING_OLD and SO_TIMESTAMPING_NEW):
 
 Supports multiple types of timestamp requests. As a result, this
 socket option takes a bitmap of flags, not a boolean. In
@@ -323,10 +343,23 @@ SO_TIMESTAMP and SO_TIMESTAMPNS records can be retrieved.
 These timestamps are returned in a control message with cmsg_level
 SOL_SOCKET, cmsg_type SCM_TIMESTAMPING, and payload of type
 
+For SO_TIMESTAMPING_OLD:
+
 struct scm_timestamping {
 	struct timespec ts[3];
 };
 
+For SO_TIMESTAMPING_NEW:
+
+struct scm_timestamping64 {
+	struct __kernel_timespec ts[3];
+
+Always use SO_TIMESTAMPING_NEW timestamp to always get timestamp in
+struct scm_timestamping64 format.
+
+SO_TIMESTAMPING_OLD returns incorrect timestamps after the year 2038
+on 32 bit machines.
+
 The structure can return up to three timestamps. This is a legacy
 feature. At least one field is non-zero at any time. Most timestamps
 are passed in ts[0]. Hardware timestamps are passed in ts[2].
-- 
2.17.1

