Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A295FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD5721A2D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD5721A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeHQT6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:58:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:25267 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbeHQT6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:58:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Aug 2018 09:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,251,1531810800"; 
   d="scan'208";a="82631089"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2018 09:54:03 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 27EC1301B7C; Fri, 17 Aug 2018 09:54:03 -0700 (PDT)
Date:   Fri, 17 Aug 2018 09:54:03 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.com>
Cc:     Nick Terrell <terrelln@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Julian Andres Klode <julian.klode@canonical.com>
Subject: Re: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
Message-ID: <20180817165403.GC12066@tassilo.jf.intel.com>
References: <20180322012943.4145794-1-terrelln@fb.com>
 <5B282FAD-EDCF-44C8-A131-A3C6FF3EA84F@fb.com>
 <3F598446-EA1D-47CE-B7A1-4D3002DA3972@exactcode.com>
 <8DE2BD14-0C9C-43AF-B9B7-F760F8434B6B@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8DE2BD14-0C9C-43AF-B9B7-F760F8434B6B@exactcode.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 06:15:45PM +0200, René Rebe wrote:
> Hey,
> 
> is there any mainline future for this zstd support? Currently my most favourite compressor for this, and for what it’s worth zstd/initrd now even tested on #t2sde / hp/pa-risc, … https://www.youtube.com/watch?v=MHplOJxnIHk

Can you remove some other compressor for the kernel image if you merge this?

The "favourite compressor" seems to roughly change every year, so if
we keep adding new ones things will get more and more convoluted.

Surely zstd is universally better than some existing compressor
the kernel already uses for itself for a particular sweet spot?
If it isn't it's likely not needed.

-Andi

