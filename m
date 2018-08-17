Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94995C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AACA20852
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AACA20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeHQW1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 18:27:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:15432 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbeHQW1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 18:27:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Aug 2018 12:22:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,251,1531810800"; 
   d="scan'208";a="73650880"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2018 12:22:44 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A6706301B7C; Fri, 17 Aug 2018 12:22:44 -0700 (PDT)
Date:   Fri, 17 Aug 2018 12:22:44 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.com>,
        Nick Terrell <terrelln@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Julian Andres Klode <julian.klode@canonical.com>
Subject: Re: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
Message-ID: <20180817192244.GF12066@tassilo.jf.intel.com>
References: <20180322012943.4145794-1-terrelln@fb.com>
 <5B282FAD-EDCF-44C8-A131-A3C6FF3EA84F@fb.com>
 <3F598446-EA1D-47CE-B7A1-4D3002DA3972@exactcode.com>
 <8DE2BD14-0C9C-43AF-B9B7-F760F8434B6B@exactcode.com>
 <20180817165403.GC12066@tassilo.jf.intel.com>
 <20180817175746.d2brxipp7xa4y2uw@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817175746.d2brxipp7xa4y2uw@angband.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 07:57:46PM +0200, Adam Borowski wrote:
> > The "favourite compressor" seems to roughly change every year, so if
> > we keep adding new ones things will get more and more convoluted.
> 
> The above patchset drops just bzip2.  It is the only one that's strictly
> beaten in every way (ratio, time, memory usage), there are also no other

Does time include build time? I've been reverting back to gzip recently
because I care very much about that.

> uses of bzip2 anywhere in the kernel so we'd get to drop its code
> completely: 900 lines of Linus' happiness.

Great!

> 
> Other candidates are lzo and bare lzma (you want lz4, zstd or xz instead),
> but those are used elsewhere thus there's hardly any gain.  If you want them
> gone, please say so -- I'll include their droppage.

Yes would be good to remove the kernel image support for those too
just to simplify the config process, even if it doesn't save much code.

-Andi
