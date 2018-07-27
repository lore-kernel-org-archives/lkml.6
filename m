Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB29C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CFB208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CFB208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbeG0Nr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:47:29 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59886 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732094AbeG0Nr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:47:28 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8CB6B200017;
        Fri, 27 Jul 2018 14:25:43 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 112B820000F;
        Fri, 27 Jul 2018 14:25:43 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id 7C04540A6B;
        Fri, 27 Jul 2018 05:25:42 -0700 (MST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w6RCPbJq006998;
        Fri, 27 Jul 2018 05:25:41 -0700
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, ruxandra.radulescu@nxp.com,
        devel@driverdev.osuosl.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/2] staging: fsl-dpaa2/eth: document nested structs as per kernel-doc
Date:   Fri, 27 Jul 2018 15:24:46 +0300
Message-Id: <257414212bc41035acef09857aab27a28ade2b90.1532687535.git.ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1532687535.git.ioana.ciornei@nxp.com>
References: <cover.1532687535.git.ioana.ciornei@nxp.com>
In-Reply-To: <cover.1532687535.git.ioana.ciornei@nxp.com>
References: <cover.1532687535.git.ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document nested structs per kernel-doc requirements by moving
all comments before the actual struct.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpkg.h |  70 ++++++---------
 drivers/staging/fsl-dpaa2/ethernet/dpni.h | 145 ++++++++++++++++++------------
 2 files changed, 115 insertions(+), 100 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpkg.h b/drivers/staging/fsl-dpaa2/ethernet/dpkg.h
