Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E741C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A94623DF7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEfBeRms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A94623DF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbeFVG7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:59:38 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34611 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeFVG7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:59:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so5564346wro.1;
        Thu, 21 Jun 2018 23:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XqHf+ryPv/kw2CvSv7hvWjQSlSfe0loCsEDbVOO7PEI=;
        b=XEfBeRms5yc5dKFWbAaGOSIMiMBYbGzeIy2n17bHn+JspjWNzAi6qoiH8jV9MQKxov
         CY2LKSW6R07JvA4JFcF8mAb4/XChM2pPLit+LYqX9cZ0dQ9cN7eTtuGmHw81YjoyyK87
         rLcOXmfbnXYwQrRXizs2VZFtbZV6XnviEPq4BriV8AimaFbAW4fwEc0RDVOEwb+8pSTI
         18fRuyGVxxZtqXEIaMEFb1YpbXAPmj8O8n228iqoIMjXwSE1WqTcdoUIvNeehVndO4dy
         DkmjjhBWKeJO8hvJiWEJqr/CsruswxTZxnGRC7m6w1so8+nTM5RiQbPrTzD7FCZPfKQa
         pCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XqHf+ryPv/kw2CvSv7hvWjQSlSfe0loCsEDbVOO7PEI=;
        b=ePrS1pQkXG9zcV9fQc7xrorR035uLrggadkM21j8+t4wn/leXpe7XL8dEx0tsl8t1h
         259CtRQNq/XDsLxGGR3EZsnbKe0RG2OmIFP0zBMgF1q4d6Ri61HeAMtFgUara7UDca5T
         1KI5kz2cpqnFjCeaTIjDNuOrMTcrtsyj6OTUH4D7IrN9kaTJcRLAZCFoLXAJE9HEOvdD
         jAK51zecsMLrCkAAmoNEBWsSENkbAakvw8F2RLf+VyK7zdrv1iDk0AbpGHVTM5Av4rhr
         LOMVUjZUh9xjnJXqesAt3weyIvNVKFjmzEac0X5afDImBWW5rdaAb9pXWxkJTf5djH0U
         +67Q==
X-Gm-Message-State: APt69E2MU18A7GVhsw9ChVK28Y2gvZpvhTFBNxYR8oJJWRy7qQGM4mjp
        1FXyfjxCU1RsfIrSfeMfDQ==
X-Google-Smtp-Source: AAOMgpfhItIU4aZ0ExO3UMjr9f98JBEPanBgTLVy0N3/uhtE36FCBzglC/3AtSCR9Lye3s72jnaaiQ==
X-Received: by 2002:a5d:4b4b:: with SMTP id w11-v6mr436260wrs.87.1529650775896;
        Thu, 21 Jun 2018 23:59:35 -0700 (PDT)
Received: from sesnaco ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id o12-v6sm291398wrn.4.2018.06.21.23.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 23:59:35 -0700 (PDT)
Date:   Fri, 22 Jun 2018 09:59:23 +0300
From:   Mawanda Henry <mawandahenrynaco@gmail.com>
To:     mawanda111@gmail.com
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] i2c: slave: use SPDX license information
Message-ID: <20180622065923.GA1405@sesnaco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDX license helps developers and machines to know the license governing
a particular file hence easing work

Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
---
 drivers/i2c/i2c-core-slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 6f56e65..15c7f7a 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Linux I2C core slave support code
  *
-- 
2.7.4

