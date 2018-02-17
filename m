Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1614509-1518834352-2-4707434078051328766
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UPPERCASE_50_75 0.008, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518834352; b=JNhYXOo5f1et5fz4+ohGTzjfZdPgRzfVnv6vjbKVG3NFD+Q
    WGsuQJEsZK2a0k7dEhIEiJ/3sNSKrTgt4Hu4JwnQ29MZKBoBY+1Vg6pF0o2p5iXt
    gKGHhTqJ4whPof5BNLB8XCPNoWzLfBnux+vDJjnUeD3iBegA2t+eiBxFR/4cwBWL
    x//hRFNknsTMsTwyQicq7JJPgvG5PqEKbSOkCEnBodCy8/FBLo4CeTAYAU6LERy2
    4rRKylWRCvos4od0gST4Fm9HBBiCEkStJNCdwg20Q+NiADcJB9oqepsfPQ5orq2q
    r+vXfhWyVWQW6il11YM+DwUi4hCD2LxucRb8u5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518834352; bh=5
    47MHe8Kgo0nWGjJxEY/mxS9+0df/XLYbFfANRqAA3g=; b=EzhSjkjRjmu0a+iKz
    86tWVtDNVoMb7hxb8qOP/NnjuXKrkp/o0YL2jQuoCX4ZKLr1mUnpCnyUNwVf59f3
    iGsTRIvj8X4DdxeIg8eA8TMzcoD2XV5peJeajoG0RHxehR7VA4mHDxbRWBHR190g
    iUNcEI9CO+/AgmnlUHORcwLsp/KF2/lbfwVXhro+D9/kt2nplWIimaJI4ORUhgXQ
    SWa16m/HL698VXFXPsxwotSCghc5Ij3oQOGn7KlvvtYuCIvokwBazguh54kI6k22
    RYIKi6F2hA1fc4UdVQnaELbQKgmzwr+SYQIcz41glITdv6zadzMKpbk0m/IyTMD0
    xsKjQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 3/4] Staging: ks7010: hostif: Fix multiple use of arguments in
 rate and event masking macros.
Date: Fri, 16 Feb 2018 18:25:02 -0800
Message-Id: <20180217022503.24982-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180217022503.24982-1-quytelda@tamalin.org>
References: <20180217022503.24982-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:643wAaizfa3wJCBFU9OHdKlQQkf0THsEkGLwFv53/9pzJpRRyzQ
 FzFkvMDUPTdRNd2TeszsnRP8ZNf6bs/OVKp32xgkYylgHGNfUlmJLBRG9frxAW4AM+bEAkk
 7fIRaK8u/VZjrv0sQ/RUVMLgjKUnVG8ijnYpMvO5z5NpKd1I6HrDmx7wA9JduZq/iC0m8GH
 ae+M6kXtHdUBaBjzyXrSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u25isY0Zndk=:7OHGgFrEtEF/rbV+QhuOB6
 VzhNY/N/GWW6u46mw1tOThMGwFTMNupHodSmkQVgVO2aOm9jxRu1rpa5UXiPn9ZKpdrb3UG0e
 cl2D1117a41fwiZORqC3xhaSZ1/aisbxrHeQjHRM6HwjL+coVi6rYpsrZZ5rOox8FwcFjdpZl
 jUw29iEyutB6TadICn53AqNofJ30iVPTLJN17edU1MmRD95I+o9EtkiuxbnLcWS36jhnjDVhS
 C+kjOcLWWqvHs5CkkJE4huIsoNBV4/Lu2Ug9R8JiACmH3kPuHsnsCi8wCs81MIx1XyaOGDJ+O
 5pOP1T7x/05xknklRpnXwXMqRze+AnVnoO9AHS6ZA1Qv2DyA7oVkJXZOEN8F7WW0k53d3WY65
 bDVFfml3bvIbBUukbrKCOktbySNDuRaLlQCjQjDHquMzr++AXGUxlnFjFF94lmZly3dfIMmGB
 EZ/wOxi6m53aYKibOT1evSecKP3yhDyW4/Dw67N+U1Q870NuEDx8g0fm2Df0yu0P/EvzDzYVx
 QzwRKogmfDnb/z1bS5pTeBfLTnO53h4f+R5gl94EMYAY+zyW1UkT1M2V++DAlso74vNnAqP0N
 b+S16n4p5hI2EapXZ4qVPKmDZ0BZL/POrj5ltWYDnvdGe/wFlcIwhq/JVSEbIA4mMAEMj5pX+
 8wQKD9W0iTosazpZiZOtD5c6RPSTAnplYVZ4QA+O1L4UGWwFpDYb0HT2Y6h/D4I70/xyPRimm
 i6Y1a59/s00jfGBIS8obvTZY91h5jKiww8E6gA==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use GCC extensions to prevent macro arguments from accidentally being evaluated
