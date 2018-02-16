Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1232828-1518822345-2-4227565083568526552
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
    t=1518822344; b=JxyEyrKgdIY7pdJO5hw/knMUGzGdwRwg72fhfWtSIgi7hAK
    7TdOD4o8X4ZDFOVnsHUAwpuu81g1MIWeyjw1qTiN3lgkegMPAq93p4RG9AeMIc6Q
    ktjXVhFaDuLMOO65qCDzKrpdG/c8d5dC7y8kuOVwmvkpFoBBQr5DkYvOntbnFSCZ
    6bWAAiPOjphuNGRPmx7l9bi6va9gC3wUfB71mrzsF5mx49FovmJ6e/Hoeut65tjG
    vJGuLJx6QruFscyfyxbdizB1DWeOG392ysmrwxfHOBem3PTf1ZXiU7+rcGxW8xtI
    K7s6h0WIL/bLwK7Yn+KV5pL0mQ32U1SG/8sJ//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:reply-to:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518822344; bh=R
    XitjjhnXe3SgdUU2R2pO566WTUYbWousw4rXWxWa8c=; b=fMQlgQcxfu3e6O6sb
    7LiG7hVzd5KA7YmfSyznjFfQnnAt7smcg8KblaU684LqNWLFSg/707zCpSv+3frb
    JAvvT6XnwbJF/G13VLC/8D6lMcuEtA5yOeQGwl/6dr1cIC09n9zApQFI9jpvf3uZ
    +1sOMT/ZKYx1pi6bSDd55xb0Jp6p2NI1Z2PYrYSSbA9Cv5J6i83XL1wvCgwrUn9Y
    mZAMnzXHjna/AQBDu4rqlyg2bIM8p1YMzv/wNZCUx9PsSlYsRuZ1qbbai+DguT45
    6xQGgTErF/8Y0qUyvJfSSfDG1W1lE86DYac0+emok5DSBxrg9Zb+FuTgGUko+7JK
    EpH4A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=outlook.com header.i=@outlook.com header.b=YR/wwBGo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=outlook.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=outlook.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=outlook.com header.i=@outlook.com header.b=YR/wwBGo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v2 char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer signaling
Thread-Topic: [PATCH v2 char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer
 signaling
Thread-Index: AQHTp3qlr+t7tJippkC8bIhTaRmWEg==
Date: Fri, 16 Feb 2018 23:05:33 +0000
Message-ID: <SN6PR1901MB20450EF7C8CC4112381274B9CBCB0@SN6PR1901MB2045.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.8.3.1
x-incomingtopheadermarker: OriginalChecksum:34E90D05175411071763483434EFE2767F94354207E720943CF54852F0777E73;
 UpperCasedChecksum:4562A5FADCB39943DFBF2569B74CE8C2F9777BE2A75CCB465E779378A43E6194;
 SizeAsReceived:7660; Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [0FT0JCftf1+PAqsvtJRxtUBpT6WlJSsa]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BL2NAM02HT189;
 6:DgSHaXsMbS18LNbycvqauyKl/vrVmgurcXMsjHg6DtHD8i4Ije3GFp9dW5hW4xirrUI3+pZ7By4X5qTXiL40i3uoqjsfarq95fnCjpzpq/ZVautmwUZvNdUjb1eq71eq/NVKxLmIp/IenGq0HEKR+QMYBdQkUICAoE62OXJQIuR+5PPL0/yC/xHVMs7N6N1kYsBqSvGnOoDXnkq+iEBulLXY0r0PSCB99CNZMtIUFtsgjZZ7h08Kl3Ssba6QCszBMqipdTr95qgTNwAr4ODw1oG00tThrZ7+aodsiLMSZl/IFlzjd5A0uGGJ9fYUWsz30OJk5XOkdmpi0dJD11QHlvE3yVZO+DCPFf4pfIYI/6c=;
 5:qzCmno1AdKTVNzf3FxKQCLYVXomk7lhw/TtMJbj09+aMfSDVe5DBABue9zxe7X+s4zMIrJAwfIuMe2b6UVCbiDitjvq3e9Mh3gf6boGh517s8ZnnctFIsZtafkhrm0yM95+zWUAh1CHJoaa2S3i8jR8srBcLVBoEnD6wS5RNFfI=;
 24:FEfzrC9AFMLiza2sbrzgbLAKQb2JZRMFsvuhXJwZOCKpnZEpuNy0p3nHK+FNwZFxFnXGEaemJ9LOCA6KwTuD7WdojjsK9EqOzsQ9BpdbZeY=;
 7:vlldDcqRs0IlomNaEX0D9D2TcYW50Og4ARf5FSK+iJd9/vf//7iyCBlb483uwEvoWU0iMpjMQW2mUvyefsUpdZXCOsemydz34TMju3MgBCy7QNWYuzXqv5jEP/9qPq6KM57q8ig2ejIE4hulihdBwDcz3CJxrg/fjfNMymP7nwHYVogtwkYpKwSo+2MCIx3iTTO5T1jsNsPQ6Zcac9FUylb0RnZhK66bbhqTgwibs2TiYAGVwm24bwAP38F5ay85
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(201702061074)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101448)(1601125374)(1701031045);
 SRVR:BL2NAM02HT189;
