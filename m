Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-875866-1522198237-2-16646138795339447996
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522198236; b=TM/Vh1F7eJJXyX88G1As0yoaTTIo/NRTpnlz1i1Ogc+PEbL
    gt4sXF+qpUrVoiQ5nk8fFMPO98xKgrGaeI56IYwQuPXlhhynDE7lMt/9rbb8UPjp
    nHt1ZFBFNZfNPExI/5R1LYvRv+frqH3pVHxTck0Zho9/aunAn+NFXNFfv7eNRQvc
    fXa8S3k4UJIU9+fLKQLyrUIOCxK2IUOEHCBjpMy2Kuu31sZ9oJTTj/p5muBAGus1
    +f9xUyVTHjG8LIf6cvyvwVx16VgTdxrvE2Tzzn5W4KXC7aYeKFGY4wyr6Pl70/G/
    6bVo0PWEIAywDYby9ktg2ti5b6CaNy4pmACNtjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1522198236; bh=aMs0hMvXzybEiHVO/QruXvITKc+EZAFbIs4NrIsawYQ=; b=F
    M/Y2HbzhItJUKv/mAkfGJNBbDT4QPRcOvAKvLdfDwNtS6kU0+SjW1mug2R+RSufT
    v0Aj4gKB31iqruJTNEoJLe0YyWCt/eXb/lc0ked7+i3kzXTPvXsQiN80j5erPjfj
    HLoYf4U/zeROKS/RwOYaerHFfDyIIsQCFKQR/8P9n30V2pfM/S4Pmci7CwTcJ3La
    e7RvF5Iuco3kHpEMY+Y/yQkx++mJn8gCuyi9HHMBAENrCgtsdoXl+dQeTdadlWF6
    nJODhep70FdreZvCK0AbPbAL/Uh6olGkO/U7kboCoA638i48+aEEXDqq4SX67W+k
    QNW8oZAW/g2598TBbKbxA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJnjM4JDJmck4yqOE4MoJ+G+kDEm/A8QwJNUyb4LXWynJGHhAurKHuMCjTLNTzkuwEONkSoiycQpZVD4QS2R846P7Vy/8JwYN6tbm5gs7851H9vRXGuO
    cjxqLIVob5jTmz4IzS3nmvuwPKjQQlmpxbPstcf+1t8MvFBwmerjWrb6ZXNgvwyvCutYXXa3np+BHKi6+VmX24DoDz9D0IJ4eHxEeHzSSGq5ki1n0rML5Dzb
    MhkEx+2gXJRQ2rcoZrLusw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=nKaLVir8sh6nB0FC6ckA:9 a=D4lcUoAsrY7zuy1x:21
    a=08yL0zhtOMN8x4om:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 devel@linuxdriverproject.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [Resend Patch 3/3] Storvsc: Select channel based on available
 percentage of ring buffer to write
Date: Tue, 27 Mar 2018 17:48:40 -0700
Message-Id: <20180328004840.22787-3-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180328004840.22787-1-longli@linuxonhyperv.com>
References: <20180328004840.22787-1-longli@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfOqt0U6DMuw2squMTZaArkKECmNWam4EVYhW808ODW5TSznVQD33wvBBYBtX77YkLE7q5SwoJfptZBHc5f0ivHthI/EsqY31ykDieNLeHsfIrf58iu2o
 pM8SfUZgzM9H7dUenQOqKYrxaDLC/AshWvzE1UwRMlpkiUo7/RF6O2+y750Rba5oHp682RTQsDJwK8epWUeC9Bkfi0PgSpNtyRY0hxtnA29J1aIJXxMKAbkT
 eGC4c+kfWybELV2vdu8G/jVWB5eF0qF/IcyO3Fv8LQcj27AOlkmLlRBeyw3ouM4f/dC+qZhV2FwtJpG3/EVK4qzoM16GIHmiURKuSaASYx2vAgO8536gLdA8
 URo+RJuus1AbDNT4ufHIHeBIdAf5JOyblrgOhPeFKl0H1rW2hWuILUUyROr2uNHFS2gSAF3U4hnYdrQkn1cvOMb+VyCI+d1YhdVKThIMyikABII3NkEnftZF
 xw8d3UXSj9R2/mZAy77BqLZDq9sp+nrQVCrg3rD4LIE3cKm/H8a9d4gTrX640ashbPM4mDd/H1v8MYOt
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
Reply-To: longli@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

This is a best effort for estimating on how busy the ring buffer is for
that channel, based on available buffer to write in percentage. It is still
possible that at the time of actual ring buffer write, the space may not be
available due to other processes may be writing at the time.

