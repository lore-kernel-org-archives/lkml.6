Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCF4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DA52086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMytgoQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DA52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbeKFArM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:47:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33245 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbeKFArK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:47:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id v68-v6so1000765pfk.0;
        Mon, 05 Nov 2018 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xmf2+4FWEijlIl5vfn4kRuEeTCFhKbTHKq/ZS3i4VVc=;
        b=mMytgoQ+feOD4pXKV7Q0BG2xGIob9XjLF69CozYMPGeEVDYR21ZYZL/AF/SHhA18lV
         lg6J1Sl/mLwgPwuPQ3//6M2VqZ84zYiLYKDtyQQmgUpMDNEYvpGn4/xxPreY1IeF/UMp
         PWDQ+wI5LNYon8VZttDpd8+jNFihUJuAFbQ9LYojXBxpprH9PoMt+znhsIiyHHssqLpV
         0sRF5Z/fTA7MnV7MT+pF2yI1KacsbyCVnyWyVn+rPIXOa1PeJ9yYALWkeMtVYeL5htAS
         sonArD5Jrlv8wALrCbzCT7Z9KLa9q20oB4hOQgR5vuDszDIPGNdVh/ECdwepvycdbzkx
         gtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xmf2+4FWEijlIl5vfn4kRuEeTCFhKbTHKq/ZS3i4VVc=;
        b=Q0VpQeEsRDUiYEkR7XKa4d6xjRcV8BLfneUeVCNHYGg2G5DWGmmDRiCGWOLz/r39sV
         b02lFyTkk58GL8VQ+LjHAdwrBndUTDNthdD71ipdqGp7CWTvLCgYf6pKegqCp4WxzKty
         bsPS6BdtXti+VjY0VCqJKQR6DBaLg7Ewn/a8cgUcwWr3Y1tJmQQ13obM0K8wN0kEk9MB
         w0OIM7jdPc00UeiG2arW/QYTjSlwazmabJd/65ZbQypI0FeXtvomY+MQcU0c8iwoGawo
         vetrDmqH8HWI+9eRMIaz6ocyXGhvMgaZIyKWQMxch8pW+J5k7+rRfG/jCHlpBp2NDJg2
         vy2A==
X-Gm-Message-State: AGRZ1gKHt4ZGNDgmqhaDeseZ34rHfdKew8qye1/AiBzXJNhwRkJLTa0K
        F493eRQxCkrCWUzajFSnCs4=
X-Google-Smtp-Source: AJdET5esmi2VWzhsDDLO+BkRwznlxVGW+PVMUFk7YPTwOMh9KjI2XzSAo1JOI3PK2rcMeX0a3YnHkg==
X-Received: by 2002:a62:3501:: with SMTP id c1-v6mr7008011pfa.173.1541431617720;
        Mon, 05 Nov 2018 07:26:57 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 07:26:57 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v6 04/18] powerpc/pseries: add of_node_put() in dlpar_detach_node()
Date:   Mon,  5 Nov 2018 07:25:01 -0800
Message-Id: <1541431515-25197-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
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

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

***** UNTESTED.  I need people with the affected PowerPC systems
*****            (systems that dynamically allocate and deallocate
*****            devicetree nodes) to test this patch.

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

