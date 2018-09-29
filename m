Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA39C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C492073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UysVz1XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C492073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbeI3CZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:25:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45303 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbeI3CZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:25:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id t70-v6so6740977pgd.12;
        Sat, 29 Sep 2018 12:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9hWfMh3TWcg8qCBecmxeBstk7XTPGeKfkEIFur6kM8k=;
        b=UysVz1XWjbpqSXbo/d4Z33u1UIB91SP5c3aX1t7RosSQb3kyVYQNlv6iiLR4R9RaBM
         zoGBJiTlXy+jX63YWybLWSLJnPMlda/dtVdWBLGIkmS/+JTuGBVFOrLYwlvE3w45FK2+
         qAi6MyoDxSGD5P9rnQ0z40QmsGy9LxmWHqoEa6kZ+e7PDxXbquYHf6w67iAhiCxZMY3l
         aIxXcAynUyHLGtJkm57CGHRhVb0Pqw9NxSKUCpL9s2OUC0PCXSQMb1YVraNdZ5MDcJEA
         JnrzXMLWI1PAZyp3DBrzVkE5H8TWCcValEsxAIQQ+wAmnjn5QKO6P5saJSKd16qWDHEb
         CFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9hWfMh3TWcg8qCBecmxeBstk7XTPGeKfkEIFur6kM8k=;
        b=S7bJrQXMSaIWWOeeEVj9OgLlBkCf4oVY+s8W29v/+rULrU2RDWbajO6nGs5SkVI85t
         ygdPcT+yjNVVgA0xfSyTNSAJn6Z3xNF2mljYWKTjbabBVTgf4Y/jcpvPI80MnzFTtqLf
         pu3uEFGuRwZkqgzLCu7ttn00iQje2OKmhCLZtqPZXeS/JVSG0muDPwUxzxW0MHU5Tutu
         8t5n9VS983poaLXGeHNrJrIzFuRwbQvWCNcwfHeqnjLBqn16+D6AEO3Hg0TIGtGEMTVR
         WDzefxz/g5PVTJj36oraq6ZVxtvaJW7gpsp8Ypf653NnQRkT5VXPikSGsQfuS2+fkUw0
         VogA==
X-Gm-Message-State: ABuFfoiolKmqtaPjbIh5VKns5A8v2QsYAWnTGThyoVLdaiwz4pUd9BT4
        lItXeII5OBN4g2b3U3mM9AxrBy54
X-Google-Smtp-Source: ACcGV63Amqq9k74n+o/e7C7mpwUGJnWfEXwMt6+uC81G58AZFs43nhuQuQkU8YeYaUXrq+7N0loYGA==
X-Received: by 2002:a17:902:b03:: with SMTP id 3-v6mr4569811plq.156.1538250919471;
        Sat, 29 Sep 2018 12:55:19 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id b126-v6sm18371946pga.49.2018.09.29.12.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:55:18 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v7 17/17] [media] v4l2-subdev.rst: Update doc regarding subdev descriptors
Date:   Sat, 29 Sep 2018 12:54:20 -0700
Message-Id: <20180929195420.28579-18-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929195420.28579-1-slongerbeam@gmail.com>
References: <20180929195420.28579-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the doc to describe the new method of adding subdevice
descriptors to async notifiers.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes since v6:
- none
Changes since v5:
- add info about v4l2_async_notifier_init().
---
 Documentation/media/kapi/v4l2-subdev.rst | 30 +++++++++++++++---------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/Documentation/media/kapi/v4l2-subdev.rst b/Documentation/media/kapi/v4l2-subdev.rst
index e1f0b726e438..1280e05b662b 100644
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
2.17.1

