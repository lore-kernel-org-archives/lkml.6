Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2689340-1527001761-2-2111768541519926874
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527001760; b=FwYB7kR66r2Da4C7jDAbea8BUJ2viW9qkQ2NcbXXdLZv/ogded
    WRacHbgCL0zo4jzEqOukLy3ioaNwK92rJw++H6poHNWBpG1d3eqZ9MgZxli4XPpu
    Cp+KOtHUhAsCCAhM9qCkhfsgpIIu20csHZHd/IEGRi3SKVM65hlWkGHm4ebk/3Vf
    9h0gHnva1lRoojeK1KST3wSW1UHbOsW5nSiUib0xVhA3xtMPf5BXo7c9+2rh+WTg
    rS7ZoOCeLTZdIdImDe3qDAQvyB2VxRnEW5iPBPZb1g05OafWpJrfPAK8bIbFPtJx
    42BYv4CFplgsaZI3Qbz246NAq3ldWe9iaSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527001760; bh=
    W0FTk8LrTgKJiloA816yKnwHFunxpCU2IhClVsf/lJ4=; b=dhzaEChZzGvmlX6h
    rNPnngCR9P7v6CmUCYGpHgECR6F30RkBX/ci+VAHhbGyGqFarBq+cGsD4UrITnPK
    WMacg44fuutRVr9kvw5yfBMCxrzFeZfsnSdYX4puqO2E8Pg9U9hfo3U+LZ8M67KJ
    lSqzlwuAVMGHxSS9Y/MvgA5ArTNuBIeBVIZ1V3n9INUBbG6Ha27PpS9Aaelt/f32
    67J6l4aDKCnUTUYEkd6/RKdH39C7dFfaHkCXP69Bj7RPQTpmSa1IlTKVsx2oTEpB
    Vnb5Z0ZbRXDEkJ5ITB80IcQYm6Z9SDa8maIDOujVNhD4kPmyvfSSPdugCBKdqWh2
    SOlyzQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=jPIvUhMP x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=jPIvUhMP x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNP8PuaM7729i78e4YUQIUFXtxPQngeSQNDLZKM5UM3+6hnmJe8q93DJNs+OeOAn4RzZtsXMYbfSvrlSY0huGLeJHsCQQek84c5mav2JHqND4Tj+va/+
    orsUiXrJCCjxh4p7eQHH6+eus53ZQzQe3l4E5G2Zz4QMkgrwDGQrZqhtKa9ny7D99uJ0DyOZgdj+CYMBuc83uk65ol1l41+PXCUXsL9xuGR4K+bDiAz6VO42
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=WYEzaqUAIiTlmOVyfcEA:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeEVPJR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 11:09:17 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26472 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbeEVPH4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 11:07:56 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520870400";
   d="scan'208";a="79548768"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org
Cc: tglx@linutronix.de, mingo@kernel.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, jack@suse.cz, darrick.wong@oracle.com,
        rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, hch@infradread.org, jmoyer@redhat.com,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v6 3/5] fs: Add aio iopriority support
Date: Tue, 22 May 2018 08:07:35 -0700
Message-Id: <20180522150737.9893-4-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180522150737.9893-1-adam.manzanares@wdc.com>
References: <20180522150737.9893-1-adam.manzanares@wdc.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

This is the per-I/O equivalent of the ioprio_set system call.

When IOCB_FLAG_IOPRIO is set on the iocb aio_flags field, then we set the
newly added kiocb ki_ioprio field to the value in the iocb aio_reqprio field.

This patch depends on block: add ioprio_check_cap function.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c         |  3 +++
 fs/aio.c                     | 16 ++++++++++++++++
 include/linux/fs.h           |  3 +++
 include/uapi/linux/aio_abi.h |  1 +
 4 files changed, 23 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5d4e31655d96..dd98dfd97f5e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -76,6 +76,8 @@
 #include <linux/miscdevice.h>
 #include <linux/falloc.h>
 #include <linux/uio.h>
+#include <linux/ioprio.h>
+
 #include "loop.h"
 
 #include <linux/uaccess.h>
@@ -559,6 +561,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
+	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 	if (cmd->css)
 		kthread_associate_blkcg(cmd->css);
 
diff --git a/fs/aio.c b/fs/aio.c
index 755d3f57bcc8..8225013f70f0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1451,6 +1451,22 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	req->ki_hint = file_write_hint(req->ki_filp);
+	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
+		/*
+		 * If the IOCB_FLAG_IOPRIO flag of aio_flags is set, then
+		 * aio_reqprio is interpreted as an I/O scheduling
+		 * class and priority.
+		 */
+		ret = ioprio_check_cap(iocb->aio_reqprio);
+		if (ret) {
+			pr_debug("aio ioprio check cap error\n");
+			return -EINVAL;
+		}
+
+		req->ki_ioprio = iocb->aio_reqprio;
+	} else
+		req->ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+
 	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags);
 	if (unlikely(ret))
 		fput(req->ki_filp);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 50de40dbbb85..73b749ed3ea1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -36,6 +36,7 @@
 #include <linux/delayed_call.h>
 #include <linux/uuid.h>
 #include <linux/errseq.h>
+#include <linux/ioprio.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -302,6 +303,7 @@ struct kiocb {
 	void			*private;
 	int			ki_flags;
 	u16			ki_hint;
+	u16			ki_ioprio; /* See linux/ioprio.h */
 } __randomize_layout;
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
@@ -1942,6 +1944,7 @@ static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 		.ki_filp = filp,
 		.ki_flags = iocb_flags(filp),
 		.ki_hint = ki_hint_validate(file_write_hint(filp)),
+		.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0),
 	};
 }
 
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index 2c0a3415beee..d4e768d55d14 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -55,6 +55,7 @@ enum {
  *                   is valid.
  */
 #define IOCB_FLAG_RESFD		(1 << 0)
+#define IOCB_FLAG_IOPRIO	(1 << 1)
 
 /* read() from /dev/aio returns these structures. */
 struct io_event {
-- 
2.15.1

