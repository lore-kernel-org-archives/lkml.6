Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6039C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C7320857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C7320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbeHAAEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:04:13 -0400
Received: from gateway30.websitewelcome.com ([192.185.146.7]:47367 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731007AbeHAAEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:04:13 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id A4F0173F9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 16:58:41 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id kceyfbTTWkBj6kcf5fuelG; Tue, 31 Jul 2018 16:58:41 -0500
X-Authority-Reason: nr=8
Received: from [189.250.131.79] (port=52052 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fkcex-001x1Z-7K; Tue, 31 Jul 2018 16:58:27 -0500
Date:   Tue, 31 Jul 2018 16:58:25 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] afs: Mark expected switch fall-throughs
Message-ID: <20180731215825.GA10268@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.131.79
X-Source-L: No
X-Exim-ID: 1fkcex-001x1Z-7K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.131.79]:52052
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Warning level 2 was used: -Wimplicit-fallthrough=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/afs/cmservice.c | 10 ++++++++--
 fs/afs/file.c      |  2 ++
 fs/afs/fsclient.c  | 41 +++++++++++++++++++++++++++--------------
 fs/afs/rxrpc.c     |  1 +
 fs/afs/vlclient.c  | 29 ++++++++++++++++-------------
 5 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 9e51d6f..c06fcda 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -179,7 +179,8 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* extract the FID array and its count in two steps */
+		/* Fall through and extract the FID array and its count
+		 * in two steps. */
 	case 1:
 		_debug("extract FID count");
 		ret = afs_extract_data(call, &call->tmp, 4, true);
