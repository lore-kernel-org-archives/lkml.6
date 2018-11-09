Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218C1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73822086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD+xGwnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73822086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeKIPsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:48:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44749 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbeKIPqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:46:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so395382pgs.11;
        Thu, 08 Nov 2018 22:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mDWmpK0OiVEqlMHbao8c5fx+Nz1R8IrIrFeiQ9xLgiE=;
        b=aD+xGwnUvNx7F6b5urQpDG08DAJqs9jR2F8TYWw1qtOia26z4rR03LnvPYrfajbXLB
         RR5CNLZbosvqOQHPkylM8pddXfa7QTqT7CgU7GJ98FDCwjnH23YTcxJnU4r/d1xW2XZE
         UT3Eh/eeXGhyG6vbrvp5M+foTwbUxJIE2MZbQqEbfs0PEw6vlrtmOp3H2iVnDKBJzI5H
         K2fDD9UA/fFaZlQIt8n41Izu0jSKhILi7ue+b2ZlvBnaT1z9eOspkucRPofNoBYJXN88
         j58myxzYKAW3evN+SmeTuWMrmsQpkofTnsyT6JL0AB2tIFjqmUXI9AP/gRbA5rkxyi2d
         0+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mDWmpK0OiVEqlMHbao8c5fx+Nz1R8IrIrFeiQ9xLgiE=;
        b=SjyspLd03K578iwHKdc2bwQEEh6Q1sFVKUBPLZQo1WdKx4Oy9oArCmZ7Zux9yj7P66
         x9+JuV3bxh3S+rjybyTOUEHbERBF32TsgoTHN0KETQ8railiDYZuNs3A77AOG+7d/+X4
         hCPwEWi/jwwIdJJRcDs+c33vWvetRXdE9rKtNP9Qcp23Dp7Asajnjw74vvNNLK1cOZuc
         59iTMzlDdglfTrN+efj4jOw3Z8RjZ8hM1M/0GPUOBgliyL7ITG7pIb7JnWMEMU7avRo8
         i/VfhFh7Pjo2AKWKSvJM4D/OqxBuClz6HNtqcL76RCJpg9UEuCF/wkW5SX0Nuj1lQZN7
         wnIQ==
X-Gm-Message-State: AGRZ1gIolD/ncb86+1kkcgvmmP9ua/aUJuZu3Za8nwZ9jvEQttTdvRfU
        hQNMcrFXneBRShH3APsL564=
X-Google-Smtp-Source: AJdET5fsZmSstsbi43stjFnRnWNJknkhYNkENqZsgyaNhzHhVlyaud0easBVeFglZJBFloKafLiWXA==
X-Received: by 2002:a62:2c16:: with SMTP id s22-v6mr7629189pfs.6.1541743671902;
        Thu, 08 Nov 2018 22:07:51 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 22:07:51 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v7 06/17] of: overlay: do not duplicate properties from overlay for new nodes
Date:   Thu,  8 Nov 2018 22:05:54 -0800
Message-Id: <1541743565-23163-7-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
References: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

When allocating a new node, add_changeset_node() was duplicating the
properties from the respective node in the overlay instead of
allocating a node with no properties.

When this patch is applied the errors reported by the devictree
unittest from patch "of: overlay: add tests to validate kfrees from
overlay removal" will no longer occur.  These error messages are of
the form:

   "OF: ERROR: ..."

and the unittest results will change from:

   ### dt-test ### end of unittest - 203 passed, 7 failed

to

   ### dt-test ### end of unittest - 210 passed, 0 failed

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 6fd8e6145e10..9808aae4621a 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -393,7 +393,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 			break;
 
 	if (!tchild) {
-		tchild = __of_node_dup(node, node_kbasename);
+		tchild = __of_node_dup(NULL, node_kbasename);
 		if (!tchild)
 			return -ENOMEM;
 
-- 
Frank Rowand <frank.rowand@sony.com>

