Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751491AbeETG1d (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 02:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750742AbeETG13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 02:27:29 -0400
Date: Sun, 20 May 2018 14:26:33 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>, Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] soc: imx: gpcv2: Do not pass static memory as
 platform data
Message-ID: <20180520062631.GS26863@dragon>
References: <20180410183210.28052-1-andrew.smirnov@gmail.com>
 <CAHQ1cqGCG0rwPcpoY+bnjcyupg18x1TvULJzvAjRxSkL6z1U_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqGCG0rwPcpoY+bnjcyupg18x1TvULJzvAjRxSkL6z1U_Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 03:35:55PM -0700, Andrey Smirnov wrote:
> On Tue, Apr 10, 2018 at 11:32 AM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
> > Platform device core assumes the ownership of dev.platform_data as
> > well as that it is dynamically allocated and it will try to kfree it
> > as a part of platform_device_release(). Change the code to use
> > platform_device_add_data() n instead of a pointer to a static memory
> > to avoid causing a BUG() when calling platform_device_put().
> >
> > The problem can be reproduced by artificially enabling the error path
> > of platform_device_add() call (around line 357).
> >
> > Note that this change also allows us to constify imx7_pgc_domains,
> > since we no longer need to be able to modify it.
> >
> 
> Shawn,
> 
> What's the status of these two patches? Do I need to change anything
> or are they good to go?

The patches were queued on imx/drivers branch for a while.  I forgot to
let you know.  Sorry.

Shawn