x-ms-traffictypediagnostic: BL2NAM02HT189:
x-ms-office365-filtering-correlation-id: 06aba962-3079-4ec7-0203-08d57591c749
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(444000031);
 SRVR:BL2NAM02HT189; BCL:0; PCL:0; RULEID:; SRVR:BL2NAM02HT189;
x-forefront-prvs: 0585417D7B
x-forefront-antispam-report: SFV:NSPM; SFS:(7070007)(98901004); DIR:OUT;
 SFP:1901; SCL:1; SRVR:BL2NAM02HT189;
 H:SN6PR1901MB2045.namprd19.prod.outlook.com; FPR:; SPF:None; LANG:;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06aba962-3079-4ec7-0203-08d57591c749
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2018 23:05:33.0545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT189
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

Changes in v2:
* Restructured to do signaling calcuations only if needed. Makes
  the most common path faster [KY Srinivasan, Steve Hemminger]
* Moved bytes read calculation to new routine hv_pkt_iter_bytes_read
  [Steve Hemminger]

---
 drivers/hv/ring_buffer.c | 52 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 50e0714..8699bb9 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -417,13 +417,24 @@ struct vmpacket_descriptor *
 }
 EXPORT_SYMBOL_GPL(__hv_pkt_iter_next);
 
+/* How many bytes were read in this iterator cycle */
+static u32 hv_pkt_iter_bytes_read(const struct hv_ring_buffer_info *rbi,
+					u32 start_read_index)
+{
+	if (rbi->priv_read_index >= start_read_index)
+		return rbi->priv_read_index - start_read_index;
+	else
+		return rbi->ring_datasize - start_read_index +
+			rbi->priv_read_index;
+}
+
 /*
  * Update host ring buffer after iterating over packets.
  */
 void hv_pkt_iter_close(struct vmbus_channel *channel)
 {
 	struct hv_ring_buffer_info *rbi = &channel->inbound;
-	u32 orig_write_sz = hv_get_bytes_to_write(rbi);
+	u32 curr_write_sz, pending_sz, bytes_read, start_read_index;
 
 	/*
 	 * Make sure all reads are done before we update the read index since
@@ -431,8 +442,12 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 	 * is updated.
 	 */
 	virt_rmb();
+	start_read_index = rbi->ring_buffer->read_index;
 	rbi->ring_buffer->read_index = rbi->priv_read_index;
 
+	if (!rbi->ring_buffer->feature_bits.feat_pending_send_sz)
+		return;
+
 	/*
 	 * Issue a full memory barrier before making the signaling decision.
 	 * Here is the reason for having this barrier:
@@ -446,26 +461,29 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 	 */
 	virt_mb();
 
-	/* If host has disabled notifications then skip */
-	if (rbi->ring_buffer->interrupt_mask)
+	pending_sz = READ_ONCE(rbi->ring_buffer->pending_send_sz);
+	if (!pending_sz)
 		return;
 
-	if (rbi->ring_buffer->feature_bits.feat_pending_send_sz) {
-		u32 pending_sz = READ_ONCE(rbi->ring_buffer->pending_send_sz);
+	/*
+	 * Ensure the read of write_index in hv_get_bytes_to_write()
+	 * happens after the read of pending_send_sz.
+	 */
+	virt_rmb();
+	curr_write_sz = hv_get_bytes_to_write(rbi);
+	bytes_read = hv_pkt_iter_bytes_read(rbi, start_read_index);
 
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
+	 * then host was not blocked.
+	 */
 
-		/* If pending write will not fit, don't give false hope. */
-		if (hv_get_bytes_to_write(rbi) < pending_sz)
-			return;
-	}
+	if (curr_write_sz - bytes_read > pending_sz)
+		return;
+
+	/* If pending write will not fit, don't give false hope. */
+	if (curr_write_sz <= pending_sz)
+		return;
 
 	vmbus_setevent(channel);
 }
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
