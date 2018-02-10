Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-627691-1518297665-2-4962795155448489002
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518297665; b=Mnp6hGXzOZRaKaj0i+TGziYcb1TXZramxPeBFAjlX8jUiCQ
    WiuCUhNeP3UxeobtYRfOXOvrDyESDyXW+c9OF1KWEH02OAoT1fpj/mKY06jSoCtA
    JfbS38JO0iFbI80+LJkJSRf9yxZqnVaMzHXqPQdWfYOk4cqi008MPVMBcVA9IZWI
    pf/SCEb3Ezt8IF1Owsj66QevwNE/l0o8F6RUa4KV28mF80qXHOwFJjkqCQjJihaA
    eFy+6jOjYbp30Iqzk2XR76lVLfKCVQ4rcUvEqtA9TuccFmGNH2qB8WwCan+//T+d
    Uf8FV8Zmyqkknqg2t5gfuuN2mRG+t9ipnaw26CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:reply-to:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518297665; bh=a
    jRBh1/tvwuRuAO1GLkzVvZoNUpkdbAq5rpuZAE2lKY=; b=Tp95kT2OVjeqApFfw
    cCLJ/KYXRp9BijODDGp+qscKInzFkdraUQqTmPqeVLP4XZZyj5KStD8Re6nAr6HW
    6v7jeKNv5VW29xLxWvyH9ukXWrG1m+8NIJ0/CV59EEtMycFA4LlQ+40ai96wx0b+
    ENuhHl2XAleRsm+S79+4RI1WKcVGpFCG/6/R5cER1SOdjmaC2JwoqmzEJoDuQCw+
    xv2KywkAHkVXXL8u1/Br03Wc64+dxP5upifIYPk9ZrWqJMykEJ6AIRwDFSeZxSUt
    D+42NqOHTcNBE3MLV3l5conzdkweloKFErbnl8N+EA/Fg0aOK7+q/a/lcUQYMQkc
    9MXbw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=outlook.com header.i=@outlook.com header.b=eHVd+7Bx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=outlook.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=outlook.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=outlook.com header.i=@outlook.com header.b=eHVd+7Bx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=outlook.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=outlook.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Michael Kelley <mhkelley@outlook.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "leann.ogasawara@canonical.com"
 <leann.ogasawara@canonical.com>, "marcelo.cerri@canonical.com"
 <marcelo.cerri@canonical.com>, "sthemmin@microsoft.com"
 <sthemmin@microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>
