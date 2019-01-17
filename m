Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC75F20868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5IYbWMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfAQV6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:58:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34555 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfAQV6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:58:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so2068090wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 13:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXZp+1IqfY7X6Iggdqfovv+bflwuKahD44sXbWHN4jA=;
        b=T5IYbWMz91hGagbuk8c91Rm6h1BNaygHrBI9zxDCs5+n6ez2St4au1fpOHyLpiYShX
         6Jknvp7ex+Qx5qqLrvgo0Zemgc4rG4Y6UTphLrxv7H1TACK8JeJjcaSM5Xlae5hl5T5u
         md/OoJQzPVMFDz4dREDe2O8cgd/o4PVnLQqaIbR1PJne/7kBhSh2XO+FKNXBsuWhvi/0
         eA+CcVz3TnD4LA1yuWfmwMbCL+9rNHVm0TblO3dYA4iItGQGlo7Fh/yNDgUXkVOeEpcP
         VTr1pbD2kR9Yt1uTG1sp2poIE6GAk/LoQSmaDTcnUjRWlhuWgmNwXTneRMDuUGAMjBdW
         2sGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXZp+1IqfY7X6Iggdqfovv+bflwuKahD44sXbWHN4jA=;
        b=EdrplVSGPoYli1z93/10BFTxwf6nhzV8TM58ibC0QrCdrbz6+NoXiZshm4OI1epW6Q
         GPvrLlyMRsn2JUkqkPQcRzxNZBFsTFsw1D6LN8bGsDc6bghVu1P0VNXcBAnm95GNpG+8
         632eFalnwZqMXeDuUGvmvrp/J6CpFtxOyWmTDx73KL+91PX/qHDPRkD87gXEmXDMDTRL
         scVqDEdgL/TiHbrXXWyYeIF9M6H5bkBz1oZVchZEBkVRtxTW2TavgkxmjUBgYE57lJAR
         xVlKk14QJI6J39daD6bHfUh+/71ANMO8ANb74WDirX2VJ+MtoMUf6aEWV+TXMY07VMl9
         F2wQ==
X-Gm-Message-State: AJcUukeLbV/BizzqxfEwjzBi/cOH6UwQP9N9aInrHdXn03T4rTu5D0jG
        p7Yo81Rc560h0pqADDgm2s5TGvH4
X-Google-Smtp-Source: ALg8bN4ekRrFgctImZp7LkucjOczhoh/FVXQp2G9gzwcUsrwC6cJwLaW6pm+iV2pFD3Y2KqY+X/fIw==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr13620040wmu.52.1547762320262;
        Thu, 17 Jan 2019 13:58:40 -0800 (PST)
Received: from nbbrfq.loc (85-127-81-11.dsl.dynamic.surfer.at. [85.127.81.11])
        by smtp.gmail.com with ESMTPSA id v6sm65576150wro.57.2019.01.17.13.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 13:58:39 -0800 (PST)
Received: from b by nbbrfq.loc with local (Exim 4.92-RC4)
        (envelope-from <b@nbbrfq.loc>)
        id 1gkFgM-0006oU-KT; Thu, 17 Jan 2019 22:58:38 +0100
From:   Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Subject: [PATCH 2/2] checkstack.pl: Commentary typo fix
Date:   Thu, 17 Jan 2019 22:58:36 +0100
Message-Id: <20190117215836.26137-2-rep.dot.nop@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117215836.26137-1-rep.dot.nop@gmail.com>
References: <20190117215836.26137-1-rep.dot.nop@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/redution/reduction/

Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
---
 scripts/checkstack.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 8946fc99ad83..82ea54ac159c 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -31,7 +31,7 @@ use strict;
 # $& (whole re) matches the complete objdump line with the stack growth
 # $1 (first bracket) matches the size of the stack growth
 #
-# $dre is similar, but for dynamic stack redutions:
+# $dre is similar, but for dynamic stack reductions:
 # $& (whole re) matches the complete objdump line with the stack growth
 # $1 (first bracket) matches the dynamic amount of the stack growth
 #
-- 
2.20.1

