Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559F3C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006C720865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUo9xGDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006C720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbeKXUGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 15:06:30 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39221 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeKXUGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 15:06:30 -0500
Received: by mail-wm1-f45.google.com with SMTP id u13-v6so13862095wmc.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 01:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jJNi7wE6Lk6Ji8Aj5FYC0xKG1Fkneqp2f0sjWnaUa7Q=;
        b=JUo9xGDsEROe8vSE1jx67FkYgzTaFjtFMuk5FEjKRM2Uu/dDnZkTDes+jg5GoYKXii
         TPdjUJR/X6wxhE5Z34GOrGqGBJIBlZNuS/K/2saKdSGczPkSu7FP8VkVrsbVV/KIY0dd
         h9Lr9iCu7hI4WqLCb4G6h9/OaUSu/kYBo9bST6giHiXD8gZa4J9uOxV/u5SdaEOljDFg
         Z0gXjoROl4qo8XVhmfCi+heTq+cLw5wqybMy3+OJb8cN36UWVkzajQm9xrE/xCm3tams
         /Ye3kXlT2JFABzCSWUA7YLkhygsyQpaEBqUBPUxmjBW5vvk/v2lVVf6qrrIZDfpu+i1H
         HaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jJNi7wE6Lk6Ji8Aj5FYC0xKG1Fkneqp2f0sjWnaUa7Q=;
        b=GsaIzyRPq4rixdB3KkQSU6HJBVO020O4kCU6nzQAQJroMpmwO0yMKk1fPgbJpP90FZ
         eY/PlmMaASmzgRKoAXuJkrByECZ4nWGRq45a58wE8hf0CqcGo5YDtVlt31I9pWU7oLxW
         t45mPKC7AtluZL73M3a2Ehe0aefEmuDxhhimXLXbDg/oJWXm1lMJnCBRwNXzMRYIJ8pf
         V3O17ViUBn9mth5fDMnmSEP2Pje7Oy7UazSq6AIh8PbV2lzvnepB/PTcsFNTw1TEvKSY
         a32/wceU5kgjsg+3V1jP/Mkif015XPjmrn0jotWcRPyfXMuc9quh4gi+Mt09Di2MZh7w
         JsGw==
X-Gm-Message-State: AGRZ1gJAXBJLn8VcDO8BPZS96xiDEc5tHundFzxMfAxl1z3V+a2yQ0s8
        uDAUMoB8TShNKkFfwXcHuA==
X-Google-Smtp-Source: AJdET5c4yYEQeYFd8olj97eOYEdxyPf6odBNH6sRWUudQvO7W/zL0Tu7KxQPUSrJ3upENU35rSvPaQ==
X-Received: by 2002:a1c:ba54:: with SMTP id k81mr16294965wmf.153.1543051111531;
        Sat, 24 Nov 2018 01:18:31 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id i16sm13422031wmd.28.2018.11.24.01.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 01:18:30 -0800 (PST)
Date:   Sat, 24 Nov 2018 12:18:29 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] make "initcall_level_names[]" const char *
Message-ID: <20181124091829.GD10969@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initcall names should not be changed.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 init/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/init/main.c
+++ b/init/main.c
@@ -934,7 +934,7 @@ static initcall_entry_t *initcall_levels[] __initdata = {
 };
 
 /* Keep these in sync with initcalls in include/linux/init.h */
-static char *initcall_level_names[] __initdata = {
+static const char *initcall_level_names[] __initdata = {
 	"pure",
 	"core",
 	"postcore",
