Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A57FC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C581120652
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C581120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fifo99.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeI3A4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 20:56:32 -0400
Received: from ec2-34-208-57-251.us-west-2.compute.amazonaws.com ([34.208.57.251]:39936
        "EHLO ip-172-31-12-36.us-west-2.compute.internal"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728197AbeI3A4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 20:56:32 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Sep 2018 20:56:32 EDT
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix, from userid 1001)
        id 0C39F40120; Sat, 29 Sep 2018 11:17:26 -0700 (PDT)
Date:   Sat, 29 Sep 2018 11:17:26 -0700
From:   dwalker@fifo99.com
To:     Maksym Kokhan <maksym.kokhan@globallogic.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/8] add generic builtin command line
Message-ID: <20180929181725.GB27441@fifo99.com>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 07:55:08PM +0300, Maksym Kokhan wrote:
> Daniel Walker (7):
>   add generic builtin command line
>   drivers: of: ifdef out cmdline section
>   x86: convert to generic builtin command line
>   arm: convert to generic builtin command line
>   arm64: convert to generic builtin command line
>   mips: convert to generic builtin command line
>   powerpc: convert to generic builtin command line
> 

When I originally submitted these I had a very good conversion with Rob Herring
on the device tree changes. It seemed fairly clear that my approach in these
changes could be done better. It effected specifically arm64, but a lot of other
platforms use the device tree integrally. With arm64 you can reduce the changes
down to only Kconfig changes, and that would likely be the case for many of the
other architecture. I made patches to do this a while back, but have not had
time to test them and push them out.

In terms of mips I think there's a fair amount of work needed to pull out their
architecture specific mangling into something generic. Part of my motivation for
these was to take the architecture specific feature and open that up for all the
architecture. So it makes sense that the mips changes should become part of
that.

The only changes which have no comments are the generic changes, x86, and
powerpc. Those patches have been used at Cisco for years with no issues.
I added those changes into my -next tree for a round of testing. Assuming there
are no issues I can work out the merging with the architecture maintainers.
As for the other changes I think they can be done in time, as long as the
generic parts of upstream the rest can be worked on by any of the architecture
developers.

Daniel
