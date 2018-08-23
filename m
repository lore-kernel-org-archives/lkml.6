Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D80C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44573208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44573208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbeHWMhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:37:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbeHWMhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:37:37 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B1C3CBBF;
        Thu, 23 Aug 2018 09:08:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.17 301/324] EDAC: Add missing MEM_LRDDR4 entry in edac_mem_types[]
Date:   Thu, 23 Aug 2018 09:56:07 +0200
Message-Id: <20180823075011.133099876@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit b748f2de4b2f578599f46c6000683a8da755bf68 upstream.

The edac_mem_types[] array misses a MEM_LRDDR4 entry, which leads to
NULL pointer dereference when accessed via sysfs or such.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180810141426.8918-1-tiwai@suse.de
Fixes: 1e8096bb2031 ("EDAC: Add LRDDR4 DRAM type")
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/edac/edac_mc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -215,6 +215,7 @@ const char * const edac_mem_types[] = {
 	[MEM_LRDDR3]	= "Load-Reduced-DDR3-RAM",
 	[MEM_DDR4]	= "Unbuffered-DDR4",
 	[MEM_RDDR4]	= "Registered-DDR4",
+	[MEM_LRDDR4]	= "Load-Reduced-DDR4-RAM",
 	[MEM_NVDIMM]	= "Non-volatile-RAM",
 };
 EXPORT_SYMBOL_GPL(edac_mem_types);


