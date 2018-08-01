Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83774C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3734520685
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3734520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbeHAL7n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:59:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:43495 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732300AbeHAL7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:59:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 03:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,431,1526367600"; 
   d="scan'208";a="220850701"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga004.jf.intel.com with ESMTP; 01 Aug 2018 03:14:40 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 03:14:40 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 03:14:39 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.81]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.124]) with mapi id 14.03.0319.002;
 Wed, 1 Aug 2018 18:14:38 +0800
From:   "He, Bo" <bo.he@intel.com>
To:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>,
        "plr.vincent@gmail.com" <plr.vincent@gmail.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>,
        "Zhang, Jun" <jun.zhang@intel.com>,
        "Bai, Jie A" <jie.a.bai@intel.com>
Subject: [PATCH] fix panic at pwq_activate_delayed_work.
Thread-Topic: [PATCH] fix panic at pwq_activate_delayed_work.
Thread-Index: AdQpgFO8Ijt1YJaORj6RAuhA9YQA2w==
Date:   Wed, 1 Aug 2018 10:14:38 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D529834D2@SHSMSX104.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2ZhMTJhMmMtMThiZC00MzUwLWFlNDQtZjgzOTcwNzQzMGJiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibXpLbEtJUzE0R2Q5Y05CRkhCYm50XC8zM0VQZVNqMlE4cE9YeXg1TnNkTE80a203ZUtWV3lnRlBDM2UxaFd0cjgifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the kernel panic is one regression with the patch:
usb: gadget: ffs: Fix BUG when userland exits with submitted AIO transfers

the kernel panic is followed the list corrupt warning:
WARNING: CPU: 0 PID: 1430 at ../../../../../../kernel/4.14/lib/list_debug.c:28 __list_add_valid+0x53/0x80
Workqueue: adb ffs_aio_cancel_worker
task: ffff880076ebe080 task.stack: ffffc90001864000
RIP: 0010:__list_add_valid+0x53/0x80
Call Trace:
insert_work+0x51/0xc0
__queue_work+0x10e/0x430
queue_work_on+0x71/0x80
ffs_epfile_async_io_complete+0x4b/0x50
usb_gadget_giveback_request+0x29/0x90
dwc3_gadget_giveback+0x3a/0x50 [dwc3]
dwc3_gadget_ep_dequeue+0x92/0x300 [dwc3]
usb_ep_dequeue+0x23/0x90
ffs_aio_cancel_worker+0x16/0x20
process_one_work+0x186/0x3e0
worker_thread+0x3d/0x3b0
kthread+0x132/0x150
ret_from_fork+0x3a/0x50

the root cause is there is race between ffs_epfile_async_io_complete()
and ffs_aio_cancel() queue the ffs->io_completion_wq.

ffs_epfile_async_io_complete() is safe to hold the eps_lock
with the below backtrace:
ffs_epfile_async_io_complete+0x25/0x70
usb_gadget_giveback_request+0x29/0x90
dwc3_gadget_giveback+0x3a/0x50 [dwc3]
__dwc3_gadget_ep_disable+0x5c/0x270 [dwc3]
dwc3_gadget_ep_disable+0x42/0xf0 [dwc3]
usb_ep_disable+0x24/0xa0
ffs_func_eps_disable.isra.15+0x5f/0xb0

the patch add eps_lock to protect the io_completion_wq in ffs_aio_cancel.

Signed-off-by: he, bo <bo.he@intel.com>
Signed-off-by: Bai, Jie A <jie.a.bai@intel.com>

---
 drivers/usb/gadget/function/f_fs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 3ada83d..45ade26 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1091,6 +1091,8 @@ static int ffs_aio_cancel(struct kiocb *kiocb)
 
 	ENTER();
 
+	spin_lock_irq(&ffs->eps_lock);
+
 	if (likely(io_data && io_data->ep && io_data->req)) {
 		INIT_WORK(&io_data->cancellation_work, ffs_aio_cancel_worker);
 		queue_work(ffs->io_completion_wq, &io_data->cancellation_work);
@@ -1099,6 +1101,8 @@ static int ffs_aio_cancel(struct kiocb *kiocb)
 		value = -EINVAL;
 	}
 
+	spin_unlock_irq(&ffs->eps_lock);
+
 	return value;
 }
 
-- 
2.7.4



