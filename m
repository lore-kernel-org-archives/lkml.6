Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6C3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 09:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009FD2086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 09:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6KSXOD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfALJH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 04:07:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53134 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfALJH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 04:07:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so4470586wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 01:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AjTMhAtIVubDdfcm+q7CkY5f3BIb/lhX0H70iW/lypM=;
        b=F6KSXOD5ZEBf08eugG+PM1JEcGwr31wAF5Z5vFEFQ2fwWkypUerRZbPWgY5A98Yi4j
         vHyAWD01YFrhpTf+JUJRlX/4uBLIlDHrMc5lo0YeI3e3KESwQBgYGlo+IJcx4d/qQX7s
         bPqIe3Px0JDogjW31O97Rhgk8TxBf0gU444B2mhj6pZZ085a9H9UUl1aIlKQmrJ+3Vpc
         LH4ElL5mUJn9Ouy5geBVAiTTOO0td4ov6FhVMXbn6dE0WxUFFBjC+PdVJbYdfKZieBIe
         FfahWSHxJq6vu95ZVXl/Vs89U8VhvSXtvgIGbDr7oPqb2wALIjhXLKQFPzSvvKCcdGJU
         i0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AjTMhAtIVubDdfcm+q7CkY5f3BIb/lhX0H70iW/lypM=;
        b=I/KjPkA/TuhqiS8kim7D5bBDX0pEsCnxEitZSNuSOUIG5i2Q18/zpcTfx912TC8UQM
         2nB9LcgHsoXhyzaiaVW/8rdWJ45WjFN26lmjVk82AD0isx5TY2euwzfLV+Oz7woGwg++
         sIyYiUYilyhI4Qf6Tb9Y50Dzvz8KjW7Mrb0t/PprT6YtYixx1986AmTWYpQkgPNmjIPa
         ci7ABFWdkHb3XJJCOa3WWGEQib1CthUgNAryyaAfh6/vLtGGm5iHd0T5PovFK+JIYoJc
         Vxqh286YDIXaYl1mz66d5o+p6De4vrnW4q1kMh968zGxRS75wdo8vznkzLDRoa0du+RE
         OVzw==
X-Gm-Message-State: AJcUukeJ25Idxsify2VvQ9/AEKgzwzSib5Q+4VpvyQ/sWjKA0Ytu7Dwy
        T3BmSNudtl3Yj72MqP5mQPM=
X-Google-Smtp-Source: ALg8bN4YPI5ltlTGdXTSp170a0dnDRcg6fsqnDLh00zsXJTKyosKe1N407A8WA1j3+97OMOiQi/gnA==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr5168586wmi.144.1547284074481;
        Sat, 12 Jan 2019 01:07:54 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d3c:9f00:10b:7275:b88:1059])
        by smtp.gmail.com with ESMTPSA id k7sm61968789wrl.51.2019.01.12.01.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 01:07:53 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: unify reference to xen-devel list
Date:   Sat, 12 Jan 2019 10:07:23 +0100
Message-Id: <20190112090723.5708-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the linux kernel MAINTAINERS file, largely
  "xen-devel@lists.xenproject.org (moderated for non-subscribers)"
is used to refer to the xen-devel mailing list.

The DRM DRIVERS FOR XEN section entry mentions
xen-devel@lists.xen.org instead, but that is just the same
mailing list as the mailing list above.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Juergen, please include this in the xen tree.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14b991ebf2c1..d9d088e0677f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5179,11 +5179,11 @@ F:	include/drm/tinydrm/
 
 DRM DRIVERS FOR XEN
 M:	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 L:	dri-devel@lists.freedesktop.org
-L:	xen-devel@lists.xen.org
+L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/gpu/drm/xen/
 F:	Documentation/gpu/xen-front.rst
 
 DRM TTM SUBSYSTEM
-- 
2.17.1

