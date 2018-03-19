Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELvmHr9c6Yt1KLnQzeLCEka97fTAWaUk33OqX8GoUkTPq9eSMeQK4UzH9mCvww8YVbWbS9Gj
ARC-Seal: i=1; a=rsa-sha256; t=1521476827; cv=none;
        d=google.com; s=arc-20160816;
        b=B0gip7kLkGxwy4DDR1MehfCmmrDPu9XFpOYneY/MHlbBc0p36hYiIKjkF03j/ou3se
         pnnHQnvuS52a+O7CQi9DFb/vkVTohEKp/ORLOwKJlwIH2wZ5QFpqwS0IXqtUZhWhATJq
         /lpvpcmukdQTjgzA7Qzn1z20+xp2W5e5snbAxhGvpLcf1wHtIVFvgzjEoerjOcegF1e1
         lHb4ufWJ7ohF8Dr3cHXEtJBRhXjom7RJqcR/YyErIVDz9VIrJPkor12G7pfMQAN8WsAE
         iZ9GNf5JFE4n0Fft4aBRxNySoOUkgqcUFZYWMBQ7ZcAHDll1d8TuBTE/lx8yB5EKPtIn
         nfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=RBmZmHkj+WIdfpV6dQFnGuvJ0moJz+gKmM/hNScKX4Q=;
        b=EvNGpXL0jh4r0xqdcsq1BKVtoEIJuoXJXhSOxlTEm3aXhLgVScokKx7Ek1Xd86ome8
         /WZ9cqRxgwm0z4EByRwx+LJaX3qcqNxMO5brcnXHrJv1mCSRPk70MATSS2T21OEu6IsD
         dz2rBHkUk+jMeB7U1HRfP80rF7akLd5B28RFMUeRCyO6+V6soFHUffbtSc7MV7krUvvA
         p9cIZgDFlSIfu+7XW/vFjvQRASFbVdHTFIbp29FRwh3c1sh4lq6HmLBsz3/TAt6F2ZtZ
         31BaceWSo6frpgURbHJU6P0ikbsEKdlmv/HqTheAOVSw42g5VGPCYzy3O4HRVtThW36w
         NyLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="29314588"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/19] thunderbolt: Changes for v4.17 merge window
Date: Mon, 19 Mar 2018 19:26:44 +0300
Message-Id: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384085659090191?=
X-GMAIL-MSGID: =?utf-8?q?1595384085659090191?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Here are Thunderbolt changes for v4.17 merge window as a patch series and
there is also a signed tag that you may choose pull directly.

New features:

  - Intel Titan Ridge Thunderbolt 3 controller support
  - Preboot ACL supported, allowing more secure way to boot from
    Thunderbolt devices
  - New "USB only" security level

In addition there are a couple of fixes for increasing timeout when
authenticating the ICM firmware and reading root switch config space.
Preventing a crash on certain Lenovo systems where ICM firmware for some
reason is not always properly starting up.

Thanks!

The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-for-v4.17

for you to fetch changes up to ea9d7bb798900096f26c585957d6ad9c532417e6:

  thunderbolt: Prevent crash when ICM firmware is not running (2018-03-14 14:26:38 +0300)

Mika Westerberg (14):
  thunderbolt: Resume control channel after hibernation image is created
  thunderbolt: Serialize PCIe tunnel creation with PCI rescan
  thunderbolt: Handle connecting device in place of host properly
  thunderbolt: Do not overwrite error code when domain adding fails
  thunderbolt: Wait a bit longer for root switch config space
  thunderbolt: Wait a bit longer for ICM to authenticate the active NVM
  thunderbolt: Handle rejected Thunderbolt devices
  thunderbolt: Factor common ICM add and update operations out
  thunderbolt: Add tb_switch_get()
  thunderbolt: Add constant for approval timeout
  thunderbolt: Move driver ready handling to struct icm
  thunderbolt: Add support for preboot ACL
  thunderbolt: Introduce USB only (SL4) security level
  thunderbolt: Prevent crash when ICM firmware is not running

Radion Mirchevsky (4):
  thunderbolt: Correct function name in kernel-doc comment
  thunderbolt: Add tb_switch_find_by_route()
  thunderbolt: Add tb_xdomain_find_by_route()
  thunderbolt: Add support for Intel Titan Ridge

Yehezkel Bernat (1):
  thunderbolt: Add 'boot' attribute for devices

 Documentation/ABI/testing/sysfs-bus-thunderbolt |  33 +
 Documentation/admin-guide/thunderbolt.rst       |  15 +-
 drivers/thunderbolt/dma_port.c                  |  28 +-
 drivers/thunderbolt/domain.c                    | 130 +++-
 drivers/thunderbolt/icm.c                       | 764 +++++++++++++++++++++---
 drivers/thunderbolt/nhi.c                       |   5 +-
 drivers/thunderbolt/nhi.h                       |   5 +
 drivers/thunderbolt/switch.c                    |  61 +-
 drivers/thunderbolt/tb.h                        |  14 +
 drivers/thunderbolt/tb_msgs.h                   | 180 +++++-
 drivers/thunderbolt/xdomain.c                   |  47 +-
 include/linux/thunderbolt.h                     |  19 +
 12 files changed, 1186 insertions(+), 115 deletions(-)

-- 
2.16.2
