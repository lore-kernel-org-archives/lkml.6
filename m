Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-568472-1520227140-2-606690386258953409
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520227139; b=gBsW6Y49reoGFe6S5z7ipII0aubaoPAAERCoTbJY8g5rEwJ
    7xWjl++M55SsLcq5OliOkIrrRU3O30GrpzgtFQkibwtT0/spYAWiuh96RARmXxFv
    nb+ukG0Uwk/kyzjH87bHaRvDaq1sLrbwxHoIaWaBG3WwTnJbMNXSSq3GeL9/NAz5
    UhLbroe8mVQkRnsSx9tlmUXWoZwpJq0aQEkU3zvlbtPPu2WyTRpNzY9/crLZHELz
    55oOsBNJokIkzT+Rp/sPWn3/z0D3myyFWlu+sh2G4GrM9sm07AxtDT3GoPkMpbB3
    QT2UnJUb9QaSbJLSCdIYcCZg/iuVWojrFRnC+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:cc:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1520227139; bh=cIVu7SPpjZ/9Nyq0080EWVRbmO+T4SinlIBL2Zq2Z6c=; b=u
    7/7jncZv2smQPkvs6Zf4u2+T+SJ8XR/oOnZQSU89MIGDhYvRQeZbkRVZlGG9GoeF
    wVvHx4agTvLGHW0lut1WMzNsglYL5pZptaIrgyIYdztFGcJmP3Ni1NKXW5lvcTtz
    rwyGUsOkZF1gHvf/jjdz6G/EXhA4ZzoTcOQrZcM6Pr6XzEPMjbWf/OprFARlB/mx
    liaWIJ2bTSbBN7ZYEz8DWDNgOPjqp9TbBd5RzGHHpe6XjC2ijeQJKXkvvwEQ5e7e
    mgaa7bwdMMPMPnifmKN/ca4PVn4thNImA8Q46df+DCyQqmWHGZpszwqe8wUsXD+d
    AggC5WdKzXB52jrygSpdg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH V2 06/12] vmbus/ring_buffer: remove some redundant helper
 function.
Date: Sun,  4 Mar 2018 22:17:16 -0700
Message-Id: <20180305051722.19157-6-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305051722.19157-1-kys@exchange.microsoft.com>
References: <20180305051539.19079-1-kys@exchange.microsoft.com>
 <20180305051722.19157-1-kys@exchange.microsoft.com>
X-CMAE-Envelope: MS4wfO3FmTSGDr+t1J2VpC6dCIL02eaZf0GUknKOk79IuzofJAxlSZ8x1gdyY9DxeXTIbeFY9CYZSt2hYaNqcAm2MYNYiaW1RdDgOZLqbXf9llZEKVRJAe6W
 +BCV7ExcHDOTn/qi6fLa60yqntcP4MwXB4Ao6GAgzylHDf3ZMXyZQMQGCGIcEh8NcJKBSA7xq0Ho7xQmYfv3m18NIhGiQ9DubiES9N24jlrP/qTY9ZRNg3qJ
 19cYOExk8FQ4cRSDod7rPAeQA4f58slxNRLItDCHOdYvi7i2v5C0Yl7zPwQ+U4nG5uISLLuHYihs1VNS735s3MRRNRQhyLtJ1o2ZQdKlJY8Jf1whpPC996S+
 vFX7dmdDj7bApjHu7yv5gCuVBXs6Y0ZspUwBNQdCpXhhZn6DYpk8NHFw6Ox+sU/hm19RBh7I1wv2lgTw8vAjwgzF7GERvg7oc790qSuipli3r3fIkBesDDOK
 GLSFL16hPgRJha9C6ubw6EXSEDwns9g4+C0WNaiZ1/fknVHxG+R4w3bLC5mbhsdlNX9CU04HO4RObKCjZ31K6LeGdA64GpUe+1M9XGYkjaOyISR1GO8EGdJ2
 /9Zilfj3F05rM8dPKNTgW9+IX3nWtTfPxH6KjHWx0rk8O3BbZu1BLG4MG8cZKSRuLmY=
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
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>

Some hv_get/set** helper functions in ring_buffer code are
only called once or not used. This patch is to clear up these codes.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/ring_buffer.c | 49 ++++--------------------------------------------
 1 file changed, 4 insertions(+), 45 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 50e071444a5c..1aa17795727b 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -78,46 +78,6 @@ static void hv_signal_on_write(u32 old_write, struct vmbus_channel *channel)
 		vmbus_setevent(channel);
 }
 
-/* Get the next write location for the specified ring buffer. */
-static inline u32
-hv_get_next_write_location(struct hv_ring_buffer_info *ring_info)
-{
-	u32 next = ring_info->ring_buffer->write_index;
-
-	return next;
-}
-
-/* Set the next write location for the specified ring buffer. */
-static inline void
-hv_set_next_write_location(struct hv_ring_buffer_info *ring_info,
-		     u32 next_write_location)
-{
-	ring_info->ring_buffer->write_index = next_write_location;
-}
-
-/* Set the next read location for the specified ring buffer. */
-static inline void
-hv_set_next_read_location(struct hv_ring_buffer_info *ring_info,
-		    u32 next_read_location)
-{
-	ring_info->ring_buffer->read_index = next_read_location;
-	ring_info->priv_read_index = next_read_location;
-}
-
-/* Get the size of the ring buffer. */
-static inline u32
-hv_get_ring_buffersize(const struct hv_ring_buffer_info *ring_info)
-{
-	return ring_info->ring_datasize;
-}
-
-/* Get the read and write indices as u64 of the specified ring buffer. */
-static inline u64
-hv_get_ring_bufferindices(struct hv_ring_buffer_info *ring_info)
-{
-	return (u64)ring_info->ring_buffer->write_index << 32;
-}
-
 /*
  * Helper routine to copy from source to ring buffer.
  * Assume there is enough room. Handles wrap-around in dest case only!!
@@ -129,7 +89,7 @@ static u32 hv_copyto_ringbuffer(
 	u32				srclen)
 {
 	void *ring_buffer = hv_get_ring_buffer(ring_info);
-	u32 ring_buffer_size = hv_get_ring_buffersize(ring_info);
+	u32 ring_buffer_size = ring_info->ring_datasize;
 
 	memcpy(ring_buffer + start_write_offset, src, srclen);
 
@@ -275,8 +235,7 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 	}
 
 	/* Write to the ring buffer */
-	next_write_location = hv_get_next_write_location(outring_info);
-
+	next_write_location = outring_info->ring_buffer->write_index;
 	old_write = next_write_location;
 
 	for (i = 0; i < kv_count; i++) {
@@ -287,7 +246,7 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 	}
 
 	/* Set previous packet start */
-	prev_indices = hv_get_ring_bufferindices(outring_info);
+	prev_indices = (u64)outring_info->ring_buffer->write_index << 32;
 
 	next_write_location = hv_copyto_ringbuffer(outring_info,
 					     next_write_location,
@@ -298,7 +257,7 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 	virt_mb();
 
 	/* Now, update the write location */
-	hv_set_next_write_location(outring_info, next_write_location);
+	outring_info->ring_buffer->write_index = next_write_location;
 
 
 	spin_unlock_irqrestore(&outring_info->ring_lock, flags);
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
