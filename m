Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F28C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848A920855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848A920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeIKApN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:45:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:7061 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbeIKApN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:45:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 12:49:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="88819023"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga001.fm.intel.com with ESMTP; 10 Sep 2018 12:47:30 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 10 Sep 2018 12:47:16 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.207]) with mapi id 14.03.0319.002;
 Mon, 10 Sep 2018 12:47:16 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH V5 0/2] Add efi page fault handler to recover from page
Thread-Topic: [PATCH V5 0/2] Add efi page fault handler to recover from page
Thread-Index: AQHUST0lXunNze/V9ke4Hf0+e55fjKTp6SFQ
Date:   Mon, 10 Sep 2018 19:47:15 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485BAE95@ORSMSX114.amr.corp.intel.com>
References: <1536607945-22018-1-git-send-email-sai.praneeth.prakhya@intel.com>
In-Reply-To: <1536607945-22018-1-git-send-email-sai.praneeth.prakhya@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGFiMDBjNDktNzAwZi00OTA2LWIyMGItNGY3YmM5NTk5M2JiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMitOaktkWlZLNWUrM0ZcL1czUXdWbFkwbjBZZTVncE9RQk9cL3dVR2JURjl3TTdZQTZyQmlSSUE1S2FudUNmXC9yYiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> Changes from V4 to V5:
> ----------------------
> 1. Drop config option that enables efi page fault handler, instead make
>    it default.
> 2. Call schedule() in an infinite loop to account for spurious wake ups.
> 3. Introduce "NONE" as an efi runtime service function identifier so that
>    it could be used in efi_recover_from_page_fault() to check if the page
>    fault was indeed triggered by an efi runtime service.

Please note that apart from dropping the config knob and accounting for 
spurious wake ups, I have added a third change.

I realized that when kernel command line option efi=old_map is passed, the efi 
page fault handler in V4 wouldn't work because, it checks for efi_mm.

In the efi page fault handler, I have also added an explicit check for x86_64 because 
AFAIK, x86_32 bit machines do not suffer from this problem (Boris, please correct me if I am wrong).
Also, I was unable to trigger page faults with buggy OVMF for x86_32.

Just wanted to state the third change explicitly here so that it doesn't escape reviewers eyes.

Regards,
Sai
