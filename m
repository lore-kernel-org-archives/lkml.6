Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3912DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87CC218EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="IBSojf8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87CC218EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeHQNWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:22:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36267 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeHQNWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:22:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id k15-v6so4253320edr.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k7F7VzVtZRn2IELLNVJ9Ybxj+V1DJvKB3OCMFLfIK/Y=;
        b=IBSojf8os4t/cPcAIhpt9LqN91j5jOqD728atmzztSMgJPUqBDZ8tjaJOjgrDoIF7Z
         uJvq2h5WAVcVf+2CIKhYBT3XT5fzMdL+gTMIbiX4Z0xL0jdTQUHLECdWddPJ6UT5Lacw
         fIWBQM952/yo6J7IXsSHTqQHB3XKeZn1ImkFaQeVuw2BFOiFLBiXcHV6uMBBGSfBH9pB
         voyMMXI0FEgvkymK/FQkBbM2uilk6QUeEfFa+dHalMz/qBj7trBPYbil978dFHbDrx8I
         e6nc8QyxO+tk2BJOHxd5BALA76TFk2/N8NoWO3vKGDoIJZqEK+irTMZ20JtF0ZslOHXg
         tO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k7F7VzVtZRn2IELLNVJ9Ybxj+V1DJvKB3OCMFLfIK/Y=;
        b=N0la7NeSI1CvjFQR0LKFi0Yr3a15twtBYTago9OkGG7iIO5n1wOfVNYL4KbXqrBLDP
         sN+YH25lwjoeYcRAnsYugwj+ylZA4//Z24qh0OgBl3hfPllIC4bi6+L+mgQ+l/GPlsrR
         8upBvCD8K7zTWFJegFg9bKtOf3Uc8j2cIb1f9UVaI49DauQOpVLnjOH7kXMlcMZUjAnO
         cZk4EzziCsFrAzIz8c9Ja4Y6DLzjaRZ8JG2NZMPkFg4XggU+o0kBb4pCiWm0Ar/ssoSY
         TmKulAyf6b5joeosKO3Co/cMGvF4vD9urSS1c0sOHhynW+qHsR2Sk+iYHtg60smHyZ55
         M7cw==
X-Gm-Message-State: AOUpUlH8lpyuCNJVbbs0c82KI9be8IYz2zyCmLnAVbx1FJ/wACqeh22b
        ANXYCMqcnkg8WJNRBPOy5jGfhg==
X-Google-Smtp-Source: AA+uWPwx6j0QkjUB5uY4qn93e/zI3sItDp+q5rywrHKZL6TVWlONT0XpR0aqTtPPIXkRRHofc01VJg==
X-Received: by 2002:a50:865b:: with SMTP id 27-v6mr40228529edt.42.1534501164018;
        Fri, 17 Aug 2018 03:19:24 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id v26-v6sm1442563eds.43.2018.08.17.03.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 03:19:23 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [V3 PATCH 0/2] lightnvm: pblk: take write semaphore on metadata
Date:   Fri, 17 Aug 2018 12:19:08 +0200
Message-Id: <1534501150-11906-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# Changes since V2:
  - Split the original patch between the metadata refactoring and the
    semaphore logic. This simplifies the write path, where the semaphore
    is taken.

# Changes singe V1:
  - Fix double I/O on the read path (by Matias)
  - Improve commit message (by Jens)

This patchset refactors the metadata separate write and read paths,
which simplifies how the semaphore is taken for writes.

Thanks,
Javier

Javier González (2):
  lightnvm: pblk: refactor metadata paths
  lightnvm: pblk: take write semaphore on metadata

 drivers/lightnvm/pblk-core.c     | 352 +++++++++++++++++++--------------------
 drivers/lightnvm/pblk-gc.c       |   2 +-
 drivers/lightnvm/pblk-recovery.c |   4 +-
 drivers/lightnvm/pblk.h          |   5 +-
 4 files changed, 178 insertions(+), 185 deletions(-)

-- 
2.7.4

