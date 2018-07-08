Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672F2C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E436208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdVgHuPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E436208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbeGHVGl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:06:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41459 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932953AbeGHVFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:48 -0400
Received: by mail-pf0-f196.google.com with SMTP id c21-v6so7529776pfn.8;
        Sun, 08 Jul 2018 14:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gX3slr+nCANV0yWUg1mXTOH9gRdfuSoEF5rQEB40Btg=;
        b=fdVgHuPKJjryaXUdGb1aIVm5PoRKu+5gO5PfDcjjNqe/YDOViZuK2gYWwAehO9s4Hl
         yF7RqIH8dlr7paTmsAqC+GC00ofTZrRBFc7TkpU3xZ2Eu38Vv9J8wk0PDEXX3+Lj5LX2
         vy32/wefY8zFV07nyZEXZkK62zyNc5SLv6YwfKPEYo/IIF24P5x+TnKAqHBELhqc9T26
         Le+GE8IsfrYx/jPIbRZb7YNIelL9GYLRgtPO4DxSZdhtYBP0+gmGBFU30oXXRcOw3Sur
         6yDiuTwrvnGp9R5tkgJGcacTaqy/nz6RqZqj1I+R0hevXu1jT0ZMpe8UETFkpaguj7Qi
         Trcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gX3slr+nCANV0yWUg1mXTOH9gRdfuSoEF5rQEB40Btg=;
        b=B2Zo/XmJ1viLR/TerSZCx4eFvblHEpG9B3XMrHGFK6SmF/dpWmOEZgM1za3PXe+lzZ
         f5AiWrAoQiOUDcEveHAABTzXf7+ldSx2a4V3Ol3n7rvtEREXJ9jj7RP4nEvyJVeUKUIZ
         gZKme8U+m/i5+VMQEatXzQkjC1Dzs752wMNId67l0w2AoZNesXCkocijxNc5xTGowfLR
         QLLMQLIkjzRYQTsooPuqpOVqtbJjHMOAJ4KhpWCWC6y7P0sVqR8Wrgbx7ipIlLh/d0aQ
         XvCOAsJqTwDhqNerQ9YhB+x1vehBLmc1bSDrbJaCJV5okMtITkXe7qgBSG+c7v4d0UgA
         NDEg==
X-Gm-Message-State: APt69E2MRw6+THaCK3jLwOCaNn1vE14z4pZI5pBqe0wj3ud1LD3DGUDw
        KYiTuVh6eHbLh6E6w+ZcRrk=
X-Google-Smtp-Source: AAOMgpdkIbgd9l+6UTrepBsJ1l2IYJ0cRuACGtnlAgRqUbepuLEi6SpaXIyQVGpnGtTyccArbmTuOg==
X-Received: by 2002:a63:c252:: with SMTP id l18-v6mr16491142pgg.76.1531083947760;
        Sun, 08 Jul 2018 14:05:47 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:47 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 18/18] fs_context: fix fscontext_write() comment
Date:   Sun,  8 Jul 2018 14:01:54 -0700
Message-Id: <20180708210154.10423-19-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The 'r' command doesn't exist, and 'd' was apparently renamed to 's'.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fsopen.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 34d7292bb398e..6947fed9df3b2 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -23,12 +23,11 @@
  * here.  For the moment, we assume a single option or command per write.  Each
  * line written is of the form
  *
- *	<option_type><space><stuff...>
+ *	<command_type><space><stuff...>
  *
- *	d /dev/sda1				-- Device name
+ *	s /dev/sda1				-- Source device
  *	o noatime				-- Option without value
  *	o cell=grand.central.org		-- Option with value
- *	r /					-- Dir within device to mount
  *	x create				-- Create a superblock
  *	x reconfigure				-- Reconfigure a superblock
  */
-- 
2.18.0

