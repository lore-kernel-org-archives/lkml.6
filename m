Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753419AbeCFLpW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:45:22 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32838 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbeCFLpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:45:17 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180306114514euoutp02a51826088747bc8f9004acf7eee9d134~ZUi-cQh410186801868euoutp02V
X-AuditID: cbfec7f4-6f9ff700000043e4-82-5a9e7f490570
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
Subject: [PATCH] crypto: hash.h: Prevent use of req->digest in ahash update
Message-id: <c29d442e-22b6-9013-05a4-32c8eb04b692@partner.samsung.com>
Date: Tue, 06 Mar 2018 12:45:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7djPc7qe9fOiDE51iFtsnLGe1WLO+RYW
        i+5XMhb37/1ksri8aw6bA6vHlpU3mTy2HVD16NuyitHj8ya5AJYoLpuU1JzMstQifbsErox7
        hz8zFcwSrTh94g5TA+NtgS5GTg4JAROJ+au7WEBsIYEVjBK3W2K7GLmA7M+MEmv+7mODKbqz
        fisjRGIZo0THhGZWCOcZo8SBWW3sIFUiAjoSK18uBkswCyxklPjRfx4swSZgLvFo+xmmLkYO
        DmEBb4mr24pBwrwCbhITX21iBLFZBFQlvp19DWaLCkRILJz6lBGiRlDix+R7YOcxC2hKvPgy
        CcoWl2huvQlly0tsXvOWGWSvhMAcNol7Sy4wQZztIjF93VVWCFtY4tXxLewQtoxEZ8dBqJpy
        iU1b1rJDNDcA/fy+iREiYS1x+PhFVogNfBKTtk1nBnlAQoBXoqNNCKLEQ+LwrbesEGFHiW+d
        fpBgjJX49W8y0wRG2VlIXpiF5IVZSF6YheSFBYwsqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS
        83M3MQJTw+l/x7/sYNz1J+kQowAHoxIPL4f33Cgh1sSy4srcQ4wSHMxKIrwR+vOihHhTEiur
        Uovy44tKc1KLDzFKc7AoifPGadRFCQmkJ5akZqemFqQWwWSZODilGhjzNqiWuW6U+iN18nn1
        dL8o9vub0u9yhdXc41YU3MfDpMXMb/o/bnvZIc5TV+3X7v7WtPjtofcSMW2zPAVWdCTPeqL/
        /PavZJk+V7+WZs2njI7XFAxO73yUkHBMz+nUzP1bmKcZnteqXfWa3/fauQsxNS4b3VobN/Rx
        TDKepiTWEKoteHoL5wQlluKMREMt5qLiRACilUiKCQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsVy+t/xq7oe9fOiDHq6jC02zljPajHnfAuL
        RfcrGYv7934yWVzeNYfNgdVjy8qbTB7bDqh69G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8a9
        w5+ZCmaJVpw+cYepgfG2QBcjJ4eEgInEnfVbGbsYuTiEBJYwSmye94YdwnnGKPG4rZ8NpEpE
        QEdi5cvFrCAJZoGFjBKTFh9jBUmwCZhLPNp+hqmLkYNDWMBb4uq2YpAwr4CbxMRXmxhBbBYB
        VYlvZ1+D2aICERKdK+ezQNQISvyYfI8FpJVZQF1iypRckDCzgLhEc+tNFghbXmLzmrfMExj5
        ZiHpmIXQMQtJxywkHQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIEhum2Yz8372C8tDH4
        EKMAB6MSD+8Gj7lRQqyJZcWVuYcYJTiYlUR4I/TnRQnxpiRWVqUW5ccXleakFh9ilOZgURLn
        PW9QGSUkkJ5YkpqdmlqQWgSTZeLglGpgnMz9/rTGm9g9v5W9e7MS3myUd2C8lVZRdd+pO2BT
        jvH+tdpt79r0p/F+PcSy0LeD56tpw+R1lanF4p9OanD8E2BpVTd9s0hlqcn90kntWZvfcvbx
        M3pqFfyNnblBl+F7Sl3Ju6B3ci7/pFuLT1QlyB5/9Ojl9uuP41s3zJgpy2Azu+FxWdImJZbi
        jERDLeai4kQAp7laxU8CAAA=
X-CMS-MailID: 20180306114512eucas1p286d36bafa1bc719d7e7ccbaa9f549fc1
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180306114512eucas1p286d36bafa1bc719d7e7ccbaa9f549fc1
X-RootMTR: 20180306114512eucas1p286d36bafa1bc719d7e7ccbaa9f549fc1
References: <CGME20180306114512eucas1p286d36bafa1bc719d7e7ccbaa9f549fc1@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent improper use of req->digest field in ahash update, init, export and
import functions in drivers code. A driver should use ahash request context
if it needs to save internal state.

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
---
 include/crypto/hash.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 2d1849dffb80..e97c2e662d6a 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -74,7 +74,8 @@ struct ahash_request {
  * @init: **[mandatory]** Initialize the transformation context. Intended only to initialize the
  *	  state of the HASH transformation at the beginning. This shall fill in
  *	  the internal structures used during the entire duration of the whole
- *	  transformation. No data processing happens at this point.
+ *	  transformation. No data processing happens at this point. Driver code
+ *	  implementation must not use req->digest.
  * @update: **[mandatory]** Push a chunk of data into the driver for transformation. This
  *	   function actually pushes blocks of data from upper layers into the
  *	   driver, which then passes those to the hardware as seen fit. This
@@ -83,7 +84,8 @@ struct ahash_request {
  *	   transformation. This function shall not modify the transformation
  *	   context, as this function may be called in parallel with the same
  *	   transformation object. Data processing can happen synchronously
- *	   [SHASH] or asynchronously [AHASH] at this point.
+ *	   [SHASH] or asynchronously [AHASH] at this point. Driver must not use
+ *	   req->digest.
  * @final: **[mandatory]** Retrieve result from the driver. This function finalizes the
  *	   transformation and retrieves the resulting hash from the driver and
  *	   pushes it back to upper layers. No data processing happens at this
@@ -120,11 +122,12 @@ struct ahash_request {
  *	    you want to save partial result of the transformation after
  *	    processing certain amount of data and reload this partial result
  *	    multiple times later on for multiple re-use. No data processing
- *	    happens at this point.
+ *	    happens at this point. Driver must not use req->digest.
  * @import: Import partial state of the transformation. This function loads the
  *	    entire state of the ongoing transformation from a provided block of
  *	    data so the transformation can continue from this point onward. No
- *	    data processing happens at this point.
+ *	    data processing happens at this point. Driver must not use
+ *	    req->digest.
  * @halg: see struct hash_alg_common
  */
 struct ahash_alg {
-- 
2.16.2
