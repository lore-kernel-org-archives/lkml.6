Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B88C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B81020883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkrIIu2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B81020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeKIPqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:46:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33030 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbeKIPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:46:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id v68-v6so459139pfk.0;
        Thu, 08 Nov 2018 22:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BPXZwtRgetnBLrUpBT+lCnjneySeub2dSLMA8WGIcW4=;
        b=EkrIIu2Bbaz7Q5a1p4vHI1Ih+6VifByNtOjp+3BxNjeFPo6IbyhKXVMpfWXEYFQNDq
         lfPXfZgxjNaPkAjSwdq9+lLNRzI+/XDcdUpZ0twKVnGeGiWSOrnzA4kLYGzYvXUuAFgv
         rtW7lu/4f2l0wDMZU2rVhxK/sLAgf6Vb1NPT4yvKVmRIAabSkWpgp3YvMZ1bwfr8wFcd
         uhLkSr6XvAD+dopD99rKwir7s6o3iRNDpM5+XkCObgBcasvSwEGcM5r+w+lMwAp67kqN
         jlPI1+gRmFLcX1t0dLWTtrL+K8GrgPvRHuxxvEDjLH25ldqVMUY7wX9CNs40DpFYwzFk
         faRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BPXZwtRgetnBLrUpBT+lCnjneySeub2dSLMA8WGIcW4=;
        b=f2wwR4HE67N3gp4f2GsIxXO9r1QGc/crq45ex7VDixFE6swRplG4z6AsdoFlYiA0GV
         iXyHuBZsHMZV+ptm6kOiiGZwdGkyY2DmnYRytZSdTvTx5aNNr52G3P0jkB9VxmQkzM3m
         0aA3zD7u59d9jficZPn+6+/hZ8lCCHP2aKw2PhZ4t18mthKMIQk+q6HiQK1PavftsWKt
         XTrk0BF0jVF4cgtNw9VWPcLuw6rQhgbDlWE1klp7xkxhBVQCrx7cr4LvJRZmWkdmFEcL
         ssQvggbRwUb3vyJxzurOPEnZBlEd9IoNIfjyVvJ8vLV5lADBkUqYN28x+WLWMLM8w6r2
         XwGQ==
X-Gm-Message-State: AGRZ1gJFq+0pZWr5LJkzOw2VXUER/uGczSNlUzvBwBfhw3c2yuklUzFd
        NSdtoJ+AjE/V9Kz9JIewOx0=
X-Google-Smtp-Source: AJdET5da2TcsX1KX5EyS3JIzD5KOqYlhS+7XR++v9e006tNHYTB7pPFVWI0qF7pu3+h+EPyEar7FLQ==
X-Received: by 2002:a62:8012:: with SMTP id j18-v6mr7624921pfd.202.1541743669402;
        Thu, 08 Nov 2018 22:07:49 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 22:07:48 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v7 04/17] powerpc/pseries: add of_node_put() in dlpar_detach_node()
Date:   Thu,  8 Nov 2018 22:05:52 -0800
Message-Id: <1541743565-23163-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
References: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The previous commit, "of: overlay: add missing of_node_get() in
__of_attach_node_sysfs" added a missing of_node_get() to
__of_attach_node_sysfs().  This results in a refcount imbalance
for nodes attached with dlpar_attach_node().  The calling sequence
from dlpar_attach_node() to __of_attach_node_sysfs() is:

   dlpar_attach_node()
      of_attach_node()
         __of_attach_node_sysfs()

For more detailed description of the node refcount, see
commit 68baf692c435 ("powerpc/pseries: Fix of_node_put() underflow
during DLPAR remove").

Tested-by: Alan Tull <atull@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 arch/powerpc/platforms/pseries/dlpar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 7625546caefd..17958043e7f7 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -270,6 +270,8 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
+	of_node_put(dn);
+
 	return 0;
 }
 
-- 
Frank Rowand <frank.rowand@sony.com>

