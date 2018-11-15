Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A21C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41004208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDdmsuOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41004208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbeKPGsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:48:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37654 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKPGsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:48:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so8399196wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 12:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uuIb9FIXKub0D/vDvuhH1Mn5qLYT4uNO74xEcum8ksM=;
        b=UDdmsuOJOsHJ/4PWRF8P4gH0hbVvSQ3awgUGO+aoEGllDzb7txjcu4cPfThwrrk3rl
         Ixw6yQ0aqOyTZylbPzP0s/csA9IcKQ8MYdO+dC09ZmYAsgIvE15f5n5jSasqxQrVCLNF
         wra6zloUNiLKMTDx3rx/nJGzwdMiav/XEnwlQ/wIZDOugVlPkz1nXaUZpA/VYIq2WJ2f
         xhvoRiyOHtfYG3Fw4/T2H7uWImPbURZF6aXikoYJYH6oyo/2+GPLgnrc7GLPuQBe7teX
         3dHJ9fikKhodblg8YHHsF7wJz887x5CCu7oe4uonKwZcFW+OMJ6t8fUZzkTc6gTQKQKr
         iwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uuIb9FIXKub0D/vDvuhH1Mn5qLYT4uNO74xEcum8ksM=;
        b=gC9gefoEeAtsiD9l7fWTPKlHWWh6Qatm6xUqRVcmwBlgxfBOVQ+yHnwgefBtOpWlPb
         wV8NQAlt+5YceJG+axXPzVlUvm/N9qA3X85iIF76EuYnyMx45sZBy9mj7bBIGC7L1q3t
         B2EYQnp+yU+EJvGJT9GLTNEow+h0tV7nlbpfs5O2hcU6ohJFx8TdOyjtOEcazVaYG21Y
         V2yj+XK4mVXWG+XiDPTayS7+fCeRRzLQJg6vWQxKdOf+nGsF2NykoGOLGAdPGzGtBtUj
         jbgw7N6FJQsPtqnO6y2gmHS/IM0QLneHZQlXCGgSBdkJr3Us4jG0G3wuvkcfN5a3JaL5
         fIww==
X-Gm-Message-State: AGRZ1gIzZOR7vaZtWmF7AmfzGALG+va8a1U71X5NkitP3TQ8876ISGwg
        RPLvakvzvLVbJ3364UlJjQ==
X-Google-Smtp-Source: AJdET5eoE+lxKH/P5tozej9Nf1Pyo3erWPejeDdjsmsCnZLcmfh0jNTJir3bywDBNIMe9iB7fseJmA==
X-Received: by 2002:adf:f38f:: with SMTP id m15mr7057624wro.111.1542314337833;
        Thu, 15 Nov 2018 12:38:57 -0800 (PST)
Received: from localhost.Home ([2a02:c7d:9b5c:9b00:1a75:ff25:fe7f:eaba])
        by smtp.gmail.com with ESMTPSA id j129-v6sm22555373wmb.47.2018.11.15.12.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 12:38:57 -0800 (PST)
From:   Garry McNulty <garrmcnu@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     richard@nod.at, dedekind1@gmail.com, adrian.hunter@intel.com,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        Garry McNulty <garrmcnu@gmail.com>
Subject: [PATCH] ubifs: fix memory leak on error condition
Date:   Thu, 15 Nov 2018 20:38:50 +0000
Message-Id: <20181115203850.5774-1-garrmcnu@gmail.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the call to ubifs_read_nnode() fails in ubifs_lpt_calc_hash() an
error is returned without freeing the memory allocated to 'buf'.
Jump to 'out' label to free allocated memory and return the error code.

Detected by CoverityScan, CID 1441025 ("Resource leak")

Signed-off-by: Garry McNulty <garrmcnu@gmail.com>
---
 fs/ubifs/lpt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
index d1d5e96350dd..c162459a1e02 100644
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -1688,7 +1688,7 @@ int ubifs_lpt_calc_hash(struct ubifs_info *c, u8 *hash)
 	if (!c->nroot) {
 		err = ubifs_read_nnode(c, NULL, 0);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	cnode = (struct ubifs_cnode *)c->nroot;
-- 
2.14.5

