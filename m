Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777BFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A1120852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A1120852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755231AbeFRPaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:30:18 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51167 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753570AbeFRPaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:30:16 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LhHE4-1fzeCz3V1E-00mdTV; Mon, 18 Jun 2018 17:30:05 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Steffen Maier <maier@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi_transport_fc: use 64-bit timestamps consistently
Date:   Mon, 18 Jun 2018 17:29:51 +0200
Message-Id: <20180618153004.1808419-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:n6eE0IN1X1w26lvEKScjAU7VFzMcgOnarfsDBImwHIG5Gcqa8t6
 P0lVXvFkWoqF4LT/r0AGxnkuariZC/2MWNuwf618nRCHf5l6rizgBZUhbtnn5BhofRChEe0
 JHU+BRMSH9+7TqnwIvmQi7dSa0mhloEsz3BFLXA+HMGHw8fgyppgzyzOkqgr7aiwdxDl/WS
 zVYv7+1QYI37w8J5Zf9Wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xKlikjjSjKY=:AZ7vhoeYUumCWkex+cKiuG
 0r35lcZdYjBorXfYby1gwHprOpihS4Bvqgkfmp8UPobz+NxPVgZqJJksQ5aBBTYjQBVhse89x
 mhRkxGpbVkMglmu5OBu2U870qICBKDiRa+gNQF7RxxpmtoGgnKAOzso06Hvn5gKkb8ZjE0z3K
 ymsfUoKTsWtwXQNFhIjA4SAo8yO1fA9e1k1SKrP4Ue61/MLJE2q6BbsvElqMjgcQVY6EFZ8Vq
 hTo5QtCUDw936LmIjHaWRyP0SfqZnBekPPytVlFmn9dVYG6vFBHOTmoISw4EyWPV3F1YxVHaN
 hxIGUIVthBW3Y3pdrr/Asa1R/nE39ngu8jGSKCPrq13h0WU85v+23/edJ1+Pb0N/ANAfQFldi
 FTr4oEP/635cgRxi+oZISBr/7iHamu6Md6tabxtvsqbiJWYi0/Tdvy+7yMe4Q7bpgmmhHPL1j
 SJ1chHnR3xMN98qng4N1lsWLD7FMivq/SGUfFWH+S6JRgrj/H4f2bsPD/GK1qUqC+0JM7Nuw5
 xt+MpxXOLcje23Xeq4G8VDdBVYMgQvmdg+WyLEesEi6AqTZjKVmd/lzOpC4tgIqsWv4z+qscj
 PcYdV1KSpVAQMQNKHoIYefdh9osMTmysFxE3ZPhtSzTdtl3WMO9nMg8ebDeYLBlvGTUJJJmB/
 tnHNPCcD+l2glvArmdtAZzOLETppwaRD7Qdj1J0pWcFT+Goh6iS61DXe3yH/N6em9vAk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_seconds() helper returns an 'unsigned long' value, which can
overflow on 32-bit architectures. Since the interface we pass it into
already uses a 64-bit type, we can just use ktime_get_real_seconds()
instead.

While we generally prefer local timestamps in CLOCK_MONOTONIC format
(ktime_get_seconds), this keeps using the CLOCK_REALTIME version
in order to maintain compatibility with existing code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/scsi_transport_fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 1da3d71e9f61..bb6de88aa724 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -567,7 +567,7 @@ fc_host_post_event(struct Scsi_Host *shost, u32 event_number,
 
 	INIT_SCSI_NL_HDR(&event->snlh, SCSI_NL_TRANSPORT_FC,
 				FC_NL_ASYNC_EVENT, len);
-	event->seconds = get_seconds();
+	event->seconds = ktime_get_real_seconds();
 	event->vendor_id = 0;
 	event->host_no = shost->host_no;
 	event->event_datalen = sizeof(u32);	/* bytes */
@@ -635,7 +635,7 @@ fc_host_post_vendor_event(struct Scsi_Host *shost, u32 event_number,
 
 	INIT_SCSI_NL_HDR(&event->snlh, SCSI_NL_TRANSPORT_FC,
 				FC_NL_ASYNC_EVENT, len);
-	event->seconds = get_seconds();
+	event->seconds = ktime_get_real_seconds();
 	event->vendor_id = vendor_id;
 	event->host_no = shost->host_no;
 	event->event_datalen = data_len;	/* bytes */
-- 
2.9.0

