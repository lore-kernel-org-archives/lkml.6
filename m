Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE73C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8339120675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY+k9JDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfAKGm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:42:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40070 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbfAKGm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:42:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so5912887pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 22:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=RXazlCLC+fh5A8rzoHGP/wwJ5mYIgXpL91wntwPhYIY=;
        b=LY+k9JDy9sOGZiFz3vAaJat5W9zNg06kcwVSODVHzjjxlEBRfyLkmjrvZnY70Zwykh
         +cEIr8iFZuxFBGsJj3AtmnP8acYyhBCZ+LKW6tF72LdGimTI/WLWz7KWCk6pUXVuJzhJ
         FWNYvKZZXCiBBKIZTAIAtpsoNMhVM9vJOnSk6/tfmuxuBGpCgs2xea7RpJXgsfPyawVR
         PtsTrA3ZMoiCwabT1B3sjvsYNER74pZhDgc1KnSffESWOcfW+M1Dvh6dOelj+iqc2kNw
         HezLmFsx9fa0m23IuP4/hMKd6Zem0xV8prToicpf9YGhhPR9/DO69nqK1QjjOIOj6DRr
         e78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=RXazlCLC+fh5A8rzoHGP/wwJ5mYIgXpL91wntwPhYIY=;
        b=NnCWdLiT9FK2s08u/4yB8OKhO87qZcyYA2fCIudowD6AsyAopVZy3c0ACsR7XE6fFB
         338VLVtznZjYb7eVedCxzYlWUAA0wD2u7ElSlpntLzV3evU6QNhpVLOFZ2G16Xr8bUO7
         X02jP4fMWZH6vhjW4mqaQYLqBkcwKmbXQ0kKlgZFGkUl5CjMkp+smcprf2DHBvnyX2JR
         lUFngq4g83tbQB0gIiOWdqEmlyHmLOHUIUzfs1rjEPj6B8MFNstXdK47XaulcRJoNGZP
         bgKnm0HO19R8fc2Gm9NyMa49uQKSS+YMsfjMjXt6gn96+omZ1tcUtSHA4p3Lxc0DB1HN
         gTQg==
X-Gm-Message-State: AJcUukew7Uc3ur73WQOcLn/Nven2Fk8ceHvnF8I+tColk1FiwqyoGjfx
        b8ICEa4PTW/8Qhq62x1V9A0=
X-Google-Smtp-Source: ALg8bN74bJA7PsORYFSUN6+dQZOQsqC3pWr6MIy5pzMFUyjTxSuQnW6rTx+d+aQZdTh7ShW2lgA45A==
X-Received: by 2002:a63:65c7:: with SMTP id z190mr10107143pgb.249.1547188977518;
        Thu, 10 Jan 2019 22:42:57 -0800 (PST)
Received: from sabyasachi ([45.116.191.228])
        by smtp.gmail.com with ESMTPSA id r66sm120722562pfk.157.2019.01.10.22.42.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 22:42:56 -0800 (PST)
Message-ID: <5c383af0.1c69fb81.c393d.125c@mx.google.com>
X-Google-Original-Message-ID: <20190111064252.GA3691@sabyasachi.linux@gmail.com>
Date:   Fri, 11 Jan 2019 12:12:52 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     dhowells@redhat.com
Cc:     jrdr.linux@gmail.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] fs/cachefiles/namei.c: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/xattr.h which is included more than once

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 fs/cachefiles/namei.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 95983c7..edecb7f 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -20,7 +20,6 @@
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/slab.h>
-#include <linux/xattr.h>
 #include "internal.h"
 
 #define CACHEFILES_KEYBUF_SIZE 512
-- 
2.7.4

