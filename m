Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0168AC7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8D620831
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9E4LDFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8D620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbeJXGB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:01:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42467 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbeJXGB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:01:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id q6-v6so1601181lfh.9;
        Tue, 23 Oct 2018 14:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=Fg4OaLOHQqrefdjonA6DL8gKc44WsS6YzuIT3EPXPyc=;
        b=C9E4LDFEqa5quLrdvuVRMmj43Vc5eOZNvcS2YZIGdDAwvs+LtTqg/8VaP6Fd6nfz00
         6Y+Kc9Ygxx4Hsd3pPwMK8bzJDFnCw4vw2zNaOu+VZoue6LSPaLP8Pj9crYs88OlfR1q+
         pgboQVBRzc+cTmFCLpSlyQunl71QSdH3MpNbzWIhwCKldHH79R1k1WZ0T6H66boZOdBV
         n7mvD9IH+lRIsAMMUZZajrAW5p8MC5rRpTADj8KpIgELHPkKjU6yxSVwgCIBwszpr8xl
         SUuArLW37lu7ZoI1jQzaAXoh/YeWiB2bfrEDO18NdKo8GXSQzCWIeSwUtgS4Hgnm59MO
         +k8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=Fg4OaLOHQqrefdjonA6DL8gKc44WsS6YzuIT3EPXPyc=;
        b=fNZYhQMLhjcnhuwsigi+3g6Eo9bk00oyJagjei+TAPEA+O7OLY6xICdUC53lD9OCsX
         YUu6rU8lWdrtY6mcsTM0xYb/Y6NaM59H9AOa/8Rp2Vc0TIdyNqL8HuN/83QD2/eyVWwN
         YMhKvGDoJ2iaU3wsdNT7qiWDh9zb0vz++8AHsVtLrbkW8nr/8TWW8LDKfY0oxExbWGLw
         MViYXy4tcACEdPQVesTHMRpC7bR1TEprVzos/y5l6Uc5I4pVib4YNXhqnBBy1RwftIm8
         tfsPzfBztygH9MVQu1PyNCYx7Q5uAMzwGIidy89+CXhH+OEyRVv3L9+jihL4SlfO9rFO
         wToA==
X-Gm-Message-State: ABuFfojln3JPvS+pl39sCz+Wsl5QCcaCAJJvUrA0UZF6Z/qu0pXvs0Ob
        MshUSTfg+fw2/kH6hlmuddM=
X-Google-Smtp-Source: ACcGV611Z5tTnO5/5bvrHUOX3goc1TR758Ld/VtLL2Gme2c4YdgEJiORfSTHNppuLgxH+rxf/KtJWg==
X-Received: by 2002:ac2:5082:: with SMTP id f2-v6mr12824852lfm.47.1540330574898;
        Tue, 23 Oct 2018 14:36:14 -0700 (PDT)
Received: from localhost.localdomain (91-159-62-169.elisa-laajakaista.fi. [91.159.62.169])
        by smtp.gmail.com with ESMTPSA id y127-v6sm377950lfc.13.2018.10.23.14.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:36:14 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Lihao Liang <lianglihao@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/17] prmem: linked list: set alignment
Date:   Wed, 24 Oct 2018 00:34:59 +0300
Message-Id: <20181023213504.28905-13-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023213504.28905-1-igor.stoppa@huawei.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation to using write rare on the nodes of various types of
lists, specify that the fields in the basic data structures must be
aligned to sizeof(void *)

It is meant to ensure that any static allocation will not cross a page
boundary, to allow pointers to be updated in one step.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Masahiro Yamada <yamada.masahiro@socionext.com>
CC: Alexey Dobriyan <adobriyan@gmail.com>
CC: Pekka Enberg <penberg@kernel.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Lihao Liang <lianglihao@huawei.com>
CC: linux-kernel@vger.kernel.org
---
 include/linux/types.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index 9834e90aa010..53609bbdcf0f 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -183,17 +183,29 @@ typedef struct {
 } atomic64_t;
 #endif
 
+#ifdef CONFIG_PRMEM
 struct list_head {
-	struct list_head *next, *prev;
-};
+	struct list_head *next __aligned(sizeof(void *));
+	struct list_head *prev __aligned(sizeof(void *));
+} __aligned(sizeof(void *));
 
-struct hlist_head {
-	struct hlist_node *first;
+struct hlist_node {
+	struct hlist_node *next __aligned(sizeof(void *));
+	struct hlist_node **pprev __aligned(sizeof(void *));
+} __aligned(sizeof(void *));
+#else
+struct list_head {
+	struct list_head *next, *prev;
 };
 
 struct hlist_node {
 	struct hlist_node *next, **pprev;
 };
+#endif
+
+struct hlist_head {
+	struct hlist_node *first;
+};
 
 struct ustat {
 	__kernel_daddr_t	f_tfree;
-- 
2.17.1

