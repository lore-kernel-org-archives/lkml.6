Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8527AC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 19:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5A521506
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 19:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AU3voZQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5A521506
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754386AbeGGTas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 15:30:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37241 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754351AbeGGTap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 15:30:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so7099289wrd.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jWQ1OKJQJ5oY8iYpZWeW/NUZn9dCJtyjHntRtvWHoY8=;
        b=AU3voZQ7lK9+q7GDTfC1nixbGHIJDGD1OwvTyucrBN10q8oE7on4nGtN7UvQ1+l43j
         XDRy9l9AiE12ybFUA49STd6zxFfFZOnwk5shHdxw9+fVEQFVXOnFqgj4O9cB+fy3wipP
         YzlRD2kNgLroTaHsbmJ83pNMSBnVIZUFznvls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jWQ1OKJQJ5oY8iYpZWeW/NUZn9dCJtyjHntRtvWHoY8=;
        b=lbnHbzpoczAOZkbi8+mOX3k3CMQOVrdln2ejjMiC4k0eTon7YrxQGiLck16k/G8GnR
         1QNc3yvtCy6+qBHN41W9UlR9Rs0mzLosCJbtJbngcR93udHCCz1E5dx7TNxD/xBc51Eo
         SOdqGMEjfIBWEEfWeCnnf8EoV1WfH5OiM3XpdCf5GFbHN3NsWi4aKiX1R9uUUyzWTaf8
         /3QJIAnpi7XNtDt8IJYiEKQgE5E4dFVr9xz68HiDwhGl2PTtJPImXz4DiUOxl9v5aHOP
         Os3U1Zj995rcKzeB/M98i4fu2uAHCuQ2hKm7WvhTBGRf8X37PTg63UF53PWIhXstWUzu
         sC5Q==
X-Gm-Message-State: APt69E0lYxCmdB1pH16gt/Gex2Z6KEe8CrFaRYZ7jKavqQo7KoxNanOK
        Trq7fa0xWyhTedJYq76wdyQCqNQdOwI=
X-Google-Smtp-Source: AAOMgpc1+OGCoZjzqUkKz6HvLD1HcA57hcIYXYYW7HV8olCCx9rXH0sNBkgVHTPEDjFr/5OAsArdLA==
X-Received: by 2002:adf:c612:: with SMTP id n18-v6mr10344238wrg.177.1530991844761;
        Sat, 07 Jul 2018 12:30:44 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id f6-v6sm1423561wrp.30.2018.07.07.12.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 07 Jul 2018 12:30:44 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] slimbus: stream: Fix htmldocs warnings
Date:   Sat,  7 Jul 2018 20:28:41 +0100
Message-Id: <20180707192841.2358-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warning during building htmldoc:
slimbus.h:352: warning: Function parameter or member 'name'
 not described in 'slim_stream_runtime'

This patch also removes documentation for state variable
in struct slim_stream_runtime which was redundant and removed.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/slimbus.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 411880f3fc0a..32ac4046154f 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -325,9 +325,8 @@ enum slim_transport_protocol {
 /**
  * struct slim_stream_runtime  - SLIMbus stream runtime instance
  *
- * @dev: Name of the stream
+ * @name: Name of the stream
  * @dev: SLIM Device instance associated with this stream
- * @state: state of stream
  * @direction: direction of stream
  * @prot: Transport protocol used in this stream
  * @rate: Data rate of samples *
-- 
2.16.2

