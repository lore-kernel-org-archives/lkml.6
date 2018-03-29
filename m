Return-Path: <dongsheng.wang@hxt-semitech.com>
X-Google-Smtp-Source: AIpwx4/S8qzViFTaT11OG6+AKrtsnO3ZJYWpXkTcNjjvvbI2G5qI5+lKH0oRpPpNliR7jfWqUzm8
ARC-Seal: i=1; a=rsa-sha256; t=1522317684; cv=none;
        d=google.com; s=arc-20160816;
        b=VUrq6gKvkGtgO5Me4D92TYBp7nLZKjTCWywGCzi3axSE91jzzPwKnq4Atosm/1T9tn
         f/rfwmZ2mMbZbcv41jBReMnBAg5GwONengnWTjaev5w+PDKdCmuTMk74uC/JD9jbB5ts
         Pn/bCIweXgCrU5zGiOTRIS7si6qVgJFgR0j3WeClHpOE0B/juMqVOB+d6rDoj6N2b/rl
         pj3lRVqwU0CMHEDvuXEM1WxB5GJ/sAKJ0mxxMpU8Y+jMxL/Ls3g3nxiX0/hjVivOHbk0
         pchst75jdRtt/uE4lOuy1jm/dI9A4dLSdhL1Fd6Wkpra2slnXOVHCN2SftGST7lXOufd
         Xikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=zmcSORLdyNNLhe4HRR0kezCxrrS5UlWiUZsWM5W1uWA=;
        b=mohFLwAUG06FaR6gXeO4bng5JlosEIu5jIVphJ8lzAeoKvqbq0o3iCjjDQcglZrVU8
         XU94C75cI9yETPBa9b9qIMMfmQt/TGr2szQJnvuhY+ifqs78zMdidwL5fHEtKjKE6qYz
         2oPCIVYuXC/OTGCkuXCSQ+jS0l5JujGP8UJK7aphLXMOUuS7ttha7lHLBEGCKFH85LSH
         eUrmlR9KvtyprrhmXnlLtvALUle+Bdxo0B34HJ+L4w3qnNoQf8BpbJqkqhjtTH+pOLme
         XvwcFLlIfVlse0Nf0GGwPNBMsAN1/5wWty2B3HsmVjaalbZimB8dQCQqe5H+EjcdcQMt
         bCaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dongsheng.wang@hxt-semitech.com designates 223.203.96.7 as permitted sender) smtp.mailfrom=dongsheng.wang@hxt-semitech.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dongsheng.wang@hxt-semitech.com designates 223.203.96.7 as permitted sender) smtp.mailfrom=dongsheng.wang@hxt-semitech.com
X-ASG-Debug-ID: 1522317680-093b7e77020c050001-y9GDlS
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
From: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
To: <rjw@rjwysocki.net>, <lorenzo.pieralisi@arm.com>
CC: <gregkh@linuxfoundation.org>, <hanjun.guo@linaro.org>,
	<sudeep.holla@arm.com>, <yu.zheng@hxt-semitech.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Wang Dongsheng
	<dongsheng.wang@hxt-semitech.com>
Subject: [RFC PATCH 0/2] driver core: add new dl device status DL_DEV_PROBE_FAILED
Date: Thu, 29 Mar 2018 03:00:58 -0700
X-ASG-Orig-Subj: [RFC PATCH 0/2] driver core: add new dl device status DL_DEV_PROBE_FAILED
Message-ID: <1522317660-11080-1-git-send-email-dongsheng.wang@hxt-semitech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.103]
X-ClientProxiedBy: HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1522317680
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6305 1.0000 0.9049
X-Barracuda-Spam-Score: 0.90
X-Barracuda-Spam-Status: No, SCORE=0.90 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.49406
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596265787893408502?=
X-GMAIL-MSGID: =?utf-8?q?1596265787893408502?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Recently we found the master of SMMU retries to probe endlessly.

[    3.658956] pci 0000:00:00.0: Retrying from deferred list
[    3.658969] pci 0000:00:00.0: Added to deferred list
[    3.658987] pci 0004:00:00.0: Retrying from deferred list
[    3.658994] pci 0004:00:00.0: Added to deferred list
[    3.659003] pci 0005:00:00.0: Retrying from deferred list
[    3.659010] pci 0005:00:00.0: Added to deferred list
[    3.659019] pci 0004:01:00.0: Retrying from deferred list
[    3.659029] pci 0004:01:00.0: Added to deferred list

The retrying should only happen when the IOMMU instance hasn't been
probed yet.
However, dma_configure() simply return -EPROBE_DEFER when failed to get
an IOMMU instance even if the IOMMU instance is failed to probe.

This patchset tries to fix the issue by distinguishing probe failures and
haven't-been-probed-yet state.

Wang Dongsheng (2):
  driver core: add new dl device status DL_DEV_PROBE_FAILED
  ACPI/IORT: use swiotlb_dma_ops when smmu probe failed

 Documentation/driver-api/device_link.rst |  2 +-
 drivers/acpi/arm64/iort.c                | 39 +++++++++++++++++++++++++++-----
 drivers/base/base.h                      |  2 +-
 drivers/base/core.c                      | 22 ++++++++++++++++--
 drivers/base/dd.c                        |  2 +-
 include/linux/device.h                   |  1 +
 6 files changed, 57 insertions(+), 11 deletions(-)

-- 
2.7.4
