Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080B7C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 12:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12DC20869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 12:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M14PhSzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfBBMyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 07:54:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36782 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfBBMyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 07:54:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so8837586wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 04:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LzRibTrepdgl7Xt0hOi6YoBdYALZ45jbA83RBWJYnEM=;
        b=M14PhSzvkCE0QtOPiYvmCq/2BEcrLyIyQ80miyFXr2iDquOKEI+eXj/jKhbaJRcj7u
         fpQNdDNcC4sG7D6nyGtNbpl8tah5in7sa+ssfztYlFL5j+ZJp/dHkD9LWsC+fQSwVzwI
         FOzlSK1pnbFkh5riPVdCdfYpYgL4eUxPlKI/5VwBZYzaqqadNxUqNNdV6PjRjsE682Lt
         UYCZM1iDy+f+ej0C5prJLn/6/pupcEH6RoKYspatPOyqh2eqOxU3TdVSz1UeLSJHL9Ep
         q1t3kzkLv7wVsiC0dK6/rrCETWHs6ritpf+n8M75HGCVXI98Z16dMty0sGih2b/Brq0q
         pAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LzRibTrepdgl7Xt0hOi6YoBdYALZ45jbA83RBWJYnEM=;
        b=pEAqVJp7GL9qNYPg0BK0bNYwkTCflxopIzZcPe6blObHVSETRO8H5QrOsdUaeIgQvP
         11BB13YNHLoUp3tiNAuzxfVdfenwbelA8VQX5IwD4LKdrC+RjPnmqgOw24St62pM6OMm
         yfIA2YFyImg1ktcEJVj9shU/8OUcFKSBJB8+fbzcYdJ8AvwYwlDTqqre5Cs99Ddir9OP
         WN/6os9fCM2iN+YxbJyp4+l8sN6ntcRNy8zO6J+dh2fVD33eLxcRzVRwgk/y8wOFWT5m
         ingpimx8o7RW1YnulLteusrMsyoG/Xkva6TrR/QQGIp/SWhDKJajarlUG719Xwg9VqwK
         /4Yw==
X-Gm-Message-State: AHQUAuZq5pvgb6R73306cI7lfghNvmNLzRDYDJe+OI/nsUWt2cz9dbKZ
        vKpL3UFjhEKF6xfZEFZxe9+/2G8T
X-Google-Smtp-Source: AHgI3IYgUBw1L5pAhe1XFSnXYBK2wmlmAe4NLvD8vNgjIvvDsDa3/8I0xQG3oCGCeYifuIpmWy8y1A==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204mr6763146wmf.144.1549112075725;
        Sat, 02 Feb 2019 04:54:35 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id r200sm10973814wmb.36.2019.02.02.04.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 04:54:34 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 816621146681; Sat,  2 Feb 2019 13:54:33 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Remove trailing semicolon after curly brace
Date:   Sat,  2 Feb 2019 13:54:27 +0100
Message-Id: <20190202125427.2309-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is not point in having a trailing semicolon after a closing curly
brace. Remove it.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/sysdev/tsi108_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/tsi108_dev.c b/arch/powerpc/sysdev/tsi108_dev.c
index 1fd0717ade02..1f1af12f23e2 100644
--- a/arch/powerpc/sysdev/tsi108_dev.c
+++ b/arch/powerpc/sysdev/tsi108_dev.c
@@ -51,7 +51,7 @@ phys_addr_t get_csrbase(void)
 		const void *prop = of_get_property(tsi, "reg", &size);
 		tsi108_csr_base = of_translate_address(tsi, prop);
 		of_node_put(tsi);
-	};
+	}
 	return tsi108_csr_base;
 }
 
-- 
2.19.2

