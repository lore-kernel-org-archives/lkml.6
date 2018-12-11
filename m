Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE5CC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290FE20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuRP7K2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290FE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeLKU2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:28:36 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34562 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLKU23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:28:29 -0500
Received: by mail-yw1-f66.google.com with SMTP id g75so6005535ywb.1;
        Tue, 11 Dec 2018 12:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qJXThoQrdEC6Qp8oHq2nQ4pgcs9sRr+YiwX0Ou/nBBw=;
        b=KuRP7K2ZzK0ze1my0DsETnJMiRJ/usosBsU1FV/DtE5CBcd7ne3bPTwvfY56l9588O
         MDmf5JCnhQn/QT0pLiIG66eI+GJizeuFgLN122SCofdJEm2aptn8sBb5vysmvM0vRMT6
         drT/fnXssGrrRDwMA0FhYy4l6jDdryQ5WndPyHZ9JfyrQQP6CJ15xJv6cOhKIHv7dn24
         YI0C8O4a2tccSv7SQELTCAK4XJFNsAHAj4OethCWCQNjSpg3cpo7i1HzBpM9NBOf0xIH
         lm1OywnQqGZyL6FrCLifanExs9oJ1CwYNUVwfYq3nBXhYuwxKsxEJk7CKu45fVFnmPJs
         /XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qJXThoQrdEC6Qp8oHq2nQ4pgcs9sRr+YiwX0Ou/nBBw=;
        b=bOiCrpN6mv6qUCxhiC7gvZx5K5t39ZaaBpjnkUSqTDjXGscpPYqIreCsKe0AfKxh+f
         sNJvLBgE/ZBFsA8ocDb+o9o2CaQjzDmUL2FYWG9Y9z+fSPnjoeT4cLDEs3OmNAnSLlng
         9QAmsmG59DJWUw290t+ahcDuY3ZDuby6trCeufD23zYW/JFDNZDIETLx9qM7Q4tbEj6R
         RhMZiyPegr5J72hs+WO9tqmiuYRm3sKFO2+I6wxuHQvo+G9on0OD6nSfoyNG7eqfTN4D
         wY9FdbiO7Fi7gmdJM5ASAOTDN9dqWzgNzB4pOiUdoPsXSK2OOQgQm+TKmr+YqwIkO3jC
         /noQ==
X-Gm-Message-State: AA+aEWZOyMxHFk6c36vkVN/mwcmX5B0WMQRG+4TJmHmSeNixXERuFlkQ
        Ccq22qc3Gb6DkySl9GmBJYE=
X-Google-Smtp-Source: AFSGD/VtzV1vLedMo3jdkpKC++F7pNgbzHl7jYWwAMDHbi2z5cjm3E7c6lOTxYdUKEzOVVWezkr7Tw==
X-Received: by 2002:a81:9244:: with SMTP id j65mr18127846ywg.36.1544560109130;
        Tue, 11 Dec 2018 12:28:29 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id l35sm5415078ywh.48.2018.12.11.12.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 12:28:28 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH v2 8/8] socket: Update timestamping Documentation
Date:   Tue, 11 Dec 2018 12:25:20 -0800
Message-Id: <20181211202520.16799-9-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211202520.16799-1-deepa.kernel@gmail.com>
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new y2038 safe timestamping options added, update the
documentation to reflect the changes.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
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

