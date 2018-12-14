Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71430C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4AE23CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5dAuqjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4AE23CB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbeLNNWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:22:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34105 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbeLNNWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:22:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so4253826lfc.1;
        Fri, 14 Dec 2018 05:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XCtFdiGQU6hhvLH6ZcpcAPy/PZILPhC2uLj3eTmyt3s=;
        b=R5dAuqjxeD7GZ6v5NHOI7Km/U/l/XvB3LOc5EjvvBJcGjCrPoKKElZY5HzD1/qd6zn
         U4JgmdN8za3u+6wLH1ujpRENcPPERbViVD4jABTJqXMjNGAA3omPiz0VmnEsCFklXhoE
         1MfzXxMWd8d9UU0Iv6Vzc5VfYyvCPNDuafQymi6e/ZrrRdGuy217Z2iQm0r6J5oXNnRJ
         ZP+3Y4Eanz3N8k2C14kwM9DKS8mdV9Rc90A5g8MWhUk9hL2vz2mzjoX4LS18xZXBoJPb
         uGeRImEE5f2WXoq4I5a+7RAobXjMJO5nbPtybAMkWqbpqaZjgV8jH5W8am1j9oYNAA1Q
         dDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XCtFdiGQU6hhvLH6ZcpcAPy/PZILPhC2uLj3eTmyt3s=;
        b=i7OCzjPiDVn6GC2T54NxrJPVisflu9P/mYfbLpJhG3TdqV47mPjHviA5Pz7wdLApIS
         5FawwWVO8846Rzs+VoU7a6Z2/pY6bQnxyEj+CbRBlEovBR6q7jCFh27DCKfrD2ZS/EtD
         um1NPfrFoZ1BQinJ7KuM6H16kAthiSEM0zA8xdh6dRJYOSG5ZS3J7+s8hEOBFeRF2s4P
         QfTZR032DQlbvWXLoakn8e5vk97JCBWMB8TzBljdO8SfFCS+CvDo8yUmA/HBgLUDtbHL
         cL+Uwc4MrQdZn+uUYvEOrmVbZqHbey3sQrKybGoig2WpWA6Md0OyJ5AeMhxL1vOqwfpX
         D66w==
X-Gm-Message-State: AA+aEWYWgKwYj6q7gVoCgF8+dzmc48dfKiK4myZ0YOcI/wVOYAVTSbyF
        +tQGBCQaQR7QwgZmytxpFGujAqvhp407UgPp
X-Google-Smtp-Source: AFSGD/U8sXmbs8g6n+d2wak1It5Q+bjLfqima1kw8M6btqIjuXyBlPP0o/NshzRXGacvsVpA0RPnnQ==
X-Received: by 2002:ac2:41cb:: with SMTP id d11mr1927038lfi.3.1544793739659;
        Fri, 14 Dec 2018 05:22:19 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id u79-v6sm944101lje.36.2018.12.14.05.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 05:22:19 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-scsi@vger.kernel.org, mironov.ivan@gmail.com
Cc:     linux-kernel@vger.kernel.org, Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com
Subject: [PATCH 0/6] Add support of the HBA mode on HP Smart Array P410i controllers
Date:   Fri, 14 Dec 2018 18:21:09 +0500
Message-Id: <20181214132115.21440-1-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds support of the HBA mode on HP Smart Array
P410i RAID controllers.

This is not guaranteed to be correct as I do not have any access to
documentation on these controllers. However, this works fine for me
on hardware that I have. Also, these changes successfully passes blktests[1]
and xfstests[2].

To make sure that this new functionality does not break anything, it is
disabled by default and may be enabled only manually using new module
parameter.

[1] https://github.com/osandov/blktests
[2] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

Ivan Mironov (6):
  scsi: hpsa: Add function to check if device is a disk or a zoned
    device
  scsi: hpsa: Support HBA mode on HP Smart Array P410i controllers
  scsi: hpsa: Add/mask existing devices on rescan if visibility changes
  scsi: hpsa: Ignore HBA flag from NVRAM if logical devices exist
  scsi: hpsa: Name more fields in "struct bmic_identify_controller"
  scsi: hpsa: Do not use HBA flag from NVRAM if HBA is not supported

 drivers/scsi/hpsa.c     | 145 ++++++++++++++++++++++++++++++++++++----
 drivers/scsi/hpsa.h     |   3 +
 drivers/scsi/hpsa_cmd.h | 113 ++++++++++++++++++++++++++++++-
 3 files changed, 244 insertions(+), 17 deletions(-)

-- 
2.19.2

