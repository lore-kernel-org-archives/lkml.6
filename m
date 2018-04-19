Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4067627-1524174940-2-6214328846357956655
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524174939; b=hbcloyWRpdWtKAjM/NC9Yo16pby4XFUOToLLqGxS28QFDZfzJI
    CbVQEXqsQK2GhXi6onl6QYs5zu+lxeLekwProJxcR5fA2fgk7O+MR0UeQo/7aQ0a
    LYQ8cpqQdtGFRn6BVLvKvz0hwxniEOx+DYsDQy8pxL6OoAoSJ2vsO6dEkJzNwZqH
    M/Ophg7PpTUghLQHE0C+V0shq5/3LSnnF5H+wCqMUaEj/16nhz1GkGCjJqEKHWKx
    PEfMY/XJ13KViUIx9cyFLPw3H0EP2saUfkq3Yvyp2aRTr+zaEQ50xzREuk84l3fg
    3Ljm4WHHKELczTBE7xtRmTr8hSmARiyz1Ieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524174939; bh=8sFJH
    LycSGILx7BEGPOhNYLhf2hBUhVJOuIS+lgar24=; b=c9FoWqZudSMDChNnM40Vj
    KHclgZlEIU8uFmWAVUfCZ4CRngXpjthCbQtzYffqaxIv8PsGd0OKpCc0ZsxaEps4
    BwnD/2XMQhe0MSDLcWhPCfG1MlE/8zUxMxEmgLo7K33SS76LDDsMXOh2Tqq/M5J5
    g03R6yX6jBXw+jqx1iwEw7E002Hi9ZNBO/p3lRe7wWxadat+Hm70HQWpPV9eXLrQ
    6sjFbMjtr72h2JCJjoJI6Tx3KAyZ/puGbWivNqBen12ggJdZqNmGbjuYEGRcC+Uf
    cm+yQMIDxK0tZhUpeNx6+dvIsD8ILeXyPgJ5XTnCN1Ags9+WaCxS98RGROGKQLRB
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDopdiM/CEXcgvG9aqHazcUGRfIDduAlbYulZpz4n7WQPVx1FYyF+kpPqmeBQ6E2hcf84kj+poV4YUa8CR3ZPc8tQjTtbrGdWDirLYeRFa1lLsO6MH+t
    UgsJs0A7uVdjQ8hNic2o/Gg6+s4oNtMGnFBA1qLb9F1jgylWvRfZFalIAzGuOEj9687MrymPBE1b8P6nOhAmfGqmSVszSmpYW7MGV+p9w7USaY2mTvswNxxL
    UlI2fGH7EDZnGtbNho1rWA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=jFiX1wcvl5R2h1cQFXYA:9 a=tqwxchAMySA5TfDN:21
    a=LPIneAFwcsgusYLb:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 devel@linuxdriverproject.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [Patch v2] Storvsc: Select channel based on available percentage of
 ring buffer to write
Date: Thu, 19 Apr 2018 14:54:24 -0700
Message-Id: <20180419215424.3557-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfGa+CKplF9EG47zeMOyjv6fZHvnP8RJLqS3mYMovs2GVn1PzTfQqvnWdP0s8EoXioDEzzuHdz+S1BlnBmsQQ06RkGvEpWB9Ng5dxdLfObg0NxsGIhzmS
 evwg1lftfLwSDUr4pJgnKEUYejyO6ugiPLFgGfMFkE3lzFXQZnplxH2JKLVo+T9AtlGyBfObAL8+iK9bYiWcn+pxuOamEqnZK9BsLLNDmm0BlpgpkW5FINGR
 YpqvKwpn3ku+bwcmlaIz+zUvL0mRwBFOGv2YBKCDKJw+3/IJWakSIoVRPBQEvADXXTeXng9U3ku2U424RgmGcMpm2LSBn1KkIgibCtDdqM4S978EKRGzj/OF
 JA16a/Hm8XLYvmvxKOrk+K4ovUNENnfHfr8jAQ6PoBY9TgFU+qedKd6NL6Sn00QR1o1UnS38KsVaPAiLw8Sx+wPXEA4vfQD8J6JSp3a9RH7p54UxBGFMX92Z
 GP6i7uJs0UfCIK5SbwLazqmG6OEk9lLk2kwUMI0xt9O2q932Ugpn/+7eg0w=
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

Changes.
v2: Pre-allocate struct cpumask on the heap.
Struct cpumask is a big structure (1k bytes) when CONFIG_NR_CPUS=8192 (default
value when CONFIG_MAXSMP=y). Don't use kernel stack for it by pre-allocating
them using kmalloc when channels are first initialized.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 90 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index a2ec0bc9e9fa..2a9fff94dd1a 100644
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
@@ -468,6 +474,13 @@ struct storvsc_device {
 	 * Mask of CPUs bound to subchannels.
 	 */
 	struct cpumask alloced_cpus;
+	/*
+	 * Pre-allocated struct cpumask for each hardware queue.
+	 * struct cpumask is used by selecting out-going channels. It is a
+	 * big structure, default to 1024k bytes when CONFIG_MAXSMP=y.
+	 * Pre-allocate it to avoid allocation on the kernel stack.
+	 */
+	struct cpumask *cpumask_chns;
 	/* Used for vsc/vsp channel reset process */
 	struct storvsc_cmd_request init_request;
 	struct storvsc_cmd_request reset_request;
@@ -872,6 +885,13 @@ static int storvsc_channel_init(struct hv_device *device, bool is_fc)
 	if (stor_device->stor_chns == NULL)
 		return -ENOMEM;
 
+	stor_device->cpumask_chns = kcalloc(num_possible_cpus(),
+			sizeof(struct cpumask), GFP_KERNEL);
+	if (stor_device->cpumask_chns == NULL) {
+		kfree(stor_device->stor_chns);
+		return -ENOMEM;
+	}
+
 	stor_device->stor_chns[device->channel->target_cpu] = device->channel;
 	cpumask_set_cpu(device->channel->target_cpu,
 			&stor_device->alloced_cpus);
@@ -1232,6 +1252,7 @@ static int storvsc_dev_remove(struct hv_device *device)
 	vmbus_close(device->channel);
 
 	kfree(stor_device->stor_chns);
+	kfree(stor_device->cpumask_chns);
 	kfree(stor_device);
 	return 0;
 }
