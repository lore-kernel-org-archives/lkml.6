Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeB1OIf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:08:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46550 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752541AbeB1OIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:08:32 -0500
Date: Wed, 28 Feb 2018 15:08:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: X86 ML <x86@kernel.org>, Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] x86/microcode: Synchronize late microcode loading
Message-ID: <20180228140806.GD3769@pd.tnic>
References: <20180228102846.13447-1-bp@alien8.de>
 <20180228102846.13447-8-bp@alien8.de>
 <20180228135931.uwveegfdv5afozxe@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228135931.uwveegfdv5afozxe@khazad-dum.debian.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 10:59:31AM -0300, Henrique de Moraes Holschuh wrote:
> Eek! If I read that right, this effectively halts the entire box until
> every core is updated, with one core entering deep-coma at a time (the
> rest are left either spinning or cpu_relax()ing

I think *you* should relax. :)

Late microcode loading on a long running box is not something you do
more than 2-3 times a year. And if the box needs to restart, it'll get
the early microcode.

And yes, this is addressing *late* loading, if you haven't noticed yet.
I added a big fat note *twice*:

"Before you read any further: the early loading method is still the
preferred one and you should always do that. This patchset is improving
the late loading mechanism for long running jobs and cloud use cases -
i.e., use cases where early loading is, hm, a bit problematic."

So keep doing the early method and you'll be fine.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
