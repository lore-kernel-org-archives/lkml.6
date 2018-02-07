Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754215AbeBGOCS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:02:18 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36487 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753763AbeBGOCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:02:17 -0500
X-Google-Smtp-Source: AH8x224O+85FMO0OTGrmv3IC3EjzEnpvvhFX6duZ9UQ8eE5JXJZeXVZH679avisoejQnJlN7LIzx9w==
Message-ID: <1518012133.13585.13.camel@redhat.com>
Subject: Re: [PATCH] x86/microcode/intel: print previous microcode revision
 during early update
From: Stanislav Kozina <skozina@redhat.com>
To: Borislav Petkov <bp@alien8.de>, Petr Oros <poros@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 07 Feb 2018 15:02:13 +0100
In-Reply-To: <20180126144918.7jiaezmdhjsiman5@pd.tnic>
References: <20180126103451.16863-1-poros@redhat.com>
         <20180126104109.slxxoq4vkqytqjxd@pd.tnic>
         <1516967135.2801.1.camel@redhat.com>
         <20180126115800.bvqrzik2f3hmmiah@pd.tnic>
         <1516974600.2801.10.camel@redhat.com>
         <20180126144918.7jiaezmdhjsiman5@pd.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.2 (3.26.2-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Borislav,

On Fri, 2018-01-26 at 15:49 +0100, Borislav Petkov wrote:
> On Fri, Jan 26, 2018 at 02:50:00PM +0100, Petr Oros wrote:
> > But what in production? Edit boot params, restart server, grep
> > /proc/cpuinfo and
> > restart again? Why i can not read it just from dmesg?
> 
> Because you don't need the previous revision.
> 
> You only *happen* to need it now but that is being addressed too with
> the blacklisting. And when you have broken microcode, it will say:

Although Spectre might be the most visible CPU issue, it's not the only
one. What if some issue causes failure during early microcode update?
What if the issue triggers only on update from a certain microcode
version? We should be transparent about what microcode version we
update from and to.

The double reboot with "dis_ucode_ldr" argument requires to schedule a
full system reboot just to figure out what version has been provided by
the system firmware.

> +               pr_warn("Intel Spectre v2 broken microcode detected;
> disabling SPEC_CTRL\n");
> 
> and if you have microcode which doesn't have IBRS, there won't be
> "spec_ctrl" in /proc/cpuinfo.
> 
> I don't want people to start paying attention to microcode
> revision numbers with the gazillion different revisions and
> family/model/steppings out there and the crazy confusion that will
> ensue
> from this.

The current microcode version is already printed in the dmesg. Many
people do care what revision they are running and what provided this
revision. It is the most important information on triaging CPU issues,
especially if anything goes awry.

I would appreciate if you could pull this patch in.

Thank you,
-Stanislav
