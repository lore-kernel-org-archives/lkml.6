Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E6CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB64F2086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltW9fV8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB64F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933542AbeGIWkb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:40:31 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37626 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbeGIWkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:40:15 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so6671301plc.4;
        Mon, 09 Jul 2018 15:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TDml3Z2bzO13EsIgZzeiivaEl9Hf3eyE+/8QqqzKI8s=;
        b=ltW9fV8AXBL/mEOS/a8KJj5htlr6r3C1DK6wBJFlGQSnzEK4ua8h83/mrq5BwYSaMK
         Q+U2ONplsnUHx6saE1TfZWrloQY8bA4ATGqxfarxrNo/DjvAz00Rlp7xOEtDxPdfe7v+
         bfsdDjZt1HSQbjpNkK6NhlnKgjDdTTB+8aenF7OQVlPJ1Ygt0jqwIh2+gP4XUhc0NW5s
         dzpO3eydOymUl2B+GJcFZ6nyTQi7z5Ni3hX498ejmiLrbJEnc6cE9JMGvvE9Lobj9JOD
         3j3OsOjEoSeLFCf5YibutN1wLDmrJx1nGWdAZkdgxFcrSVPFy0VVw6xcFZXEmaT3cDH5
         7rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TDml3Z2bzO13EsIgZzeiivaEl9Hf3eyE+/8QqqzKI8s=;
        b=GIHgVVJOtva9EX5E0K0UXolVo45kpB544wWAxU4xL5HuCOITQkDTbaLSwocxvnZUp2
         hWjk4LlQFzxK5G0XfXljKo3hpAXvQeH+jXJFY3JvDbznGMpxYDISGNMtvj8Cy8daLWZF
         Ikd/enpyHsMIFewGKphcm3otvXcQ0OFao0atlgg5nQ1pKAzVDSaCgnyi37A+lDgtsjqp
         e1E6a2HYN1kYJ2BTqa67Cdi3cCmFfA5br41Bg1R+3Ofxln9A0ymkAHuXiSS4qYpWvH26
         NEJp0KiIKnVIRbd5KR+qRRxmSGC1Lsksz/2qvxGw2/2/viuc6Vo+DbpKjlM3GEZPZOsz
         kx5g==
X-Gm-Message-State: APt69E0G1qgwaIktgeshuwLmpS9g8gI3IXLfRmuhpp4lLl3HMdRXapfR
        Ze+1BPyqzG/YbNDfHzaOIieOrw==
X-Google-Smtp-Source: AAOMgpcLKGiD/vbna1AbT7RqgTwQFbWZSICL164g9UZ5SNjL3ZPUUZSlBk3tnTbqvmfElxWoXFZaBQ==
X-Received: by 2002:a17:902:364:: with SMTP id 91-v6mr2556837pld.261.1531176014597;
        Mon, 09 Jul 2018 15:40:14 -0700 (PDT)
Received: from majic.sklembedded.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm30143804pfe.173.2018.07.09.15.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 15:40:13 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 17/17] [media] v4l2-subdev.rst: Update doc regarding subdev descriptors
Date:   Mon,  9 Jul 2018 15:39:17 -0700
Message-Id: <1531175957-1973-18-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the doc to describe the new method of adding subdevice
descriptors to async notifiers.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
Changes since v5:
- add info about v4l2_async_notifier_init().
---
 Documentation/media/kapi/v4l2-subdev.rst | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/Documentation/media/kapi/v4l2-subdev.rst b/Documentation/media/kapi/v4l2-subdev.rst
index e1f0b72..1280e05 100644
--- a/Documentation/media/kapi/v4l2-subdev.rst
+++ b/Documentation/media/kapi/v4l2-subdev.rst
@@ -247,20 +247,28 @@ performed using the :c:func:`v4l2_async_unregister_subdev` call. Subdevices
 registered this way are stored in a global list of subdevices, ready to be
 picked up by bridge drivers.
 
-Bridge drivers in turn have to register a notifier object with an array of
-subdevice descriptors that the bridge device needs for its operation. This is
+Bridge drivers in turn have to register a notifier object. This is
 performed using the :c:func:`v4l2_async_notifier_register` call. To
 unregister the notifier the driver has to call
 :c:func:`v4l2_async_notifier_unregister`. The former of the two functions
-takes two arguments: a pointer to struct :c:type:`v4l2_device` and a pointer to
-struct :c:type:`v4l2_async_notifier`. The latter contains a pointer to an array
-of pointers to subdevice descriptors of type struct :c:type:`v4l2_async_subdev`
-type. The V4L2 core will then use these descriptors to match asynchronously
-registered
-subdevices to them. If a match is detected the ``.bound()`` notifier callback
-is called. After all subdevices have been located the .complete() callback is
-called. When a subdevice is removed from the system the .unbind() method is
-called. All three callbacks are optional.
+takes two arguments: a pointer to struct :c:type:`v4l2_device` and a
+pointer to struct :c:type:`v4l2_async_notifier`.
+
+Before registering the notifier, bridge drivers must do two things:
+first, the notifier must be initialized using the
+:c:func:`v4l2_async_notifier_init`. Second, bridge drivers can then
+begin to form a list of subdevice descriptors that the bridge device
+needs for its operation. Subdevice descriptors are added to the notifier
+using the :c:func:`v4l2_async_notifier_add_subdev` call. This function
+takes two arguments: a pointer to struct :c:type:`v4l2_async_notifier`,
+and a pointer to the subdevice descripter, which is of type struct
+:c:type:`v4l2_async_subdev`.
+
+The V4L2 core will then use these descriptors to match asynchronously
+registered subdevices to them. If a match is detected the ``.bound()``
+notifier callback is called. After all subdevices have been located the
+.complete() callback is called. When a subdevice is removed from the
+system the .unbind() method is called. All three callbacks are optional.
 
 V4L2 sub-device userspace API
 -----------------------------
-- 
2.7.4

