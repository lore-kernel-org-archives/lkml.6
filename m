Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-285521-1527285668-2-16877424574357742340
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527285667; b=cdJJvotKT8HireLgzd6di8TelvD/CRwcv1Gt8cc9SjmM9g1yVf
    2tKwnFC4dRnr1q2sBda7Mb1aH4EydE+MwATHqQhMrbCRN5KzFrPJicKt0drfPY0U
    3MMvfJHmbZa9wCsj6XrC5TyI8ci15Yc/qC/xg6OR6JECWNRDcZbLoINumD1mJ2xn
    gDxOeYMUYYfDP/r2I6SRHceuyKE9qXfAJjmSeg0nQweY4ySSMqiAbqAqGVKVWlgG
    et5iI6mjN1M/9oxYSSYM7Rhfm8PiRoEFjCRx8G5WDWLdEN4n8gM54YnCIovPl6UD
    cRwL3lDXDAeq+fLqCNo45xzItRCbOFiSoBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527285667; bh=
    qanCpA1+QGOhGOLfejPz5Yt/nZHp0tyw8ZpeO66SuW8=; b=JxozLMEj1cDhtuW6
    X4AknxMbfijvJkVn5/HCq02FEA2WD6fnm7sci64yZLW9YAyA1pyXIbJ4x2mfAzIe
    RUSlEV9HNR+yPk4GoQgiUkaePCeXmRHYw7Y6iK/Q30S7k1a6MYn/E0pU+GbjWVVN
    mqqYHlX4cm397QpRX1VppOPRXgz9oUbHfXcqmo/oHSROUtMu84IoW+Sdl/fQZKq4
    6sRRP7tXrSKZl6nMLioc7VsMbKWRABjZF1U0XUk3E/ZmZnY6T2cvgTHdjojSJcKD
    cdtunk7mHxtqMl/1Bsu7VHvEJdtf/M6BL+YGN5TG1/UAtGiu1+vib1oc8cnpso8L
    oO17mg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFFny2hwykhFrAB6FpikQl0OUj/yJgrYxogyyncdQKwZJeM7tbscGyjeczjsEYXcdA2tdWM2FGbhTdc3UDeh1tSBi3pHQ9hRvT4+YUe34HoXOAGaFwiI
    nupS2kfgHDQTRZG9ODzaBSWGzCA8sVGsqtDssoHpSF0dlg8ESQkNw5fQDlZTu8U+QGsJ+qsprt1vJEPO0NVkHN9M8avOGvnzM9wcKONU1Ie+QUyQly93EwsD
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=1b4FeyyPZkk651F0QM0A:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030609AbeEYWBD (ORCPT <rfc822;linux@kroah.com>);
        Fri, 25 May 2018 18:01:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:17942 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030550AbeEYWBC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 May 2018 18:01:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,441,1520924400";
   d="scan'208";a="231900882"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-xfs@vger.kernel.org
Subject: [PATCH resend 3/7] dm: fix test for DAX device support
Date: Fri, 25 May 2018 16:00:51 -0600
Message-Id: <20180525220055.18920-4-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180525220055.18920-1-ross.zwisler@linux.intel.com>
References: <20180525220055.18920-1-ross.zwisler@linux.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently device_supports_dax() just checks to see if the QUEUE_FLAG_DAX
flag is set on the device's request queue to decide whether or not the
device supports filesystem DAX.  This is insufficient because there are
devices like PMEM namespaces in raw mode which have QUEUE_FLAG_DAX set but
which don't actually support DAX.

This means that you could create a dm-linear device, for example, where the
first part of the dm-linear device was a PMEM namespace in fsdax mode and
the second part was a PMEM namespace in raw mode.  Both DM and the
filesystem you put on that dm-linear device would think the whole device
supports DAX, which would lead to bad behavior once your raw PMEM namespace
part using DAX needed struct page for something.

Fix this by using bdev_dax_supported() like filesystems do at mount time.
This checks for raw mode and also performs other tests like checking to
make sure the dax_direct_access() path works.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Fixes: commit 545ed20e6df6 ("dm: add infrastructure for DAX support")
---
 drivers/md/dm-table.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 0589a4da12bb..5bb994b012ca 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -885,9 +885,7 @@ EXPORT_SYMBOL_GPL(dm_table_set_type);
 static int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
 			       sector_t start, sector_t len, void *data)
 {
-	struct request_queue *q = bdev_get_queue(dev->bdev);
-
-	return q && blk_queue_dax(q);
+	return bdev_dax_supported(dev->bdev, PAGE_SIZE);
 }
 
 static bool dm_table_supports_dax(struct dm_table *t)
-- 
2.14.3
