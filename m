Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/cXjVIK6khc64lakB5gXETglIjxFCfLbkXJcgf9ikKpWA4dCUKvxFle9H5B9T+HLFUCJ5Y
ARC-Seal: i=1; a=rsa-sha256; t=1522120877; cv=none;
        d=google.com; s=arc-20160816;
        b=s0u1qDBqmr5bVrCBrYEkBjE8O63Dc8Q9vbVmn6UPXuhrPOD51fsTwh9mRxZ9Hxer8Y
         uS1BZpj7MZIggy2D5S78gd45xdpgruEGbEK08O2n0vIVOQHYvJWiqZLFIJzQ4R/N12AW
         oVLaL6zYV/miQ66FztTbEvq7XC1xCl2cTqxtCyPQ8QTB9XcDLd1lxZMrH4J9/DKTT6YH
         A/mLgJonDcBssanPRbbYb85osGHdQbQ7nnvL0L7gpJIZZXyg6/iiipbaHmhAan03b4QF
         32FZsOxtQkzUF1+VCZBaofFOr7HKdWRt6Yw9DlFaK5cDh6zMpNPwx9jjV1RWnpADahHJ
         /RpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=8SUM94jDTRPjBUMad1I5DlJ3eW89bAEmkMAy2jr4qGg=;
        b=XmlXcAUEoRsaZ+7LdIW9SrbpwJvrMRxC7+D1uAPqKW+jwMVU7bM7H+pAQB17EzDqXj
         d+iIy7bk+KFwGs0gsjmzS0QAwc6W5TWEHmhUfusnUYPnlq14Ii+OC/FRY/ib1efeqzdA
         gcvAxpCSlGrsb7IdPZtl4DCenjrYwayA017rKSGY8Ym1jtnBeNA75fZ8dSa9Ns3ca5TC
         2+xlRpF8GXa5TtHw9Oj0utkeOYN5BUmkd/njVISI5axzIc5/nP8iJ6ODTWKguWH8lfuP
         uXk34gVUGMa7uBuWoK2mTn7PUnv6ooq4JiKv0RsUsfu5i/p600JZIRIF0UNzoB9iAkQP
         fqiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbeC0DVQ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 23:21:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:63675 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751489AbeC0DVQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 23:21:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="215125657"
From: changbin.du@intel.com
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH v2 0/4] selftests: fix compiling issues
Date: Tue, 27 Mar 2018 11:11:30 +0800
Message-Id: <1522120294-24926-1-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596059421203981403?=
X-GMAIL-MSGID: =?utf-8?q?1596059421203981403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Changbin Du <changbin.du@intel.com>

These 4 patches fixed all the existing compiling errors. With this serias,
no compiling error reported after running 'make kselftest'.

v2: resolve compiling error if run make in individual folder.

Changbin Du (4):
  selftests/Makefile: append a slash to env variable OUTPUT
  selftests/gpio: fix paths in Makefile
  kselftest: install sanitized kernel headers before compiling
  selftests/bpf: fix compiling errors

 tools/testing/selftests/.gitignore      |  4 ----
 tools/testing/selftests/Makefile        | 21 ++++++++++++---------
 tools/testing/selftests/bpf/Makefile    |  5 +++--
 tools/testing/selftests/gpio/.gitignore |  4 ++++
 tools/testing/selftests/gpio/Makefile   | 17 +++++++++--------
 5 files changed, 28 insertions(+), 23 deletions(-)

-- 
2.7.4

