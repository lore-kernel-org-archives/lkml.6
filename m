Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DC1C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B8E206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azDv5Hzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B8E206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeI2EPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:15:21 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:45005 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeI2EPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:15:21 -0400
Received: by mail-pf1-f169.google.com with SMTP id k21-v6so5134457pff.11;
        Fri, 28 Sep 2018 14:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xo0Q7awxYEQ5HLS8VFgLhaQwfoM2Dc+auDGUUFI7J30=;
        b=azDv5HzkzPahy7VK/kf/rN80vWkX6eWbKSEroI2BWa8OcG76LHJ0/0e4NpAPMJArH+
         aHrMREAM+Q5QXauNWiBq1JHd2rjYEvdlfMfqRtG3b/63B0HG1GsVGkYXRonhFQYDYNfE
         2v0xAKWCglnZBni9ASH48B6W4zoRFZNkdcJwcGuH1OY6AdeRSsNMl4Xhkic+s2QwpSxk
         Z6biLie6FKlINev9iEOIV+hQjB/+FW/e1Kx/Adi10/gP/Vh4/4Z/SPLzt54lMEQ5Opnv
         VMvCPqftlK8rBJ/vmggLMgKbjUMumWZp7RlCROKFbp6h3+yNZpmWUjCQ2RaK4xELVgUh
         6tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xo0Q7awxYEQ5HLS8VFgLhaQwfoM2Dc+auDGUUFI7J30=;
        b=n+j7ntRiCx6Z+Zaum6khKWZhuyO15f6GCkGG426SDm9l7CCuKDpUY3ac5f2Yg/QVN7
         cpkgKMnXVjeQIpCPaKRr3lMmsNJ2bVLpwCVjLIjF5zukmHusaByAsClMr10r1983lfuu
         Lp4h883/NyqZs9APlcLE2serp200fa7kMSrkNEgR6KQsxnP2C1KuJu4cTiDyJQbBsl/c
         Vc3ZiNbPMLKpv4s3C8kBTv8jKU8bDbEE4I8hxk24scr1DMonpvSiUDvvD1Zid2FRoiJW
         K5PD8Dk20xEaSKGjwEiDFB8fYne8Jv0DFlztaFkA2QA0zp+cEEmaGhIdsSetJaNUgqyq
         ukDA==
X-Gm-Message-State: ABuFfoiMDIIiUOe051JK2ebRKSxRGt7tEPg+7Pj9eTGgyYqmSMBMLLxs
        pfPtBMj8fPymuvw/58Ef+Bs=
X-Google-Smtp-Source: ACcGV639xzHjvEF7fAKRf3N2/rIhxadQWX6EQPdpoQVFiMYRx/VLtvwehGlTsAjaCkhbyZNLxZYt1g==
X-Received: by 2002:a62:934b:: with SMTP id b72-v6mr451266pfe.193.1538171380547;
        Fri, 28 Sep 2018 14:49:40 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r1-v6sm136842pgo.81.2018.09.28.14.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 14:49:40 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon: ina3221: Add suspend and resume functions
Date:   Fri, 28 Sep 2018 14:49:19 -0700
Message-Id: <20180928214921.11528-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add system suspend and resume functiosn for
ina3221 hwmon driver.

Nicolin Chen (2):
  hwmon: ina3221: Add INA3221_CONFIG to volatile_table
  hwmon: ina3221: Add suspend and resume functions

 drivers/hwmon/ina3221.c | 56 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

-- 
2.17.1

