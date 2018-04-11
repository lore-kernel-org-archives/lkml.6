Return-Path: <kernel-hardening-return-12965-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48Yp+UPraB0sNIM0qfa9dmUVxeLC3wjAPzmLnzbIHjXKlOywv7aj16LXby+w2QFdEvwvR9V
ARC-Seal: i=1; a=rsa-sha256; t=1523408592; cv=none;
        d=google.com; s=arc-20160816;
        b=xRjiSAFcCZus+7bGkrEz5HjiGfctdNF0pHbY2QjysvWj/D0LK7YTHkuRf8HtwFaAbm
         ExE7pjaDi2HFYWHUmKKlwABBcii5oaFl+KEIeK5CdxSRis2O43rgnDRbW8gkS75MX/bS
         OQjHmGU8BT+KzF5lMNbxU7fXZG4TqVqYyKIeGE0Fla84ARTWdLEq4No5Hh5R8jyP7yvz
         0l7SLpumGoQq/QaYCj0iKtPLwKQFwlQf1wXzE3/Dd5FV4yO/VS674wK0+T8sk3FgJ3Kg
         mLKAGoOEcg7g/NIqxYSUKYbI3Omo2368hvGn8fKdHyvDQCBlEmbcRSpQYeZ8lVUgh4jd
         m9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=vjfMdQW2qqANENkY55bBcrTsKlYRfZRl/r97fU0VU4w=;
        b=HD4YB+2GeEI6lxK3JReLRACH9GkVyTOgbYeI4vHLtGU9MaZ2DdKfvgliN6APZpIErR
         tCgas7HdqPR7c1yc1CFqG8lkfj01CCAL4YbQUt6mIeDO4fS2IKX4/MiLPU7WHn00BeQ3
         zzLana4cmWRT1EnbTJUTLwnnWV9IFqrHe2iG/S+S8gy70t13OFb7Ie5smansI85gd9sk
         MZ3wixvYwEXe94FIhE3czUgEqz4zh/WVdPQP+mTUJJZ9aJ9LbLPYbEgG68pUEPzteA2X
         D7L8U+5q0fm8jpxPZ/YBUrcpcYVfr635/tzgPntBKVg8wS68mN3w6MjfIMTkYf1Y85vg
         8CQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12965-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12965-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12965-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12965-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Oded Gabbay <oded.gabbay@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"David (ChunMing) Zhou" <David1.Zhou@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>
Cc: Laura Abbott <labbott@redhat.com>,
	David Airlie <airlied@linux.ie>,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>
Subject: [PATCHv2] drm/amdkfd: Remove vla
Date: Tue, 10 Apr 2018 18:02:43 -0700
Message-Id: <20180411010243.17771-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304222291643357?=
X-GMAIL-MSGID: =?utf-8?q?1597409688663986140?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There's an ongoing effort to remove VLAs[1] from the kernel to eventually
turn on -Wvla. Switch to a constant value that covers all hardware.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Switch to a larger size to account for other hardware
---
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index 035c351f47c5..c3a5a80e31ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -139,10 +139,12 @@ static void interrupt_wq(struct work_struct *work)
 {
 	struct kfd_dev *dev = container_of(work, struct kfd_dev,
 						interrupt_work);
+	uint32_t ih_ring_entry[8];
 
-	uint32_t ih_ring_entry[DIV_ROUND_UP(
-				dev->device_info->ih_ring_entry_size,
-				sizeof(uint32_t))];
+	if (dev->device_info->ih_ring_entry_size > (8 * sizeof(uint32_t))) {
+		dev_err(kfd_chardev(), "Ring entry too small\n");
+		return;
+	}
 
 	while (dequeue_ih_ring_entry(dev, ih_ring_entry))
 		dev->device_info->event_interrupt_class->interrupt_wq(dev,
-- 
2.14.3
