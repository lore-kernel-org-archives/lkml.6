Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933098AbeBVPtK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:49:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:12150 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932952AbeBVPtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:49:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="32771188"
From: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        "Raj, Ashok" <ashok.raj@intel.com>
CC: Borislav Petkov <bp@suse.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "Ingo Molnar" <mingo@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: RE: [v2 1/3] x86/microcode/intel: Check microcode revision before
 updating sibling threads
Thread-Topic: [v2 1/3] x86/microcode/intel: Check microcode revision before
 updating sibling threads
Thread-Index: AQHTq6cTtegEYmMXlU6hc2DJSnfWCaOwx6KAgAAPWwCAAAVdAIAAEfAAgAApA4D//3pZ0A==
Date: Thu, 22 Feb 2018 15:49:05 +0000
Message-ID: <0575AF4FD06DD142AD198903C74E1CC87A61B8E8@ORSMSX103.amr.corp.intel.com>
References: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
 <1519281205-58951-2-git-send-email-ashok.raj@intel.com>
 <20180222110056.GA27489@pd.tnic>
 <20180222115554.GA3797@araj-mobl1.jf.intel.com>
 <20180222121506.GC27489@pd.tnic>
 <20180222131918.GB3797@araj-mobl1.jf.intel.com>
 <20180222154605.er6llhcaxmie3rhr@khazad-dum.debian.net>
In-Reply-To: <20180222154605.er6llhcaxmie3rhr@khazad-dum.debian.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1MFnFdD019025


> > In the past the only guidance was to not load microcode at the same time to
> the
> > thread siblings of a core. We now have new guidance that the sibling must be
> > spinning and not doing other things that can introduce instability around
> loading
> > microcode.
> 
> Document that properly in the Intel SDM, *please*.

yes we will update the SDM, just that is a much longer process than sending code out.

> 
> While at it, please verify with the microcode teams that the requirement
> for 16-byte alignment of the microcode update as present in the Intel
> SDM still stands.  

I'd be surprised if it did not. 

>Linux does not enforce it on the early microcode
> update loader when using an initramfs (but userspace can work around
> that, and iucode_tool --early-fw does so).  If that 16-byte alignment is
> important, I could dust off some patches that fix it.

hmm wonder what those tools do nowadays; Intel publishes the microcode in the linux native format since some time (and the .dat format is about to go away entirely)
