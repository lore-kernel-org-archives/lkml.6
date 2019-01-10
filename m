Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF318C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B9020665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfAJWCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:02:50 -0500
Received: from gateway30.websitewelcome.com ([50.116.125.1]:17012 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728288AbfAJWCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:02:49 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 3FB616467
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:02:47 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hiPXgWAzMdnCehiPXgblD7; Thu, 10 Jan 2019 16:02:47 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=33272 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghiPW-003tYb-Cl; Thu, 10 Jan 2019 16:02:46 -0600
Date:   Thu, 10 Jan 2019 16:02:45 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] afs: Mark expected switch fall-throughs
Message-ID: <20190110220245.GA20942@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ghiPW-003tYb-Cl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:33272
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

This patch suppresses ALL missing-break-in-switch false positives
in fs/afs

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
 fs/afs/cmservice.c |  8 ++++++++
 fs/afs/file.c      |  2 ++
 fs/afs/flock.c     |  1 +
 fs/afs/fsclient.c  | 31 +++++++++++++++++++------------
 fs/afs/misc.c      |  9 +++++++++
 fs/afs/rxrpc.c     |  1 +
 fs/afs/vlclient.c  | 18 +++++++++++-------
 fs/afs/yfsclient.c | 30 ++++++++++++++++++++----------
 8 files changed, 71 insertions(+), 29 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 8ee5972893ed..40e09bf547e3 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -285,6 +285,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		call->unmarshall++;
 
 		/* extract the FID array and its count in two steps */
+		/* fall through */
 	case 1:
 		_debug("extract FID count");
 		ret = afs_extract_data(call, true);
@@ -304,6 +305,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		afs_extract_to_buf(call, call->count * 3 * 4);
 		call->unmarshall++;
 
+		/* Fall through */
 	case 2:
 		_debug("extract FID array");
 		ret = afs_extract_data(call, true);
@@ -329,6 +331,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		call->unmarshall++;
 
 		/* extract the callback array and its count in two steps */
+		/* fall through */
 	case 3:
 		_debug("extract CB count");
 		ret = afs_extract_data(call, true);
@@ -344,6 +347,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		iov_iter_discard(&call->iter, READ, call->count2 * 3 * 4);
 		call->unmarshall++;
 
+		/* Fall through */
 	case 4:
 		_debug("extract discard %zu/%u",
 		       iov_iter_count(&call->iter), call->count2 * 3 * 4);
@@ -422,6 +426,7 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 		afs_extract_to_buf(call, 11 * sizeof(__be32));
 		call->unmarshall++;
 
+		/* Fall through */
 	case 1:
 		_debug("extract UUID");
 		ret = afs_extract_data(call, false);
@@ -537,6 +542,7 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 		afs_extract_to_buf(call, 11 * sizeof(__be32));
 		call->unmarshall++;
 
+		/* Fall through */
 	case 1:
 		_debug("extract UUID");
 		ret = afs_extract_data(call, false);
@@ -673,6 +679,7 @@ static int afs_deliver_yfs_cb_callback(struct afs_call *call)
 		call->unmarshall++;
 
 		/* extract the FID array and its count in two steps */
+		/* Fall through */
 	case 1:
 		_debug("extract FID count");
 		ret = afs_extract_data(call, true);
@@ -692,6 +699,7 @@ static int afs_deliver_yfs_cb_callback(struct afs_call *call)
 		afs_extract_to_buf(call, size);
 		call->unmarshall++;
 
+		/* Fall through */
 	case 2:
 		_debug("extract FID array");
 		ret = afs_extract_data(call, false);
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 323ae9912203..e8d6619890a9 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -300,6 +300,8 @@ int afs_page_filler(void *data, struct page *page)
 		/* page will not be cached */
 	case -ENOBUFS:
 		_debug("cache said ENOBUFS");
+
+		/* fall through */
 	default:
 	go_on:
 		req = kzalloc(sizeof(struct afs_read) + sizeof(struct page *),
diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 0568fd986821..65e2209fb487 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -303,6 +303,7 @@ void afs_lock_work(struct work_struct *work)
 			return;
 		}
 
+		/* Fall through */
 	default:
 		/* Looks like a lock request was withdrawn. */
 		spin_unlock(&vnode->lock);
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index ca08c83168f5..06277408477b 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -498,7 +498,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 			afs_extract_to_tmp(call);
 		}
 
-		/* extract the returned data length */
+		/* Fall through - and extract the returned data length */
 	case 1:
 		_debug("extract data length");
 		ret = afs_extract_data(call, true);
