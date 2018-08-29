Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D05C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6082084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="O+XNB7Mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6082084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeH2M5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:57:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35503 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeH2M5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:57:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so3366570edq.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 02:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KK/r9o9nElkqmdjVFdLS9CL8KjZHgjLzXSxUZEWw7Ic=;
        b=O+XNB7MkvgbzU5gkkl+Xu/PHq7yjdVf4Nhq4v+luG3orhHJk3mbNIu1YYHhyepg3kC
         2rxPobs+cjZhVvdL9H89xqvBTaQEn0dUJaqEw3dvfC6LUFO/v2BZMcRo1ckEB19xB+bi
         BjafwLtJ/smk2sCz+olz6yGFwB0BzSKlK9sqppQXhKmNsQhCawsbqAMcsvXUQY8lwAAc
         z0FXX6OqBHPYux5E3q177IaAz98KMhXjYq9zuzjWlm6lbKOU5Szj9knYf4SwvwNZ8bo+
         VzSgjC5rS6U4rwJgFEjAULYHe0ydSes+oMEhrHxzIdBBr7+xbB5VjQjW6mgeQC+So4Hb
         4Zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KK/r9o9nElkqmdjVFdLS9CL8KjZHgjLzXSxUZEWw7Ic=;
        b=Pvmlypeff3N2MAG5aw7U2wZzbmfBuyPmTt2S2d/UCejLszlwg1rBI946IauFLm0P+X
         cyinAOTukTGk2IJfMtcYObhJjw2j+BiNyTSfn+VDwN6xClEi8qCqY738Hvc8a2eCQUm0
         hETF0LKpADR3fYYJybKMZTQdYexjqZdQchfwLYkUSThwyvDrGQ9R7Z9obC0CDvolgnVr
         DWh3p7SCz/k487+uF9P+jPYL+W6nzx5u0JjeisTKxJz3nAaKCOPCqAzpKlLeaVL0iMS6
         TV+xZ2wITPopyM8N+KfNk3aN8eE+ASMcEtChamO69AKeLAZM3Zae8bmx1u9Qi8t2KMju
         tc8g==
X-Gm-Message-State: APzg51AUkYyEO6vYPMAk73oBArv4yA74IlSmIrWrSypHaWmx1ThCBUoa
        IevJeSLVSnypfDK9cB4tL6n9jQ==
X-Google-Smtp-Source: ANB0VdbTtSeu9M9VlV/lXdJz+ICHu6TK9FBBqbgum6O+11kAUE6Fjy2cGa2MCnaZJgWX+bheD/ez2A==
X-Received: by 2002:aa7:c485:: with SMTP id m5-v6mr6490693edq.205.1535533319411;
        Wed, 29 Aug 2018 02:01:59 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id a41-v6sm1546569edc.57.2018.08.29.02.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 02:01:59 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/4] lightnvm: pblk: collection of small fixes
Date:   Wed, 29 Aug 2018 11:01:49 +0200
Message-Id: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collection of small helper function fixes, removal of unused variables
and comment typos.

Javier González (4):
  lightnvm: pblk: calculate line pad distance in helper
  lightnvm: pblk: fix comment typo
  lightnvm: pblk: remove unused variable.
  lightnvm: pblk: guarantee emeta on line close

 drivers/lightnvm/pblk-core.c     | 13 +++++++++++--
 drivers/lightnvm/pblk-recovery.c |  2 --
 drivers/lightnvm/pblk-write.c    |  2 +-
 drivers/lightnvm/pblk.h          |  6 +++---
 4 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.7.4

