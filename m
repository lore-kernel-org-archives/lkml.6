Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150E7C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D410C21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcjkijs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388521AbfA1QS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:18:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39266 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387976AbfA1QSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:18:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so7943593pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=imAw9HKTkgky4lYpjJlw+h7HEYeh+bjKOHbPMFg+nYc=;
        b=dcjkijs9gpTNIvdtSxHouaFDhOZ/vqAfsBBSbWwSGyegP11yLdPgYAi5ToWCMuWdAd
         QFMiFQhUvKlfzdZ78Eeo4QDumBncMX3bWMnDkAIvG4bBYlzJYA/mi34LCTgE5xXho0PQ
         Vsa3L+/bEzwdy2PeegEm2A7yENWIPGw/DwVKGOkCJWvi/k7xZFzwIBmdqCpbVRsAln5z
         32kyJHQeRe9nSEu0oCtr2px5V3AmQZ8pZj6CM6+ugFDuJP8MI61nhXuMP+OUY/Vv6NaE
         CBKvM2vnbiJGJU+qkaZlzbLv1SuNbLxt7/3ZnuTkFeI889YIf910XK2+4Y1aLSS2qohS
         104g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=imAw9HKTkgky4lYpjJlw+h7HEYeh+bjKOHbPMFg+nYc=;
        b=b0i3wEw1HWAYHMLQ8FxfL/ITs2qi+myTuJcx7wcN41uIjNwhVTY+wcbGrDEKCmfSoP
         sO4qOPXp4m5FjEPndaeE3twT1OH6unx/MK30QHOxnOYGWaZdWx9/7mXBbh6whjFQJRka
         KYzRAPvWZX0945xzcHPkPLDlevsIIkzl2mu5Vni3pJnr+yEDP9z+emIu94R6XRy3u7d0
         w50wxKArJ0INt9/UVogQssGNeDHWIKZDXvHEXbxfE26kugTrC8zVXP2JCGGfNGd6zDuE
         66qxdvp5n0wboH3Hk1lBCJXcxb/UbrdEf9jk3DVKPjRdgKbhEn8wd7uA/IzXCMkExSM2
         +k1Q==
X-Gm-Message-State: AJcUukfm/oYTDm8o76hP207tz0lEFbSv1aq8JgfSCs2qopMoH9Tfgexp
        V+1/fEQrGWNTwlmNexwrcIY=
X-Google-Smtp-Source: ALg8bN4JgFoLi45V5RjDpMM4fNNzLOSDJ2MkXqnCOpo0sStJOevtjSQqXYkgWnAJxzFoI09LrzGBFg==
X-Received: by 2002:a17:902:30a3:: with SMTP id v32mr22683722plb.26.1548692334817;
        Mon, 28 Jan 2019 08:18:54 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([47.11.154.113])
        by smtp.gmail.com with ESMTPSA id e16sm41736143pfn.46.2019.01.28.08.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 08:18:53 -0800 (PST)
Date:   Mon, 28 Jan 2019 21:48:47 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dwmw@amazon.co.uk, brajeswar.linux@gmail.com
Cc:     jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] include/asm-prototypes: Remove duplicate header
Message-ID: <20190128161847.GA2318@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove asm/page.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 arch/x86/include/asm/asm-prototypes.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 1908214b9125..ce92c4acc913 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -7,7 +7,6 @@
 
 #include <asm-generic/asm-prototypes.h>
 
-#include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/special_insns.h>
 #include <asm/preempt.h>
-- 
2.17.1

