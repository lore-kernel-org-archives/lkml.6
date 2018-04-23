Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524514334; cv=none;
        d=google.com; s=arc-20160816;
        b=pYBwUs173qip9OBCuQ8+t0iCCb74ZDIKeNd9exFPO3f60xAaql0lLb8TWlEedy/aNZ
         pVc5AaJFUkDss78eqf8xQncsPBlBIWw2SMx7hCW7g9GRqWcutThSzsZtt5GZHuuVwvcy
         ZwQrAPIieVv9vqBVJiStdOBrVYDdR/1znYVjnEu2KJ5Dc+i29x4S8j6DciYisb7qDEn7
         lVQ7nDcdeFQKG4joWTrSZh4GsrPZrYnQ7Ynr4eH40BGSzWwe0PHUa0h2eqZc2xpoC37R
         GOLi4E9A27YpdDQJh1q1QUd8q+kGdIK1h2M0SfJ+bfHnrKosBuQZOG6reMqqOawRrpNv
         5C1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=tc3EPw6y+UBPMU2rKMTbDpmMdSyvl0F7//vr0H4UYZg=;
        b=SG3FXscz2GCccZ8EvlNwHPhzSf/6/b0INxrM7gtiLmQh+WpKQiYTfzqq4+NqxVvKEf
         F410HRoifiAjHu2SEwmJKyxW1gJsZQ7Wb2v2ejoUwSNXt6fKY8AFPnIzS2Fa9dgZUIoD
         DaZMwCi8ufqR7AFPd1h7e9yRTIQKk2T5KgMHpHjWmRnAk8+7ZdII1zW4QTb+kXmF9Ena
         CiJ9KvX4ay0yNlZgsGy6JX5ibCO/7cyjekNZMvshdtsN4/ittedJw3oVxLdh3bzRuJdK
         UWZtyMBg9eYy00KrqfNzrI9W2n5KFEBlUFw5UgCXWT3jNDB779U3H0+858O8mYyIN5K2
         mxRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RIbbnScB;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RIbbnScB;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+fQejRhgkPGdbB2wh9rwn8O5H8qVg6Ufr7Nvi2CTGraF6PCV9aEhjKHQgNa1+N6mbNqEQnrg==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	christian.koenig@amd.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	hdegoede@redhat.com
Subject: [PATCH 0/9] Loading optional firmware v4
Date: Mon, 23 Apr 2018 16:11:56 -0400
Message-Id: <20180423201205.20533-1-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569142620232223?=
X-GMAIL-MSGID: =?utf-8?q?1598569142620232223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey Everyone,

This is a trimmed down version of v3 that contains the changes for which we
have agreement. Changes that raised concern are being shifted to a followup
series, mainly changes to the async firmware API.

Inline feedback I received in these patches has also been addressed, thanks
everyone that chimed in.

I'll be following up with some proposals for the async API. Hopefully we can
end up with something that is not "the least bad" option.

This series can be found in the for-luis-v4 branch of:
https://github.com/lostgoat/linux.git

Andres Rodriguez (9):
  firmware: some documentation fixes
  firmware: wrap FW_OPT_* into an enum
  firmware: add kernel-doc for enum fw_opt
  firmware: use () to terminate kernel-doc function names
  firmware: add function to load firmware without warnings v5
  firmware: print firmware name on fallback path
  firmware: use rename fw_sysfs_fallback to use the firmware_ prefix
  ath10k: use request_firmware_nowarn to load firmware
  ath10k: re-enable the firmware fallback mechanism for testmode

 .../driver-api/firmware/request_firmware.rst       | 21 +++++----
 drivers/base/firmware_loader/fallback.c            | 30 ++++++------
 drivers/base/firmware_loader/fallback.h            | 12 +++--
 drivers/base/firmware_loader/firmware.h            | 38 +++++++++++----
 drivers/base/firmware_loader/main.c                | 54 ++++++++++++++++------
 drivers/net/wireless/ath/ath10k/core.c             |  2 +-
 drivers/net/wireless/ath/ath10k/testmode.c         |  2 +-
 include/linux/firmware.h                           |  2 +
 8 files changed, 108 insertions(+), 53 deletions(-)

-- 
2.14.1
