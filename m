Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CEAC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135E320875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxPYVA/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135E320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbeGXVyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:54:51 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:43043 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388604AbeGXVyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:54:50 -0400
Received: by mail-pf1-f173.google.com with SMTP id j26-v6so1124050pfi.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QuyyNq9ZFC3HSMCUHgh/8rZRyuzcFzdaIJ4tDziGVEE=;
        b=uxPYVA/mmGOeMDUwQSp7fsP95cByxOFbPwQuu9YYSQXxnLy+9wn6rtczNieiAMYTBF
         EdFwC2urMAuGvklPJTV7si1Croe+er4LYCBUeYc3wbDEYMkha6fYtxTkxqD1H5Yrfrhr
         QSVdTms33c/o6EEBCThtpKFHd4XljOnzw6W9LJpLhKVv/7DLai4pVD8Ya0ZQNwOGkIQL
         +63ZvTCf2mcts+liMXyIAU1XaVLpvxp5mirN7lGXqCT9wayyrxiYyDrLzvb/U0xMdMRl
         +HLAbN0QOZx+yfCGMXs6fxfq34wKzQ9O4KnY226KXsOwsgmGFN1n8bGog7Pdhv5rf8zI
         Xlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QuyyNq9ZFC3HSMCUHgh/8rZRyuzcFzdaIJ4tDziGVEE=;
        b=nCCv77qgQ+KVd8fzcBDRaKu1/H99RjEwwFZTbOXobPyXN/4jx+opHpSOH2pb9xOF7h
         MZ7w3bMSpBFNBaRmUejsFDiIKzQV79l5GhKpnA+xIEUqQtJdlorpbh1JKucANCIL7HGZ
         WYowwrkTsEkq4Ty9W2MkCX7z5H/jSm8g9iFi6+F9W6bM5e6dqtbSHgPXvcPzMC/59lVK
         CpdgO24308lg+bmaZS9xWDjkjF2Xth18I6til57VMuDTsomhmQ6XwPDoC2fX685ngJZ2
         mZI0CxTKBUehPJJcgHEvVDgPsC+wgTKMRK/HFJerPEBlSsPZPVq8dIguSWTE7AyICw3r
         Na9Q==
X-Gm-Message-State: AOUpUlH1hFHVCSP1/x5GezFJQcsxH+Bdz6SO+mBltMRA9JFGsgCW9CBn
        0rANro/mkOzBKiVvwkwEsnwBpSXE
X-Google-Smtp-Source: AAOMgpd/XPHE/nCDGmkhjFe7JrZIWIb+j3xvpnQYUbXtSL5qXwBhqis2HxINziIDwbv99RG0ZexjKw==
X-Received: by 2002:a65:6699:: with SMTP id b25-v6mr17912460pgw.426.1532465195144;
        Tue, 24 Jul 2018 13:46:35 -0700 (PDT)
Received: from midway.home (static-50-53-52-16.bvtn.or.frontiernet.net. [50.53.52.16])
        by smtp.gmail.com with ESMTPSA id t21-v6sm21536110pfi.73.2018.07.24.13.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Jul 2018 13:46:34 -0700 (PDT)
From:   Randy Dunlap <rd.dunlab@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Ofer Levi <oferle@mellanox.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH 3/4] arc: fix some plat-eznps data type errors
Date:   Tue, 24 Jul 2018 13:46:21 -0700
Message-Id: <20180724204622.2366-4-rd.dunlab@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180724204622.2366-1-rd.dunlab@gmail.com>
References: <20180724204622.2366-1-rd.dunlab@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Add <asm-generic/types.h> to fix build errors.
Both ctop.h and <soc/nps/common.h> use u32 types and cause many
errors.

Examples:
../include/soc/nps/common.h:71:4: error: unknown type name 'u32'
    u32 __reserved:20, cluster:4, core:4, thread:4;
../include/soc/nps/common.h:76:3: error: unknown type name 'u32'
   u32 value;
../include/soc/nps/common.h:124:4: error: unknown type name 'u32'
    u32 base:8, cl_x:4, cl_y:4,
../include/soc/nps/common.h:127:3: error: unknown type name 'u32'
   u32 value;

../arch/arc/plat-eznps/include/plat/ctop.h:83:4: error: unknown type name 'u32'
    u32 gen:1, gdis:1, clk_gate_dis:1, asb:1,
../arch/arc/plat-eznps/include/plat/ctop.h:86:3: error: unknown type name 'u32'
   u32 value;
../arch/arc/plat-eznps/include/plat/ctop.h:93:4: error: unknown type name 'u32'
    u32 csa:22, dmsid:6, __reserved:3, cs:1;
../arch/arc/plat-eznps/include/plat/ctop.h:95:3: error: unknown type name 'u32'
   u32 value;

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Ofer Levi <oferle@mellanox.com>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/plat-eznps/include/plat/ctop.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20180723.orig/arch/arc/plat-eznps/include/plat/ctop.h
+++ linux-next-20180723/arch/arc/plat-eznps/include/plat/ctop.h
@@ -21,6 +21,7 @@
 #error "Incorrect ctop.h include"
 #endif
 
+#include <asm-generic/types.h>
 #include <soc/nps/common.h>
 
 /* core auxiliary registers */
