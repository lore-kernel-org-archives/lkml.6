Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELtPltg4i9hD6mrklybOCfSlH86CtvqbAI7kG6HiR2/y2Ne/kYC/W/l80XXd5NZSNPIEu50I
ARC-Seal: i=1; a=rsa-sha256; t=1522056790; cv=none;
        d=google.com; s=arc-20160816;
        b=vk1sG35IB+eW2M2pqkwp/joz/SU01qXsDVKIVjMlR7k99Zu+Jb/gnRisxhS/AqjkHv
         EJx7kxRXh+vLIWvDOS+DlhNSpJv2eFcMJTc62HKhKRC/zhoUiz1JtVfLOUIa2fM9C6xO
         44mJwDZWEl38+Eg8q7npIXKw4mEMIOATPnEW4oUar30IvjvTAKpUBNhXmYywBzk09wXR
         B5QfwgWU69ig3vxxjZR5VyHPmkgpB4Oibycg3H+LdFjayM3swtuND3Edk21VBhJB2gOl
         E0a/oTrjiWjmZLSDQMm+tCH9nmxkI1E+K6/7CTMWpZzAGCDq6EasDeLfc12azgUsTnvC
         azew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=oLj0cDx42CQeADO0aQJcfszVZpM2N7yEkrLrtTyawfY=;
        b=0bjwmSWUtnE8Xp4svuVwqP/BDimoVs+67dD98YNSH+UHtul5Qz4bl1m79t77+Px06O
         vXflFNaD5k+TlwTvZlON3hV0CvuSkYnuj7W8qqKjsRZA7Bc0/9HN43phPJ5jsVmtI27l
         XJnq25Qu/LPPAzHd1dA8rZnwuiOqQ2sfAQcPymM3dWcdKWuYVs1XR6YyZcrIpaq5Zw6m
         up8uAEWLmu+DOomAcLZ+gZ9LlIGH6w/6ECAwKRWeqiiH/w6DxfyuezqVfHYJKdbfPuIM
         qt/j+FdSK2JRRW24z6ue+vFx1KgEAgbag0tUQdZ3K0TQ0S3jB0MzsVNFcix9M7ZHt84/
         ytnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbeCZJdK (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 05:33:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:43803 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbeCZJdJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 05:33:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="36851558"
From: changbin.du@intel.com
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH 0/4] selftests: fix compiling issues
Date: Mon, 26 Mar 2018 17:23:24 +0800
Message-Id: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595992221276715783?=
X-GMAIL-MSGID: =?utf-8?q?1595992221276715783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Changbin Du <changbin.du@intel.com>

These 4 patches fixed all the existing compiling errors. With this serias,
no compiling error reported after running 'make kselftest'.

Changbin Du (4):
  selftests/Makefile: append a slash to env variable OUTPUT
  selftests/gpio: fix paths in Makefile
  kselftest: install sanitized kernel headers before compiling
  selftests/bpf: fix compiling errors

 tools/testing/selftests/.gitignore      |  4 ----
 tools/testing/selftests/Makefile        | 21 ++++++++++++---------
 tools/testing/selftests/bpf/Makefile    |  5 +++--
 tools/testing/selftests/gpio/.gitignore |  4 ++++
 tools/testing/selftests/gpio/Makefile   | 14 +++++++-------
 5 files changed, 26 insertions(+), 22 deletions(-)

-- 
2.7.4

