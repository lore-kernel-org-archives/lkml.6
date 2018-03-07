Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbeCGKtn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:49:43 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38293 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeCGKti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:49:38 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180307104936euoutp021d7f218b19ac15f72fbe23d5a5a89210~ZnbsV1Gbh1739017390euoutp02R
X-AuditID: cbfec7f2-1dbff70000011644-1e-5a9fc3bfa569
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
Subject: [PATCH v2] crypto: hash.h: Prevent use of req->result in ahash
 update
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <7850c31c-8703-51fb-0710-3b4920935bfc@partner.samsung.com>
Date: Wed, 07 Mar 2018 11:49:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7djP87r7D8+PMlj/kNli44z1rBZzzrew
        WHS/krG4f+8nk8XlXXPYHFg9tqy8yeSx7YCqR9+WVYwenzfJBbBEcdmkpOZklqUW6dslcGXM
        6ikueCVasfn9NfYGxjmCXYycHBICJhLfP2xm7GLk4hASWMEosflrAzuE85lRYsP3NWwwVf0P
        LzNBJJYxSuzcfZUZwnnGKNGy+DAzSBWbgLnEo+1nmEBsYYEAid83poF1iwjoSKx8uZgVpIFZ
        YCGjxI/+8+wgCV4BN4n/91eCNbMIqEpsm/6QBcQWFYiQWDj1KSNEjaDEj8n3wOLMApoSL75M
        grLFJZpbb0LZ8hKb17xlhjh1DpvEjU0SELaLRNePDhYIW1ji1fEt7BC2jMTlyd1Q8XKJTVvW
        gv0sIdDAKLHmfRMjRMJa4vDxi6wQC/gkJm2bDrSAAyjOK9HRJgRR4iHx+PEhRoiwo0THEROQ
        sJBArMT8ZwtZJzDKzkLywSwkH8xC8sEsJB8sYGRZxSieWlqcm55abJiXWq5XnJhbXJqXrpec
        n7uJEZgaTv87/mkH49dLSYcYBTgYlXh4I/bOixJiTSwrrsw9xCjBwawkwju5ZH6UEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd44jbooIYH0xJLU7NTUgtQimCwTB6dUA2N67aR3ny7GX1pzW+r8
        HMPQeqd3c+9VLtfzV2zzP3wu98TCBoFFc1qvP7oqJH5lI1t9+l6O5wESVSf9LoTNsJnwYO1D
        vrzEQzOmtB0/wfPyxoaVCZM/Xp3148LTF9MyexYVSk8KqGCeU/zE2sGRYWIny66VInmf7xxO
        DP85/9z5txcb7XuffQy6r8RSnJFoqMVcVJwIALV86S8JAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsVy+t/xa7r7Ds+PMjjzXNBi44z1rBZzzrew
        WHS/krG4f+8nk8XlXXPYHFg9tqy8yeSx7YCqR9+WVYwenzfJBbBEcdmkpOZklqUW6dslcGXM
        6ikueCVasfn9NfYGxjmCXYycHBICJhL9Dy8zdTFycQgJLGGUOHvzAyNIQkjgGaPEtTcpIDab
        gLnEo+1nmEBsYQE/iXcvzrKB2CICOhIrXy5mBWlmFljIKDFp8TFWkASvgJvE//srmUFsFgFV
        iW3TH7KA2KICERKdK+ezQNQISvyYfA/I5gBqVpeYMiUXJMwsIC7R3HqTBcKWl9i85i3zBEa+
        WUg6ZiF0zELSMQtJxwJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBQbrt2M8tOxi73gUf
        YhTgYFTi4d2wf16UEGtiWXFl7iFGCQ5mJRHeySXzo4R4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        njeojBISSE8sSc1OTS1ILYLJMnFwSjUwHt8RbfLahWNpo5Xxp5KaTnPp1fGBC++LL9irs0GL
        T4kr9S1DVlHPfdtP5nMqVMzPzvw3X7Ha73tQxmPTr61sEVWytqsF8m8ILF13/LZQbo6Gu2WZ
        4bfITyf3pj8RXvxtY1vdiwUq/X4JSn9zJJ9MvROrfmxGdf7cx//VXpQHzH5mwSSgFnZaiaU4
        I9FQi7moOBEAPO1X0E4CAAA=
X-CMS-MailID: 20180307104934eucas1p18af0e65a519299997b5d2f7fb78cd39f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180307104934eucas1p18af0e65a519299997b5d2f7fb78cd39f
X-RootMTR: 20180307104934eucas1p18af0e65a519299997b5d2f7fb78cd39f
References: <CGME20180307104934eucas1p18af0e65a519299997b5d2f7fb78cd39f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent improper use of req->result field in ahash update, init, export and
import functions in drivers code. A driver should use ahash request context
if it needs to save internal state.

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
---
version 2:
 Change req->digest to req->result, as pointed out by Tom Lendacky

 include/crypto/hash.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 2d1849dffb80..76e432cab75d 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -74,7 +74,8 @@ struct ahash_request {
  * @init: **[mandatory]** Initialize the transformation context. Intended only to initialize the
  *	  state of the HASH transformation at the beginning. This shall fill in
  *	  the internal structures used during the entire duration of the whole
- *	  transformation. No data processing happens at this point.
+ *	  transformation. No data processing happens at this point. Driver code
+ *	  implementation must not use req->result.
  * @update: **[mandatory]** Push a chunk of data into the driver for transformation. This
  *	   function actually pushes blocks of data from upper layers into the
  *	   driver, which then passes those to the hardware as seen fit. This
@@ -83,7 +84,8 @@ struct ahash_request {
  *	   transformation. This function shall not modify the transformation
  *	   context, as this function may be called in parallel with the same
  *	   transformation object. Data processing can happen synchronously
- *	   [SHASH] or asynchronously [AHASH] at this point.
+ *	   [SHASH] or asynchronously [AHASH] at this point. Driver must not use
+ *	   req->result.
  * @final: **[mandatory]** Retrieve result from the driver. This function finalizes the
  *	   transformation and retrieves the resulting hash from the driver and
  *	   pushes it back to upper layers. No data processing happens at this
@@ -120,11 +122,12 @@ struct ahash_request {
  *	    you want to save partial result of the transformation after
  *	    processing certain amount of data and reload this partial result
  *	    multiple times later on for multiple re-use. No data processing
- *	    happens at this point.
+ *	    happens at this point. Driver must not use req->result.
  * @import: Import partial state of the transformation. This function loads the
  *	    entire state of the ongoing transformation from a provided block of
  *	    data so the transformation can continue from this point onward. No
- *	    data processing happens at this point.
+ *	    data processing happens at this point. Driver must not use
+ *	    req->result.
  * @halg: see struct hash_alg_common
  */
 struct ahash_alg {
-- 
2.16.2