@@ -525,7 +525,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		iov_iter_bvec(&call->iter, READ, call->bvec, 1, size);
 		ASSERTCMP(size, <=, PAGE_SIZE);
 
-		/* extract the returned data */
+		/* Fall through - and extract the returned data */
 	case 2:
 		_debug("extract data %zu/%llu",
 		       iov_iter_count(&call->iter), req->remain);
@@ -552,6 +552,8 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		/* Discard any excess data the server gave us */
 		iov_iter_discard(&call->iter, READ, req->actual_len - req->len);
 		call->unmarshall = 3;
+
+		/* Fall through */
 	case 3:
 		_debug("extract discard %zu/%llu",
 		       iov_iter_count(&call->iter), req->actual_len - req->len);
@@ -564,7 +566,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		call->unmarshall = 4;
 		afs_extract_to_buf(call, (21 + 3 + 6) * 4);
 
-		/* extract the metadata */
+		/* Fall through - and extract the metadata */
 	case 4:
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
@@ -1634,7 +1636,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->unmarshall++;
 		afs_extract_to_buf(call, 12 * 4);
 
-		/* extract the returned status record */
+		/* Fall through - and extract the returned status record */
 	case 1:
 		_debug("extract status");
 		ret = afs_extract_data(call, true);
@@ -1646,7 +1648,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->unmarshall++;
 		afs_extract_to_tmp(call);
 
-		/* extract the volume name length */
+		/* Fall through - and extract the volume name length */
 	case 2:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -1661,7 +1663,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		afs_extract_begin(call, call->reply[2], size);
 		call->unmarshall++;
 
-		/* extract the volume name */
+		/* Fall through - and extract the volume name */
 	case 3:
 		_debug("extract volname");
 		ret = afs_extract_data(call, true);
@@ -1674,7 +1676,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
-		/* extract the offline message length */
+		/* Fall through - and extract the offline message length */
 	case 4:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -1689,7 +1691,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		afs_extract_begin(call, call->reply[2], size);
 		call->unmarshall++;
 
-		/* extract the offline message */
+		/* Fall through - and extract the offline message */
 	case 5:
 		_debug("extract offline");
 		ret = afs_extract_data(call, true);
@@ -1703,7 +1705,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
-		/* extract the message of the day length */
+		/* Fall through - and extract the message of the day length */
 	case 6:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -1718,7 +1720,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		afs_extract_begin(call, call->reply[2], size);
 		call->unmarshall++;
 
-		/* extract the message of the day */
+		/* Fall through - and extract the message of the day */
 	case 7:
 		_debug("extract motd");
 		ret = afs_extract_data(call, false);
@@ -2016,7 +2018,7 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
-		/* Extract the capabilities word count */
+		/* Fall through - and extract the capabilities word count */
 	case 1:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -2029,7 +2031,7 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 		iov_iter_discard(&call->iter, READ, count * sizeof(__be32));
 		call->unmarshall++;
 
-		/* Extract capabilities words */
+		/* Fall through - and extract capabilities words */
 	case 2:
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
@@ -2206,6 +2208,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->unmarshall++;
 
 		/* Extract the file status count and array in two steps */
+		/* Fall through */
 	case 1:
 		_debug("extract status count");
 		ret = afs_extract_data(call, true);
@@ -2223,6 +2226,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 	more_counts:
 		afs_extract_to_buf(call, 21 * sizeof(__be32));
 
+		/* Fall through */
 	case 2:
 		_debug("extract status array %u", call->count);
 		ret = afs_extract_data(call, true);
@@ -2246,6 +2250,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		afs_extract_to_tmp(call);
 
 		/* Extract the callback count and array in two steps */
+		/* Fall through */
 	case 3:
 		_debug("extract CB count");
 		ret = afs_extract_data(call, true);
@@ -2262,6 +2267,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 	more_cbs:
 		afs_extract_to_buf(call, 3 * sizeof(__be32));
 
+		/* Fall through */
 	case 4:
 		_debug("extract CB array");
 		ret = afs_extract_data(call, true);
@@ -2284,6 +2290,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		afs_extract_to_buf(call, 6 * sizeof(__be32));
 		call->unmarshall++;
 
