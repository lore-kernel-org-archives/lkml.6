Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965301AbeE2Pvy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:51:54 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39648 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964978AbeE2Pve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:51:34 -0400
X-Google-Smtp-Source: ADUXVKItS2f+K+jk5e7Dlt9G2Xlk6NRev6TYGEmYItwmwmwkog/fAc8d/nnCHfLP/fh8WEBmjDZGWw==
Date: Tue, 29 May 2018 11:51:32 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Will Deacon <will.deacon@arm.com>
cc: Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com
Subject: Re: [PATCH] ARM: mcpm, perf/arm-cci: export mcpm_is_available
In-Reply-To: <20180529153013.GH17159@arm.com>
Message-ID: <nycvar.YSQ.7.76.1805291150330.1473@knanqh.ubzr>
References: <20180528154448.2494709-1-arnd@arndb.de> <20180529153013.GH17159@arm.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018, Will Deacon wrote:

> Hi Arnd, Russell, [+Nico and Robin]
> 
> On Mon, May 28, 2018 at 05:44:36PM +0200, Arnd Bergmann wrote:
> > Now that the ARM CCI PMU driver can be built as a loadable module,
> > we get a link failure when MCPM is enabled:
> > 
> > ERROR: "mcpm_is_available" [drivers/perf/arm-cci.ko] undefined!
> > 
> > The simplest fix is to export that helper function.
> > 
> > Fixes: 8b0c93c20ef7 ("perf/arm-cci: Allow building as a module")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > The patch that caused this is currently part of the arm-perf/for-next/perf
> > branch, it would be good to have the fix there as well.
> > ---
> >  arch/arm/common/mcpm_entry.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> I'm happy to take this via the arm perf tree if others are ok with that.
> Alternatively, I can revert the offending commit if there are objections
> to exporting the symbol.

Looks fine to me.

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
