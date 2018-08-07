Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A611EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1432173F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7CmxZN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1432173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbeHGM7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:59:06 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36752 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeHGM7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:59:06 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so6969005plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 03:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7XnpbU30l1Fe3R8WyVHQ4d4M5K53k9CjTKaucIp1NAk=;
        b=B7CmxZN0LniYVGHe1kR/g2j1+8wiWK033Nv4qkrQ4We4rpHhDIsYE6p38NIbmbN4b6
         iasu0FJHsfo8xUbL3Yy+6qg+4h7XAc4gHMuQMYuiMdBX0KF3lhp103mZeY3bHLD0iS+e
         4uoV55RDL3jBkxQEnqqWp1T/DEJzynCnjM3B3Ma35N1VRLL4w8Vk/nOPv4l0J81C2mXM
         fO0wQyUwb6tkp/MiucohOWflXwaN436M65hDVJPFuaMM0T+aduMaC0PkIbp6ceAsYfuv
         pOZpwjE3aLI3lYzBHzrw6gRayXnc9FI7R4wmjedWnFG7qcC5zQMF10nfKsfOKYtJ09TJ
         UzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7XnpbU30l1Fe3R8WyVHQ4d4M5K53k9CjTKaucIp1NAk=;
        b=KlRaq5AlTRACKnHSRMEZSgIz5Q6XAG3753pw29z6fYnx+gd/F8TdFyz6AV0LjMg0Yg
         aqfl5fy3x5skyhA4B+5QzJTjY+eSzdZiDKv9JfI6LsR1my4pZOlmUuDyoK+2abcY7yjP
         CKr2x39M10w1W6A41ubsBmlbRRuZ3LCxL25vOnY6TX3nzfHNaLiJtbSTmlk+7lPfn+xF
         j/OjZtFFWixR6ZQjNhxcMNaDADTQ6Y+CsXV5Uo/cfIZGO0/WXTyUDSXwSgi2MampyRc3
         nOJYhMmmELDPpWZKRZCqWJmqz0u5oBnfYHMV40yYjSAslgHlavc05DXNPTG2UHEkO6xI
         /3Dw==
X-Gm-Message-State: AOUpUlHTaMwSPKgb44HEm2+YAYnzMqJoN3bg9zlwReiYPKtD/+y1RzYM
        hzNWxHhimEy/GV47/1yArbY=
X-Google-Smtp-Source: AAOMgpfBz7ThNyoB+OGHG0BKluuvipe4NCKUTbT+MGfhvwMjREGOIyW1QNBAYSFjEZFMxlA9WZ11sg==
X-Received: by 2002:a17:902:2f84:: with SMTP id t4-v6mr17267714plb.87.1533638722818;
        Tue, 07 Aug 2018 03:45:22 -0700 (PDT)
Received: from blackpearl ([175.100.146.34])
        by smtp.gmail.com with ESMTPSA id q26-v6sm1674487pff.9.2018.08.07.03.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 03:45:22 -0700 (PDT)
From:   Sumit Pundir <pundirsumit11@gmail.com>
To:     rspringer@google.com
Cc:     jnjoseph@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Sumit Pundir <pundirsumit11@gmail.com>
Subject: [PATCH] staging: gasket: fix code indent for conditional statement
Date:   Tue,  7 Aug 2018 16:14:28 +0530
Message-Id: <20180807104428.24486-1-pundirsumit11@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue related to indentation. Reported by
checkpatch.pl

Signed-off-by: Sumit Pundir <pundirsumit11@gmail.com>
---
 drivers/staging/gasket/gasket_page_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index ed6ab3c5f038..d4c5f8aa7dd3 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1311,7 +1311,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 	gasket_dev->coherent_buffer.virt_base = mem;
 
 	*dma_address = driver_desc->coherent_buffer_description.base;
-		for (j = 0; j < num_pages; j++) {
+	for (j = 0; j < num_pages; j++) {
 		gasket_dev->page_table[index]->coherent_pages[j].paddr =
 			handle + j * PAGE_SIZE;
 		gasket_dev->page_table[index]->coherent_pages[j].kernel_virt =
-- 
2.17.1

