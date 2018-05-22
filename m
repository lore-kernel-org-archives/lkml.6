Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeEVIfj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:35:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44996 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751039AbeEVIfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:35:37 -0400
Date: Tue, 22 May 2018 10:34:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: mce: [Hardware Error] from dmesg -l emerg
Message-ID: <20180522083456.GA5512@pd.tnic>
References: <CAG=yYwmnHgAvauZLxfFcUEACF_J+qh4d2tvYY=AdjHvyeSFK_A@mail.gmail.com>
 <20180514162752.GG23049@pd.tnic>
 <CAG=yYwk-dbMF_7eS9bUraAru8b4fyCosxp+MpQA=1ZYH0nd_hg@mail.gmail.com>
 <20180520204032.GA19845@pd.tnic>
 <CAG=yYw=bdgsTSW80R1Wt9uUTtXeMwX5macbjrPBNzVLihk-Ufw@mail.gmail.com>
 <20180521165803.GA15717@agluck-desk>
 <CAG=yYw=OQ7zpyK-5iqg7uQvcykTvuhQfX=RFg3GpQGvCRowd=Q@mail.gmail.com>
 <20180521205751.GA19282@agluck-desk>
 <CAG=yYwmgceOCf3TeefFN-i54Z4Qxsp7asD0uhqah5P7md94kWw@mail.gmail.com>
 <20180522000614.GA21542@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180522000614.GA21542@agluck-desk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 05:06:14PM -0700, Luck, Tony wrote:
> On Tue, May 22, 2018 at 02:43:37AM +0530, Jeffrin Thalakkottoor wrote:
> > mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 5: ee0000000040110b
> > mce: [Hardware Error]: TSC 0 ADDR 160000080 MISC 5040008086
> > mce: [Hardware Error]: PROCESSOR 0:306d4 TIME 1526932210 SOCKET 0 APIC
> > 0 microcode 2a
> 
> The problem is that "mcelog --ascii" is expecting the first line to
> look like:
> 
> 	CPU 0: Machine Check Exception: 0 Bank 5: ee0000000040110b
> 
> This seems to have been broken by commit:
> 
> 	cd9c57cad3fe ("x86/MCE: Dump MCE to dmesg if no consumers")
> 
> relevent part is this ... where we now conditionally include the
> word "Exception".

Well, mcelog should decode the error signature regardless whether it
says "Exception" or not, IMO.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
