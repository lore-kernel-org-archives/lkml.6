Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282F6C43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D484B20685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D484B20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeI3IzB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 04:55:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:58127 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbeI3IzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 04:55:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2018 19:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,322,1534834800"; 
   d="scan'208";a="261565168"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga005.jf.intel.com with ESMTP; 29 Sep 2018 19:16:59 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sat, 29 Sep 2018 19:16:58 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.58]) with mapi id 14.03.0319.002;
 Sat, 29 Sep 2018 19:16:58 -0700
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: [GIT PULL] filesystem-dax fix for 4.19-rc6
Thread-Topic: [GIT PULL] filesystem-dax fix for 4.19-rc6
Thread-Index: AQHUWGOp3kAhMNI5r0eciiF5g1GxnA==
Date:   Sun, 30 Sep 2018 02:16:57 +0000
Message-ID: <1538273814.24243.65.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.25.95]
Content-Type: text/plain; charset="utf-7"
Content-ID: <574EDF985B944848B7B3A62FF722AB64@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, please pull from...

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes2-4.19-rc6

...to receive one more urgent fix for 4.19-rc6.

---

The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +-0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes2-4.19-rc6

for you to fetch changes up to f52afc93cd018fe6910133a05d44671192d1aeb0:

  dax: Fix deadlock in dax+AF8-lock+AF8-mapping+AF8-entry() (2018-09-27 10:56:15 -0700)

----------------------------------------------------------------
filesystem-dax for 4.19-rc6

Fix a deadlock in the new for 4.19 dax+AF8-lock+AF8-mapping+AF8-entry() routine.

----------------------------------------------------------------
Jan Kara (1):
      dax: Fix deadlock in dax+AF8-lock+AF8-mapping+AF8-entry()

 fs/dax.c +AHw- 1 +-
 1 file changed, 1 insertion(+-)

commit f52afc93cd018fe6910133a05d44671192d1aeb0
Author: Jan Kara +ADw-jack+AEA-suse.cz+AD4-
Date:   Thu Sep 27 13:23:32 2018 +-0200

    dax: Fix deadlock in dax+AF8-lock+AF8-mapping+AF8-entry()
    
    When dax+AF8-lock+AF8-mapping+AF8-entry() has to sleep to obtain entry lock, it will
    fail to unlock mapping-+AD4-i+AF8-pages spinlock and thus immediately deadlock
    against itself when retrying to grab the entry lock again. Fix the
    problem by unlocking mapping-+AD4-i+AF8-pages before retrying.
    
    Fixes: c2a7d2a11552 (+ACI-filesystem-dax: Introduce dax+AF8-lock+AF8-mapping+AF8-entry()+ACI-)
    Reported-by: Barret Rhoden +ADw-brho+AEA-google.com+AD4-
    Signed-off-by: Jan Kara +ADw-jack+AEA-suse.cz+AD4-
    Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

diff --git a/fs/dax.c b/fs/dax.c
index f32d7125ad0f..e4ef8af31aa6 100644
--- a/fs/dax.c
+-+-+- b/fs/dax.c
+AEAAQA- -447,6 +-447,7 +AEAAQA- bool dax+AF8-lock+AF8-mapping+AF8-entry(struct page +ACo-page)
                        xa+AF8-unlock+AF8-irq(+ACY-mapping-+AD4-i+AF8-pages)+ADs-
                        break+ADs-
                +AH0- else if (IS+AF8-ERR(entry)) +AHs-
+-                       xa+AF8-unlock+AF8-irq(+ACY-mapping-+AD4-i+AF8-pages)+ADs-
                        WARN+AF8-ON+AF8-ONCE(PTR+AF8-ERR(entry) +ACEAPQ- -EAGAIN)+ADs-
                        continue+ADs-
                +AH0-
