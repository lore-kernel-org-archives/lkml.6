Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0E4C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216F021755
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KR9XOziK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216F021755
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbeHNCYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:24:12 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:36984 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbeHNCYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:24:11 -0400
Received: by mail-oi0-f74.google.com with SMTP id b8-v6so18570375oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qphkOWujziwL0wBgfe6QsGywOKK66zCgD2St8Z53K1Q=;
        b=KR9XOziKdVih1FA6mKyUzXX1Pm7mYuvIMCowafFuKrrqsXLdkF9JKKW+ogs+QFgDVp
         o/nO38mEN7JEOT/38rgtjkFoon6Qml9ELSClOb7J4PNc0QVbyDsSiR53mBlBS1HllcfD
         H4e7JpLyF/uWlXvCfjL4Ixle4Kn7vqa3iEviuPTDcb2GiOPqH1qw3+vGiR9OXrI6dr9A
         kEJnfu8rI8HZmcbRkgRAAdAqCHwa6a0VO8TSctxf8V91ZYmuS2YTpM/SRu5xNidtSyzA
         MEEAEV49HWLNVRM3Siha8bf5pNg4ZaO7jRn2eBsvajl6OV/PXONnBQdu7oOi8lgKsX5J
         jK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qphkOWujziwL0wBgfe6QsGywOKK66zCgD2St8Z53K1Q=;
        b=hx3TZtDT9Zz1MWgOip6pMJe081O55Qn/IfWcPjF205KT7b/LA/Sl8SzX1p9o5Zl6yi
         Oj427u3RuAp4L880JXa0zpt/SMACkpWt1ms3PZm/owmvDq/N/aIMeryGNB13Eu4756Kw
         J1ceaywF48mXpXmlFTE/oinf4dsKzfRH1n9JxmclPut18gQoAO448K9ipXryqw/d957y
         ZpXnW+uOiB903B5jH7TcTbB4c3MpEqHOnEuR07aUa80VTKcNXIk8aq37dFbK+/PQ/I0X
         v++f/h5/qU/BHWIuBPeYw2ikL+yBUT5ikdJwx5JFT39/BSyKjxR34oTVIU8BmuC3g1Vc
         jo5Q==
X-Gm-Message-State: AOUpUlETP0cnrEhZzuWtepK1L2rLBA+uZUAf5iu6Z3wVXM9pfi0tl33C
        HdX39oXf8SqGi3HSeSGod+PKEJao
X-Google-Smtp-Source: AA+uWPzdZnJ4yC/p2545bQMXV0zGxqGA70ep25Kf865yidhR/0bWzg5nys2Pjg2JZNnaa4RJVOrtXgRG
X-Received: by 2002:aca:1e11:: with SMTP id m17-v6mr12730122oic.107.1534203583030;
 Mon, 13 Aug 2018 16:39:43 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:38:39 -0700
In-Reply-To: <20180813233839.190855-1-rkir@google.com>
Message-Id: <20180813233839.190855-8-rkir@google.com>
Mime-Version: 1.0
References: <20180813233839.190855-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 8/9] platform: goldfish: pipe: Replace pr_ with dev_ for logging
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

dev_ is preferred if struct device is available.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 6f3fc4b30fba..3f8e440d62ae 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -384,6 +384,7 @@ static ssize_t goldfish_pipe_read_write(struct file *filp,
 	int count = 0, ret = -EINVAL;
 	unsigned long address, address_end, last_page;
 	unsigned int last_page_size;
+	struct device *pdev_dev;
 
 	/* If the emulator already closed the pipe, no need to go further */
 	if (unlikely(test_bit(BIT_CLOSED_ON_HOST, &pipe->flags)))
@@ -401,6 +402,8 @@ static ssize_t goldfish_pipe_read_write(struct file *filp,
 	last_page = (address_end - 1) & PAGE_MASK;
 	last_page_size = ((address_end - 1) & ~PAGE_MASK) + 1;
 
+	pdev_dev = pipe->dev->pdev_dev;
+
 	while (address < address_end) {
 		s32 consumed_size;
 		int status;
@@ -433,7 +436,8 @@ static ssize_t goldfish_pipe_read_write(struct file *filp,
 			 * err.
 			 */
 			if (status != PIPE_ERROR_AGAIN)
-				pr_info_ratelimited("goldfish_pipe: backend error %d on %s\n",
+				dev_err_ratelimited(pdev_dev,
+					"goldfish_pipe: backend error %d on %s\n",
 					status, is_write ? "write" : "read");
 			break;
 		}
-- 
2.18.0.865.gffc8e1a3cd6-goog

