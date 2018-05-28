Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-682722-1527521961-2-6887939567618582556
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527521961; b=ZGkzvhxtO0EwD/MVC/JCn8a13cr7Lf4DlPNntT01Y99kFSjjyW
    SZrt2RAMGJcnPB7XARNI/nzOMS4A8yqQz4GaOHei/XivhGzNbeeHRiDRLitWDWWV
    RzD/fgHRfgn0pzQHOioV9T48MlXRmAb3lVai5I9aARP2X6gOiAzxAbwEiAIZaXgp
    3rj9evXWpZ2J6sTg7xRUb2E8z+r8Va1orBWoSKOs3ROAEALntyVpEr5YlU1nNnnd
    alw+PGmFbaKlySjBzJDsxMDBjDW7APw5BI3UqzVod+bA49gVp0hMAXx1IuMFyVtn
    3aFnyh9G5dpNt0Lxt1TkZoHR07b7XB+N1fNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527521961; bh=sFDnTp8olFsTip/V3jHC6YVREX1bZn
    rJKzn7K1jCkKY=; b=RcpOIuPxK1ZDxNprWbbNHXv0rbisUMJryzswiqkqEanCC/
    s8c96aI6fq8pk7f3uTrn34ubHJYTsEh6ZG0VluuB6+XKUL3sjfZ9GUyQYknUomRL
    2qXsIRisyn3uIl/5rUy5L02ngIvxJQUGOrJgn/nkczJJpN9sWos1aJu5qGlfufiV
    ytyK/AGv2gDIRpvDQko/ouxv2Rt7K4WfRb+JaU0jTqY62SKpoGqPkkUdtnZ2kWHF
    oe8SHLcyT6hiHR4rqnuG1XFdcI2M0NtRfo+3bYKDcGxdIm7G90srNTqfznmHlP1m
    2lIEKCILS7KeEdN4LNjr7FCATilbM+PAliH7VwJg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAIrXeQC1ewxg6fVSRwS0NCoegDwlmXXuOabj9UzKpo6WD7oi9cBZYPTPsoI1rDFXguE6BGmnC0khE+VO+8YR/UChj1WGQCzUoeqz1iKLXE3onFnX+h6
    6eh0fS6bjXDTKcnNZrTfsA2fNuZTAnaVojjsy4uigRB0DjtPjk6pexe59oGGLj25YW1lXfv3MnWqzj6j+lsG/0z7PdFOsUp2Bj69YfK0+F4Fmelqi58JszDc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=TKYDfnLQTZiq3GljLNMA:9
    a=N8N-558xWu8A:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034572AbeE1PjM (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 11:39:12 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969088AbeE1PjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 May 2018 11:39:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mikulas Patocka <mpatocka@redhat.com>,
        Shaohua Li <shli@kernel.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dm: writecache: add DAX dependency
Date: Mon, 28 May 2018 17:38:10 +0200
Message-Id: <20180528153834.2268557-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:RVNtoTNxmkupetdjiOpqWgwo6lSqiBxyBsOD/guBm6k/BgIb1bU
 /PkFlS0foP11aHO8R3kgO1Lp7VW92gLWVPQgJdrVS/nFASHjIkRppnPw2QzQSRTdJnzlmxc
 Q2pE4xGD49yo/xR9D/++PL28JK0ukas67VXppxQSRd2sV0e3YfwtlNCSkVwbBpxRDv/pggt
 6JFG8Ca+lXli6dYSgcvlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ouZeIPFc7Os=:KUhffD8Bt0pxIgBdPPYEjn
 rUrjnOcg/ETHJg+aoiKr8nTLXOzU4fcKT7WdOYUCgjokiZ07tuDiyqfGT4uxn4tAo5BSmtc1a
 rUpaeso2/KouH3k4q9srz8sfDjZEIL5I/LiGi/q3z5NOPG2+meMbVAImvBsg63UztUevn8pFw
 uM01/c29aHtDjjmdpCSsuxhTuEwtrmSqEj8BmulVH83/v+j4qZu+ij5fH2sPDkBIotmiANCFv
 H3BUsMPcVabzgf8a7NF6e20AVc8wWzEMlCsDCHKNB2rEq+9cNvxQ91XuD+mfngLSqMl893hhx
 2Zk5Eodm0KVZ+lMWsKmRa5S2jJRL5FD9R1s8DzCAgyums59Xo1zuuTx8iEFPynfpi1MAtm+yn
 EjLkRQBBQxMBz7UjNdG4vcQXfV6Ou9ngi6Tq8U9kbSpLxQOAXMVFS4qXTPoRGKEXUs5bt5glK
 Vf7kEY7hqiyYBlnZJQ4Y6Ni9a0uowfXQ7eOiSwp47gB7alrQ+JiQWJC9SLxbFjgREhqjJEnc1
 WjH6ic4Sm8jLlCpdT+7Nt3URb2VLmxb8CYpx/Xk4NBSZCcm41X+a0x90fe0d+l3+IdcrKgibv
 BtaObZ63bGAORN1HNySB6r7JMRMpdgj5FW2MpM41YP8HVeslf9cvu/iexso87Lno7PT/9Q6Pc
 qmWfu0J9Tp6oSU2RCfazALeU+KCM7oc8LRReWmUkc1u5qQDWaHKUuhS363LR41YS4R38=
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The new dm-writecache driver inconditionally uses the dax
subsystem, leading to link errors in some configurations:

drivers/md/dm-writecache.o: In function `writecache_ctr':
dm-writecache.c:(.text+0x1fdc): undefined reference to `dax_read_lock'
dm-writecache.c:(.text+0x2004): undefined reference to `dax_direct_access'
dm-writecache.c:(.text+0x21cc): undefined reference to `dax_read_unlock'

It seems wrong to require DAX in order to build the writecache
driver, but that at least avoids randconfig build errors.

Fixes: bb15b431d650 ("dm: add writecache target")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/md/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 852c7ebe2902..f8ecf2da1edf 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -338,6 +338,7 @@ config DM_CACHE_SMQ
 config DM_WRITECACHE
 	tristate "Writecache target"
 	depends on BLK_DEV_DM
+	depends on DAX
 	---help---
 	   The writecache target caches writes on persistent memory or SSD.
 	   It is intended for databases or other programs that need extremely
-- 
2.9.0
