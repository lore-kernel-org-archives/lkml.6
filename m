Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4653C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD3B26D3B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIwuVjwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD3B26D3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeFZPc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:32:29 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45301 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeFZPc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:32:27 -0400
Received: by mail-lf0-f66.google.com with SMTP id m13-v6so7190831lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VAIDyeMmFFj0UadIGkDkYS/5YaxUvBOhpRmvp/uTwkA=;
        b=NIwuVjwxZa6Fnz+QL4CRTe92CR8W9PURrui+gAwZ2Fp1WIyonSghhLr8huX0fW+sIn
         dbEpIkrLIpgJciKpCwIF6hJeUWtm6C8S0ljP+LsGEgjhwYHzyyOfVmMsMUiVDsXJ5mxv
         JLDBfLBd+b09qERVuR2X+zIjWfhOpY0KMaetA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VAIDyeMmFFj0UadIGkDkYS/5YaxUvBOhpRmvp/uTwkA=;
        b=Fnh38BuE+Evtz6gLbz05rldhgXquXT5ULAXwdbVx+DYzDz5w0oa2DNJBhNU1cLOpjF
         6cvuyzMij80lw7iCFtR/N2nfSxwASoQIR+xrtKYbhKiRYHltcmyPZ23Phv0T+wdrHMEw
         59s3zxhFtP2AolXwuCwjGMGnk1XrQVHu+LAH6ERNNf/y8LHU57rEXvI+CKrwhq0lAF6z
         tMa39HiFChb6myXA0bxBpm+nNDIyHT0RBcj9EybzNYMUDzGsr4sh+7ga3LCq0zczEinM
         1OwB5aHauniJ2XsRs0r6Rn7xfUrjLEYHQeFu2kvLCu+NG9x4qIICsUgOlU3yut8AL/Nd
         F2kQ==
X-Gm-Message-State: APt69E15moqMV8xvGOl1Yz5EndZtL9kW3JBSUTIE3HPq+Ket0yAtCFXg
        GLHUnD6zRDdFo0NZYP8u3nDo5g==
X-Google-Smtp-Source: AAOMgpehdR6qVwU00a6GGScWnxD03RFUNlPY406V1KaqUMwLvpCzdNd8lFN2i5y1yIX+SLC0V3YiAQ==
X-Received: by 2002:a19:9b49:: with SMTP id d70-v6mr1552660lfe.137.1530027145900;
        Tue, 26 Jun 2018 08:32:25 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id o9-v6sm69118ljd.18.2018.06.26.08.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 08:32:25 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: mount: remove no longer needed config option
Date:   Tue, 26 Jun 2018 17:32:13 +0200
Message-Id: <20180626153213.676-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit eedf265aa003 ("devpts: Make each mount of devpts an
independent filesystem.") CONFIG_DEVPTS_MULTIPLE_INSTANCES isn't needed
in the defconfig anymore.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/mount/config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mount/config b/tools/testing/selftests/mount/config
index b5d881e48548..416bd53ce982 100644
--- a/tools/testing/selftests/mount/config
+++ b/tools/testing/selftests/mount/config
@@ -1,2 +1 @@
 CONFIG_USER_NS=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
-- 
2.18.0

