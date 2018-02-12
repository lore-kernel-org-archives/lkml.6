Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AH8x226PwJxlq8tgakAsqYqRFbjvrlzbJeYODZ13fTJ9A3WCib6+ceQbISjsm4JvlfLFcX6s23BM
ARC-Seal: i=1; a=rsa-sha256; t=1518395677; cv=none;
        d=google.com; s=arc-20160816;
        b=vv9Ja6D9vtSVxFvhkPa0lviHsuW/6hFFONZkk3M6fOUYtYLYLpfCl/41JTb2KuTU3A
         Kur5Y1NcXA2H/2ABxa6sTjfBH48li8i5D3jmVvv7+g3x71R/bLPa5qWfYbVZc9vwS74a
         G8b7HnDQLjHMj+y2SPdk7GJEtvvx6gVtNtaR6TOq5F2OXhsItDVKtSuyz8iNV0xqPfA3
         Rnc+PP69by2CQjc6m3NEri2nFGmTVL+MqGcm+bsPUYAVZp54mAq9XqEpr0HYX+S5vMDR
         l6e1ULwgg+9abPB9yPWTqWMsJfY954GRAAcuVyh5n/iIDo2IDZjiZKAKRAKwlC/aBhWE
         v7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=WZ25gcUtLMvd9cAt/rsDV80zsN5hPb+wVtqTVo1Ng10=;
        b=RUhhicqragO3M4XuL/gkunarYbh3TnB8IF4tkO+KeUrODBNet5Bc9SzJtdl4q9UpbE
         t/GXz66HpUIkCY1NgM1HBIAZwo4x6iL/29BSTZIOsh+K4gZ+1qg8WxJmyy9DCk7XLBss
         SHZJFXTkBOXqptMKc878uLv1SquSjREmFtBdHXJnfY/dyxomotB/zvnFT0X/44g/WiAY
         pN5ccO2Nj34Nspqcix4zhA3D+/EKKmjZeXbCdp0mDjiUGQz1hjGm4WCWsqwtvpqs55m4
         H2c9uV8u3OcMdoC58ahinF4PL+g7MbzzELf0DprBpeSLNMBr8dF2Y+6wglCz/vYZFuCc
         mQBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.37 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.37 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Cc: "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
	Tianyu Lan <Tianyu.Lan@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 06/12] vmbus/ring_buffer: remove some redundant helper function.
Date: Sun, 11 Feb 2018 17:33:14 -0700
Message-Id: <20180212003320.6748-6-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212003320.6748-1-kys@exchange.microsoft.com>
References: <20180212002958.6679-1-kys@exchange.microsoft.com>
 <20180212003320.6748-1-kys@exchange.microsoft.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfMBPoVmBpj5ZCphvaGIPrQDPdiP9EBYCoCwA13x7dFTj0gCvjgvLTrZo/d8eqMq58uZhIcAyYn4RsEcbpIMrcjHLlYImX+d1C+FSuKEllEHKslHysej8
 fg7BkCJVqliBc/AKN5cBO6jAxYFgkycGtdH8qut8ktMRW0Bmc7FWA4uM53dOeR89Xwr0VKSCFO1XWLzwEbB3rz8/KYfzTmOD9+3Re8g0q4B/e2kgE1Otj8cM
 bYCYWVee90ko4UUvzxMRgdLY8YfK0rwgSVUjAdRQVy4pI51KoNIfBbiLztjv7aqqkZ3N2zAB4UW7v/8iPNEveR4voRZu7PV9Ck/I5zoec+UJgWVhOVncj97V
 A5j6Rp4ucU6Yw3nxE/94evxnKLng9xKGKZN6FvoHVhjSzXyCfYlD+vCtM8FPDFmFq5Tui0lNmSilITqRvPbMgIOWC7EcVCEIIGDsQNc/e38KBnasD+JNt7Hl
 EXth0TMIVNIWA7jzBuhCpGnrMHXHNHogLhiGsm50Ys40E/WCwFkyAhylcgjVDPYg4rkH437/fvrt25C7zK1JoxVTOJkZS7lvdFIY0R5vw1eRC8Lzk5RKHUqD
 /uq/mnrevffjIXfNcKRGwuzbOGMe2ipTUQ7xJ1YImw99O8tfujcMDg/xBo2WbceNe10=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592153265112869010?=
X-GMAIL-MSGID: =?utf-8?q?1592153265112869010?=
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
