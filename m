Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C149EC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8834D2098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjLKBF08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8834D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeJMMaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 08:30:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46089 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJMMau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 08:30:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so7147172pfb.13;
        Fri, 12 Oct 2018 21:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
        b=XjLKBF08ZQ+dsEyY+1vcvgFDvIQUH+3J+mij+q0zb8rlPtPBVFuf5qpY1NOYkLMfWI
         LqJaauyLUA2EQ/lBipHWNE0gvwzV7tNahnPnfKggwln8idyWVA6EVc1MNMpOXBMduylD
         hbUgnmPJ3tMlT7Ez7ftzWY9/qtX+3Z8PEP+Wx6XfJEnvDQwMYWSHtLZezIJITXjbsgzr
         qxFUauNaVKokdPIeKVZxfVgmERQM91b3Al/4t14pd+5anf9hSVdzeG0KAt7gK3Br4dze
         MFzqaiAyDAcx9IFrwN8uYqjthUhxIim9HYDqu2myBuMCvzZsF6TY1FJsuVS7IATvdWvM
         KT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
        b=MtP/UR9hxmoFEcK0z7zqLGJZ4HwaKeDK+4gcT34BefKAC3TLoJa4+Y6u4PG9poyPUH
         TzJDtptIkintvprrtRFZch61eQz2b+0FD7Z68T0ndRdNDa6JdzZzxznlM462c7maLzZx
         B4xpJAoXyW5CCgGkBPFdzIO5HBXS895eFNzDEr9wR4poamNT4f3LlTHRJShL+8UQB006
         hQce+HB/Cqw5NZGnmNyKJWWzbl8looNsodVa7otBh7EKNUF8iSt3ys3J87D5ajknz+kW
         BxMQ3cFONciQ3eLh1kRnbZDyi+VAs8VpyiI+0KcwcxtTFIZ4OcTEKpX5GvMqWimbSM77
         T4YQ==
X-Gm-Message-State: ABuFfogcVKTIzwXjNSB988y+f8dY9+tsP9dWspBv7Z2uElFHHtOvnfhs
        G7YUyYaEgF9wQ1vR3HdRiFQ=
X-Google-Smtp-Source: ACcGV63Jw8JZON7Ti8uWdCVxtgPjcr/J6vei2RiqRNuBSRDqGBHpxXgxxuMvJCv9Z1oTfYAqhkmFJQ==
X-Received: by 2002:a63:565d:: with SMTP id g29-v6mr7995901pgm.227.1539406509460;
        Fri, 12 Oct 2018 21:55:09 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 21:55:08 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v2 04/18] powerpc/pseries: add of_node_put() in dlpar_detach_node()
Date:   Fri, 12 Oct 2018 21:53:24 -0700
Message-Id: <1539406418-18162-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
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

