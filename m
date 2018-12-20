Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5432EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D785218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbeLTVZ6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:25:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:38205 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731225AbeLTVZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:25:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 13:25:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,378,1539673200"; 
   d="scan'208";a="120060044"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2018 13:25:58 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.175]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.224]) with mapi id 14.03.0415.000;
 Thu, 20 Dec 2018 13:25:57 -0800
From:   "Greensky, James J" <james.j.greensky@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Fix "perf tools: Synthesize GROUP_DESC feature in pipe mode" in the
 LT 4.14 branch
Thread-Topic: Fix "perf tools: Synthesize GROUP_DESC feature in pipe mode"
 in the LT 4.14 branch
Thread-Index: AdSYqhOOjTeuqArwRNuweSLcVqXhpQ==
Date:   Thu, 20 Dec 2018 21:25:56 +0000
Message-ID: <05BD5679F4A9234798A0693ABF94E75ADFF7F3A5@ORSMSX101.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjc1NmI2NWUtYTI3Yy00MmJmLTg4ZjYtNTE1YjdlYzA3ZThjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibFwvekYzdStkUXNQNHZ6Rm0rUW51WVhlUWt1OGlja3F0S3NCSnQzT1BVTzVXOEJqVFY4NHlHMmZBSGFcL3M5eDJBIn0=
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d38d272592737ea88a20 ("perf tools: Synthesize GROUP_DESC feature in pipe mode") broke the LT 4.14 branch when using event groups in pipe-mode.

  # perf record -e '{cycles,instructions,branches}' -- sleep 4 | perf report
  # To display the perf.data header info, please use --header/--header-only options
  #
  Oxd7c [0x60]: failed to process type: 80
  Error:
  Failed to process sample

Commit a2015516c5c0be932a69 ("perf record: Synthesize features before events in pipe mode") is the fix. Can we get this cherry-picked and applied?

