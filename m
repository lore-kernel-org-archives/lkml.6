Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-703119-1520227519-2-15634569917400823913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520227519; b=kOTBS2Y8UFVCS37MRDOWyeDzdQpMAt4L9rpB7U9FrzWDJgl
    2Vxiz6/qQSW/kD3sjuTITWdBvGhJeE1GgWx5tvRcAhxBCIczFJwpLJ6vel6jSxGQ
    M+s4lysWVWJ79Yophs0Uy+S5QuhjNu1TAVla0/XGcMIBu68Y4yJkfIdXWruCWJFB
    nscLxBrcJUFcdREqNnQe+x8Hg10LKB/rAWS9cbecrVHGIyEz7r053WrdbyDC4K9M
    gDlUfRH+dyYCg+/iIpeWTbKt4dEDuOxi0nLDjVzzPnGw7+DvxvX/Ve4QQmvPzWvJ
    n1hcj/Mlno4j1bFhTS7cU1CcDgyBwCXRUqLjJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520227519; bh=2
    iGIU2DHdv9mbQEWaStZuc60w86Tjdbk8WmPCnLXMg4=; b=Wv2E82dNwQcZdtVPw
    EKUeaOLHOevC4P01rXb30A7H7yQhMnl+aiTRrW/XZFQ+0JqRy/cY7dirtADgcytn
    26f5HdZ9HRKvLFSl5QLI/lQ9er2c/StUSC2RzJq9bUyO+1eZaORF+l1ym+RNVrwN
    zNdgIZ4cWUAdqw29RPfSEpQVPt2BxRa8TltHCMFB8hny5lL4QJhXXyxbCDBU5Tzo
    okePXiOwrILeQBepJRFO1fTw0l4+c3EaT3SnwcK5AB3jQMfXHww753nxnj18xcNL
    ue7ngm5Duw9SBuW+tkRJytSf3sBp8cfFmnZIeB3aNvfzXc3IrLdvnNJ4ujUJRO6V
    lL6/w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH 1/1] Drivers: hv: vmbus: Fix ring buffer signaling
Date: Sun,  4 Mar 2018 22:24:08 -0700
Message-Id: <20180305052408.19475-1-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfB/+UNp7qsYPPTccJikU7t/HpZXaFZxKs24hkUywCXVAU+8hrON2HJTah7eBq6N84vvr0xo005sz77Lr5DdPsFK51hMQI+H+tK45zLs2dMx4ANPLYomv
 L9RhTsY3gmLQzlcT4lBX2r01qXvm07BGsnq16gJjoRiyVzegxylfQT0x72lehzR/DLS71/ZmUfMoTaaUhoSHk8sVa/NHR2NDm/SUnOYwFI+piYYZok5EFBXr
 X9fWlGSCghhdVAB3DUkCwAC26dIuoxdQbWeO3JoZdHFMjFTvxAHFgqvs2S3Ge1XjeVvJxsmP805/CyMiZW0djAuNlDRZj1orCdzi/NmykOZKfx24sAtyJEZ8
 FoPhzgsWYbgAx6pVRLyjsMuODJFJnmG9ODgBDmTAY+on+JWkpsKWvldEZo9+Gfc9LCY7kpLcL6NIbU/krsKXBlRtsfJ71Lq4XecU9j0yL10kizSE7OdFRYO/
 EoqxRdvKfoSCL3w/FObomH68tJnCozNeTnLDgDHDEg2Aib6Y0fjFcCGWiqRb1mTrg5nhTt47aagVWmPI8qtNOMvcePDIKNwoFuMF8LzfY9OXcftjVwJ7xPr3
 J19Ech26MpDPB1UisnviwGSolKrJi7ifzGMJ6joZCNhKtX/0dnpfCeohLAzy5yD7w3Q=
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
Reply-To: kys@microsoft.com
Cc: Michael Kelley <mhkelley@outlook.com>, Stable <stable@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Kelley <mhkelley@outlook.com>

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

Cc: Stable <stable@vger.kernel.org> # 4.14 and above
Signed-off-by: Michael Kelley <mhkelley@outlook.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/ring_buffer.c | 52 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 1aa17795727b..3cd7f29906ae 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -376,13 +376,24 @@ __hv_pkt_iter_next(struct vmbus_channel *channel,
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
@@ -390,8 +401,12 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
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
@@ -405,26 +420,29 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
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
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
