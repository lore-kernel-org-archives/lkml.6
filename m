Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C8FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D03A24704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D03A24704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933998AbeFVSCX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:02:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:52939 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751335AbeFVSCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:02:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 11:02:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,258,1526367600"; 
   d="scan'208";a="239470787"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2018 11:02:21 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 22 Jun 2018 11:02:21 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.79]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.4]) with mapi id 14.03.0319.002;
 Fri, 22 Jun 2018 12:02:19 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>
CC:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 7/7] x86/vdso: Move out the CPU number store
Thread-Topic: [PATCH v4 7/7] x86/vdso: Move out the CPU number store
Thread-Index: AQHUCOybjk1HPp+AQ0ixAne6DKuaN6RsyyuAgAAO+wCAAAHegP//uCpw
Date:   Fri, 22 Jun 2018 18:02:19 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66BDB78B@CRSMSX101.amr.corp.intel.com>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
 <1529536506-26237-8-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1806221714260.2402@nanos.tec.linutronix.de>
 <80C1F514-1B4D-4CDC-BD46-6C3AA9601446@amacapital.net>,<alpine.DEB.2.21.1806221817280.2402@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806221817280.2402@nanos.tec.linutronix.de>
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

> Still setup_cpu_number() sucks.

How about setup_cpu_and_node_number()?

Thanks, 
Chang
