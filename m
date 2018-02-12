Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbeBLXZz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 18:25:55 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44970 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932272AbeBLXZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 18:25:54 -0500
X-Google-Smtp-Source: AH8x225RPclsTcyDM8fhi0A/mM9+CYwLO8xXoyW0gfxqAZHEJQQfTIq2pQl8plE8IhAZ5PgQSRshig==
Date: Mon, 12 Feb 2018 15:25:51 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
        <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/kdump: Add missing optional dummy functions
Message-ID: <20180212232551.GA5199@roeck-us.net>
References: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
 <CAKTCnzmtDNJHThzuZa1+ydrriQG-dVovHA7uLSVvfLFG2MaidQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTCnzmtDNJHThzuZa1+ydrriQG-dVovHA7uLSVvfLFG2MaidQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:01:57AM +1100, Balbir Singh wrote:
> On Tue, Feb 13, 2018 at 9:34 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> > If KEXEC_CORE is not enabled, PowerNV builds fail as follows.
> >
> > arch/powerpc/platforms/powernv/smp.c: In function 'pnv_smp_cpu_kill_self':
> > arch/powerpc/platforms/powernv/smp.c:236:4: error:
> >         implicit declaration of function 'crash_ipi_callback'
> >
> > Add dummy function calls, similar to kdump_in_progress(), to solve the
> > problem.
> >
> > Fixes: 4145f358644b ("powernv/kdump: Fix cases where the kdump kernel ...")
> > Cc: Balbir Singh <bsingharora@gmail.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> 
> Thanks for working on this.
> 
> You've added two functions, I understand the crash_send_ipi() bits
> that I broke. Looks like crash_ipi_callback broken without KEXEC_CORE?
> 

If I recall correctly, 4145f358644b introduced the call to crash_ipi_callback().
After I declared the dummy function for that, I got an error about the missing
crash_send_ipi(). I didn't spend more time on it but just added another dummy
function. It may well be that another problem was introduced in the same time
frame. On the other side, maybe I got it all wrong, and my patch is not worth
the computer it was written on.

Thanks,
Guenter
