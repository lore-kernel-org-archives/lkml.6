Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AD9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E91220846
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="kQ1MsPyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E91220846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeH2OF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:05:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:56070 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbeH2OF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:05:59 -0400
Received: by mail-it0-f67.google.com with SMTP id d10-v6so6842890itj.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 03:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jHY1u6vtCbAE4lV4L2cBKtvB1ns8sSlx5vp2Kn8HND4=;
        b=kQ1MsPyljKKYOm3zuzIwtIj22o/TAt5bPTtLLEHseCJqOB4UuQDtvsQM/aivjM09IC
         RwMhsM9k8+5n8uMNCv3f6z3hKpRURcO3amgYUaJu1bOtGUzboZFT7btHquICl0rpBq5G
         yKmmK6w66o/Nqfx3pRWcblqUpaCcTzl2gJaASn/cJnvIeeEr7gnXzaXksc+coUyCn4i1
         f9PlbI13/2tAbKqiea/ABxvQdfEFP8tOhmZp+KsQ6V+06aH7EhHeFp09xouJPLSk9WJz
         Q58hogtv9hPUBuWG5aCRzx4zYh6YDxifAQEqBiagPnLHXhY8/cSkfsSPwQleX/WwM9J+
         uB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jHY1u6vtCbAE4lV4L2cBKtvB1ns8sSlx5vp2Kn8HND4=;
        b=WpBUUArJK/erDxXqRgKhOFp5xi0GaLCzCBRoozpqxnrjHizun5AISnHjtrrgjsIpSN
         oDY0iNJyIY7roz+RjBfPcXXgrt0Ep5PDwPeXW4FnZKN9iMUH4CWTFElfKDbDT7f8wHsF
         pynE9psOYcBe+qKDB+/KcNMiqo8hSZwMXavQG0rUn9HxEvAPql6yqVnLkr1GAOoceULN
         TydQ7nYTfyewMMAEkQIfXev2NyyM5tbDJDg2c5PWt09QDRhWX5PYrIguOLQLHhsI5iSK
         XJzOb0/IvrUyD1aE1NX+CDVS1TmlwPs8pwO59lLj975x4u418+D/Kx2D/++KxQU9F5BV
         gA5A==
X-Gm-Message-State: APzg51AsJEsA4SFGjaa5DaaD2+/NdMP3byAWs0NMZ8/xBMGPRCWSpuRZ
        mHhjvEve0Jc6IT4XJkpIHqKf7w==
X-Google-Smtp-Source: ANB0VdZAARNI8aCo4O42YkU04WaAIxeGr7DMbQHd+letw6vJFMo4vicYU5817d/S3yKtzzrEyiq1cQ==
X-Received: by 2002:a24:e142:: with SMTP id n63-v6mr4429594ith.94.1535537390134;
        Wed, 29 Aug 2018 03:09:50 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id v14-v6sm1721501iog.42.2018.08.29.03.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 03:09:49 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 0/3] lightnvm: pblk: support variable OOB size
Date:   Wed, 29 Aug 2018 12:09:27 +0200
Message-Id: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds pblk support for variable metadata sizes on the out
of bound area.

Igor, Marcin, you sent a patch some time ago implementing a similar
functionality, but it never got re-posted after review. Can you test
this and see if it works for your case? I did not implement support for
outlined metadata for the case where the reported OOB area is 0. It
should be pretty simple to do that on top of these patches though.

Thanks,
Javier

Javier González (3):
  lightnvm: use internal allocation for chunk log page
  lightnvm: do no update csecs and sos on 1.2
  lightnvm: pblk: support variable OOB size

 drivers/lightnvm/pblk-core.c     | 60 ++++++++++++++++++++++++++++++----------
 drivers/lightnvm/pblk-init.c     | 16 ++++++++++-
 drivers/lightnvm/pblk-map.c      | 19 +++++++++----
 drivers/lightnvm/pblk-read.c     | 55 ++++++++++++++++++++++--------------
 drivers/lightnvm/pblk-recovery.c | 34 ++++++++++++++++-------
 drivers/lightnvm/pblk.h          | 18 +++++++++---
 drivers/nvme/host/lightnvm.c     | 26 +++++++++++------
 7 files changed, 164 insertions(+), 64 deletions(-)

-- 
2.7.4

