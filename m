Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99546C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A7620671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A7620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbeJXBHl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:07:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:1549 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeJXBHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:07:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 09:43:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,416,1534834800"; 
   d="scan'208";a="97865606"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga002.fm.intel.com with ESMTP; 23 Oct 2018 09:43:31 -0700
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 23 Oct 2018 09:43:30 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.194]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.49]) with mapi id 14.03.0319.002;
 Tue, 23 Oct 2018 09:43:30 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Waiman Long <longman@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] efi: Fix debugobjects warning on efi_rts_work
Thread-Topic: [PATCH] efi: Fix debugobjects warning on efi_rts_work
Thread-Index: AQHUattVKXQRdywjHE2UY+SkHumNlKUtCRNA
Date:   Tue, 23 Oct 2018 16:43:29 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485D622C@ORSMSX114.amr.corp.intel.com>
References: <1540304307-2806-1-git-send-email-longman@redhat.com>
In-Reply-To: <1540304307-2806-1-git-send-email-longman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzhjZWM2MWEtNmJjNS00NDY2LThkYjItYTAyOTczMGExN2RmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ0M2U1FGdmNNalJ6cTZhdmRYVXV2XC9ES2NpU2FyK2h4WFFwUEhlanVDZ3U4aFZRcHAwMENGY2laRzdDQ1dnQ3oifQ==
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



> -----Original Message-----
> From: Waiman Long [mailto:longman@redhat.com]
> Sent: Tuesday, October 23, 2018 7:18 AM
> To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org; Prakhya, Sai
> Praneeth <sai.praneeth.prakhya@intel.com>; Waiman Long
> <longman@redhat.com>
> Subject: [PATCH] efi: Fix debugobjects warning on efi_rts_work
> 
> The commit 9dbbedaa6171 ("efi: Make efi_rts_work accessible to efi page fault
> handler") converted efi_rts_work from an auto variable to a global variable.
> However, when submitting the work, INIT_WORK_ONSTACK() was still used
> causing the following complaint from debugobjects:
> 
> ODEBUG: object 00000000ed27b500 is NOT on stack 00000000c7d38760, but
> annotated.
> 
> Change the macro to just INIT_WORK() to eliminate the warning.
> 
> Fixes: 9dbbedaa6171 ("efi: Make efi_rts_work accessible to efi page fault
> handler")

Thanks for fixing this :)
Looks good to me.

Regards,
Sai
