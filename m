Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8B0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8975021708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAuYI/jA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8975021708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeI1Any (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:43:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40054 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1Anx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:43:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id e9-v6so3812624qtp.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LfhcDKS1UyVeWVBd99qFp44B2bLB9C4f6VmfdsulXwE=;
        b=bAuYI/jA2WdfsvJ3IUbFtf8KBYcmhlFzabpcBktkjonFmUunj6vnIvcFqNY0v4eukW
         YQxIIi9VfJ994+gvzCYzwLRnzURaYgaK6Z4cupzt56NdnYYAmqP0Vc04bkj4R0x3HDUB
         z+BVOLuBnJwwlsA8kiBP3HDNPEc1JcYCkqdKd1b4elhqpnHFvHXpdV6yNeLyO4BgQEY/
         +kJLmtyr7GLfwBPAnhvbUpeR5PbpZSIPSiRH26Nul0oj8OL5hbszCyfM5m096U0MI0/2
         cxBgoMNNCkLMGV2+r9KSvBd2LshdrANUFxfA6nG4IyVgXjZP2B6a0c2yB8e54k6znk/R
         zHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LfhcDKS1UyVeWVBd99qFp44B2bLB9C4f6VmfdsulXwE=;
        b=ZluQXFp+IxAiYaZWfM6Sh5SsuSTsFEe/rY7ChXACV4EQLwyctKwmZcqUbNQjqkmg/I
         GosFxsjQKPft8cAq9Db/80W9ecnX1K7TslHExNr8KKa0d3jMxZ+CP7KqMWMsWkvedR0T
         QL14EebjelBtXPmw1cO/ZhhrtKyO4ERp4M/SgAUkS0p301jcecLZrSUYeIrWSJ0QR6vT
         1eOaceW5oLnPoQwQKRFMI5MfOevVWdQ/WHNVJtsmSt4x/gn7vDAUW2RVugAA+ro4fYMb
         iYT4STOrIico9BiF9yZkVDL/9YICxYRQglXQUZqLD6wijEp1Zu5CWIt4yHMkde/IzMPN
         Dqmw==
X-Gm-Message-State: ABuFfog3pEIuAr93xCk+nBvsIjVLIp6SBChh/Wr36ER0tgM2LLJv1Xal
        whDhlgRiOJyJzBSpcGTVWco=
X-Google-Smtp-Source: ACcGV60l0fekmjFGKQviZG7D290NjnqF6vOwUeifD3Pbo7J0Fhrhwb5ZTNXXwM9rDzTqaeBn70NpCA==
X-Received: by 2002:aed:3848:: with SMTP id j66-v6mr9304357qte.218.1538072660206;
        Thu, 27 Sep 2018 11:24:20 -0700 (PDT)
Received: from localhost.localdomain ([187.66.107.61])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1492988qkc.53.2018.09.27.11.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 11:24:19 -0700 (PDT)
From:   Diego Viola <diego.viola@gmail.com>
To:     jikos@kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org, trivial@kernel.org,
        miguel.ojeda.sandonis@gmail.com, richard.weinberger@gmail.com,
        Diego Viola <diego.viola@gmail.com>
Subject: [PATCH TRIVIAL v3 2/3] MAINTAINERS: punctuation fix
Date:   Thu, 27 Sep 2018 15:23:45 -0300
Message-Id: <20180927182346.2257-2-diego.viola@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927182346.2257-1-diego.viola@gmail.com>
References: <20180927182346.2257-1-diego.viola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Diego Viola <diego.viola@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 02a39617e..db46fa83c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -93,7 +93,7 @@ Descriptions of section entries:
 	   Supported:	Someone is actually paid to look after this.
 	   Maintained:	Someone actually looks after it.
 	   Odd Fixes:	It has a maintainer but they don't have time to do
-			much other than throw the odd patch in. See below..
+			much other than throw the odd patch in. See below.
 	   Orphan:	No current maintainer [but maybe you could take the
 			role as you write your new code].
 	   Obsolete:	Old code. Something tagged obsolete generally means
-- 
2.19.0

