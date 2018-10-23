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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42092C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EFC2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itzYzOZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EFC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbeJXGBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:01:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42155 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbeJXGB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:01:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id l25-v6so994869lja.9;
        Tue, 23 Oct 2018 14:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=TAyei4tGiwzaEFtWD6qceoBqlcxrR+efj6ojDl9ZulY=;
        b=itzYzOZKVGSRr5rVXV9w3CTN+HNRtiP2lfwk2bdN5A02HCaZvCEbnax0J9Fu/juSNo
         EcY511Ql87pqbnb0nQ0U4qlvdE/WGUUTyhGDw3ocKVdXVrH6nq1j+VVbuuQZBZ3Y2I+u
         29hbESNI1S7hLjecHmP8IOlcVCaZa30vVsEtLe64Cw9MI0v07p2NrG9jjY3s2KBpm8lg
         rRfTiwuxjwvwnfNey826fVQVWA/nhe5Q/2Tp+jYyyT3lcto+pe0S34JatMd3V+ebedOk
         MjWulDt7SOtNxlaCwZMuKPaoMCvmL2XsAbZoMRLzFuGwvYBHmVQ/0nqh9XiTQOyJz+ee
         7Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=TAyei4tGiwzaEFtWD6qceoBqlcxrR+efj6ojDl9ZulY=;
        b=qmPncgZgYAZ7B5z9r9VkHj7sP3R+Goc+1cjWqvxT+uCPkJ8DpIope5xsWZg2OOmcV7
         xLNIrWh1a4Dddfs9dWxkIq9b2KG9l34HKqkhDvqohX0rQQI7qiDLQ6byf9f7eIhoG5sJ
         TDiBlviZCfsat/Mo+1pFnzmXXHQ9jV6Z1fwd4TJzLr3EoYcblY16CYxAemcZVLdf11lI
         cqWOIXeOrp5nNUUgK8cTD4BIbzNJJbyuNurzgA/flVxkAR7PBnbqmEP+EXd+4wUpI5HI
         e66nDUaD3LnhnQ0vAwsw1Ua4CPduAMx5Sl8P6p+0E+iBHa0PTD2l1VmYXklgkvAI3QN5
         R23w==
X-Gm-Message-State: AGRZ1gJEmDFFjsnpYXaDIE4V21mQYDS0pnMcky6bmnhDm+NhBs6jEjNQ
        4E9NubASgMH+e9+XL8fltiI=
X-Google-Smtp-Source: ACcGV62jyvAifNg0UaxHUEFim2YZjRqmlefBY1q8HSVOsnALwybksvOWnPKQYCy+l29Mj8oEFgWb/A==
X-Received: by 2002:a2e:3810:: with SMTP id f16-v6mr13247460lja.77.1540330576357;
        Tue, 23 Oct 2018 14:36:16 -0700 (PDT)
Received: from localhost.localdomain (91-159-62-169.elisa-laajakaista.fi. [91.159.62.169])
        by smtp.gmail.com with ESMTPSA id y127-v6sm377950lfc.13.2018.10.23.14.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:36:15 -0700 (PDT)
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
Subject: [PATCH 13/17] prmem: linked list: disable layout randomization
Date:   Wed, 24 Oct 2018 00:35:00 +0300
Message-Id: <20181023213504.28905-14-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023213504.28905-1-igor.stoppa@huawei.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the data structures used in list management are composed by two
pointers. Since the kernel is now configured by default to randomize the
layout of data structures soleley composed by pointers, this might
prevent correct type punning between these structures and their write
rare counterpart.

It shouldn't be anyway a big loss, in terms of security: with only two
fields, there is a 50% chance of guessing correctly the layout.
The randomization is disabled only when write rare is enabled.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
CC: Kees Cook <keescook@chromium.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Masahiro Yamada <yamada.masahiro@socionext.com>
CC: Alexey Dobriyan <adobriyan@gmail.com>
CC: Pekka Enberg <penberg@kernel.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Lihao Liang <lianglihao@huawei.com>
CC: linux-kernel@vger.kernel.org
---
 include/linux/types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index 53609bbdcf0f..a9f6f6515fdc 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -187,12 +187,12 @@ typedef struct {
 struct list_head {
 	struct list_head *next __aligned(sizeof(void *));
 	struct list_head *prev __aligned(sizeof(void *));
-} __aligned(sizeof(void *));
+} __no_randomize_layout __aligned(sizeof(void *));
 
 struct hlist_node {
 	struct hlist_node *next __aligned(sizeof(void *));
 	struct hlist_node **pprev __aligned(sizeof(void *));
-} __aligned(sizeof(void *));
+} __no_randomize_layout __aligned(sizeof(void *));
 #else
 struct list_head {
 	struct list_head *next, *prev;
-- 
2.17.1

