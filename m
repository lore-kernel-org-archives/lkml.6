Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F7CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E6220896
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5qBXJK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfANNp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:45:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43578 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfANNp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:45:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so22903352wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 05:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6GX4QfPBBeacrHbLNIDhvIKv4Puslem9kqoKjLJKUM=;
        b=I5qBXJK53+ViG2XP6ArXMff/EiwoJ2JYNn0QgwNH2GwfIgFU2N/P1j2Adofg+1p8fW
         ssNu1nm8HYNha9sGTIQYb3MPZkpWjFm0qcsLGBZlWKA//1oaoymEWt9qaIKq0Ro66Qa9
         ux8/2hLxKFFZOBFsLFEfs/kNRGPKAJySQuh8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6GX4QfPBBeacrHbLNIDhvIKv4Puslem9kqoKjLJKUM=;
        b=Nm5TOKBwP87A2vXYgE7vWKfol6Inup9tjmkx5s09bKVbA0LUl3nxP5ToJNRwC2rWPS
         7jVoLyhIWiZD7vrL1jYf0hwR/vIV6zeoW754SD0ypQeNzdxPolXTDcs2ZKcdmRlJX/+M
         4rw7HIhFtne0FhVd1kYzE/voGzVz2+LjSMvSM4pzBcNxiiTtiNRM1T7aVZZQ7J3Gz2P0
         gD4/ENO2DfV+BnbJI58bw+nBHt+V7sPkIs+chmuhC27AOOIAjQ4ftMyLU3YF1cEzfneL
         cg69oj/3MzX1HRua1uKtE1Nnk+0x6hMvUdr4FOJXUbAnL0Uyt0FxAkFZQBKas738ebf0
         cVqA==
X-Gm-Message-State: AJcUukd30Zg6yLng2A669CmVzU4u8dH8JIEWXvPUS8MBfvafve0LlAZa
        wn1/2jadI9E526t2Eqhx0m/2rQ==
X-Google-Smtp-Source: ALg8bN7AfwMvqIo3GaOqqKsF/CmLhASWf+Ic03gMUVfGKaWJwrbflnl+uzu3VV5T2d4pIRd3RIJ+Fg==
X-Received: by 2002:adf:de91:: with SMTP id w17mr25968246wrl.320.1547473554392;
        Mon, 14 Jan 2019 05:45:54 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id x10sm86766472wrn.29.2019.01.14.05.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 05:45:53 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] slimbus: minor fixes.
Date:   Mon, 14 Jan 2019 13:44:45 +0000
Message-Id: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some minor fixes to slimbus core for issues found while testing wcd9335.
First one is make the slimbus core match full device id,
second one is to avoid using big lock in status callback function,
third one is to use status function rather than directly invoking the status ops.
finally last one is to fix missing spinlock init.

Thanks,
srini


Srinivas Kandagatla (4):
  slimbus: core: match full device id
  slimbus: core: do not call device_status under a lock
  slimbus: core: use slim_device_update_status() to update status
  slimbus: core: add missing spin_lock_init on txn_lock

 drivers/slimbus/core.c | 45 +++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

-- 
2.20.1

