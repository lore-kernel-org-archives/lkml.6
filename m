Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A5FECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC1C204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC1C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbeGSSco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:32:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:33727 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732150AbeGSScn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:32:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 10:48:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,375,1526367600"; 
   d="scan'208";a="59021659"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga006.jf.intel.com with ESMTP; 19 Jul 2018 10:48:29 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fgD2S-000Kx6-N2; Fri, 20 Jul 2018 01:48:28 +0800
Date:   Fri, 20 Jul 2018 01:48:10 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc:     kbuild-all@01.org, tiwai@suse.de, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] ALSA: usb-audio: snd_usb_add_audio_stream_v3() can be
 static
Message-ID: <20180719174810.GA74610@lkp-hsx03>
References: <20180719112215.4219-3-jorge.sanjuan@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719112215.4219-3-jorge.sanjuan@codethink.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 69abc040c878 ("ALSA: usb-audio: AudioStreaming Power Domain parsing")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 stream.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 031878a..c0567fa1 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -559,10 +559,10 @@ int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 	return __snd_usb_add_audio_stream(chip, stream, fp, NULL);
 }
 
-int snd_usb_add_audio_stream_v3(struct snd_usb_audio *chip,
-				int stream,
-				struct audioformat *fp,
-				struct snd_usb_power_domain *pd)
+static int snd_usb_add_audio_stream_v3(struct snd_usb_audio *chip,
+				       int stream,
+				       struct audioformat *fp,
+				       struct snd_usb_power_domain *pd)
 {
 	return __snd_usb_add_audio_stream(chip, stream, fp, pd);
 }
