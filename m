Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FBAC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1C320861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Goc/hFU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfAWKkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:40:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34584 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbfAWKkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:40:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so10632951wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2WopGAHC3vhDTNXuOGSdAGTac9qZGaqwKjIqjMvQSeU=;
        b=Goc/hFU8+Zu9MH+v7UBE/S5u1Z2Jte0UYY+VTlLvPg64dEwuuPcHZS3HA+32f1KdxN
         BwHHPJ1v4+S750m/kHv27OBl9rKzpFHcIWzOCtDarge5h93g9Ba3FBqPb8LmVHrqymVB
         UwXelunkfwho0lKOcyGUevsi2roFYQ7V7Lvv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2WopGAHC3vhDTNXuOGSdAGTac9qZGaqwKjIqjMvQSeU=;
        b=k7tWqXGMCB3zqLaAhbtrNnfxql5Th84zJI2IJo4k+uj9MBGlK4S4NRhWulppl21s7x
         Q8uppKebTCtUVtREXmNF2dADRV02r4Z4r6huIS0Okd4KU+uSqFqd+1OT82JXojLF+9oE
         jehMZfZPENm8RcDuAuCPF7n8/wysBW4GkrvxIybR/FuUtoGSqn9EMXVmKUkuY60kDJ+Z
         NLb5OY0WARHWNTem1JqrCw4EpuP1tXtIxoXER+rfzN/k8H6i4DRZAzZnnIozP/zErcOt
         YFFyIBVv8sVsgSnfjt9/fqOto4rR7hqueQOnl+fx3PNqsekpmqCluTh2tlpNoxe3YWz8
         AeHw==
X-Gm-Message-State: AJcUukf9WXTnN9KZk6DKT3EWjxnVjvM3dvRATwY9Dcjnfy89gTRx96NF
        7lPW1l3mnoUvoy4iKj81Xl3Zqg==
X-Google-Smtp-Source: ALg8bN5pgQqWc7dhDG5TLFgMGWYpXN57+xczsOV5sA2pCnNTv/90L1SnwGOirjslxJZgRk5Pq1pnnA==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr2161893wmb.80.1548240015469;
        Wed, 23 Jan 2019 02:40:15 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id b18sm84525211wrw.83.2019.01.23.02.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 02:40:14 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 0/4] Venus various fixes
Date:   Wed, 23 Jan 2019 12:39:45 +0200
Message-Id: <20190123103949.13496-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Changes in v2:
 * in 1/4 make 'mapped' const - Alex
 * fixed typos in 2/4 and 4/4 - Alex
 * added Reviewed-by and Tested-by tags

regards,
Stan

Stanimir Varbanov (4):
  venus: firmware: check fw size against DT memory region size
  venus: core: correct maximum hardware load for sdm845
  venus: core: correct frequency table for sdm845
  venus: helpers: drop setting of timestamp invalid flag

 drivers/media/platform/qcom/venus/core.c     | 12 +++--
 drivers/media/platform/qcom/venus/core.h     |  1 +
 drivers/media/platform/qcom/venus/firmware.c | 53 +++++++++++---------
 drivers/media/platform/qcom/venus/helpers.c  |  3 --
 4 files changed, 38 insertions(+), 31 deletions(-)

-- 
2.17.1

