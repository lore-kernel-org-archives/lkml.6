Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9382EC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530B420811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIwD8A2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530B420811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeLLA4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:56:14 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50655 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeLLAzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:55:53 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so6616520iti.0;
        Tue, 11 Dec 2018 16:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4U3PNF7JZZPKLCYh0Oave/Y3+d9jjju4/OWSW4r6jQ=;
        b=aIwD8A2Kcld+gp/b1xdxZy0FZTjXcslHyF694uIJTlbT1P229Bu50T2bSZdHcNMErF
         40uRUYksS7Rts3ar07s0MWKjBHP8fruipwTOb/mBJu/oy6LYc4GhJgtToKerFTNexbQp
         kdMEBbqVkezlX1Q8JoGS9ov9EXp3OYeve9zm7arlwVjwVhoQ8NL0yqrpMuFbQFMHtnE/
         fSVt6eXVVQubH1oTTfgioWfUvTQSI4NHLY441d4jJyKWXm/owPT6U2W4BWFqM1GyLImU
         mGVrGpejKGkCKaVX3anWqZkqGeDpdttmKG/Kv1RWFXjRwIpg+Sv9pqAwXbkeYMrZZ3SM
         oqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4U3PNF7JZZPKLCYh0Oave/Y3+d9jjju4/OWSW4r6jQ=;
        b=hXATk9QP1IWkt+D9O+t04VW6pDYaGz+V+wTd7GUo+0lgYTPaccH1AD9NruM83iNmXk
         JQGzTVf/EJZl3sc6syrHByf+ja8pJmMvt0tE2+sWlpziBCVk+I3gZN7OCdC6W4dPG5RN
         SGBo9ThjyuEcjhwvmVQTm+Em4/PPEiDqmIMO4rqe0i/COaoZSuKaCRDBcYAk5BZGHiB2
         PhakmGEdtjZJgQ818fEj0fT8tr8EJkiymAnTHlrQ3YYIv36t0VFU39iT9BhyYhTexvnv
         J/rhxnyoUkIomXk4DD+ZFWuKZxNmW7PDpsd7HPjBp0AlWShaOZalZBkyC3mUnG1xyJAj
         aryw==
X-Gm-Message-State: AA+aEWbIHPFitpA3VhCbt8WEB319h736BonMfPa/rsd+h8bzZPHmGSbf
        7/AocIR5yy3rcscyldrYb3E=
X-Google-Smtp-Source: AFSGD/W2Gxx6S/m6J0d6dJgKQge+oX6kcvwOsjxxwwp8E32NXGM15q51WVH+b041wG5NMi/JUxIa1A==
X-Received: by 2002:a24:4709:: with SMTP id t9mr4551515itb.47.1544576152796;
        Tue, 11 Dec 2018 16:55:52 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id l186sm1952445itl.22.2018.12.11.16.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:55:52 -0800 (PST)
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeremy Fertic <jeremyfertic@gmail.com>
Subject: [PATCH 10/11] staging: iio: adt7316: change interpretation of write to dac update mode
Date:   Tue, 11 Dec 2018 17:55:02 -0700
Message-Id: <20181212005503.28054-11-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212005503.28054-1-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the output of adt7316_show_all_DAC_update_modes() and
adt7316_show_DAC_update_mode(), adt7316_store_DAC_update_mode() should
expect the user to enter an integer input from 0 to 3. The user input is
currently expected to account for the actual bit positions in the register.
For example, choosing option 3 would require a write of 0x30 (actually 48
since it expects base 10). To address this inconsistency, create a shift
macro to be used in the valid input check as well as the calculation for
the register write.

Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
I'm not sure if this patch is appropriate since it's making a user visible
change. I've included it since the driver is still in staging.

 drivers/staging/iio/addac/adt7316.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index bca599d8c51c..58b462ad0c83 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -129,6 +129,7 @@
  */
 #define ADT7316_DA_2VREF_CH_MASK	0xF
 #define ADT7316_DA_EN_MODE_MASK		0x30
+#define ADT7316_DA_EN_MODE_SHIFT	4
 #define ADT7316_DA_EN_MODE_SINGLE	0x00
 #define ADT7316_DA_EN_MODE_AB_CD	0x10
 #define ADT7316_DA_EN_MODE_ABCD		0x20
@@ -879,11 +880,11 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
 		return -EPERM;
 
 	ret = kstrtou8(buf, 10, &data);
-	if (ret || data > ADT7316_DA_EN_MODE_MASK)
+	if (ret || data > (ADT7316_DA_EN_MODE_MASK >> ADT7316_DA_EN_MODE_SHIFT))
 		return -EINVAL;
 
 	dac_config = chip->dac_config & (~ADT7316_DA_EN_MODE_MASK);
-	dac_config |= data;
+	dac_config |= data << ADT7316_DA_EN_MODE_SHIFT;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
 	if (ret)
-- 
2.19.1

