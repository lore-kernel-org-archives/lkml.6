Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B944DC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7E8208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEN9obSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7E8208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933547AbeGHVFx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:05:53 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37723 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932437AbeGHVFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:47 -0400
Received: by mail-pf0-f196.google.com with SMTP id x10-v6so2291937pfm.4;
        Sun, 08 Jul 2018 14:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tQgirrJxXJmTmU+afvcNHwBLtlIR/mauWurgdutbcLM=;
        b=iEN9obSjbeaiXGTbCgnC05ErOUwahBXXOvzWhxO0lsuv0A4xlgmR9wvcaQ9d90vt11
         y3CQOSQaE2HnWT/nMM6RzyHr0m3UYfDQdb5QhNRzT51655NqqRO5QwJM+CXsDtIp++qa
         AJlaBeF/m2N6a6GVsX5/NI4HlT9WeJ5yqXINfKWlsCuhjImx5ANZim3SVuWTor9pSI4W
         yXwfKEmCL8Oh5jv+hviDebeQ7RKFUb0mcA6baSQyyaXPNfo8yPZXQM0uSTEH0Rrt4HA6
         nYP0FHcsrLDoLuQkQjgN9/5oNUDTfE7TYedST9MVD4jB/i8AtE9gDZGhfTLQHPejQOJ5
         +TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tQgirrJxXJmTmU+afvcNHwBLtlIR/mauWurgdutbcLM=;
        b=mlR/it91E1PJEoikksZ1DVEWY7BxbM5+hVw8piwT2ZGPqeZpR1Ng3z3BcLzBxQEi9V
         7LVCWJAD0vWIPNkDmKhmmDOF5UOV34jThSHkZOgvqtYawUW15wIXzCD0ovQa4py8BLW+
         vWPCGuVxV0ouxolvPv1Xc5Q7SdERpcpkvc4Nl86oOT/7aTww7aJF9S44Th8cU4yGwW/G
         vnZu7D4Si5shTa4QMpCaToSTm4URJcXsN7egVc7LqN0bOmRLUy7FVDGUmirK2Hrz1Cou
         UJzwOWddFcjnEbRBupnBctabVMJ9Lpu9IfXUad4w8/mLuLaW1+h1UbVNgwUqZAn73G/Y
         Ajmg==
X-Gm-Message-State: APt69E3ddPAmUX4iglqz3yfKpDUIU2Kh9Kc1Iw+pL7JwM68cl0e41Kh1
        gzbhzuFhpAtV82oPBnbIEJk=
X-Google-Smtp-Source: AAOMgpc2xBwXHm9MU51z6n7bv31WKUbecd53Ut2EjrbbebQlS6VYtFHENCLFThLSdBlhDIrJcBN+Iw==
X-Received: by 2002:a62:d10b:: with SMTP id z11-v6mr18671440pfg.255.1531083946982;
        Sun, 08 Jul 2018 14:05:46 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:46 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 17/18] fs_context: de-obfuscate command validation
Date:   Sun,  8 Jul 2018 14:01:53 -0700
Message-Id: <20180708210154.10423-18-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fsopen.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index dd38f6b65aace..34d7292bb398e 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -50,10 +50,10 @@ static ssize_t fscontext_write(struct file *file,
 	case 'x':
 		break;
 	default:
-		goto err_bad_cmd;
+		return -EINVAL;
 	}
 	if (opt[1] != ' ')
-		goto err_bad_cmd;
+		return -EINVAL;
 
 	data = memdup_user_nul(_buf + 2, len - 2);
 	if (IS_ERR(data))
@@ -136,8 +136,7 @@ static ssize_t fscontext_write(struct file *file,
 err_free:
 	kfree(data);
 	return ret;
-err_bad_cmd:
-	return -EINVAL;
+
 wrong_phase:
 	ret = -EBUSY;
 	goto err_unlock;
-- 
2.18.0

