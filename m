Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52A4C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD11217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfACXka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:40:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:62472 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbfACXk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:40:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 15:40:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,436,1539673200"; 
   d="scan'208";a="115303270"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2019 15:40:29 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0CB19301B2E; Thu,  3 Jan 2019 15:40:29 -0800 (PST)
Date:   Thu, 3 Jan 2019 15:40:29 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [RFC v2 1/6] x86: introduce kernel restartable sequence
Message-ID: <20190103234029.GH6118@tassilo.jf.intel.com>
References: <20181231072112.21051-1-namit@vmware.com>
 <20181231072112.21051-2-namit@vmware.com>
 <87va35e61a.fsf@linux.intel.com>
 <263A441C-F062-491F-9E95-F00FA2092A99@gmail.com>
 <20190103224835.GG6118@tassilo.jf.intel.com>
 <28F28C02-1817-4A0A-B488-216FDF22169A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28F28C02-1817-4A0A-B488-216FDF22169A@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the explanations. I don’t think it would work (e.g., IRQs). I can
> avoid generalizing and just detect the "magic sequence” of the code, but let
> me give it some more thought.

If you ask me I would just use compiler profile feedback or autofdo (if your
compiler has a working version)

The compiler can do a much better job at optimizing this than you ever could.

Manual FDO needs some kernel patching though.

-Andi

