Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3458174-1518631968-2-9151574326512384990
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518631967; b=bHTdEnzsRpwCwI7hWBxpQHkYb+ZZNjJ1Xb7cWA9NiB6bvAj
    +MbiROZry4qHZ2tfvWbeMmJnAnWz4u4Y66OkfuH1UIcMzkZqWKMx9EuHIg+u4eBW
    tv95y5s/DoPiHLuVVcDYeT4ZAzfJjAiZ1JoAdjPX7Vt7uAHEFC71dcpEEeDOM9fH
    suKCKYjCrMCBQlAhO3EshlU8R8BBE1useyJOGhb0J5YX63KLZbH26qPRSHChKbwR
    G5q45PBUxS8L0YyGJDYAAJUb57B1W6+AqENsG/Cyy9B48+oqfXQvowRIgxPA0esM
    IaAMRWLrtApqGjnd3ltQZyGSAZ485J6NnjV/i+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518631967; bh=6
    QJMX5aVUTDRvc9YpMexaZzeH5kDeqlrohTKeTfjkmM=; b=hWCe3nkR2zTi3HYJ1
    I2pCF4p8NDoJA96cILJN8dyU3CgNwzfP4tCwkrErg8hDTTSjL/1bAJFJ17QRnsC9
    Nn5aqE4vL8iZ2jTsX3VpOx95vAtTlZdbacsn9dLQ0oDZdg1IMm4Cps60aeEnh2Cj
    HTjJT+F5Nw/17eTS3ngEvh09y8VMRG5xk7CwRe4vFXkpRMcKfOG6fsAgjbUl4ZiZ
    4fEG0dLMCVfpeWjf4j5FtW8yAXCaKrxrJCEzp6Nu+eb8/sj1hZyUyAiGZNr1CAsW
    9D2+v77XJUNRr05NO0vtm3Y2SZMqwvVX8YaJQEL67PecKqqN+CzKMiF9CA11MiIP
    vMuPw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=KZsq21Sn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eFyDy6lv;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=KZsq21Sn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eFyDy6lv;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x226hFfgEo1KorKmQYNadlR9LxRT/KS9+VnDCbHPbsaYxfZBlhFReOuY/kQwwsLT40lJ8CJXNdQ==