Selecting a channel based on how full it is can reduce the possibility that
a ring buffer write will fail, and avoid the situation a channel is over
busy.

Now it's possible that storvsc can use a smaller ring buffer size
(e.g. 40k bytes) to take advantage of cache locality.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 62 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index a2ec0bc9e9fa..b1a87072b3ab 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -395,6 +395,12 @@ MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
 
 module_param(storvsc_vcpus_per_sub_channel, int, S_IRUGO);
 MODULE_PARM_DESC(storvsc_vcpus_per_sub_channel, "Ratio of VCPUs to subchannels");
+
+static int ring_avail_percent_lowater = 10;
+module_param(ring_avail_percent_lowater, int, S_IRUGO);
+MODULE_PARM_DESC(ring_avail_percent_lowater,
+		"Select a channel if available ring size > this in percent");
+
 /*
  * Timeout in seconds for all devices managed by this driver.
  */
@@ -1285,9 +1291,9 @@ static int storvsc_do_io(struct hv_device *device,
 {
 	struct storvsc_device *stor_device;
 	struct vstor_packet *vstor_packet;
-	struct vmbus_channel *outgoing_channel;
+	struct vmbus_channel *outgoing_channel, *channel;
 	int ret = 0;
-	struct cpumask alloced_mask;
+	struct cpumask alloced_mask, other_numa_mask;
 	int tgt_cpu;
 
 	vstor_packet = &request->vstor_packet;
@@ -1301,22 +1307,53 @@ static int storvsc_do_io(struct hv_device *device,
 	/*
 	 * Select an an appropriate channel to send the request out.
 	 */
-
 	if (stor_device->stor_chns[q_num] != NULL) {
 		outgoing_channel = stor_device->stor_chns[q_num];
-		if (outgoing_channel->target_cpu == smp_processor_id()) {
+		if (outgoing_channel->target_cpu == q_num) {
 			/*
 			 * Ideally, we want to pick a different channel if
 			 * available on the same NUMA node.
 			 */
 			cpumask_and(&alloced_mask, &stor_device->alloced_cpus,
 				    cpumask_of_node(cpu_to_node(q_num)));
-			for_each_cpu_wrap(tgt_cpu, &alloced_mask,
-					outgoing_channel->target_cpu + 1) {
-				if (tgt_cpu != outgoing_channel->target_cpu) {
-					outgoing_channel =
-					stor_device->stor_chns[tgt_cpu];
-					break;
+
+			for_each_cpu_wrap(tgt_cpu, &alloced_mask, q_num + 1) {
+				if (tgt_cpu == q_num)
+					continue;
+				channel = stor_device->stor_chns[tgt_cpu];
+				if (hv_get_avail_to_write_percent(
+							&channel->outbound)
+						> ring_avail_percent_lowater) {
+					outgoing_channel = channel;
+					goto found_channel;
+				}
+			}
+
+			/*
+			 * All the other channels on the same NUMA node are
+			 * busy. Try to use the channel on the current CPU
+			 */
+			if (hv_get_avail_to_write_percent(
+						&outgoing_channel->outbound)
+					> ring_avail_percent_lowater)
+				goto found_channel;
+
+			/*
+			 * If we reach here, all the channels on the current
+			 * NUMA node are busy. Try to find a channel in
+			 * other NUMA nodes
+			 */
+			cpumask_andnot(&other_numa_mask,
+					&stor_device->alloced_cpus,
+					cpumask_of_node(cpu_to_node(q_num)));
+
+			for_each_cpu(tgt_cpu, &other_numa_mask) {
+				channel = stor_device->stor_chns[tgt_cpu];
+				if (hv_get_avail_to_write_percent(
+							&channel->outbound)
+						> ring_avail_percent_lowater) {
+					outgoing_channel = channel;
+					goto found_channel;
 				}
 			}
 		}
@@ -1324,7 +1361,7 @@ static int storvsc_do_io(struct hv_device *device,
 		outgoing_channel = get_og_chn(stor_device, q_num);
 	}
 
-
+found_channel:
 	vstor_packet->flags |= REQUEST_COMPLETION_FLAG;
 
 	vstor_packet->vm_srb.length = (sizeof(struct vmscsi_request) -
@@ -1733,7 +1770,8 @@ static int storvsc_probe(struct hv_device *device,
 	}
 
 	scsi_driver.can_queue = (max_outstanding_req_per_channel *
-				 (max_sub_channels + 1));
+				 (max_sub_channels + 1)) *
+				 (100 - ring_avail_percent_lowater) / 100;
 
 	host = scsi_host_alloc(&scsi_driver,
 			       sizeof(struct hv_host_device));
-- 
2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
