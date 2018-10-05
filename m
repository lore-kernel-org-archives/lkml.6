Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CF5C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA79208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB/pc7f8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA79208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJELLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:11:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36259 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeJELLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:11:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id f18-v6so4143846pgv.3;
        Thu, 04 Oct 2018 21:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
        b=aB/pc7f8FxZc7uvWjU1rnHCfgnfN0z8C3vWsTvXR9xDr0ZaXu3l+aKzPSrD4J/PtBZ
         g6Nuvdx+FJHvQzlFn43EqB/Z0MzHmEKcv1sd7dlaF3rQKM0RC8DzbbXZ7AYmPTj0YgP7
         JaNzyAfaTGpL3cArYhv5Hh70vUMvjcEmFJ84jyhunUzqBjEFYxl6x84NDxj7okW3QMqC
         YeTjxPW8riexKDFWU3ZxE+A+p0Xfw+CoXkCmw+TbQsh7MqEXC4l5jCGSIC+Ldz5whgSA
         Yt2TKSKwgjN0TIYIlZPyDhu4d4r4EkSPrEFm8W/G3FlffIMGXsztEQkdK2uW60nMD21l
         HzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
        b=pf0K7/0B4FRTkRjJbey/XkZeO63U6OYcr31EvAd0kL1iEU+DpC6N2MUeby8MglynDd
         9BvVky8F7rmonMVh54lfYtGFiI2/+2jLnd1/WrEnH8Y59y0TX4meNqpVD4hvHvXmwfCr
         AEhA/aT5JPH/a4H8P456MC6ca1pYdfIFRIOBgH7HMC93nRlD5kwbT8UfgaZ0xp0Uzr9o
         v9NyLaAhgAGi3gwUqZWjDWhkniADfQZcyKcId7zjDD14EkxBmEDHfAW3CE+oH+REiW3s
         zxP1bYPdzEELCqF9z41U1+lhhDqVdQylhoVNdXqXImeHXAKghTYKfdsPBXYGCK97Xh8T
         cJtg==
X-Gm-Message-State: ABuFfogQaIgJobBafBEuYgMe++uQONxZkOv288fW7DBwc5kz6y0TVCN6
        8bOZG7+LR2+/fD2QEj4pZGxUpdNJ
X-Google-Smtp-Source: ACcGV61470fq1TFoZi6jkEm12Z57jOx/YB0UTtMISFtSwg/fGVSHpMljSvPiU4o8Onwg3riTLIACxg==
X-Received: by 2002:a63:6203:: with SMTP id w3-v6mr8425138pgb.53.1538712857052;
        Thu, 04 Oct 2018 21:14:17 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 21:14:16 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 04/16] powerpc/pseries: add of_node_put() in dlpar_detach_node()
Date:   Thu,  4 Oct 2018 21:12:35 -0700
Message-Id: <1538712767-30394-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
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

