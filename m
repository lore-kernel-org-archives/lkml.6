Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3862117-1520968041-2-9496574399839977979
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520968040; b=uHjQb3DIiCzszqDScY+05G2a2GvzbO75kcRVAD7LrrFiPu0
    LUJgF3fQ3IXWZdxBXP94xwMMN2WwfGQdYfJpFefTG1ruxD71fpXO27PZoccW/vO+
    qmmNhDFE8lGWaF0fLDIeFVqXatQqH6+u0z9B1XDSM47p5GNNN0i5iVEGDeG7X1SS
    azQ4zAlFiaajZvJKxaWMIt0UedUwEAOXUBurZdQspTUZmhWA4FaA7ZVPkIb/r/bk
    psT/z7n+GqwSiOEVAlBziOgSRUbs9KA+HDp3U7UpCwJZgLele9gUCjGaj+AragRB
    PSnU+gtJix+2tSnlJVePexQTtzemT2tNnfuX3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520968040; bh=H
    ACI7V519dUZfrDcPfibeb5POrEkjP+JLiT40NzMUZQ=; b=UmPeuF6FlgaRHQkow
    NjcICS6JUss/5Pt2j0Z4+kOY8JKnVwcnNB6DBSCmM+oWI2n1dTiHMuWnh/VSo0co
    FwUS753YZJ05Y3h9ZeJZ2D5bb8DHP2KS3+Z26WvxI/J82s2DxFiDEixT68pfKwvo
    V/TBTb2kSAKmdw2hUl5kFdSwWjiu+PcxWCm/rKTeee50fCYuxtAYAd4vcP9CPtJf
    cjdRxC7Re+zT/WLhMJJkng/9ryxgq7vuUqQYNJHHqcPYZCWE2j+zd6vddUUMuCSh
    hAJvefAyx8DcgoA3DkNtXU/rSW4GqIk2zXpzKd4syvh5GJIQSz9VEXkAErIGn09x
    kMx5Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Mohammed Gamal <mgamal@redhat.com>
To: netdev@vger.kernel.org,
	sthemmin@microsoft.com
Subject: [PATCH] hv_netvsc: Make sure out channel is fully opened on send
Date: Tue, 13 Mar 2018 20:06:50 +0100
Message-Id: <1520968010-20733-1-git-send-email-mgamal@redhat.com>
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
Cc: otubo@redhat.com, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, vkuznets@redhat.com,
 Mohammed Gamal <mgamal@redhat.com>, davem@davemloft.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dring high network traffic changes to network interface parameters
such as number of channels or MTU can cause a kernel panic with a NULL
pointer dereference. This is due to netvsc_device_remove() being
called and deallocating the channel ring buffers, which can then be
accessed by netvsc_send_pkt() before they're allocated on calling
netvsc_device_add()

The patch fixes this problem by checking the channel state and returning
ENODEV if not yet opened. We also move the call to hv_ringbuf_avail_percent()
which may access the uninitialized ring buffer.

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 drivers/net/hyperv/netvsc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 0265d70..44a8358 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -757,7 +757,7 @@ static inline int netvsc_send_pkt(
 	struct netdev_queue *txq = netdev_get_tx_queue(ndev, packet->q_idx);
 	u64 req_id;
 	int ret;
-	u32 ring_avail = hv_ringbuf_avail_percent(&out_channel->outbound);
+	u32 ring_avail;
 
 	nvmsg.hdr.msg_type = NVSP_MSG1_TYPE_SEND_RNDIS_PKT;
 	if (skb)
@@ -773,7 +773,7 @@ static inline int netvsc_send_pkt(
 
 	req_id = (ulong)skb;
 
-	if (out_channel->rescind)
+	if (out_channel->rescind || out_channel->state != CHANNEL_OPENED_STATE)
 		return -ENODEV;
 
 	if (packet->page_buf_cnt) {
@@ -791,6 +791,7 @@ static inline int netvsc_send_pkt(
 				       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	}
 
+	ring_avail = hv_ringbuf_avail_percent(&out_channel->outbound);
 	if (ret == 0) {
 		atomic_inc_return(&nvchan->queue_sends);
 
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