@@ -1241,7 +1262,7 @@ static struct vmbus_channel *get_og_chn(struct storvsc_device *stor_device,
 {
 	u16 slot = 0;
 	u16 hash_qnum;
-	struct cpumask alloced_mask;
+	struct cpumask *alloced_mask = &stor_device->cpumask_chns[q_num];
 	int num_channels, tgt_cpu;
 
 	if (stor_device->num_sc == 0)
@@ -1257,10 +1278,10 @@ static struct vmbus_channel *get_og_chn(struct storvsc_device *stor_device,
 	 * III. Mapping is persistent.
 	 */
 
-	cpumask_and(&alloced_mask, &stor_device->alloced_cpus,
+	cpumask_and(alloced_mask, &stor_device->alloced_cpus,
 		    cpumask_of_node(cpu_to_node(q_num)));
 
-	num_channels = cpumask_weight(&alloced_mask);
+	num_channels = cpumask_weight(alloced_mask);
 	if (num_channels == 0)
 		return stor_device->device->channel;
 
@@ -1268,7 +1289,7 @@ static struct vmbus_channel *get_og_chn(struct storvsc_device *stor_device,
 	while (hash_qnum >= num_channels)
 		hash_qnum -= num_channels;
 
-	for_each_cpu(tgt_cpu, &alloced_mask) {
+	for_each_cpu(tgt_cpu, alloced_mask) {
 		if (slot == hash_qnum)
 			break;
 		slot++;
@@ -1285,9 +1306,9 @@ static int storvsc_do_io(struct hv_device *device,
 {
 	struct storvsc_device *stor_device;
 	struct vstor_packet *vstor_packet;
-	struct vmbus_channel *outgoing_channel;
+	struct vmbus_channel *outgoing_channel, *channel;
 	int ret = 0;
-	struct cpumask alloced_mask;
+	struct cpumask *alloced_mask;
 	int tgt_cpu;
 
 	vstor_packet = &request->vstor_packet;
@@ -1301,22 +1322,53 @@ static int storvsc_do_io(struct hv_device *device,
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
-			cpumask_and(&alloced_mask, &stor_device->alloced_cpus,
+			alloced_mask = &stor_device->cpumask_chns[q_num];
+			cpumask_and(alloced_mask, &stor_device->alloced_cpus,
 				    cpumask_of_node(cpu_to_node(q_num)));
-			for_each_cpu_wrap(tgt_cpu, &alloced_mask,
-					outgoing_channel->target_cpu + 1) {
-				if (tgt_cpu != outgoing_channel->target_cpu) {
-					outgoing_channel =
-					stor_device->stor_chns[tgt_cpu];
-					break;
+
+			for_each_cpu_wrap(tgt_cpu, alloced_mask, q_num + 1) {
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
+			cpumask_andnot(alloced_mask, &stor_device->alloced_cpus,
+					cpumask_of_node(cpu_to_node(q_num)));
+
+			for_each_cpu(tgt_cpu, alloced_mask) {
+				channel = stor_device->stor_chns[tgt_cpu];
+				if (hv_get_avail_to_write_percent(
+							&channel->outbound)
+						> ring_avail_percent_lowater) {
+					outgoing_channel = channel;
+					goto found_channel;
 				}
 			}
 		}
@@ -1324,7 +1376,7 @@ static int storvsc_do_io(struct hv_device *device,
 		outgoing_channel = get_og_chn(stor_device, q_num);
 	}
 
-
+found_channel:
 	vstor_packet->flags |= REQUEST_COMPLETION_FLAG;
 
 	vstor_packet->vm_srb.length = (sizeof(struct vmscsi_request) -
@@ -1732,8 +1784,9 @@ static int storvsc_probe(struct hv_device *device,
 				(num_cpus - 1) / storvsc_vcpus_per_sub_channel;
 	}
 
-	scsi_driver.can_queue = (max_outstanding_req_per_channel *
-				 (max_sub_channels + 1));
+	scsi_driver.can_queue = max_outstanding_req_per_channel *
+				(max_sub_channels + 1) *
+				(100 - ring_avail_percent_lowater) / 100;
 
 	host = scsi_host_alloc(&scsi_driver,
 			       sizeof(struct hv_host_device));
@@ -1864,6 +1917,7 @@ static int storvsc_probe(struct hv_device *device,
 
 err_out1:
 	kfree(stor_device->stor_chns);
+	kfree(stor_device->cpumask_chns);
 	kfree(stor_device);
 
 err_out0:
-- 
2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
