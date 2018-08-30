Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07129C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A896720658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dTqxgia5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A896720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeH3QVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:21:05 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48092 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeH3QVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:21:05 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7UCInGl002438;
        Thu, 30 Aug 2018 07:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535631529;
        bh=KI1K/VxJfFcHIOohYRAOblrsuKIOmy9Dr6P+VeCw0Oo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dTqxgia5EpqpDla/DvWaWXTXByCebiKEPYTMrL5qOsGpVhOd5HUj+L1Z7F+ZLqhTM
         fGIgJaq2/suqPYMernSmJjxw1ETBIHy5nYyePosLmCqDgL35MHpBQnO0swiKkluuhU
         Pv0qTr6cHg3zNyGcPQQlYoRFjyTDh1gMiUQAv4TY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7UCInkA010102;
        Thu, 30 Aug 2018 07:18:49 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 30
 Aug 2018 07:18:49 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 30 Aug 2018 07:18:49 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7UCIhK1019829;
        Thu, 30 Aug 2018 07:18:47 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <radheys@xilinx.com>
Subject: [PATCH v2 2/2] dmaengine: doc: Add sections for per descriptor metadata support
Date:   Thu, 30 Aug 2018 15:19:10 +0300
Message-ID: <20180830121910.16005-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830121910.16005-1-peter.ujfalusi@ti.com>
References: <20180830121910.16005-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the provider and client documentation with details about the
metadata support.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/driver-api/dmaengine/client.rst | 70 +++++++++++++++++++
 .../driver-api/dmaengine/provider.rst         | 46 ++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index fbbb2831f29f..584a39347cfe 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -151,6 +151,76 @@ The details of these operations are:
      Note that callbacks will always be invoked from the DMA
      engines tasklet, never from interrupt context.
 
+  Optional: per descriptor metadata
+  ---------------------------------
+  DMAengine provides two ways for metadata support.
+
+  DESC_METADATA_CLIENT
+
+    The metadata buffer is allocated/provided by the client driver and it is
+    attached to the descriptor.
+
+  .. code-block:: c
+
+     int dmaengine_desc_attach_metadata(struct dma_async_tx_descriptor *desc,
+				   void *data, size_t len);
+
+  DESC_METADATA_ENGINE
+
+    The metadata buffer is allocated/managed by the DMA driver. The client
+    driver can ask for the pointer, maximum size and the currently used size of
+    the metadata and can directly update or read it.
+
+  .. code-block:: c
+
+     void *dmaengine_desc_get_metadata_ptr(struct dma_async_tx_descriptor *desc,
+		size_t *payload_len, size_t *max_len);
+
+     int dmaengine_desc_set_metadata_len(struct dma_async_tx_descriptor *desc,
+		size_t payload_len);
+
+  Client drivers can query if a given mode is supported with:
+
+  .. code-block:: c
+
+     bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
+		enum dma_desc_metadata_mode mode);
+
+  Depending on the used mode client drivers must follow different flow.
+
+  DESC_METADATA_CLIENT
+
+    - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
+      1. prepare the descriptor (dmaengine_prep_*)
+         construct the metadata in the client's buffer
+      2. use dmaengine_desc_attach_metadata() to attach the buffer to the
+         descriptor
+      3. submit the transfer
+    - DMA_DEV_TO_MEM:
+      1. prepare the descriptor (dmaengine_prep_*)
+      2. use dmaengine_desc_attach_metadata() to attach the buffer to the
+         descriptor
+      3. submit the transfer
+      4. when the transfer is completed, the metadata should be available in the
+         attached buffer
+
+  DESC_METADATA_ENGINE
+
+    - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
+      1. prepare the descriptor (dmaengine_prep_*)
+      2. use dmaengine_desc_get_metadata_ptr() to get the pointer to the
+         engine's metadata area
+      3. update the metadata at the pointer
+      4. use dmaengine_desc_set_metadata_len()  to tell the DMA engine the
+         amount of data the client has placed into the metadata buffer
+      5. submit the transfer
+    - DMA_DEV_TO_MEM:
+      1. prepare the descriptor (dmaengine_prep_*)
+      2. submit the transfer
+      3. on transfer completion, use dmaengine_desc_get_metadata_ptr() to get the
+         pointer to the engine's metadata are
+      4. Read out the metadate from the pointer
+
 4. Submit the transaction
 
    Once the descriptor has been prepared and the callback information
diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index dfc4486b5743..502c59f75302 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -247,6 +247,52 @@ after each transfer. In case of a ring buffer, they may loop
 (DMA_CYCLIC). Addresses pointing to a device's register (e.g. a FIFO)
 are typically fixed.
 
+Per descriptor metadata support
+-------------------------------
+Some data movement architecure (DMA controller and peripherals) uses metadata
+associated with a transaction. The DMA controller role is to transfer the
+payload and the metadata alongside.
+The metadata itself is not used by the DMA engine itself, but it contains
+parameters, keys, vectors, etc for peripheral or from the peripheral.
+
+The DMAengine framework provides a generic ways to facilitate the metadata for
+descriptors. Depending on the architecture the DMA driver can implment either
+or both of the methods and it is up to the client driver to choose which one
+to use.
+
+- DESC_METADATA_CLIENT
+
+  The metadata buffer is allocated/provided by the client driver and it is
+  attached (via the dmaengine_desc_attach_metadata() helper to the descriptor.
+
+  From the DMA driver the following is expected for this mode:
+  - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM
+    The data from the provided metadata buffer should be prepared for the DMA
+    controller to be sent alongside of the payload data. Either by copying to a
+    hardware descriptor, or highly coupled packet.
+  - DMA_DEV_TO_MEM
+    On transfer completion the DMA driver must copy the metadata to the client
+    provided metadata buffer.
+
+- DESC_METADATA_ENGINE
+
+  The metadata buffer is allocated/managed by the DMA driver. The client driver
+  can ask for the pointer, maximum size and the currently used size of the
+  metadata and can directly update or read it. dmaengine_desc_get_metadata_ptr()
+  and dmaengine_desc_set_metadata_len() is provided as helper functions.
+
+  From the DMA driver the following is expected for this mode:
+  - get_metadata_ptr
+    Should return a pointer for the metadata buffer, the maximum size of the
+    metadata buffer and the currently used / valid (if any) bytes in the buffer.
+  - set_metadata_len
+    It is called by the clients after it have placed the metadata to the buffer
+    to let the DMA driver know the number of valid bytes provided.
+
+  Note: since the client will ask for the metadata pointer in the completion
+  callback (in DMA_DEV_TO_MEM case) the DMA driver must ensure that the
+  descriptor is not freed up prior the callback is called.
+
 Device operations
 -----------------
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

