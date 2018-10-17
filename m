Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2DAECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FCE214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FCE214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJQTc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:32:27 -0400
Received: from gateway30.websitewelcome.com ([192.185.144.21]:11191 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726954AbeJQTc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:32:27 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id E60B61AB53
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 06:37:07 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Ck8Dgr1VHkBj6Ck8LgvQoO; Wed, 17 Oct 2018 06:37:07 -0500
X-Authority-Reason: nr=8
Received: from lfbn-1-466-13.w86-245.abo.wanadoo.fr ([86.245.173.13]:59062 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gCk8B-001PaC-Le; Wed, 17 Oct 2018 06:36:52 -0500
Date:   Wed, 17 Oct 2018 13:36:49 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] afs: Mark expected switch fall-throughs
Message-ID: <20181017113649.GA29776@embeddedor.com>
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
X-Source-IP: 86.245.173.13
X-Source-L: No
X-Exim-ID: 1gCk8B-001PaC-Le
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lfbn-1-466-13.w86-245.abo.wanadoo.fr (embeddedor) [86.245.173.13]:59062
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

Notice that in many cases I placed a /* Fall through */ comment
at the bottom of the case, which what GCC is expecting to find.

In other cases I had to tweak a bit the format of the comments.

This patch suppresses 39 missing-break-in-switch false positives.

Addresses-Coverity-ID: 115042 ("Missing break in switch")
Addresses-Coverity-ID: 115043 ("Missing break in switch")
Addresses-Coverity-ID: 115045 ("Missing break in switch")
Addresses-Coverity-ID: 1357430 ("Missing break in switch")
Addresses-Coverity-ID: 115047 ("Missing break in switch")
Addresses-Coverity-ID: 115050 ("Missing break in switch")
Addresses-Coverity-ID: 115051 ("Missing break in switch")
Addresses-Coverity-ID: 1467806 ("Missing break in switch")
Addresses-Coverity-ID: 1467807 ("Missing break in switch")
Addresses-Coverity-ID: 1467811 ("Missing break in switch")
Addresses-Coverity-ID: 115041 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/afs/cmservice.c |  6 ++++++
 fs/afs/file.c      |  2 ++
 fs/afs/fsclient.c  | 34 ++++++++++++++++++++++++----------
 fs/afs/rxrpc.c     |  1 +
 fs/afs/vlclient.c  | 18 +++++++++++-------
 5 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 9e51d6f..ecf7aee 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -180,6 +180,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		call->unmarshall++;
 
 		/* extract the FID array and its count in two steps */
+		/* fall through */
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
@@ -225,6 +227,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		call->unmarshall++;
 
 		/* extract the callback array and its count in two steps */
+		/* fall through */
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
index 50929cb..2c8abf3 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -485,9 +485,10 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 			goto no_msw;
 		}
 
-		/* extract the upper part of the returned data length of an
+		/* Extract the upper part of the returned data length of an
 		 * FSFETCHDATA64 op (which should always be 0 using this
 		 * client) */
+		/* Fall through */
 	case 1:
 		_debug("extract data length (MSW)");
 		ret = afs_extract_data(call, &call->tmp, 4, true);
@@ -499,6 +500,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
+		/* Fall through */
 	no_msw:
 		/* extract the returned data length */
 	case 2:
@@ -527,7 +529,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		ASSERTCMP(call->count, <=, PAGE_SIZE);
 		req->remain -= size;
 
-		/* extract the returned data */
+		/* Fall through - and extract the returned data */
 	case 3:
 		_debug("extract data %llu/%llu %zu/%u",
 		       req->remain, req->actual_len, call->offset, call->count);
@@ -572,7 +574,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall = 5;
 
-		/* extract the metadata */
+		/* Fall through - and extract the metadata */
 	case 5:
 		ret = afs_extract_data(call, call->buffer,
 				       (21 + 3 + 6) * 4, false);
