Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeC1NBZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:01:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47524 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751840AbeC1NBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:01:24 -0400
Date: Wed, 28 Mar 2018 15:00:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] EDAC/amd64: Print ECC enabled/disabled for nodes
 with enabled MCs
Message-ID: <20180328130028.GB20533@pd.tnic>
References: <20180321191335.7832-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180321191335.7832-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 02:13:33PM -0500, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> It's possible that a system can be used without any DRAM populated on
> one or more physical Dies on multi-die systems. Firmware will not
> enable DRAM ECC on Dies without DRAM. Users will then see a message
> about DRAM ECC disabled on those nodes without DRAM. However, DRAM ECC
> may, in fact, be enabled on the other Dies that have DRAM.
> 
> Only print ECC enabled/disabled information for nodes that have at least
> one enabled memory channel.

So if the only reason for this is make the error messages more precise,
then let's not make it uglier than it is.

The right way to do it would be to push those checks down to
debug_display_dimm_sizes* which looks at the CS rows and the chip select
enable bits and there to differentiate between

* memory controller doesn't have DIMMs

and

* memory controller has DIMMs but ECC is disabled in the BIOS

and then print the respective informative error message. But not with a
yet another boolean which kinda takes care of F17h only and leaves the
old families as they were.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
