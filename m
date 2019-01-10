Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2B3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8391D2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Swa9WSoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfAJPZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:25:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46057 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfAJPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:25:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so5436252pfd.12;
        Thu, 10 Jan 2019 07:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=k99t01FnTowbQW6ZCl0NJtyXLV7y5o0Gwv4+MzhnJfw=;
        b=Swa9WSoH7JlKAw/FheNsqIO0ePS3dwKpdxC6tUFMGG1o61P4rzdTH52leq/1+Qek8q
         KtEFwKUdaF4G0HEIYI0TXb7OSY6EYrTfVSmn5Uih6Fk329Ohtn+bOIST3GlTKX+0lT/p
         WHzZR2MfPOgpSARi8M7J1gbq3g+UWIY84YUXalAAahdvjjpEMVlqj0smnclcri9HMfhO
         hle91g4w6/sWwEPuUvB2CchQ94OhRNnDyMFHJPEt2W4zf4NB/qVNyWnnFP9sj4dBBK76
         NAU9+S7qvkhU3k/g6P4990JyewG2zyqlQiHzYhw1knzsJ8AQk3jqoStm4NyYV4CS2GRB
         wJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=k99t01FnTowbQW6ZCl0NJtyXLV7y5o0Gwv4+MzhnJfw=;
        b=cnFX7pMREDSeeODKsYp+EiSVeSWY2q65o069BPo+jzs/xZIv8BqS84AzxPPUjTiAf7
         SeG0Sm1prbDvyy/JCcXYeZR6rXI1VszBDmIf9CyQM2r6T4pbUFqQEyTiOOC/0GAh+vaW
         cz8wOWBSEQwrDXwSsJbh9vHToxjqjvpRdUrWIry73GM7qff0XRcNt1s/vg6DfHxYJx+B
         Y25zXdLJh9/6ug7F16M8uqzju05JoDDuZb8edv5iEebgufEC1kXLc1ZMuXLTEaONn6GN
         mTKsntIIK7n3YtYhKFGLwlRQG+vW4VIin0jHY6j+Piep4n4vLXqeDfx8OdqTtvog2ywx
         vX/w==
X-Gm-Message-State: AJcUukfsXRkK0jZZ1KYbUyZ+uEGBXhIy8y5Hz9GWyiOURy8/XjRiZh3g
        GXNe9HJVwtYSWqYDDnGGfNvIY+o9
X-Google-Smtp-Source: ALg8bN665FZ0E60h0zggbeIwd6GQWRjQTprdDh432TWnnqGA0yhQygCQBcOPMIZ2B80ofKhBRyM4ww==
X-Received: by 2002:a62:1b50:: with SMTP id b77mr10682951pfb.36.1547133938626;
        Thu, 10 Jan 2019 07:25:38 -0800 (PST)
Received: from sabyasachi ([45.116.191.237])
        by smtp.gmail.com with ESMTPSA id o1sm114236579pgn.63.2019.01.10.07.25.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 07:25:37 -0800 (PST)
Message-ID: <5c3763f1.1c69fb81.f2570.4457@mx.google.com>
X-Google-Original-Message-ID: <20190110152527.GA22558@sabyasachi.linux@gmail.com>
Date:   Thu, 10 Jan 2019 20:55:29 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     jrdr.linux@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] fs/block_dev.c: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/dax.h which is included more than once.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 fs/block_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index cdda48f..8abcdb6 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -29,7 +29,6 @@
 #include <linux/namei.h>
 #include <linux/log2.h>
 #include <linux/cleancache.h>
-#include <linux/dax.h>
 #include <linux/badblocks.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/falloc.h>
-- 
2.7.4

