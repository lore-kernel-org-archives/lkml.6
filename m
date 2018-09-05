Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C99AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D042075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D042075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeIEU0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:26:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbeIEU0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:26:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A1857DAC2;
        Wed,  5 Sep 2018 15:55:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7308D2027EB7;
        Wed,  5 Sep 2018 15:55:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/11] UAPI: sound: Fix use of u32 and co. in UAPI headers
From:   David Howells <dhowells@redhat.com>
To:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 05 Sep 2018 16:55:30 +0100
Message-ID: <153616293089.23468.13515059526628668970.stgit@warthog.procyon.org.uk>
In-Reply-To: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 05 Sep 2018 15:55:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 05 Sep 2018 15:55:32 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the use of u32 and co. in UAPI headers as these are not defined.  Switch
to using the __u32-style equivalents instead.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jaroslav Kysela <perex@perex.cz>
cc: Takashi Iwai <tiwai@suse.com>
cc: alsa-devel@alsa-project.org (moderated for non-subscribers)
---

 include/uapi/sound/skl-tplg-interface.h |  106 ++++++++++++++++---------------
 1 file changed, 54 insertions(+), 52 deletions(-)

diff --git a/include/uapi/sound/skl-tplg-interface.h b/include/uapi/sound/skl-tplg-interface.h
index f58cafa42f18..f39352cef382 100644
--- a/include/uapi/sound/skl-tplg-interface.h
+++ b/include/uapi/sound/skl-tplg-interface.h
@@ -10,6 +10,8 @@
 #ifndef __HDA_TPLG_INTERFACE_H__
 #define __HDA_TPLG_INTERFACE_H__
 
+#include <linux/types.h>
+
 /*
  * Default types range from 0~12. type can range from 0 to 0xff
  * SST types start at higher to avoid any overlapping in future
@@ -143,10 +145,10 @@ enum skl_module_param_type {
 };
 
 struct skl_dfw_algo_data {
-	u32 set_params:2;
-	u32 rsvd:30;
-	u32 param_id;
-	u32 max;
+	__u32 set_params:2;
+	__u32 rsvd:30;
+	__u32 param_id;
+	__u32 max;
 	char params[0];
 } __packed;
 
@@ -163,68 +165,68 @@ enum skl_tuple_type {
 /* v4 configuration data */
 
 struct skl_dfw_v4_module_pin {
-	u16 module_id;
-	u16 instance_id;
+	__u16 module_id;
+	__u16 instance_id;
 } __packed;
 
 struct skl_dfw_v4_module_fmt {
-	u32 channels;
-	u32 freq;
-	u32 bit_depth;
-	u32 valid_bit_depth;
-	u32 ch_cfg;
-	u32 interleaving_style;
-	u32 sample_type;
-	u32 ch_map;
+	__u32 channels;
+	__u32 freq;
+	__u32 bit_depth;
+	__u32 valid_bit_depth;
+	__u32 ch_cfg;
+	__u32 interleaving_style;
+	__u32 sample_type;
+	__u32 ch_map;
 } __packed;
 
 struct skl_dfw_v4_module_caps {
-	u32 set_params:2;
-	u32 rsvd:30;
-	u32 param_id;
-	u32 caps_size;
-	u32 caps[HDA_SST_CFG_MAX];
+	__u32 set_params:2;
+	__u32 rsvd:30;
+	__u32 param_id;
+	__u32 caps_size;
+	__u32 caps[HDA_SST_CFG_MAX];
 } __packed;
 
 struct skl_dfw_v4_pipe {
-	u8 pipe_id;
-	u8 pipe_priority;
-	u16 conn_type:4;
-	u16 rsvd:4;
-	u16 memory_pages:8;
+	__u8 pipe_id;
+	__u8 pipe_priority;
+	__u16 conn_type:4;
+	__u16 rsvd:4;
+	__u16 memory_pages:8;
 } __packed;
 
 struct skl_dfw_v4_module {
 	char uuid[SKL_UUID_STR_SZ];
 
-	u16 module_id;
-	u16 instance_id;
-	u32 max_mcps;
-	u32 mem_pages;
-	u32 obs;
-	u32 ibs;
-	u32 vbus_id;
-
-	u32 max_in_queue:8;
-	u32 max_out_queue:8;
-	u32 time_slot:8;
-	u32 core_id:4;
-	u32 rsvd1:4;
-
-	u32 module_type:8;
-	u32 conn_type:4;
-	u32 dev_type:4;
-	u32 hw_conn_type:4;
-	u32 rsvd2:12;
-
-	u32 params_fixup:8;
-	u32 converter:8;
-	u32 input_pin_type:1;
-	u32 output_pin_type:1;
-	u32 is_dynamic_in_pin:1;
-	u32 is_dynamic_out_pin:1;
-	u32 is_loadable:1;
-	u32 rsvd3:11;
+	__u16 module_id;
+	__u16 instance_id;
+	__u32 max_mcps;
+	__u32 mem_pages;
+	__u32 obs;
+	__u32 ibs;
+	__u32 vbus_id;
+
+	__u32 max_in_queue:8;
+	__u32 max_out_queue:8;
+	__u32 time_slot:8;
+	__u32 core_id:4;
+	__u32 rsvd1:4;
+
+	__u32 module_type:8;
+	__u32 conn_type:4;
+	__u32 dev_type:4;
+	__u32 hw_conn_type:4;
+	__u32 rsvd2:12;
+
+	__u32 params_fixup:8;
+	__u32 converter:8;
+	__u32 input_pin_type:1;
+	__u32 output_pin_type:1;
+	__u32 is_dynamic_in_pin:1;
+	__u32 is_dynamic_out_pin:1;
+	__u32 is_loadable:1;
+	__u32 rsvd3:11;
 
 	struct skl_dfw_v4_pipe pipe;
 	struct skl_dfw_v4_module_fmt in_fmt[MAX_IN_QUEUE];

