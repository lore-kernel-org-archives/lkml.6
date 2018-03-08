Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934559AbeCHE1K (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 23:27:10 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37065 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750761AbeCHE1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 23:27:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Sz3uhW2_1520483225;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: jeyu@kernel.org
Cc: linux-kernel@vger.kernel.org, zhang.jia@linux.alibaba.com
Subject: [PATCH v2 0/4] modsign enhancement
Date: Thu,  8 Mar 2018 12:26:59 +0800
Message-Id: <1520483223-6596-1-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series allows to disable module validity enforcement
in runtime through /sys/kernel/security/modsign/enforce interface.

Assuming CONFIG_MODULE_SIG_FORCE=y, here are the instructions to
disable the validity enforcement.

# cat /sys/kernel/security/modsign/enforce
# echo -n 0 > data
# openssl smime -sign -nocerts -noattr -binary -in data \
    -inkey <system_trusted_key> -signer <cert> -outform der \
    -out /sys/kernel/security/modsign/enforce

Now enable enforcement again on demand.

# echo 1 > /sys/kernel/security/modsign/enforce

Changelog:
v2:
- Support to disable validity enforcement in runtime.
