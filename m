Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDFBC67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CED21476
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXCxbx5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CED21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeJIGNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:13:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43520 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIGNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:13:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so22479265wrt.10;
        Mon, 08 Oct 2018 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qjN6uuOPYEpzWnPvY5iQ0eXUxJmLHduQ1u5qDz2CchQ=;
        b=uXCxbx5HjI1nQ1Sapk4dyl+dhYu+WzRuJahOdE+zPtN7u8uyWNjSnaTP/1LuzkEogw
         KtqQzhc5vt7IQYrJp0nZEjwH0RsbT1HSLKRIEcaAm02Ei1iIhF7oVhhwqDsrueKYJV6p
         QB39qhb1f1IA122zv7NxW9UZDAAqkncz0M0zBViz+6e0Qat+4QzZZpZLM0o+IGyg31Yr
         LP3Fo8A8/mwbuy+69nw2AfWmzd8EQZTkKhptsVjImYj1bpTvKRvaTs8yy3QQEQYRhs8F
         M2yWrrQKte+rG41iTXWiri40U0Mr+H72TIF55Jc4lXUvItUZtPx/0+T6Le3X6OwwBoc2
         41qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qjN6uuOPYEpzWnPvY5iQ0eXUxJmLHduQ1u5qDz2CchQ=;
        b=FgO4zZdJHs2o/zgepUjSC3bAbyQhZRbI4pyypkHq4jC2UNvjTlmkNVw5xEp5VP4JqU
         Bm0NewX4Bv6DZ2nzOX4ONCEqwysSIkZVLrS9Rj9Pn/gQdiNzVdwoNV5iFff+gv/zULAa
         UrkQFVRZJcN8YJwgkpRUThp7QVJFDE63yNJXT9s8sIDOPby/8otF0s9prdBPyWBrfs/H
         2YkPyXG7CXLXSpPS2onHWF0xj0tuSmKxr8N6ocpVqcPkSu4syTZmLmMJAk9aP5cAl2Mq
         6lGOJcRS3QjK6+8HZADIiVNIGep6QLpYMOpPh0e/F7ZgH2qCqFX8rCjhxt9t3H4R2Aox
         0J4w==
X-Gm-Message-State: ABuFfoj6SUSv0s1K7daoy4L80Czh0yLlngWGi9JDhrcnPZ5aMYM3BQGW
        3hig2bZzQxmGTXjEAiwjOIjmYdH9lKk=
X-Google-Smtp-Source: ACcGV61B2MHbnifJsE1UtJwXoY0N2ll6XbnuBmtbSlxdf9PLPC3qcSfGo0ZRw0DvsGTkSxw4rT61YA==
X-Received: by 2002:adf:bb02:: with SMTP id r2-v6mr17967990wrg.24.1539039554277;
        Mon, 08 Oct 2018 15:59:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id u76-v6sm23578116wmd.10.2018.10.08.15.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 15:59:13 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] isdn/hisax: amd7930_fn: Remove unnecessary parentheses
Date:   Mon,  8 Oct 2018 15:59:05 -0700
Message-Id: <20181008225905.24214-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple sets of parentheses are used for a single
conditional statement.

drivers/isdn/hisax/amd7930_fn.c:628:32: warning: equality comparison
with extraneous parentheses [-Wparentheses-equality]
                if ((cs->dc.amd7930.ph_state == 8)) {
                     ~~~~~~~~~~~~~~~~~~~~~~~~^~~~
drivers/isdn/hisax/amd7930_fn.c:628:32: note: remove extraneous
parentheses around the comparison to silence this warning
                if ((cs->dc.amd7930.ph_state == 8)) {
                    ~                        ^   ~
drivers/isdn/hisax/amd7930_fn.c:628:32: note: use '=' to turn this
equality comparison into an assignment
                if ((cs->dc.amd7930.ph_state == 8)) {
                                             ^~
                                             =
1 warning generated.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/isdn/hisax/amd7930_fn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hisax/amd7930_fn.c b/drivers/isdn/hisax/amd7930_fn.c
index 77debda2221b..6c336366128c 100644
--- a/drivers/isdn/hisax/amd7930_fn.c
+++ b/drivers/isdn/hisax/amd7930_fn.c
@@ -625,7 +625,7 @@ Amd7930_l1hw(struct PStack *st, int pr, void *arg)
 		break;
 	case (HW_RESET | REQUEST):
 		spin_lock_irqsave(&cs->lock, flags);
-		if ((cs->dc.amd7930.ph_state == 8)) {
+		if (cs->dc.amd7930.ph_state == 8) {
 			/* b-channels off, PH-AR cleared
 			 * change to F3 */
 			Amd7930_ph_command(cs, 0x20, "HW_RESET REQUEST"); //LMR1 bit 5
-- 
2.19.0

