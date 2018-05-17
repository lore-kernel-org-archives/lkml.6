Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2691500-1526589512-2-9689601350916127988
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES ro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526589511; b=g0BGySeKEkhpefDln7YT4b+jNF/Q5oweXCuLU9YH37ykSaxSZP
    PTC9dhXKVMw9nAUTcOTEmg7iKIjGvA4u61KbYKisnXwGJRh2eblsK9r+13EZApcR
    4Czb57WroQHJWIXvKh/RkDZjc1zrl9//VCDv6QcJMCFXMRcZn1RBDAFUZPdmoEuj
    dHsQ76d4qSWuzbg5XR1VS0k4ZGhO29ZSjbQwjNHOZ2tU8OG6GqZf7vH24N+eBc6f
    la6v8DtUE7gY7QBOsx8W0r38hzZyplC7URn5LAK+pzB7BBa/m77yN0SINTcDtkNg
    6So0MD54vIuhJa6l20xvoGzZwv7vfl4qwjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526589511; bh=
    bfbbUSBgTlYSGda+amdU0YDhCjXFlrFQlz4M9dbgApo=; b=noJnEKgyAsB5QB6H
    ENzxwrnTaMXdOud2Urt2pZmmBVv8Rbd8rv84zQfJ5y3k/YlSw+q8BA7QSkMhCXP6
    gWSkidiCQLpDABRMNd+dM2ubeGKE4oBR9mjhF7IlW9vI9TQB3S5Qmq+a1HPTcXZf
    X7yRt0+3Foqm+TkpZWS/mb04opJZMWF9QKtAjF3dlWglu3ZMK03lXyGb2I6yDIQq
    G/MKB0QBxYlO884zmkx6I+S3w6tmLn0HcMt21ZzGJ7spD1Qv3sdI29QZs3Abr/pt
    rQO/Yd9xas5nHE11fyj8MNx1b6CN8rRg/85hwj+rNeY5wxCDyrW56xTv0t9lD0PZ
    J+DBTw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=nVWpbAhc x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=nVWpbAhc x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAOvpnttCPFUnJw/F2e0pkuako5iyI5ctUBOMuJn3WknssXhNBSforzHv+GHngJgDE0xMlAi28nDkJNCrFBEs/wxfz5LPZsu7Q+QOpMQuU6IyK2fjSB8
    0xFvnTGK/J8iE06smJqTItVqz/J09uCaAzURiyyHU9cmh2DjxyBh5ZmsvCi78T+Cho4K7soKurWqkwyzFkm/N0d8wcbjHkbyALR49b2w9NUknWzx98MitGn5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=VwQbUJbxAAAA:8 a=ZYdTY-Wl7BD0CIAsORkA:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeEQUia (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 16:38:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:60847 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeEQUi0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 May 2018 16:38:26 -0400
X-IronPort-AV: E=Sophos;i="5.49,412,1520870400";
   d="scan'208";a="78199745"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org
Cc: mingo@kernel.org, peterz@infradead.org, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v4 2/3] fs: Convert kiocb rw_hint from enum to u16
Date: Thu, 17 May 2018 13:38:02 -0700
Message-Id: <20180517203803.2664-3-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180517203803.2664-1-adam.manzanares@wdc.com>
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

In order to avoid kiocb bloat for per command iopriority support, rw_hint
is converted from enum to a u16. Added a guard around ki_hint assigment.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 include/linux/fs.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 760d8da1b6c7..7a90ce387e00 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -284,6 +284,8 @@ enum rw_hint {
 	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
 };
 
+#define MAX_KI_HINT		((1 << 16) - 1) /* ki_hint type is u16 */
+
 #define IOCB_EVENTFD		(1 << 0)
 #define IOCB_APPEND		(1 << 1)
 #define IOCB_DIRECT		(1 << 2)
@@ -299,7 +301,7 @@ struct kiocb {
 	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
 	void			*private;
 	int			ki_flags;
-	enum rw_hint		ki_hint;
+	u16			ki_hint;
 } __randomize_layout;
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
@@ -1927,12 +1929,21 @@ static inline enum rw_hint file_write_hint(struct file *file)
 
 static inline int iocb_flags(struct file *file);
 
+/* ki_hint changed from enum to u16, make sure rw_hint fits into u16 */
+static inline u16 ki_hint_valid(enum rw_hint hint)
+{
+	if (hint > MAX_KI_HINT)
+		return 0;
+
+	return hint;
+}
+
 static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 {
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
 		.ki_flags = iocb_flags(filp),
-		.ki_hint = file_write_hint(filp),
+		.ki_hint = ki_hint_valid(file_write_hint(filp)),
 	};
 }
 
-- 
2.15.1