+		/* Fall through */
 	case 5:
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
diff --git a/fs/afs/misc.c b/fs/afs/misc.c
index bbb1fd51b019..7f2af061ea06 100644
--- a/fs/afs/misc.c
+++ b/fs/afs/misc.c
@@ -131,33 +131,42 @@ void afs_prioritise_error(struct afs_error *e, int error, u32 abort_code)
 		if (e->error == -ETIMEDOUT ||
 		    e->error == -ETIME)
 			return;
+		/* Fall through */
 	case -ETIMEDOUT:
 	case -ETIME:
 		if (e->error == -ENOMEM ||
 		    e->error == -ENONET)
 			return;
+		/* Fall through */
 	case -ENOMEM:
 	case -ENONET:
 		if (e->error == -ERFKILL)
 			return;
+		/* Fall through */
 	case -ERFKILL:
 		if (e->error == -EADDRNOTAVAIL)
 			return;
+		/* Fall through */
 	case -EADDRNOTAVAIL:
 		if (e->error == -ENETUNREACH)
 			return;
+		/* Fall through */
 	case -ENETUNREACH:
 		if (e->error == -EHOSTUNREACH)
 			return;
+		/* Fall through */
 	case -EHOSTUNREACH:
 		if (e->error == -EHOSTDOWN)
 			return;
+		/* Fall through */
 	case -EHOSTDOWN:
 		if (e->error == -ECONNREFUSED)
 			return;
+		/* Fall through */
 	case -ECONNREFUSED:
 		if (e->error == -ECONNRESET)
 			return;
+		/* Fall through */
 	case -ECONNRESET: /* Responded, but call expired. */
 		if (e->responded)
 			return;
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index a7b44863d502..cb55e438ce7b 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -878,6 +878,7 @@ void afs_send_empty_reply(struct afs_call *call)
 		_debug("oom");
 		rxrpc_kernel_abort_call(net->socket, call->rxcall,
 					RX_USER_ABORT, -ENOMEM, "KOO");
+		/* Fall through */
 	default:
 		_leave(" [error]");
 		return;
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index c3d9e5a5f67e..b0175b3ef0e8 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -195,7 +195,9 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 				   sizeof(struct afs_uuid__xdr) + 3 * sizeof(__be32));
 		call->unmarshall++;
 
-		/* Extract the returned uuid, uniquifier, nentries and blkaddrs size */
+		/* Extract the returned uuid, uniquifier, nentries and
+		 * blkaddrs size */
+		/* Fall through */
 	case 1:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -220,7 +222,7 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 		count = min(call->count, 4U);
 		afs_extract_to_buf(call, count * sizeof(__be32));
 
-		/* Extract entries */
+		/* Fall through - and extract entries */
 	case 2:
 		ret = afs_extract_data(call, call->count > 4);
 		if (ret < 0)
@@ -323,7 +325,7 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
-		/* Extract the capabilities word count */
+		/* Fall through - and extract the capabilities word count */
 	case 1:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -336,7 +338,7 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 		call->unmarshall++;
 		afs_extract_discard(call, count * sizeof(__be32));
 
-		/* Extract capabilities words */
+		/* Fall through - and extract capabilities words */
 	case 2:
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
@@ -436,6 +438,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		/* Extract the returned uuid, uniquifier, fsEndpoints count and
 		 * either the first fsEndpoint type or the volEndpoints
 		 * count if there are no fsEndpoints. */
+		/* Fall through */
 	case 1:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -476,7 +479,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		afs_extract_to_buf(call, size);
 		call->unmarshall = 2;
 
-		/* Extract fsEndpoints[] entries */
+		/* Fall through - and extract fsEndpoints[] entries */
 	case 2:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -529,6 +532,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		 * extract the type of the next endpoint when we extract the
 		 * data of the current one, but this is the first...
 		 */
+		/* Fall through */
 	case 3:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -555,7 +559,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		afs_extract_to_buf(call, size);
 		call->unmarshall = 4;
 
-		/* Extract volEndpoints[] entries */
+		/* Fall through - and extract volEndpoints[] entries */
 	case 4:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -591,7 +595,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		afs_extract_discard(call, 0);
 		call->unmarshall = 5;
 
-		/* Done */
+		/* Fall through - Done */
 	case 5:
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 12658c1363ae..234b57982801 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -544,7 +544,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		afs_extract_to_tmp64(call);
 		call->unmarshall++;
 
-		/* extract the returned data length */
+		/* Fall through - and extract the returned data length */
 	case 1:
 		_debug("extract data length");
 		ret = afs_extract_data(call, true);
@@ -571,7 +571,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		iov_iter_bvec(&call->iter, READ, call->bvec, 1, size);
 		ASSERTCMP(size, <=, PAGE_SIZE);
 