multiple times when the macro is called.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 74 +++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 5bae8d468e23..750ac86cee77 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -599,19 +599,39 @@ struct hostif_mic_failure_confirm_t {
 #define TX_RATE_48M	(uint8_t)(480 / 5)
 #define TX_RATE_54M	(uint8_t)(540 / 5)
 
-#define IS_11B_RATE(A) (((A & RATE_MASK) == TX_RATE_1M) || ((A & RATE_MASK) == TX_RATE_2M) || \
-			((A & RATE_MASK) == TX_RATE_5M) || ((A & RATE_MASK) == TX_RATE_11M))
-
-#define IS_OFDM_RATE(A) (((A & RATE_MASK) == TX_RATE_6M) || ((A & RATE_MASK) == TX_RATE_12M) || \
-			 ((A & RATE_MASK) == TX_RATE_24M) || ((A & RATE_MASK) == TX_RATE_9M) || \
-			 ((A & RATE_MASK) == TX_RATE_18M) || ((A & RATE_MASK) == TX_RATE_36M) || \
-			 ((A & RATE_MASK) == TX_RATE_48M) || ((A & RATE_MASK) == TX_RATE_54M))
-
-#define IS_11BG_RATE(A) (IS_11B_RATE(A) || IS_OFDM_RATE(A))
-
-#define IS_OFDM_EXT_RATE(A) (((A & RATE_MASK) == TX_RATE_9M) || ((A & RATE_MASK) == TX_RATE_18M) || \
-			     ((A & RATE_MASK) == TX_RATE_36M) || ((A & RATE_MASK) == TX_RATE_48M) || \
-			     ((A & RATE_MASK) == TX_RATE_54M))
+#define IS_11B_RATE(A)							\
+	({								\
+		typeof(A) A_ = (A);					\
+		((A_ & RATE_MASK) == TX_RATE_1M) ||			\
+			((A_ & RATE_MASK) == TX_RATE_2M) ||		\
+			((A_ & RATE_MASK) == TX_RATE_5M) ||		\
+			((A_ & RATE_MASK) == TX_RATE_11M); })
+
+#define IS_OFDM_RATE(A)							\
+	({								\
+		typeof(A) A_ = (A);					\
+		((A_ & RATE_MASK) == TX_RATE_6M) ||			\
+			((A_ & RATE_MASK) == TX_RATE_12M) ||		\
+			((A_ & RATE_MASK) == TX_RATE_24M) ||		\
+			((A_ & RATE_MASK) == TX_RATE_9M) ||		\
+			((A_ & RATE_MASK) == TX_RATE_18M) ||		\
+			((A_ & RATE_MASK) == TX_RATE_36M) ||		\
+			((A_ & RATE_MASK) == TX_RATE_48M) ||		\
+			((A_ & RATE_MASK) == TX_RATE_54M); })
+
+#define IS_11BG_RATE(A)					\
+	({						\
+		typeof(A) A_ = (A);			\
+		IS_11B_RATE(A_) || IS_OFDM_RATE(A_); })
+
+#define IS_OFDM_EXT_RATE(A)						\
+	({								\
+		typeof(A) A_ = (A);					\
+		((A_ & RATE_MASK) == TX_RATE_9M) ||			\
+			((A_ & RATE_MASK) == TX_RATE_18M) ||		\
+			((A_ & RATE_MASK) == TX_RATE_36M) ||		\
+			((A_ & RATE_MASK) == TX_RATE_48M) ||		\
+			((A_ & RATE_MASK) == TX_RATE_54M); })
 
 enum connect_status_type {
 	CONNECT_STATUS,
@@ -633,17 +653,23 @@ enum multicast_filter_type {
 
 /* macro function */
 #define HIF_EVENT_MASK 0xE800
-#define IS_HIF_IND(_EVENT)  ((_EVENT & HIF_EVENT_MASK) == 0xE800  && \
-			     ((_EVENT & ~HIF_EVENT_MASK) == 0x0001 || \
-			     (_EVENT & ~HIF_EVENT_MASK) == 0x0006 || \
-			     (_EVENT & ~HIF_EVENT_MASK) == 0x000C || \
-			     (_EVENT & ~HIF_EVENT_MASK) == 0x0011 || \
-			     (_EVENT & ~HIF_EVENT_MASK) == 0x0012))
-
-#define IS_HIF_CONF(_EVENT) ((_EVENT & HIF_EVENT_MASK) == 0xE800  && \
-			     (_EVENT & ~HIF_EVENT_MASK) > 0x0000  && \
-			     (_EVENT & ~HIF_EVENT_MASK) < 0x0012  && \
-			     !IS_HIF_IND(_EVENT))
+#define IS_HIF_IND(_EVENT)					      \
+	({							      \
+		typeof(_EVENT) EVENT_ = (_EVENT);		      \
+		(EVENT_ & HIF_EVENT_MASK) == 0xE800  &&		      \
+			((EVENT_ & ~HIF_EVENT_MASK) == 0x0001 ||      \
+			 (EVENT_ & ~HIF_EVENT_MASK) == 0x0006 ||      \
+			 (EVENT_ & ~HIF_EVENT_MASK) == 0x000C ||      \
+			 (EVENT_ & ~HIF_EVENT_MASK) == 0x0011 ||      \
+			 (EVENT_ & ~HIF_EVENT_MASK) == 0x0012); })
+
+#define IS_HIF_CONF(_EVENT)					     \
+	({							     \
+		typeof(_EVENT) EVENT_ = (_EVENT);		     \
+		(EVENT_ & HIF_EVENT_MASK) == 0xE800  &&		     \
+			(EVENT_ & ~HIF_EVENT_MASK) > 0x0000  &&	     \
+			(EVENT_ & ~HIF_EVENT_MASK) < 0x0012  &&	     \
+			!IS_HIF_IND(EVENT_); })
 
 #ifdef __KERNEL__
 
-- 
2.16.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
