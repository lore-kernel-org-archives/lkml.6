Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9D3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AE8206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AE8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbeGSGtg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:49:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:46957 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbeGSGtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:49:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 23:08:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,373,1526367600"; 
   d="scan'208";a="76003265"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2018 23:08:09 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 18 Jul 2018 23:08:09 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.81]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.100]) with mapi id 14.03.0319.002;
 Thu, 19 Jul 2018 14:08:07 +0800
From:   "Zhang, Jun" <jun.zhang@intel.com>
To:     Takashi Iwai <tiwai@suse.de>, "He, Bo" <bo.he@intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: RE: [PATCH] ALSA: core: fix unsigned int pages overflow when
 comapred
Thread-Topic: [PATCH] ALSA: core: fix unsigned int pages overflow when
 comapred
Thread-Index: AdQejWjk55iqWVRYS2+apgz1v2Viqv//hmgA//5dnoA=
Date:   Thu, 19 Jul 2018 06:08:06 +0000
Message-ID: <88DC34334CA3444C85D647DBFA962C272B0C4C34@SHSMSX104.ccr.corp.intel.com>
References: <CD6925E8781EFD4D8E11882D20FC406D52980C51@SHSMSX104.ccr.corp.intel.com>
 <s5hpnzkbu3v.wl-tiwai@suse.de>
In-Reply-To: <s5hpnzkbu3v.wl-tiwai@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTYxY2I2MzQtMDMyNi00NTRmLWEwZDktOGY5ZjcyNjM3ZTRkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ1NMQmxcL1lERzlkRjJibXRSM1FTemNBN252ZTRpMVZveDRtOTBGZlA1VlBPc0ZFb3RNVStKNVd1QWFzcUdaTkwifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Takashi

I think use our patch, it's NOT possible that the returned size is over sgbuf->tblsize.

In function snd_malloc_sgbuf_pages, 

Pages is align page,
sgbuf->tblsize is align 32*page,
chunk is align 2^n*page,

in our panic case, pages = 123, tlbsize = 128,  
1st loop trunk = 32
2nd loop trunk = 32
3rd loop trunk = 32
4th loop trunk = 16
5th loop trunk = 16
So in 5th loop pages-trunk = -5, which make dead loop. 

Use our patch , in 5th loop,  while is break.  Returned size could NOT be over sgbuf->tblsize.

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Wednesday, July 18, 2018 20:34
To: He, Bo <bo.he@intel.com>
Cc: alsa-devel@alsa-project.org; perex@perex.cz; linux-kernel@vger.kernel.org; Zhang, Jun <jun.zhang@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>
Subject: Re: [PATCH] ALSA: core: fix unsigned int pages overflow when comapred

On Wed, 18 Jul 2018 13:52:45 +0200,
 He, Bo  wrote:
> 
> we see the below kernel panic on stress suspend resume test in 
> snd_malloc_sgbuf_pages(), snd_dma_alloc_pages_fallback() alloc chunk 
> maybe larger than the left pages due to the pages alignment, which 
> will cause the pages overflow.
> 
> while (pages > 0) {
> 	...
> 	pages -= chunk;
> }
> 
> the patch is change the pages from unsigned int to int to fix the issue.

Thanks for the patch.

Although the analysis is correct, the fix doesn't look ideal.  It's also possible that the returned size may over sgbuf->tblsize if we are more unlucky.

A change like below should work instead.  Could you give it a try?


Takashi

-- 8< --
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -108,7 +108,7 @@ void *snd_malloc_sgbuf_pages(struct device *device,
 			break;
 		}
 		chunk = tmpb.bytes >> PAGE_SHIFT;
-		for (i = 0; i < chunk; i++) {
+		for (i = 0; i < chunk && pages > 0; i++) {
 			table->buf = tmpb.area;
 			table->addr = tmpb.addr;
 			if (!i)
@@ -117,9 +117,9 @@ void *snd_malloc_sgbuf_pages(struct device *device,
 			*pgtable++ = virt_to_page(tmpb.area);
 			tmpb.area += PAGE_SIZE;
 			tmpb.addr += PAGE_SIZE;
+			sgbuf->pages++;
+			pages--;
 		}
-		sgbuf->pages += chunk;
-		pages -= chunk;
 		if (chunk < maxpages)
 			maxpages = chunk;
 	}