@@ -198,6 +199,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
+		/* Fall through */
 	case 2:
 		_debug("extract FID array");
 		ret = afs_extract_data(call, call->buffer,
@@ -224,7 +226,8 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* extract the callback array and its count in two steps */
+		/* Fall through and extract the callback array and its count
+		 * in two steps. */
 	case 3:
 		_debug("extract CB count");
 		ret = afs_extract_data(call, &call->tmp, 4, true);
@@ -238,6 +241,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
+		/* Fall through */
 	case 4:
 		_debug("extract CB array");
 		ret = afs_extract_data(call, call->buffer,
@@ -336,6 +340,7 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 			return -ENOMEM;
 		call->unmarshall++;
 
+		/* Fall through */
 	case 1:
 		_debug("extract UUID");
 		ret = afs_extract_data(call, call->buffer,
@@ -459,6 +464,7 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 			return -ENOMEM;
 		call->unmarshall++;
 
+		/* Fall through */
 	case 1:
 		_debug("extract UUID");
 		ret = afs_extract_data(call, call->buffer,
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 7d4f261..4a853ba 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -299,6 +299,8 @@ int afs_page_filler(void *data, struct page *page)
 		/* page will not be cached */
 	case -ENOBUFS:
 		_debug("cache said ENOBUFS");
+
+		/* fall through */
 	default:
 	go_on:
 		req = kzalloc(sizeof(struct afs_read) + sizeof(struct page *),
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 50929cb..34fa791 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -485,9 +485,9 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 			goto no_msw;
 		}
 
-		/* extract the upper part of the returned data length of an
-		 * FSFETCHDATA64 op (which should always be 0 using this
-		 * client) */
+		/* Fall through and extract the upper part of the returned data
+		 * length of an FSFETCHDATA64 op (which should always be 0 using
+		 * this client) */
 	case 1:
 		_debug("extract data length (MSW)");
 		ret = afs_extract_data(call, &call->tmp, 4, true);
@@ -499,6 +499,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
+		/* Fall through */
 	no_msw:
 		/* extract the returned data length */
 	case 2:
@@ -527,7 +528,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		ASSERTCMP(call->count, <=, PAGE_SIZE);
 		req->remain -= size;
 
-		/* extract the returned data */
+		/* Fall through and extract the returned data */
 	case 3:
 		_debug("extract data %llu/%llu %zu/%u",
 		       req->remain, req->actual_len, call->offset, call->count);
@@ -572,7 +573,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall = 5;
 
-		/* extract the metadata */
+		/* Fall through and extract the metadata */
 	case 5:
 		ret = afs_extract_data(call, call->buffer,
 				       (21 + 3 + 6) * 4, false);
@@ -1590,7 +1591,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* extract the returned status record */
+		/* Fall through and extract the returned status record */
 	case 1:
 		_debug("extract status");
 		ret = afs_extract_data(call, call->buffer,
@@ -1603,7 +1604,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* extract the volume name length */
+		/* Fall through extract the volume name length */
 	case 2:
 		ret = afs_extract_data(call, &call->tmp, 4, true);
 		if (ret < 0)
@@ -1616,7 +1617,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* extract the volume name */
+		/* Fall through and extract the volume name */
 	case 3:
 		_debug("extract volname");
 		if (call->count > 0) {
@@ -1640,6 +1641,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		}
 		call->count = 4 - (call->count & 3);
 
+		/* Fall through */
 	case 4:
 		ret = afs_extract_data(call, call->buffer,
 				       call->count, true);
@@ -1648,6 +1650,8 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 
 		call->offset = 0;
 		call->unmarshall++;
+
+		/* Fall through */
 	no_volname_padding:
 
 		/* extract the offline message length */
@@ -1663,7 +1667,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* extract the offline message */
+		/* Fall through and extract the offline message */
 	case 6:
 		_debug("extract offline");
 		if (call->count > 0) {
@@ -1687,6 +1691,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		}
 		call->count = 4 - (call->count & 3);
 
+		/* Fall through */
 	case 7:
 		ret = afs_extract_data(call, call->buffer,
 				       call->count, true);
@@ -1695,6 +1700,8 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 
 		call->offset = 0;
 		call->unmarshall++;
+
+		/* Fall through */
 	no_offline_padding:
 
 		/* extract the message of the day length */
@@ -1710,7 +1717,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* extract the message of the day */
+		/* Fall through and extract the message of the day */
 	case 9:
 		_debug("extract motd");
 		if (call->count > 0) {
@@ -1730,6 +1737,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		/* extract the message of the day padding */
 		call->count = (4 - (call->count & 3)) & 3;
 
+		/* Fall through */
 	case 10:
 		ret = afs_extract_data(call, call->buffer,
 				       call->count, false);
@@ -2012,7 +2020,7 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* Extract the capabilities word count */
+		/* Fall through and extract the capabilities word count */
 	case 1:
 		ret = afs_extract_data(call, &call->tmp,
 				       1 * sizeof(__be32),
@@ -2027,7 +2035,7 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* Extract capabilities words */
+		/* Fall through and extract capabilities words */
 	case 2:
 		count = min(call->count, 16U);
 		ret = afs_extract_data(call, call->buffer,
@@ -2196,7 +2204,8 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* Extract the file status count and array in two steps */
+		/* Fall through and extract the file status count and array
+		 * in two steps. */
 	case 1:
 		_debug("extract status count");
 		ret = afs_extract_data(call, &call->tmp, 4, true);
@@ -2213,6 +2222,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 	more_counts:
 		call->offset = 0;
 
+		/* Fall through */
 	case 2:
 		_debug("extract status array %u", call->count);
 		ret = afs_extract_data(call, call->buffer, 21 * 4, true);
@@ -2234,7 +2244,8 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->unmarshall++;
 		call->offset = 0;
 
-		/* Extract the callback count and array in two steps */
+		/* Fall through and extract the callback count and array in
+		 * two steps. */
 	case 3:
 		_debug("extract CB count");
 		ret = afs_extract_data(call, &call->tmp, 4, true);
@@ -2250,6 +2261,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 	more_cbs:
 		call->offset = 0;
 
+		/* Fall through */
 	case 4:
 		_debug("extract CB array");
 		ret = afs_extract_data(call, call->buffer, 3 * 4, true);
@@ -2272,6 +2284,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
+		/* Fall through */
 	case 5:
 		ret = afs_extract_data(call, call->buffer, 6 * 4, false);
 		if (ret < 0)
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 183cc54..d0f915a 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -842,6 +842,7 @@ void afs_send_empty_reply(struct afs_call *call)
 		_debug("oom");
 		rxrpc_kernel_abort_call(net->socket, call->rxcall,
 					RX_USER_ABORT, -ENOMEM, "KOO");
+		/* Fall through */
 	default:
 		_leave(" [error]");
 		return;
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index c3b7408..e94735c 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -195,7 +195,9 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* Extract the returned uuid, uniquifier, nentries and blkaddrs size */
+
+		/* Fall through and extract the returned uuid, uniquifier,
+		 * nentries and blkaddrs size. */
 	case 1:
 		ret = afs_extract_data(call, call->buffer,
 				       sizeof(struct afs_uuid__xdr) + 3 * sizeof(__be32),
@@ -219,7 +221,7 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* Extract entries */
+		/* Fall through and extract entries */
 	case 2:
 		count = min(call->count, 4U);
 		ret = afs_extract_data(call, call->buffer,
@@ -326,7 +328,7 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* Extract the capabilities word count */
+		/* Fall through and extract the capabilities word count */
 	case 1:
 		ret = afs_extract_data(call, &call->tmp,
 				       1 * sizeof(__be32),
@@ -341,7 +343,7 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* Extract capabilities words */
+		/* Fall through and extract capabilities words */
 	case 2:
 		count = min(call->count, 16U);
 		ret = afs_extract_data(call, call->buffer,
@@ -434,9 +436,9 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall = 1;
 
-		/* Extract the returned uuid, uniquifier, fsEndpoints count and
-		 * either the first fsEndpoint type or the volEndpoints
-		 * count if there are no fsEndpoints. */
+		/* Fall through and extract the returned uuid, uniquifier,
+		 * fsEndpoints count and either the first fsEndpoint type
+		 * or the volEndpoints count if there are no fsEndpoints. */
 	case 1:
 		ret = afs_extract_data(call, call->buffer,
 				       sizeof(uuid_t) +
@@ -465,7 +467,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 
 		call->unmarshall = 2;
 
-		/* Extract fsEndpoints[] entries */
+		/* Fall through and extract fsEndpoints[] entries */
 	case 2:
 		switch (call->count2) {
 		case YFS_ENDPOINT_IPV4:
@@ -522,9 +524,10 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 
 		call->unmarshall = 3;
 
-		/* Extract the type of volEndpoints[0].  Normally we would
-		 * extract the type of the next endpoint when we extract the
-		 * data of the current one, but this is the first...
+		/* Fall through and extract the type of volEndpoints[0].
+		 * Normally we would extract the type of the next endpoint
+		 * when we extract the data of the current one, but this is
+		 * the first...
 		 */
 	case 3:
 		ret = afs_extract_data(call, call->buffer, sizeof(__be32), true);
@@ -536,7 +539,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall = 4;
 
-		/* Extract volEndpoints[] entries */
+		/* Fall through and extract volEndpoints[] entries */
 	case 4:
 		switch (call->count2) {
 		case YFS_ENDPOINT_IPV4:
@@ -584,7 +587,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 	end:
 		call->unmarshall = 5;
 
-		/* Done */
+		/* Fall through - Done */
 	case 5:
 		ret = afs_extract_data(call, call->buffer, 0, false);
 		if (ret < 0)
-- 
2.7.4

