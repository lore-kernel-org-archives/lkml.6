Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6770C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A718B2470C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A718B2470C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934081AbeFVSJN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:09:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:56254 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932968AbeFVSJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:09:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 11:09:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,258,1526367600"; 
   d="scan'208";a="65507865"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2018 11:09:09 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 22 Jun 2018 11:09:09 -0700
Received: from crsmsx151.amr.corp.intel.com (172.18.7.86) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 22 Jun 2018 11:09:09 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.79]) by
 CRSMSX151.amr.corp.intel.com ([169.254.3.85]) with mapi id 14.03.0319.002;
 Fri, 22 Jun 2018 12:09:07 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Ingo Molnar" <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/7] x86/fsgsbase/64: Introduce FS/GS base helper
 functions
Thread-Topic: [PATCH v4 1/7] x86/fsgsbase/64: Introduce FS/GS base helper
 functions
Thread-Index: AQHUCOybYpDa3VZ4oEOyN0TjYJBC5KRsvVMA///YFK4=
Date:   Fri, 22 Jun 2018 18:09:06 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66BDB7DC@CRSMSX101.amr.corp.intel.com>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
 <1529536506-26237-2-git-send-email-chang.seok.bae@intel.com>,<alpine.DEB.2.21.1806221610500.2402@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806221610500.2402@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.3.86.137]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah. You copied it from here where it makes no sense either. Copy and paste
> is useful, but you really want to think about it.

That's the matter of fact though, let me revise those you pointed out here.

> This patch wants to be split into:
>      1) Adding the new functions
>      2) Convert vdso
>      3) Convert ptrace
> _AFTER_ fixing the existing bug.

Okay, I think it is reasonable to do that, (regardless of defining it as bug or not).
Thanks for the sharp reviews.

Chang