index 02290a0..8057a25 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpkg.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpkg.h
@@ -89,45 +89,41 @@ struct dpkg_mask {
 /**
  * struct dpkg_extract - A structure for defining a single extraction
  * @type: Determines how the union below is interpreted:
- *		DPKG_EXTRACT_FROM_HDR: selects 'from_hdr';
- *		DPKG_EXTRACT_FROM_DATA: selects 'from_data';
- *		DPKG_EXTRACT_FROM_PARSE: selects 'from_parse'
+ *	DPKG_EXTRACT_FROM_HDR: selects 'from_hdr';
+ *	DPKG_EXTRACT_FROM_DATA: selects 'from_data';
+ *	DPKG_EXTRACT_FROM_PARSE: selects 'from_parse'
  * @extract: Selects extraction method
+ * @extract.from_hdr: Used when 'type = DPKG_EXTRACT_FROM_HDR'
+ * @extract.from_data: Used when 'type = DPKG_EXTRACT_FROM_DATA'
+ * @extract.from_parse:  Used when 'type = DPKG_EXTRACT_FROM_PARSE'
+ * @extract.from_hdr.prot: Any of the supported headers
+ * @extract.from_hdr.type: Defines the type of header extraction:
+ *	DPKG_FROM_HDR: use size & offset below;
+ *	DPKG_FROM_FIELD: use field, size and offset below;
+ *	DPKG_FULL_FIELD: use field below
+ * @extract.from_hdr.field: One of the supported fields (NH_FLD_)
+ * @extract.from_hdr.size: Size in bytes
+ * @extract.from_hdr.offset: Byte offset
+ * @extract.from_hdr.hdr_index: Clear for cases not listed below;
+ *	Used for protocols that may have more than a single
+ *	header, 0 indicates an outer header;
+ *	Supported protocols (possible values):
+ *	NET_PROT_VLAN (0, HDR_INDEX_LAST);
+ *	NET_PROT_MPLS (0, 1, HDR_INDEX_LAST);
+ *	NET_PROT_IP(0, HDR_INDEX_LAST);
+ *	NET_PROT_IPv4(0, HDR_INDEX_LAST);
+ *	NET_PROT_IPv6(0, HDR_INDEX_LAST);
+ * @extract.from_data.size: Size in bytes
+ * @extract.from_data.offset: Byte offset
+ * @extract.from_parse.size: Size in bytes
+ * @extract.from_parse.offset: Byte offset
  * @num_of_byte_masks: Defines the number of valid entries in the array below;
  *		This is	also the number of bytes to be used as masks
  * @masks: Masks parameters
  */
 struct dpkg_extract {
 	enum dpkg_extract_type type;
-	/**
-	 * union extract - Selects extraction method
-	 * @from_hdr - Used when 'type = DPKG_EXTRACT_FROM_HDR'
-	 * @from_data - Used when 'type = DPKG_EXTRACT_FROM_DATA'
-	 * @from_parse - Used when 'type = DPKG_EXTRACT_FROM_PARSE'
-	 */
 	union {
-		/**
-		 * struct from_hdr - Used when 'type = DPKG_EXTRACT_FROM_HDR'
-		 * @prot: Any of the supported headers
-		 * @type: Defines the type of header extraction:
-		 *	DPKG_FROM_HDR: use size & offset below;
-		 *	DPKG_FROM_FIELD: use field, size and offset below;
-		 *	DPKG_FULL_FIELD: use field below
-		 * @field: One of the supported fields (NH_FLD_)
-		 *
-		 * @size: Size in bytes
-		 * @offset: Byte offset
-		 * @hdr_index: Clear for cases not listed below;
-		 *	Used for protocols that may have more than a single
-		 *	header, 0 indicates an outer header;
-		 *	Supported protocols (possible values):
-		 *	NET_PROT_VLAN (0, HDR_INDEX_LAST);
-		 *	NET_PROT_MPLS (0, 1, HDR_INDEX_LAST);
-		 *	NET_PROT_IP(0, HDR_INDEX_LAST);
-		 *	NET_PROT_IPv4(0, HDR_INDEX_LAST);
-		 *	NET_PROT_IPv6(0, HDR_INDEX_LAST);
-		 */
-
 		struct {
 			enum net_prot			prot;
 			enum dpkg_extract_from_hdr_type type;
@@ -136,22 +132,10 @@ struct dpkg_extract {
 			u8			offset;
 			u8			hdr_index;
 		} from_hdr;
-		/**
-		 * struct from_data - Used when 'type = DPKG_EXTRACT_FROM_DATA'
-		 * @size: Size in bytes
-		 * @offset: Byte offset
-		 */
 		struct {
 			u8 size;
 			u8 offset;
 		} from_data;
-
-		/**
-		 * struct from_parse - Used when
-		 *		       'type = DPKG_EXTRACT_FROM_PARSE'
-		 * @size: Size in bytes
-		 * @offset: Byte offset
-		 */
 		struct {
 			u8 size;
 			u8 offset;
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpni.h b/drivers/staging/fsl-dpaa2/ethernet/dpni.h
index ce86a81..36d3ec1 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpni.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpni.h
@@ -117,15 +117,12 @@ int dpni_close(struct fsl_mc_io	*mc_io,
  * @num_dpbp: Number of DPBPs
  * @pools: Array of buffer pools parameters; The number of valid entries
  *	must match 'num_dpbp' value
+ * @pools.dpbp_id: DPBP object ID
+ * @pools.buffer_size: Buffer size
+ * @pools.backup_pool: Backup pool
  */
 struct dpni_pools_cfg {
 	u8		num_dpbp;
-	/**
-	 * struct pools - Buffer pools parameters
-	 * @dpbp_id: DPBP object ID
-	 * @buffer_size: Buffer size
-	 * @backup_pool: Backup pool
-	 */
 	struct {
 		int	dpbp_id;
 		u16	buffer_size;
@@ -424,16 +421,48 @@ int dpni_get_tx_data_offset(struct fsl_mc_io	*mc_io,
 
 #define DPNI_STATISTICS_CNT		7
 
+/**
+ * union dpni_statistics - Union describing the DPNI statistics
+ * @page_0: Page_0 statistics structure
+ * @page_0.ingress_all_frames: Ingress frame count
+ * @page_0.ingress_all_bytes: Ingress byte count
+ * @page_0.ingress_multicast_frames: Ingress multicast frame count
+ * @page_0.ingress_multicast_bytes: Ingress multicast byte count
+ * @page_0.ingress_broadcast_frames: Ingress broadcast frame count
+ * @page_0.ingress_broadcast_bytes: Ingress broadcast byte count
+ * @page_1: Page_1 statistics structure
+ * @page_1.egress_all_frames: Egress frame count
+ * @page_1.egress_all_bytes: Egress byte count
+ * @page_1.egress_multicast_frames: Egress multicast frame count
+ * @page_1.egress_multicast_bytes: Egress multicast byte count
+ * @page_1.egress_broadcast_frames: Egress broadcast frame count
+ * @page_1.egress_broadcast_bytes: Egress broadcast byte count
+ * @page_2: Page_2 statistics structure
+ * @page_2.ingress_filtered_frames: Ingress filtered frame count
+ * @page_2.ingress_discarded_frames: Ingress discarded frame count
+ * @page_2.ingress_nobuffer_discards: Ingress discarded frame count due to
+ *	lack of buffers
+ * @page_2.egress_discarded_frames: Egress discarded frame count
+ * @page_2.egress_confirmed_frames: Egress confirmed frame count
+ * @page_3: Page_3 statistics structure with values for the selected TC
+ * @page_3.ceetm_dequeue_bytes: Cumulative count of the number of bytes dequeued
+ * @page_3.ceetm_dequeue_frames: Cumulative count of the number of
+ *	frames dequeued
+ * @page_3.ceetm_reject_bytes: Cumulative count of the number of bytes
+ *	in all frames whose enqueue was rejected
+ * @page_3.ceetm_reject_frames: Cumulative count of all frame enqueues rejected
+ * @page_4: congestion point drops for seleted TC
+ * @page_4.cgr_reject_frames: number of rejected frames due to congestion point
+ * @page_4.cgr_reject_bytes: number of rejected bytes due to congestion point
+ * @page_5: policer statistics per TC
+ * @page_5.policer_cnt_red: NUmber of red colored frames
+ * @page_5.policer_cnt_yellow: number of yellow colored frames
+ * @page_5.policer_cnt_green: number of green colored frames
+ * @page_5.policer_cnt_re_red: number of recolored red frames
+ * @page_5.policer_cnt_re_yellow: number of recolored yellow frames
+ * @raw: raw statistics structure, used to index counters
+ */
 union dpni_statistics {
-	/**
-	 * struct page_0 - Page_0 statistics structure
-	 * @ingress_all_frames: Ingress frame count
-	 * @ingress_all_bytes: Ingress byte count
-	 * @ingress_multicast_frames: Ingress multicast frame count
-	 * @ingress_multicast_bytes: Ingress multicast byte count
-	 * @ingress_broadcast_frames: Ingress broadcast frame count
-	 * @ingress_broadcast_bytes: Ingress broadcast byte count
-	 */
 	struct {
 		u64 ingress_all_frames;
 		u64 ingress_all_bytes;
@@ -442,15 +471,6 @@ int dpni_get_tx_data_offset(struct fsl_mc_io	*mc_io,
 		u64 ingress_broadcast_frames;
 		u64 ingress_broadcast_bytes;
 	} page_0;
-	/**
-	 * struct page_1 - Page_1 statistics structure
-	 * @egress_all_frames: Egress frame count
-	 * @egress_all_bytes: Egress byte count
-	 * @egress_multicast_frames: Egress multicast frame count
-	 * @egress_multicast_bytes: Egress multicast byte count
-	 * @egress_broadcast_frames: Egress broadcast frame count
-	 * @egress_broadcast_bytes: Egress broadcast byte count
-	 */
 	struct {
 		u64 egress_all_frames;
 		u64 egress_all_bytes;
@@ -459,15 +479,6 @@ int dpni_get_tx_data_offset(struct fsl_mc_io	*mc_io,
 		u64 egress_broadcast_frames;
 		u64 egress_broadcast_bytes;
 	} page_1;
-	/**
-	 * struct page_2 - Page_2 statistics structure
-	 * @ingress_filtered_frames: Ingress filtered frame count
-	 * @ingress_discarded_frames: Ingress discarded frame count
-	 * @ingress_nobuffer_discards: Ingress discarded frame count
-	 *				due to lack of buffers
-	 * @egress_discarded_frames: Egress discarded frame count
-	 * @egress_confirmed_frames: Egress confirmed frame count
-	 */
 	struct {
 		u64 ingress_filtered_frames;
 		u64 ingress_discarded_frames;
@@ -475,9 +486,6 @@ int dpni_get_tx_data_offset(struct fsl_mc_io	*mc_io,
 		u64 egress_discarded_frames;
 		u64 egress_confirmed_frames;
 	} page_2;
-	/**
-	 * struct raw - raw statistics structure
-	 */
 	struct {
 		u64 counter[DPNI_STATISTICS_CNT];
 	} raw;
@@ -685,29 +693,52 @@ enum dpni_dest {
 
 /**
  * struct dpni_queue - Queue structure
- * @user_context: User data, presented to the user along with any frames from
- *		this queue. Not relevant for Tx queues.
- */
-struct dpni_queue {
-/**
- * struct destination - Destination structure
- * @id: ID of the destination, only relevant if DEST_TYPE is > 0.
- *		Identifies either a DPIO or a DPCON object. Not relevant for
- *		Tx queues.
- * @type: May be one of the following:
- *	0 - No destination, queue can be manually queried, but will not
- *		push traffic or notifications to a DPIO;
- *	1 - The destination is a DPIO. When traffic becomes available in
- *		the queue a FQDAN (FQ data available notification) will be
+ * @destination - Destination structure
+ * @destination.id: ID of the destination, only relevant if DEST_TYPE is > 0.
+ *	Identifies either a DPIO or a DPCON object.
+ *	Not relevant for Tx queues.
+ * @destination.type:	May be one of the following:
+ *	0 - No destination, queue can be manually
+ *		queried, but will not push traffic or
+ *		notifications to a DPIO;
+ *	1 - The destination is a DPIO. When traffic
+ *		becomes available in the queue a FQDAN
+ *		(FQ data available notification) will be
  *		generated to selected DPIO;
- *	2 - The destination is a DPCON. The queue is associated with a
- *		DPCON object for the purpose of scheduling between multiple
- *		queues. The DPCON may be independently configured to
- *		generate notifications. Not relevant for Tx queues.
- * @hold_active: Hold active, maintains a queue scheduled for longer
- *		in a DPIO during dequeue to reduce spread of traffic.
- *		Only relevant if queues are not affined to a single DPIO.
+ *	2 - The destination is a DPCON. The queue is
+ *		associated with a DPCON object for the
+ *		purpose of scheduling between multiple
+ *		queues. The DPCON may be independently
+ *		configured to generate notifications.
+ *		Not relevant for Tx queues.
+ * @destination.hold_active: Hold active, maintains a queue scheduled for longer
+ *	in a DPIO during dequeue to reduce spread of traffic.
+ *	Only relevant if queues are
+ *	not affined to a single DPIO.
+ * @user_context: User data, presented to the user along with any frames
+ *	from this queue. Not relevant for Tx queues.
+ * @flc: FD FLow Context structure
+ * @flc.value: Default FLC value for traffic dequeued from
+ *      this queue.  Please check description of FD
+ *      structure for more information.
+ *      Note that FLC values set using dpni_add_fs_entry,
+ *      if any, take precedence over values per queue.
+ * @flc.stash_control: Boolean, indicates whether the 6 lowest
+ *      - significant bits are used for stash control.
+ *      significant bits are used for stash control.  If set, the 6
+ *      least significant bits in value are interpreted as follows:
+ *      - bits 0-1: indicates the number of 64 byte units of context
+ *      that are stashed.  FLC value is interpreted as a memory address
+ *      in this case, excluding the 6 LS bits.
+ *      - bits 2-3: indicates the number of 64 byte units of frame
+ *      annotation to be stashed.  Annotation is placed at FD[ADDR].
+ *      - bits 4-5: indicates the number of 64 byte units of frame
+ *      data to be stashed.  Frame data is placed at FD[ADDR] +
+ *      FD[OFFSET].
+ *      For more details check the Frame Descriptor section in the
+ *      hardware documentation.
  */
+struct dpni_queue {
 	struct {
 		u16 id;
 		enum dpni_dest type;
-- 
1.9.1