Subject: [PATCH char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer signaling
Thread-Topic: [PATCH char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer
 signaling
Thread-Index: AQHTorCNaQB4t9RCq0qElSZLQrwNpQ==
Date: Sat, 10 Feb 2018 20:48:49 +0000
Message-ID: <SN6PR1901MB204572CAD3159EB07D6F1043CBF10@SN6PR1901MB2045.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.8.3.1
x-incomingtopheadermarker: OriginalChecksum:A490342225F4EEDF2446CE04791427218BDACDE1AC1DD6C8235CE1BCE91B59E2;
 UpperCasedChecksum:3C6704DC42144017929F4869C8417FF2599B723CFDC5AC48F69D898D2C65798C;
 SizeAsReceived:7687; Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [rtKw4uiBWu9kcGDutNkfpl6ofk5JVSd3PdMcK2qU6wo=]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY1NAM02HT135;
 6:7nuheFl0QpbpFCC1mH1S/m6KnOamXi1ITAa8Z79EBO+FjPq8aXy4EJZl8I3pHa9JWNu0iKrN1pF4j/VDWNapjLXvj1ywzzoRfKzf1KfeJFqEBdEXCswqHhf1z5MCkQr4s3nQsaiRW51SSlXV00k23yqO2MRCVgmup1g9ePBXJym/jawMSbIPRf7dH0lVhmxZCJZTjx2krfdF/eXAyqm3L9JPYnhC0f8wJc8SZjQjluG7ad2mLz9CyCe9dHmA19t0RMRMfX0IAp0PwtEBuqQuL3vlUDwAQyIJUekwfOTnBDG7ILzpvvWciCmpZ7ymxfE+QT1EFAVCkqLP9jRmwKkewfvuk5YjgxdGEhdcEspAiyA=;
 5:RHXp4Vks3/f+7BtpXupBV0p0YQPRIbLHG2U40a5WtrupYbj7ozeu3OM/CStE7Yt1eZYUCwjaw1bCFb17o1xfYXlH2BKSZ5y9kgIODqyO2tWTcROHqpFTiR5B/hnwFlIQolUasn/z5qNSCPW/omD5aqS/FGPYW3TggYyHMTGryJU=;
 24:r6VQMDapI3R4xrh6wvLEnWnEylCAHEyNjrQmNC0PecA5VyFIn493xdAagrvI+yb6t2BbXfjJKe3fF9bRh3ULYFaCOszgW8xX9Y/CXcGCA+U=;
 7:vylzSDpgcOkmkmbOgzmqVV7dSYQKWY4hs4YHaBANowf/2c2D6o+qZgVa08fQEKoAqdC5O08KYLaiMmNWQh5n4zyi/ExgBv1uyBzmMvznE+JNtrEOE+aqEh5A4nroBYsa+LJnygXF047oUGKvLZF3mFYy7tdGi6G2iZ5Ga+oJn2EDqFdVYTte9xhPBDaJ/ZwsYwYoJ3JoLU9b/E4iDWFUpbBAG6oWZl1oyChii3BBI4+821aNVcvsElj9uz7lstnE
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(201702061074)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125374)(1603101448)(1701031045);
 SRVR:CY1NAM02HT135;
x-ms-traffictypediagnostic: CY1NAM02HT135:
x-ms-office365-filtering-correlation-id: cfb01ca7-e59a-4cac-0119-08d570c7afd8
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(444000031);
 SRVR:CY1NAM02HT135; BCL:0; PCL:0; RULEID:; SRVR:CY1NAM02HT135;
x-forefront-prvs: 057906460E
x-forefront-antispam-report: SFV:NSPM; SFS:(7070007)(98901004); DIR:OUT;
 SFP:1901; SCL:1; SRVR:CY1NAM02HT135;
 H:SN6PR1901MB2045.namprd19.prod.outlook.com; FPR:; SPF:None; LANG:;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb01ca7-e59a-4cac-0119-08d570c7afd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2018 20:48:49.7983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1NAM02HT135
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
Reply-To: "mikelley@microsoft.com" <mikelley@microsoft.com>
Cc: "mikelley@microsoft.com" <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
 drivers/hv/ring_buffer.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 50e0714..b64be18 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -423,7 +423,11 @@ struct vmpacket_descriptor *
 void hv_pkt_iter_close(struct vmbus_channel *channel)
 {
 	struct hv_ring_buffer_info *rbi = &channel->inbound;
-	u32 orig_write_sz = hv_get_bytes_to_write(rbi);
+	u32 curr_write_sz;
+	u32 delta = rbi->ring_buffer->read_index < rbi->priv_read_index ?
+			(rbi->priv_read_index - rbi->ring_buffer->read_index) :
+			(rbi->ring_datasize - rbi->ring_buffer->read_index +
+			rbi->priv_read_index);
 
 	/*
 	 * Make sure all reads are done before we update the read index since
@@ -446,27 +450,31 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 	 */
 	virt_mb();
 
-	/* If host has disabled notifications then skip */
-	if (rbi->ring_buffer->interrupt_mask)
-		return;
-
 	if (rbi->ring_buffer->feature_bits.feat_pending_send_sz) {
 		u32 pending_sz = READ_ONCE(rbi->ring_buffer->pending_send_sz);
 
 		/*
+		 * Ensure the read of write_index in hv_get_bytes_to_write()
+		 * happens after the read of pending_send_sz.
+		 */
+		virt_rmb();
+		curr_write_sz = hv_get_bytes_to_write(rbi);
+
+		/*
 		 * If there was space before we began iteration,
 		 * then host was not blocked. Also handles case where
 		 * pending_sz is zero then host has nothing pending
 		 * and does not need to be signaled.
 		 */
-		if (orig_write_sz > pending_sz)
+		if (curr_write_sz - delta > pending_sz)
 			return;
 
 		/* If pending write will not fit, don't give false hope. */
-		if (hv_get_bytes_to_write(rbi) < pending_sz)
+		if (curr_write_sz <= pending_sz)
 			return;
+
+		vmbus_setevent(channel);
 	}
 
-	vmbus_setevent(channel);
 }
 EXPORT_SYMBOL_GPL(hv_pkt_iter_close);
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
