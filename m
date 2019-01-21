Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9D9C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE4221721
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djS4PyXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfAUOMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:12:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44907 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbfAUOMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:12:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so10184896pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=A0SfeOnkiJq6Qkdmztx66BFDv5wXET9MNgzTXvm4Fu8=;
        b=djS4PyXyfscPPaB5UAWSiOLNZCOBzwzsPO2OzLhLpBUFWXp6He7wBHqPKD73slFsZm
         kTWdZtmfZ4aoRbOdtuQVpVqnpebFHxhYU90CStIdBBSvOKtolmL7Z84uVcCPmgwkNprR
         69Lj5tMEsl6hUY01yh2mR5rHXEUCSjWML9F7g86q2yvP8AfAulzkBGzWIvYu9NViTPTD
         IGO1NKsBBC5wT3I5F5A3dUuwDCDA3jJfFdnxGOlji4/puUYlZ1kp4h2Kl9E8UXSx4Z5Y
         DyfNPCQTqorRSmK/9Gul+quyN0QQcNGjBzrNuP8LgwJB4gt5w1IWNA6byl+lVXg8hpgY
         qMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=A0SfeOnkiJq6Qkdmztx66BFDv5wXET9MNgzTXvm4Fu8=;
        b=cm9ySKduCHRnwJk8KxGHq2Z/6wQpWWDxD4SC+3i5DijgClespFg3xfgzKjwVoX7KGH
         2NjhFcbbjM3DIlO248knktJqceZ5nm9q8h2ZwPL8sgtTnxU3zjC+KJKwRbzl4gryHG+P
         WeCDHk9P1Kf4RtkPBTgMRM5KHW6VLOiLG3FMU59NBfa03Htn0tAAuMiABAevofcSRvUT
         djotBT8sDo1HaDk6E7gEPg/y229IgjjnVrXOIBoU2bMDhWZNq/mH3ifPl0buK4sq4rCI
         TOfI1TXVn0hoctMFMZWo/Qqp3k9IKLTJNgeaS5i5y1Hu7b9sxFLpDnEf0R5GSKA2jFdL
         wqZg==
X-Gm-Message-State: AJcUukeRgE4uki92fMxN7OO12huqMWpitsjnZGHEq3nd7JuFY+AUysXh
        1xwbQerXg9aWEjBcjgYbS08=
X-Google-Smtp-Source: ALg8bN6hPgvz6C1s4UQBsVC+4ygSpvvid/8C1xNtBrlVDVPO74OCdB0yl7dLbTxzX3XRIcHcEY6moQ==
X-Received: by 2002:a63:e950:: with SMTP id q16mr28375021pgj.138.1548079943017;
        Mon, 21 Jan 2019 06:12:23 -0800 (PST)
Received: from sabyasachi ([2409:4061:61f:bee8:59d9:12db:80a:c3ca])
        by smtp.gmail.com with ESMTPSA id 7sm22401313pfm.8.2019.01.21.06.12.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jan 2019 06:12:21 -0800 (PST)
Message-ID: <5c45d345.1c69fb81.d90ed.8e05@mx.google.com>
X-Google-Original-Message-ID: <20190121141214.GA4205@sabyasachi.linux@gmail.com>
Date:   Mon, 21 Jan 2019 19:42:14 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     lftan@altera.com, akpm@linux-foundation.org
Cc:     jrdr.linux@gmail.com, nios2-dev@lists.rocketboards.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] mm: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/ptrace.h which is included more than once

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/nios2/mm/fault.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index 24fd84c..eb65f17 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -24,7 +24,6 @@
 #include <linux/mm.h>
 #include <linux/extable.h>
 #include <linux/uaccess.h>
-#include <linux/ptrace.h>
 
 #include <asm/mmu_context.h>
 #include <asm/traps.h>
-- 
2.7.4