@@ -1590,7 +1592,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* extract the returned status record */
+		/* Fall through - and extract the returned status record */
 	case 1:
 		_debug("extract status");
 		ret = afs_extract_data(call, call->buffer,
@@ -1603,7 +1605,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* extract the volume name length */
+		/* Fall through - and extract the volume name length */
 	case 2:
 		ret = afs_extract_data(call, &call->tmp, 4, true);
 		if (ret < 0)
@@ -1616,7 +1618,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* extract the volume name */
+		/* Fall through - and extract the volume name */
 	case 3:
 		_debug("extract volname");
 		if (call->count > 0) {
@@ -1640,6 +1642,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		}
 		call->count = 4 - (call->count & 3);
 
+		/* Fall through */
 	case 4:
 		ret = afs_extract_data(call, call->buffer,
 				       call->count, true);
@@ -1648,6 +1651,8 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 
 		call->offset = 0;
 		call->unmarshall++;
+
+		/* Fall through */
 	no_volname_padding:
 
 		/* extract the offline message length */
@@ -1663,7 +1668,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* extract the offline message */
+		/* Fall through - and extract the offline message */
 	case 6:
 		_debug("extract offline");
 		if (call->count > 0) {
@@ -1687,6 +1692,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		}
 		call->count = 4 - (call->count & 3);
 
+		/* Fall through */
 	case 7:
 		ret = afs_extract_data(call, call->buffer,
 				       call->count, true);
@@ -1695,6 +1701,8 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 
 		call->offset = 0;
 		call->unmarshall++;
+
+		/* Fall through */
 	no_offline_padding:
 
 		/* extract the message of the day length */
@@ -1710,7 +1718,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* extract the message of the day */
+		/* Fall through - and extract the message of the day */
 	case 9:
 		_debug("extract motd");
 		if (call->count > 0) {
@@ -1730,6 +1738,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		/* extract the message of the day padding */
 		call->count = (4 - (call->count & 3)) & 3;
 
+		/* Fall through */
 	case 10:
 		ret = afs_extract_data(call, call->buffer,
 				       call->count, false);
@@ -2012,7 +2021,7 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* Extract the capabilities word count */
+		/* Fall through - and extract the capabilities word count */
 	case 1:
 		ret = afs_extract_data(call, &call->tmp,
 				       1 * sizeof(__be32),
@@ -2027,7 +2036,7 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* Extract capabilities words */
+		/* Fall through - and extract capabilities words */
 	case 2:
 		count = min(call->count, 16U);
 		ret = afs_extract_data(call, call->buffer,
@@ -2197,6 +2206,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->unmarshall++;
 
 		/* Extract the file status count and array in two steps */
+		/* Fall through */
 	case 1:
 		_debug("extract status count");
 		ret = afs_extract_data(call, &call->tmp, 4, true);
@@ -2213,6 +2223,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 	more_counts:
 		call->offset = 0;
 
+		/* Fall through */
 	case 2:
 		_debug("extract status array %u", call->count);
 		ret = afs_extract_data(call, call->buffer, 21 * 4, true);
@@ -2235,6 +2246,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->offset = 0;
 
 		/* Extract the callback count and array in two steps */
+		/* Fall through */
 	case 3:
 		_debug("extract CB count");
 		ret = afs_extract_data(call, &call->tmp, 4, true);
@@ -2250,6 +2262,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 	more_cbs:
 		call->offset = 0;
 
+		/* Fall through */
 	case 4:
 		_debug("extract CB array");
 		ret = afs_extract_data(call, call->buffer, 3 * 4, true);
@@ -2272,6 +2285,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
+		/* Fall through */
 	case 5:
 		ret = afs_extract_data(call, call->buffer, 6 * 4, false);
 		if (ret < 0)
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 77a8379..59da27e 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -840,6 +840,7 @@ void afs_send_empty_reply(struct afs_call *call)
 		_debug("oom");
 		rxrpc_kernel_abort_call(net->socket, call->rxcall,
 					RX_USER_ABORT, -ENOMEM, "KOO");
+		/* Fall through */
 	default:
 		_leave(" [error]");
 		return;
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index c3b7408..ec15c24 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -195,7 +195,9 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* Extract the returned uuid, uniquifier, nentries and blkaddrs size */
+		/* Extract the returned uuid, uniquifier, nentries and
+		 * blkaddrs size */
+		/* Fall through */
 	case 1:
 		ret = afs_extract_data(call, call->buffer,
 				       sizeof(struct afs_uuid__xdr) + 3 * sizeof(__be32),
@@ -219,7 +221,7 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* Extract entries */
+		/* Fall through - and extract entries */
 	case 2:
 		count = min(call->count, 4U);
 		ret = afs_extract_data(call, call->buffer,
@@ -326,7 +328,7 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* Extract the capabilities word count */
+		/* Fall through - and extract the capabilities word count */
 	case 1:
 		ret = afs_extract_data(call, &call->tmp,
 				       1 * sizeof(__be32),
@@ -341,7 +343,7 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall++;
 
-		/* Extract capabilities words */
+		/* Fall through - and extract capabilities words */
 	case 2:
 		count = min(call->count, 16U);
 		ret = afs_extract_data(call, call->buffer,
@@ -437,6 +439,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		/* Extract the returned uuid, uniquifier, fsEndpoints count and
 		 * either the first fsEndpoint type or the volEndpoints
 		 * count if there are no fsEndpoints. */
+		/* Fall through */
 	case 1:
 		ret = afs_extract_data(call, call->buffer,
 				       sizeof(uuid_t) +
@@ -465,7 +468,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 
 		call->unmarshall = 2;
 
-		/* Extract fsEndpoints[] entries */
+		/* Fall through - and extract fsEndpoints[] entries */
 	case 2:
 		switch (call->count2) {
 		case YFS_ENDPOINT_IPV4:
@@ -526,6 +529,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		 * extract the type of the next endpoint when we extract the
 		 * data of the current one, but this is the first...
 		 */
+		/* Fall through */
 	case 3:
 		ret = afs_extract_data(call, call->buffer, sizeof(__be32), true);
 		if (ret < 0)
@@ -536,7 +540,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		call->offset = 0;
 		call->unmarshall = 4;
 
-		/* Extract volEndpoints[] entries */
+		/* Fall through - and extract volEndpoints[] entries */
 	case 4:
 		switch (call->count2) {
 		case YFS_ENDPOINT_IPV4:
@@ -584,7 +588,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 	end:
 		call->unmarshall = 5;
 
-		/* Done */
+		/* Fall through - Done */
 	case 5:
 		ret = afs_extract_data(call, call->buffer, 0, false);
 		if (ret < 0)
-- 
2.7.4

