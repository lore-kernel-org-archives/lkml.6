Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4BDC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221C72075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221C72075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeJWTbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:31:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36261 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeJWTbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:31:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id x2-v6so1210479eds.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yf1ILPrjy1ajsZHeETSHKgKbtuoKgSQp67npbqaWSdo=;
        b=r+ucQPRnCLDsyFN+Kp1/MQr7gVjAbbCDBIXyVjmlA9Miv9/3mx+7hixxCgrNTYC5Xi
         xSNtgMhmv8xVtphDdtjq3dm0/lpV/6mKUmid9s76Fc1WVX5oX3lTVt3MsEbtZrTORWDA
         C6seMRRlAGPaID0lYUW9CHj5MA3IiQwW5oXKp0DDHHchW7uRSbp9zCeBRJ6zjeLqfH7j
         sh8hw9AWxBGJyu8KfaYBZBw8nTG7Lg9reLiL+LgW38V7KBbior9ARZWcfRNKve2O9KKn
         i/CusCB+KJXhnYN/J9DjJAmCSDzk20o561WzrZ+ii7RVZQrsQmZU6x5QLY/2y0bIeuzD
         lQWw==
X-Gm-Message-State: ABuFfoiQvjNJXZKI/Sd75nBj3mTFAfflp4LgIesMYJo4SUrLNXgA1pKA
        IbWvETxyZ7R67I+hdf5Szgs=
X-Google-Smtp-Source: ACcGV629XtKytngaV4Bss0XX9qHKSr+tu5rDC4fnPP+W7n6t5OMzR+wnHMWDpjTyvFOSPNWSw4no3g==
X-Received: by 2002:a50:9471:: with SMTP id q46-v6mr16126130eda.70.1540292935032;
        Tue, 23 Oct 2018 04:08:55 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id l36-v6sm459263edb.24.2018.10.23.04.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:08:54 -0700 (PDT)
From:   efremov@linux.com
To:     James Morris <jmorris@namei.org>
Cc:     Denis Efremov <efremov@linux.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] security: fix documentation for the socket_post_create hook
Date:   Tue, 23 Oct 2018 14:08:37 +0300
Message-Id: <20181023110837.27840-1-efremov@linux.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

This patch slightly fixes the documentation for the
socket_post_create hook. The documentation states that
i_security field is accessible through inode field of socket
structure (i.e., 'sock->inode->i_security'). There is no inode
field in the socket structure. The i_security field is accessible
through SOCK_INODE macro. The patch fixes the documentation accordingly.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 include/linux/lsm_hooks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8f84ef819e00..accf6f34ac8e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -752,9 +752,9 @@
  *	socket structure, but rather, the socket security information is stored
  *	in the associated inode.  Typically, the inode alloc_security hook will
  *	allocate and and attach security information to
- *	sock->inode->i_security.  This hook may be used to update the
- *	sock->inode->i_security field with additional information that wasn't
- *	available when the inode was allocated.
+ *	SOCK_INODE(sock)->i_security.  This hook may be used to update the
+ *	SOCK_INODE(sock)->i_security field with additional information that
+ *	wasn't available when the inode was allocated.
  *	@sock contains the newly created socket structure.
  *	@family contains the requested protocol family.
  *	@type contains the requested communications type.
-- 
2.17.2

