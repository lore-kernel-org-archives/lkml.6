Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F9EC4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D4821C1A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D4821C1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeHIFTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 01:19:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:36101 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbeHIFTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 01:19:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 19:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,213,1531810800"; 
   d="scan'208";a="75011782"
Received: from sofia.sh.intel.com (HELO sofia) ([10.239.147.112])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2018 19:56:27 -0700
Date:   Thu, 9 Aug 2018 10:55:37 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     broonie@opensource.wolfsonmicro.com, rostedt@goodmis.org,
        mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        changcheng.liu@intel.com
Subject: [PATCH v2 1/2] ASoC: trace: remove unnecessary typecast
Message-ID: <20180809025537.GE161967@sofia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to do typecast since the defined type matches the output
fromat requirement.

Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 40c300f..bf17edc 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -32,7 +32,7 @@ DECLARE_EVENT_CLASS(snd_soc_card,
 		__entry->val = val;
 	),
 
-	TP_printk("card=%s val=%d", __get_str(name), (int)__entry->val)
+	TP_printk("card=%s val=%d", __get_str(name), __entry->val)
 );
 
 DEFINE_EVENT(snd_soc_card, snd_soc_bias_level_start,
@@ -101,7 +101,7 @@ DECLARE_EVENT_CLASS(snd_soc_dapm_widget,
 	),
 
 	TP_printk("widget=%s val=%d", __get_str(name),
-		  (int)__entry->val)
+		__entry->val)
 );
 
 DEFINE_EVENT(snd_soc_dapm_widget, snd_soc_dapm_widget_power,
@@ -149,8 +149,8 @@ TRACE_EVENT(snd_soc_dapm_walk_done,
 	),
 
 	TP_printk("%s: checks %d power, %d path, %d neighbour",
-		  __get_str(name), (int)__entry->power_checks,
-		  (int)__entry->path_checks, (int)__entry->neighbour_checks)
+		__get_str(name), __entry->power_checks,
+		__entry->path_checks, __entry->neighbour_checks)
 );
 
 TRACE_EVENT(snd_soc_dapm_path,
@@ -180,8 +180,7 @@ TRACE_EVENT(snd_soc_dapm_path,
 	),
 
 	TP_printk("%c%s %s %s %s %s",
-		(int) __entry->path_node &&
-		(int) __entry->path_connect ? '*' : ' ',
+		__entry->path_node && __entry->path_connect ? '*' : ' ',
 		__get_str(wname), DAPM_ARROW(__entry->path_dir),
 		__get_str(pname), DAPM_ARROW(__entry->path_dir),
 		__get_str(pnname))
@@ -242,8 +241,8 @@ TRACE_EVENT(snd_soc_jack_report,
 		__entry->val = val;
 	),
 
-	TP_printk("jack=%s %x/%x", __get_str(name), (int)__entry->val,
-		  (int)__entry->mask)
+	TP_printk("jack=%s %x/%x", __get_str(name), __entry->val,
+		__entry->mask)
 );
 
 TRACE_EVENT(snd_soc_jack_notify,
@@ -262,7 +261,7 @@ TRACE_EVENT(snd_soc_jack_notify,
 		__entry->val = val;
 	),
 
-	TP_printk("jack=%s %x", __get_str(name), (int)__entry->val)
+	TP_printk("jack=%s %x", __get_str(name), __entry->val)
 );
 
 #endif /* _TRACE_ASOC_H */
-- 
2.7.4