-		/* extract the returned data */
+		/* Fall through - and extract the returned data */
 	case 2:
 		_debug("extract data %zu/%llu",
 		       iov_iter_count(&call->iter), req->remain);
@@ -598,6 +598,8 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		/* Discard any excess data the server gave us */
 		iov_iter_discard(&call->iter, READ, req->actual_len - req->len);
 		call->unmarshall = 3;
+
+		/* Fall through */
 	case 3:
 		_debug("extract discard %zu/%llu",
 		       iov_iter_count(&call->iter), req->actual_len - req->len);
@@ -613,7 +615,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 				   sizeof(struct yfs_xdr_YFSCallBack) +
 				   sizeof(struct yfs_xdr_YFSVolSync));
 
-		/* extract the metadata */
+		/* Fall through - and extract the metadata */
 	case 4:
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
@@ -629,6 +631,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 
 		call->unmarshall++;
 
+		/* Fall through */
 	case 5:
 		break;
 	}
@@ -1584,7 +1587,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->unmarshall++;
 		afs_extract_to_buf(call, sizeof(struct yfs_xdr_YFSFetchVolumeStatus));
 
-		/* extract the returned status record */
+		/* Fall through - and extract the returned status record */
 	case 1:
 		_debug("extract status");
 		ret = afs_extract_data(call, true);
@@ -1596,7 +1599,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		call->unmarshall++;
 		afs_extract_to_tmp(call);
 
-		/* extract the volume name length */
+		/* Fall through - and extract the volume name length */
 	case 2:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -1611,7 +1614,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		afs_extract_begin(call, call->reply[2], size);
 		call->unmarshall++;
 
-		/* extract the volume name */
+		/* Fall through - and extract the volume name */
 	case 3:
 		_debug("extract volname");
 		ret = afs_extract_data(call, true);
@@ -1624,7 +1627,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
-		/* extract the offline message length */
+		/* Fall through - and extract the offline message length */
 	case 4:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -1639,7 +1642,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		afs_extract_begin(call, call->reply[2], size);
 		call->unmarshall++;
 
-		/* extract the offline message */
+		/* Fall through - and extract the offline message */
 	case 5:
 		_debug("extract offline");
 		ret = afs_extract_data(call, true);
@@ -1653,7 +1656,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
-		/* extract the message of the day length */
+		/* Fall through - and extract the message of the day length */
 	case 6:
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -1668,7 +1671,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 		afs_extract_begin(call, call->reply[2], size);
 		call->unmarshall++;
 
-		/* extract the message of the day */
+		/* Fall through - and extract the message of the day */
 	case 7:
 		_debug("extract motd");
 		ret = afs_extract_data(call, false);
@@ -1681,6 +1684,7 @@ static int yfs_deliver_fs_get_volume_status(struct afs_call *call)
 
 		call->unmarshall++;
 
+		/* Fall through */
 	case 8:
 		break;
 	}
@@ -2026,6 +2030,7 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->unmarshall++;
 
 		/* Extract the file status count and array in two steps */
+		/* Fall through */
 	case 1:
 		_debug("extract status count");
 		ret = afs_extract_data(call, true);
@@ -2043,6 +2048,7 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 	more_counts:
 		afs_extract_to_buf(call, sizeof(struct yfs_xdr_YFSFetchStatus));
 
+		/* Fall through */
 	case 2:
 		_debug("extract status array %u", call->count);
 		ret = afs_extract_data(call, true);
@@ -2066,6 +2072,7 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		afs_extract_to_tmp(call);
 
 		/* Extract the callback count and array in two steps */
+		/* Fall through */
 	case 3:
 		_debug("extract CB count");
 		ret = afs_extract_data(call, true);
@@ -2082,6 +2089,7 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 	more_cbs:
 		afs_extract_to_buf(call, sizeof(struct yfs_xdr_YFSCallBack));
 
+		/* Fall through */
 	case 4:
 		_debug("extract CB array");
 		ret = afs_extract_data(call, true);
@@ -2104,6 +2112,7 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		afs_extract_to_buf(call, sizeof(struct yfs_xdr_YFSVolSync));
 		call->unmarshall++;
 
+		/* Fall through */
 	case 5:
 		ret = afs_extract_data(call, false);
 		if (ret < 0)
@@ -2114,6 +2123,7 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 
 		call->unmarshall++;
 
+		/* Fall through */
 	case 6:
 		break;
 	}
-- 
2.20.1

