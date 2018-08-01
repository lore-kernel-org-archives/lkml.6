Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84319C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EA720840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYEQxO4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EA720840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbeHAUZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:25:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35905 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388660AbeHAUZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:25:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id b22-v6so14010175lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AEuxU+RrmcJzzmMOQHyifCwZ+9iESsKRD5NlJK8j514=;
        b=SYEQxO4uTofgyVJqTrLjNFpkz+XUA4wV57O4XxJtLrYWNj2lpYYGM+KdcEhY0pE3Oi
         HoY+cYUUnWth3DgJxS7OnL0AnAcVzgQsE79PEQyS2JA/z0UE7yxjoptso5KJAxUDbf0N
         h019E+t2irg7wO8haBMU0K7Hzu4IsY10y9m7959jO3pjRWuO7EJM1Ti/Xi9jWAsvvWKt
         v2Y+rUqXbm2c72y25AAPwlr24fAgpZQLWVuvoFiay1/nfy4/m6xLXpNns1Ww2AX2cdOB
         o1sYMw3shvttm53iI4zVXhRLXpA2ne74j9BHbWEtCXrkvPQFCT4CynqKCX94ldHTI6YP
         chJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AEuxU+RrmcJzzmMOQHyifCwZ+9iESsKRD5NlJK8j514=;
        b=rFZUaTsF2f3BnBBpheV0nDBW7MZJKAHnOy57mFSGuHryzlVYiuM2CAb9KMWVvEjy5i
         KvFlQy0SuPkWT2UNZSLMO18HP0igfR21JUEL5XQCJpoyW6fR7hdNEA1zyBKAm5atckb4
         wYv5+P/vJkU1wZfW4HcSo/LuXg7zp1QMLupNZDUVwLItghH8yKDjN1PskW/aMmqN60+9
         tTnrKkGRSplYjYKs4KIG5RalxMMO9a2FDFN1xPevSJF4omYCqhOgHvfcMUNiKakaGkSE
         hJmvZxALG5QoHhL9hghaFnVdb197SM6BZxOcODmgCNrqRPHgDJO9t8IagDeQQctgo+NH
         hLBA==
X-Gm-Message-State: AOUpUlGgcvLQIedFEjx2tmzXxCbUVGcPkUj5/V+OChD80QbQlnfQAHCq
        3OXdTSFOca75HpSQrwjAn4s=
X-Google-Smtp-Source: AAOMgpfLkn7xx7xQABD4Kfzt9dpKv/nEFz3wXcSWs4w48NbHicA0UwLqFMo0XMsje+EJIapRpNGgSQ==
X-Received: by 2002:a19:5788:: with SMTP id l130-v6mr17435930lfb.93.1533148697918;
        Wed, 01 Aug 2018 11:38:17 -0700 (PDT)
Received: from localhost.mts.local ([5.144.106.90])
        by smtp.gmail.com with ESMTPSA id v136-v6sm2491473lfa.10.2018.08.01.11.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 11:38:17 -0700 (PDT)
From:   Ivan Bornyakov <brnkv.i1@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        benchan@chromium.org, jnjoseph@google.com, rspringer@google.com,
        Ivan Bornyakov <brnkv.i1@gmail.com>
Subject: [PATCH v2] staging: gasket: sysfs: fix potential null dereference
Date:   Wed,  1 Aug 2018 21:37:44 +0300
Message-Id: <20180801183744.30293-1-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180801180807.GA31510@kroah.com>
References: <20180801180807.GA31510@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add handling of possible allocation failure.

Reported by smatch:

  drivers/staging/gasket/gasket_sysfs.c:105 put_mapping() error: potential null dereference 'files_to_remove'. (kcalloc returns null)

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 drivers/staging/gasket/gasket_sysfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index a4bfca43cd03..56d62aea5111 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -101,6 +101,11 @@ static void put_mapping(struct gasket_sysfs_mapping *mapping)
 		files_to_remove = kcalloc(num_files_to_remove,
 					  sizeof(*files_to_remove),
 					  GFP_KERNEL);
+		if (!files_to_remove) {
+			mutex_unlock(&mapping->mutex);
+			return;
+		}
+
 		for (i = 0; i < num_files_to_remove; i++)
 			files_to_remove[i] = mapping->attributes[i].attr;
 
-- 
2.16.4