Date: Wed, 14 Feb 2018 10:12:36 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Michael Kelley <mhkelley@outlook.com>
Subject: Re: [PATCH char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer
 signaling
Message-ID: <20180214101236.49e0f66c@xeon-e3>
In-Reply-To: <SN6PR1901MB204572CAD3159EB07D6F1043CBF10@SN6PR1901MB2045.namprd19.prod.outlook.com>
References: <SN6PR1901MB204572CAD3159EB07D6F1043CBF10@SN6PR1901MB2045.namprd19.prod.outlook.com>
MIME-Version: 1.0
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mikelley@microsoft.com" <mikelley@microsoft.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "leann.ogasawara@canonical.com" <leann.ogasawara@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

What about the following simplification. If on older hosts you can avoid more code
and the additional barrier. Also cleanup comment wording somewhat.



>From de2d566d9092cbbc8e5974dea581617ef787ff69 Mon Sep 17 00:00:00 2001
From: Michael Kelley <mhkelley@outlook.com>
Date: Sat, 10 Feb 2018 20:48:49 +0000
Subject: [PATCH 1/9] Drivers: hv: vmbus: Fix ring buffer signaling

Fix bugs in signaling the Hyper-V host when freeing space in the
host->guest ring buffer:

1. The interrupt_mask must not be used to determine whether to signal
   on the host->guest ring buffer
2. The ring buffer write_index must be read (via hv_get_bytes_to_write)
   *after* pending_send_sz is read in order to avoid a race condition
3. Comparisons with pending_send_sz must treat the "equals" case as
   not-enough-space
4. Don't signal if the pending_send_sz feature is not present. Older
   versions of Hyper-V that don't implement this feature will poll.

Fixes: 03bad714a161 ("vmbus: more host signalling avoidance")
Signed-off-by: Michael Kelley <mhkelley@outlook.com>
---
 drivers/hv/ring_buffer.c | 67 +++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 50e071444a5c..d27cbb66279c 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -417,13 +417,25 @@ __hv_pkt_iter_next(struct vmbus_channel *channel,
 }
 EXPORT_SYMBOL_GPL(__hv_pkt_iter_next);
 
+/* How many bytes were read in this iterator cycle */
+static u32 hv_pkt_iter_bytes_read(const struct hv_ring_buffer_info *rbi)
+{
+	if (rbi->ring_buffer->read_index < rbi->priv_read_index)
+		return rbi->priv_read_index - rbi->ring_buffer->read_index;
+	else
+		return rbi->ring_datasize -
+			rbi->ring_buffer->read_index + rbi->priv_read_index;
+}
+
 /*
  * Update host ring buffer after iterating over packets.
  */
 void hv_pkt_iter_close(struct vmbus_channel *channel)
 {
 	struct hv_ring_buffer_info *rbi = &channel->inbound;
-	u32 orig_write_sz = hv_get_bytes_to_write(rbi);
+	u32 curr_write_sz;
+	u32 delta = hv_pkt_iter_bytes_read(rbi);
+	u32 pending_sz;
 
 	/*
 	 * Make sure all reads are done before we update the read index since
@@ -433,39 +445,40 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 	virt_rmb();
 	rbi->ring_buffer->read_index = rbi->priv_read_index;
 
+	/* Older versions do not require signalling */
+	if (!rbi->ring_buffer->feature_bits.feat_pending_send_sz)
+		return;
+
 	/*
-	 * Issue a full memory barrier before making the signaling decision.
-	 * Here is the reason for having this barrier:
-	 * If the reading of the pend_sz (in this function)
-	 * were to be reordered and read before we commit the new read
-	 * index (in the calling function)  we could
-	 * have a problem. If the host were to set the pending_sz after we
-	 * have sampled pending_sz and go to sleep before we commit the
-	 * read index, we could miss sending the interrupt. Issue a full
-	 * memory barrier to address this.
+	 * If the reading of the pend_sz were to be reordered and read
+	 * before we commit the new read index then we would have a
+	 * problem. If the host were to set the pending_sz after we
+	 * have sampled pending_sz and go to sleep before we commit
+	 * the read index, we could miss sending the interrupt.
 	 */
 	virt_mb();
 
-	/* If host has disabled notifications then skip */
-	if (rbi->ring_buffer->interrupt_mask)
-		return;
+	pending_sz = READ_ONCE(rbi->ring_buffer->pending_send_sz);
 
-	if (rbi->ring_buffer->feature_bits.feat_pending_send_sz) {
-		u32 pending_sz = READ_ONCE(rbi->ring_buffer->pending_send_sz);
+	/*
+	 * Ensure the read of write_index in hv_get_bytes_to_write()
+	 * happens after the read of pending_send_sz.
+	 */
+	virt_rmb();
+	curr_write_sz = hv_get_bytes_to_write(rbi);
 
-		/*
-		 * If there was space before we began iteration,
-		 * then host was not blocked. Also handles case where
-		 * pending_sz is zero then host has nothing pending
-		 * and does not need to be signaled.
-		 */
-		if (orig_write_sz > pending_sz)
-			return;
+	/*
+	 * If there was space before we began iteration,
+	 * then host was not blocked. Also handles case where
+	 * pending_sz is zero then host has nothing pending and does
+	 * not need to be  signaled.
+	 */
+	if (curr_write_sz - delta > pending_sz)
+		return;
 
-		/* If pending write will not fit, don't give false hope. */
-		if (hv_get_bytes_to_write(rbi) < pending_sz)
-			return;
-	}
+	/* If pending write will not fit, don't give false hope. */
+	if (curr_write_sz <= pending_sz)
+		return;
 
 	vmbus_setevent(channel);
 }
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
