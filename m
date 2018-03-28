Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbeC1T6p (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:58:45 -0400
Received: from nov-007-i637.relay.mailchannels.net ([46.232.183.191]:18042
        "EHLO nov-007-i637.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753072AbeC1T6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:58:44 -0400
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Trail-Trail: 5af00deb33ce48e0_1522266620570_1747112857
X-MC-Loop-Signature: 1522266620570:1076594230
X-MC-Ingress-Time: 1522266620569
From: =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
To: mtk.manpages@gmail.com
Cc: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Subject: [PATCH] readv.2, io_submit.2: Document RWF_APPEND added in Linux 4.16
Date: Wed, 28 Mar 2018 21:49:11 +0200
Message-Id: <20180328194911.49632-1-j@bitron.ch>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jürg Billeter <j@bitron.ch>
---
 man2/io_submit.2 | 10 ++++++++++
 man2/readv.2     | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/man2/io_submit.2 b/man2/io_submit.2
index 397fd0b75..79fcdfee4 100644
--- a/man2/io_submit.2
+++ b/man2/io_submit.2
@@ -111,6 +111,16 @@ field of the
 .I io_event
 structure (see
 .BR io_getevents (2)).
+.TP
+.BR RWF_APPEND " (since Linux 4.16)"
+.\" commit e1fc742e14e01d84d9693c4aca4ab23da65811fb
+Append data to the end of the file.
+See the description of the flag of the same name in
+.BR pwritev2 (2)
+as well as the description of
+.B O_APPEND
+in
+.BR open (2).
 .RE
 .TP
 .I aio_lio_opcode
diff --git a/man2/readv.2 b/man2/readv.2
index b3b7b9658..668fba576 100644
--- a/man2/readv.2
+++ b/man2/readv.2
@@ -248,6 +248,16 @@ to
 .BR EAGAIN .
 Currently, this flag is meaningful only for
 .BR preadv2 ().
+.TP
+.BR RWF_APPEND " (since Linux 4.16)"
+.\" commit e1fc742e14e01d84d9693c4aca4ab23da65811fb
+Provide a per-write equivalent of the
+.B O_APPEND
+.BR open (2)
+flag.
+This flag is meaningful only for
+.BR pwritev2 (),
+and its effect applies only to the data range written by the system call.
 .SH RETURN VALUE
 On success,
 .BR readv (),
-- 
2.16.2
