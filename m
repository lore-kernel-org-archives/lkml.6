Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FEFECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFBD208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdjRxXqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFBD208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbeGQCkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37154 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731371AbeGQCkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id a26-v6so5135794pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K2diT+bR2+SNhccHrm7GfFHWJMMfbEsrNN5SW1IVBI8=;
        b=MdjRxXqATkIvZE+Je4ErDv+wWTOsSVGy4SRLg3qAH89GNysesYX+tNJz74L9xIEhTv
         9iaPmb9xAwMHX/CQnsa/e9XQfNZF7uGvBigl9ZM4VsuilAwoTmoRCpOtFNZeh3Kbw7ZE
         L8xAQNQptE3AI3S9d9QoHeS0zcKEy3bHxdqyqdWcdD9MpD3g2qKLbnuqqxYTD8DlUh00
         s8D09byUihuzTXvI94z8X2Gu/UsqmeitEipqw/rA4DntxNn1SLDqIwkLxEPb/NZEv/ko
         Qs0NvR512GruztSb0feaCdNwFxh3HkWNXa0qOFf/Yry71LodILb8CKDpEZzOVMfNOxdg
         x++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K2diT+bR2+SNhccHrm7GfFHWJMMfbEsrNN5SW1IVBI8=;
        b=PkUZQp2zhdjCElW2vQaqoiqf2M4dQYgYldFZ9w+jpVX9KxAeBOjyzjDpxKDKtkJ+Bx
         k+q6lwO+w/k7lqcn9E2PCemIMdLE3e5IPpcGFdAu4tUfKfKuP1V1ta7wtIoPpMReHffR
         GD6mChVp1AEz+ldxWXbbgw8vW/CJ2L1YnzMONHUQmLMTTlT0cumkMeKlGwXcb79DID01
         8gUGCvW6opb17zF+iI4348D7HDZApSBExucDPf1aDKsbYrJ2rhl9u0klphZRmKb3mGkJ
         aBYI6Z4oAgIpWbYXNezJo3fVKFPFG77BybuHwGNsmTXj+t78nBDHxFFkCwUq+AI3Fu7W
         HCbg==
X-Gm-Message-State: AOUpUlHn92AvzHeClsWOhm1DsyCS/iCNPd6Z0FTMnfjJu0Y/gTq88arR
        vfeOo2lTYQs7eJSiNq8VTUc=
X-Google-Smtp-Source: AAOMgpfWaR81ezWN/yzoVM8yHj6ROXWbL02ipCThyP3R6UV9Phw4Vb6NUcbco21ios63tYbeFkv1Fw==
X-Received: by 2002:a62:1f06:: with SMTP id f6-v6mr20502287pff.140.1531793393489;
        Mon, 16 Jul 2018 19:09:53 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:09:53 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 07/32] staging: gasket: Return EBUSY on mapping create when already in use
Date:   Mon, 16 Jul 2018 19:09:01 -0700
Message-Id: <20180717020926.176408-8-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_sysfs_create_mapping() return EBUSY if sysfs mapping already in
use.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index e3d770630961b..dd4d3aaa57e2f 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -194,7 +194,7 @@ int gasket_sysfs_create_mapping(
 			"0x%p.", device);
 		put_mapping(mapping);
 		mutex_unlock(&function_mutex);
-		return -EINVAL;
+		return -EBUSY;
 	}
 
 	/* Find the first empty entry in the array. */
-- 
2.18.0.203.gfac676dfb9-goog

