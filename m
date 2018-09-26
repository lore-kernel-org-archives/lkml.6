Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08EEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A2520843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1odSgBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A2520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeIZMyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:54:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47098 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIZMyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:54:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so13382623pga.13;
        Tue, 25 Sep 2018 23:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NI5e4zVrcMEznDRPw9a1QkzXZQXmCW1qfwjkdVNVb6E=;
        b=l1odSgBnJQffYk4H6LPTBgztZ6GT3z14UhEA6zfzziOU4m28Olnq9A+T/XUmQ+wmFf
         +SeRAAhRD9wLPilYWtneaVe/7p7f5dd57OyEQ3XI1E+J7T+aCbTA8Mu1QoLwV1ha8LbQ
         rcUSrC2yE3bbdpCEMfIK+CdN61CNhfgoV+GfgdZJD9VPRuHRVQ5+CJVd2pMPNjtFo5a+
         SlW6SuW9rAFCvaGsdsuGtFTs9iiSiwfa8J1opG4mqaxX2GynyGwOKTfOtomZk6VCN0FR
         /wUfb9AmE/zsgDQOzdkKmFoCTIi4tlm9H+YHx2PC14FE3p1WdhSFjtJqwoMToCMprucX
         iVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NI5e4zVrcMEznDRPw9a1QkzXZQXmCW1qfwjkdVNVb6E=;
        b=UN8tLW9EHEpt03LF4z6Z9ZglawyLeCKY0jEWidEudBL2o2uDHXP5eBbLz9Xd2EpgPH
         9sLD7EfuRKsx7eA5aQ4DbuF73N64/4bnMstpvMDlrKyfcHDBUguwsXA5JsZ474VF+Tlz
         uAN9lxygpvMjZOhSoeydTGXrkeipibBAJrTl0rLpsZnQx/P3mqU9ByiHgzupoqDq2nEX
         mNT4Sgun4Kd2BNw98cg4t2YS5oHWukZyPW3P/Shh3DGWyUfIoUMvgKlCBTpq9MjhEEJJ
         Uncz3nuYD1HXFTW5BJSpbbwERW9HFcwHdhjym0BNnnlvNqnTtCoaTNuvb+28uYuJBLu2
         j3VQ==
X-Gm-Message-State: ABuFfoj80KKAOJJTl7VhuPTPPzvClF3FgfMwlyVwvJSf12TPS/49OUCY
        jGSbUiNjfAghxMRNGeHSf/s=
X-Google-Smtp-Source: ACcGV60QyRY8OJQRpoBltgTi3E0WJC1oODxdCf6RJS0ti2Lksk9RBXHHHMS+/wKMIq+K92jBy7lf0A==
X-Received: by 2002:a62:cdcf:: with SMTP id o198-v6mr4762790pfg.12.1537944181021;
        Tue, 25 Sep 2018 23:43:01 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 71-v6sm5574861pfx.182.2018.09.25.23.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 23:43:00 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 0/2] hwmon: ina3221: Add power and enable sysfs nodes
Date:   Tue, 25 Sep 2018 23:42:43 -0700
Message-Id: <20180926064245.4091-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patch is to add three sets of sysfs nodes for ina3221
hwmon driver. PATCH-1 adds two power sysfs nodes while PATCH-2 adds
an enable node.

Note: both two patches are rebased upon the following patch:
        "hwmon: ina3221: Read channel input source info from DT"
      As this patch is still under review (waiting for an ack from DT
      binding side), these two patches can only go through review at
      this point -- needs to wait for the patch above getting merged
      first.

Nicolin Chen (2):
  hwmon: ina3221: Add power sysfs nodes
  hwmon: ina3221: Add enable sysfs nodes

 Documentation/hwmon/ina3221 |   5 +
 drivers/hwmon/ina3221.c     | 228 +++++++++++++++++++++++++++++++++---
 2 files changed, 218 insertions(+), 15 deletions(-)

-- 
2.17.1

