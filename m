Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A4C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCED2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfABUzB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:55:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:52603 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfABUzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:55:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 12:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,432,1539673200"; 
   d="scan'208";a="122860582"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jan 2019 12:55:00 -0800
Received: from orsmsx106.amr.corp.intel.com ([169.254.1.152]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.191]) with mapi id 14.03.0415.000;
 Wed, 2 Jan 2019 12:54:59 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        "Pathan, Arshiya Hayatkhan" <arshiya.hayatkhan.pathan@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 08/10] selftests/resctrl Add Cache QoS Monitoring
 (CQM) selftest
Thread-Topic: [PATCH v4 08/10] selftests/resctrl Add Cache QoS Monitoring
 (CQM) selftest
Thread-Index: AQHUmY0E7PbQrfGorE+0Ns6hcp2JeKWdA1YA//+CyeA=
Date:   Wed, 2 Jan 2019 20:54:59 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C71220985C2046@ORSMSX106.amr.corp.intel.com>
References: <1545438038-75107-1-git-send-email-fenghua.yu@intel.com>
 <1545438038-75107-9-git-send-email-fenghua.yu@intel.com>
 <ea7b91f7-aadc-c26a-f616-e400b5e4cf2d@amd.com>
In-Reply-To: <ea7b91f7-aadc-c26a-f616-e400b5e4cf2d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWMyZThhNTMtYmRlYi00OGM3LWFlMTktNmMwMzI0ZDM1M2RmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZndHKzd5S3Ztb1wvNlMrazFnQ2tuK2NVeXdqQkRYVVlUMFBlaUNRVFh6RGMrRTh2U0J1WldCa0tneVdSdWM3M1YifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Moger, Babu [mailto:Babu.Moger@amd.com]
>   for (int i = 0; i < argc; i++) {
>            ^
> resctrl_tests.c:39:56: note: previous declaration of 'i' was here
>   int res, c, core_id = 1, span = 250, argc_new = argc, i, no_of_bits = 5;
>                                                         ^
> resctrl_tests.c:46:2: error: 'for' loop initial declarations are only allowed in
> C99 mode
>   for (int i = 0; i < argc; i++) {
>   ^
> resctrl_tests.c:46:2: note: use option -std=c99 or -std=gnu99 to compile your
> code

Sure. Will fix this.

Thanks.

-Fenghua
