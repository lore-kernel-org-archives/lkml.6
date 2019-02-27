Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659D2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF2E2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfB0W0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:26:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:36551 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbfB0W0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 17:26:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 14:26:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="150575652"
Received: from yyu32-desk1.sc.intel.com ([10.144.155.177])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2019 14:26:06 -0800
Message-ID: <6be796c64cb4ba21ef879facc65f5b3b476cacfd.camel@intel.com>
Subject: Re: [PATCH] x86/selftests/xsave: Introduce XSAVE tests
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kselftest@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
Date:   Wed, 27 Feb 2019 14:19:27 -0800
In-Reply-To: <67fa7d2a-31e2-efdf-7ffe-39c3e2a9b4a2@intel.com>
References: <20190227212422.11845-1-yu-cheng.yu@intel.com>
         <67fa7d2a-31e2-efdf-7ffe-39c3e2a9b4a2@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-27 at 13:45 -0800, Dave Hansen wrote:
> I wonder, though, if you can spend a little more time on these.  They
> look a little "raw".  They're virtually free of comments and there is no
> explanation of what the tests do or why they do them.  I honestly forget
> things like what XSAVE has to do with fork() failing, for instance.

I will add comments of what problems each test detects.

> I'd question why we need 5 different .c files.  It also seems like
> things like set_ymm() could be trivially factored into a .h rather than
> making 5 copies of them.

Each C file contains only one single test and can be built with one command,
e.g. "gcc xsave_check_exec.c", or as part of the whole selftest.

I am hoping that, should any test fail, one can easily modify the test to find
out why.

Yes, I will move set_ymm() to a header file.

Yu-cheng
