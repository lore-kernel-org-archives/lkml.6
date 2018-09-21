Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077AEECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D672154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt/VztWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D672154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391333AbeIVB3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:29:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36444 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391102AbeIVB3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:29:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id j192-v6so4462477wmj.1;
        Fri, 21 Sep 2018 12:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FAhlPDumkMGXgOo2/rsfaCLRaM0SPVtVgtCJunyOUig=;
        b=mt/VztWv3zuy2fDlsKYNJY5nMcr+8usKbyq/7DssLfPa/00bUA+oD/4Ias7FWRQRb8
         OTo2PkJoa45KCIKMJl9lBPNjQkphVpRVavPngIWH726XMsE4hRuzQEiG707I+RLn2z61
         qYD8E816DJ+B2fYuPlJJ5v07BZ4Od3hNJWcB7uQVJIFGG0qEtYk9UCGiNAuR7ORWf0zR
         rwVZTmuH/Osufad7CyWMCmvTLrfk2Jf19YFKQD0pu7miAYncOtaGcmsQkN5Fc2becNZ4
         nsiFmL8vXSbuDP4Rk34uDbRnX4MZAn4AM5wVmsihW/+Ql0W2SkLgSOSrBVtlwcUwC7qy
         hOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FAhlPDumkMGXgOo2/rsfaCLRaM0SPVtVgtCJunyOUig=;
        b=Mi3ReDnOQHlvFRRC+FK5zpoTgTL+3dDLoZBDNZPcADiTrZGNAmAINGFbAz9VIYQl9M
         KfJeAAepKCAnxiHrqtLFgNaaUZFwxkWwgVy2bPhq7nYa3Dna+DOQTBDmu8LGXPqpTD1t
         DokcP3o9cm6JcZK+t4xtyn5stB6W9Li50BDffNNclFAvoJFKvxsdedWBUhvAiuEJv1If
         OzmeiI10/Hsbb7zrwnHEufV9XTlJP2qxv4pUMJw242YrEl/nIsmjf9JkBqkm6eUVqBrg
         AXjbkOm6eW52HREa6cRHlkz3+lGlMBxdTUvW6u2j6bWTyeycAW/fhr9NB3uairxjERK7
         SVPg==
X-Gm-Message-State: APzg51Bm1Kop7T6DoQc3rhP4fS2CNVXcvU0EYTo+thrrhNrHSSYcSzVd
        T6JX6gVAVtvL0b1Ssq0fezc=
X-Google-Smtp-Source: ANB0VdY9xcr/X4q07H4Pg0q/hcQOKkM7hImoQYV13+RRJJN/zDCka1H4gr7HGusfKkmW2vOnHGYrig==
X-Received: by 2002:a1c:b984:: with SMTP id j126-v6mr8481409wmf.25.1537558758140;
        Fri, 21 Sep 2018 12:39:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z13sm29773086wrw.19.2018.09.21.12.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 12:39:17 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] i40e: Remove unnecessary print statement
Date:   Fri, 21 Sep 2018 12:39:07 -0700
Message-Id: <20180921193907.4864-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that the address of a pointer will always evaluated as true
in a boolean context.

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:136:9: warning: address
of array 'vsi->active_vlans' will always evaluate to 'true'
[-Wpointer-bool-conversion]
                 vsi->active_vlans ? "<valid>" : "<null>");
                 ~~~~~^~~~~~~~~~~~ ~
./include/linux/device.h:1431:33: note: expanded from macro 'dev_info'
        _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                       ^~~~~~~~~~~
1 warning generated.

Given that the statement shows that active_vlans is always valid, just
remove the statement since it's not giving any useful information.

Link: https://github.com/ClangBuiltLinux/linux/issues/82
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 56b911a5dd8b..a20d1cf058ad 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -132,8 +132,6 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 		dev_info(&pf->pdev->dev, "        vlan_features = 0x%08lx\n",
 			 (unsigned long int)nd->vlan_features);
 	}
-	dev_info(&pf->pdev->dev, "    active_vlans is %s\n",
-		 vsi->active_vlans ? "<valid>" : "<null>");
 	dev_info(&pf->pdev->dev,
 		 "    flags = 0x%08lx, netdev_registered = %i, current_netdev_flags = 0x%04x\n",
 		 vsi->flags, vsi->netdev_registered, vsi->current_netdev_flags);
-- 
2.19.0

