Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFC0C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8682089D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJiWecW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8682089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966575AbeF2Sxi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:53:38 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34660 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965133AbeF2Sxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:53:33 -0400
Received: by mail-pl0-f65.google.com with SMTP id z9-v6so4872241plo.1;
        Fri, 29 Jun 2018 11:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=45ToJvq9+6cqBBBLfKH8+TVwq7TYPCfSi3VQEHlyhZM=;
        b=DJiWecW5ITZO/UwL/4R9lGRDIO3Wi8filk+4VE2frc2l0OXTyPVAuO68RiNIThD5Y3
         dmwugmAtlxdYfCT5IiqRbCduc+cikBq+OSk643a7VtYl/mFf2PwKxKZYDj00yLW2UkI4
         7lXM+N3mDDqoDoTRQWwZIizeAvxqx/Aa14Id57MPWIHTOPnwCgrCcgvafntNufeVA50l
         599e9MVGuYgFqJNVQ6D99GUvfKEH8MJahJdX9ZC6kL857xRiXD/vVG+TJgZgdQYGC+cf
         k7HW0S7YG7uy0tootBvqdKbv43p9AwWk+mbBgFmYzPe3+M9RjsOw5RwxoR5SFWRkflP2
         b5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=45ToJvq9+6cqBBBLfKH8+TVwq7TYPCfSi3VQEHlyhZM=;
        b=McGvPDF1Q82qkSvAdtKckW1UKA1MOGNlW9vp6Xe5uSiHr3Qe3jJeQiqVwAPZVQsgR8
         eaOItueq4CcLIP96YdFSgiEuts3u2DqYma6OfMYVn4qoDyvdnXx5VnTeu7BI07jgkIPm
         rPocLKYrsF4+exkTmz0i0B02FSVyX2FlgowYRNYwQRDUAWU9YJlthXHLvmMVJXbLeRfJ
         /eO4dEmLFIgr+mamctjFO52m32e/PxJzZ6auRCpYLJ2KvbbvX6me2FP2gxSWeLgHCsvS
         RVOYAaqeDB9aLGFu82PuySezuseSCzLkU2DamgL28mL/ADeMN7WtQQF06ixBbSrhlHRV
         QgYQ==
X-Gm-Message-State: APt69E04IO237OSSNqLr6UHOJ7ZRsCeTU+HphZGxoZxxeEZO8wOGPQFS
        76KVW/FdZDSCvVt7DkjyCVUWJg==
X-Google-Smtp-Source: AAOMgpcRkT4/BCpv+rnxtlTIyIkyo7rEcZ9yWRJ1DFQJNZC7al88CD3jGd229/BaMzBusjBJASNLEQ==
X-Received: by 2002:a17:902:18a:: with SMTP id b10-v6mr4279799plb.62.1530298411928;
        Fri, 29 Jun 2018 11:53:31 -0700 (PDT)
Received: from mappy.world.mentorg.com ([2602:306:cc3b:f020:7cd8:9ad7:a375:e853])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm27672308pfg.130.2018.06.29.11.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 11:53:31 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/17] [media] v4l2-subdev.rst: Update doc regarding subdev descriptors
Date:   Fri, 29 Jun 2018 11:50:01 -0700
Message-Id: <1530298220-5097-18-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the doc to describe the new method of adding subdevice
descriptors to async notifiers.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 Documentation/media/kapi/v4l2-subdev.rst | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/Documentation/media/kapi/v4l2-subdev.rst b/Documentation/media/kapi/v4l2-subdev.rst
index e1f0b72..7197eeb 100644
--- a/Documentation/media/kapi/v4l2-subdev.rst
+++ b/Documentation/media/kapi/v4l2-subdev.rst
@@ -247,20 +247,26 @@ performed using the :c:func:`v4l2_async_unregister_subdev` call. Subdevices
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
+Before registering the notifier, bridge drivers form a list of
+subdevice descriptors that the bridge device needs for its operation.
+Subdevice descriptors are added to the notifier using the
+:c:func:`v4l2_async_notifier_add_subdev` call. This function takes
+two arguments: a pointer to struct :c:type:`v4l2_async_notifier`, and
+a pointer to the subdevice descripter, which is of type struct
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

