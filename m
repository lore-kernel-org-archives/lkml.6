Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37504C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F161A21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSe2uh2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F161A21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeJPK1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:27:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44185 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJPK1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:27:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id r9-v6so10641791pff.11;
        Mon, 15 Oct 2018 19:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
        b=QSe2uh2lmEBWzGocx1091GFtso1i+7JvcwBNHmFcLCaOD9XT58ge0nRjLWnEsf5qKW
         Q7rYPC+wn+HYN+ZQBLHSd7Jv+IT2SMyzU5ZRp3qLwxv9ZgEAD4Z6K+WVbEgXOudkKqSz
         B6qXTLLyzrEaFLq8Dv0KVfuanrf5EEk85M5YHq1EZEnXNnK19YBs56l4homFQOa+4v7Q
         PgjlMiyAafVC4bQUTijplazml94eUr68CoRd2HQb/OZm3dsktc6DA7LKol6V0jDoitAq
         n5txE/0Ol0tzKfWlBU4dLXytbimzSU1jspWGAcAFvy+XTZAOVPZutwGQjST6M6ArYaV+
         lJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
        b=n4qYedft+VA6X4EVIiP8K0zC6cNMjCA5tX4kSFbkXPrEIomjgrRQANmVLWvDboCwPQ
         6tezNpilCmALtJHzIV2XO1rf7d/Bt0rxOgXy1CzrMJTOooSuoBFLsfB80NgF/o/XMHjX
         I19fJJ/KMBkXZMAwohEuhrZ9Dd4S+ZfjxWDI4Lqe2mnQwyuAk+WJAoeeDJ+jCqgyahBe
         oc/etJ0PXNeBW8D+Z8cR15cY9YuuSqbpPKsDIcPXHvEMs18QyEtS9T/qZjaOj+ZkNbE9
         q0p8RFMuzaq6eCToQhMqyRCu+d9Ny82bq7s+v5/HWrckG47mpWOvo4QjFWEHo8zsrAfn
         cFMw==
X-Gm-Message-State: ABuFfoiVeTFpAP+GAOjqYGTseWYtYYuE8o19Zs179PmuQeB8VPcR1Uwt
        5Sv6pypmgUpF1zlYHPpAAf+Yyok3
X-Google-Smtp-Source: ACcGV62qv6djpH8R68FA95H/QfvSFm8orbPd0ksC2pwJ88hxHx2WZA0HtD94qwQDOruHZyvKuRJZ2w==
X-Received: by 2002:a63:9612:: with SMTP id c18-v6mr17827455pge.21.1539657556344;
        Mon, 15 Oct 2018 19:39:16 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 19:39:15 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v4 04/18] powerpc/pseries: add of_node_put() in dlpar_detach_node()
Date:   Mon, 15 Oct 2018 19:37:24 -0700
Message-Id: <1539657458-24401-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

"of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
added a missing of_node_get() to __of_attach_node_sysfs().  This
results in a refcount imbalance for nodes attached with
dlpar_attach_node().  The calling sequence from dlpar_attach_node()
to __of_attach_node_sysfs() is:

   dlpar_attach_node()
      of_attach_node()
         __of_attach_node_sysfs()

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

***** UNTESTED.  I need people with the affected PowerPC systems
*****            (systems that dynamically allocate and deallocate
*****            devicetree nodes) to test this patch.

 arch/powerpc/platforms/pseries/dlpar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a0b20c03f078..e3010b14aea5 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -272,6 +272,8 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
+	of_node_put(dn);
+
 	return 0;
 }
 
-- 
Frank Rowand <frank.rowand@sony.com>

