Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757338AbeEJMeh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:34:37 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:54458 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756741AbeEJMef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:34:35 -0400
Date: Thu, 10 May 2018 14:34:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: David Miller <davem@davemloft.net>, James Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>, rakesh@tuxera.com,
        netdev@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Emily Chien <emily.chien@canonical.com>
Subject: Re: [PATCH 2/2] alx: add disable_wol paramenter
Message-ID: <20180510123425.GB5527@lunn.ch>
References: <1523273714-17264-1-git-send-email-acelan.kao@canonical.com>
 <1523273714-17264-2-git-send-email-acelan.kao@canonical.com>
 <20180409123910.GB31060@lunn.ch>
 <20180409.105039.310935818370762783.davem@davemloft.net>
 <CAFv23Q=QYastpgLxHiwr_PSdoeWfEjiNp6x2F9kM5EYhRee2hA@mail.gmail.com>
 <CAFv23QmkLiuFA6C4YFsO3hoTEE--2bT4H2uxaMqoY30G4_QJGw@mail.gmail.com>
 <CAFv23Qn1-5nHcFsk3egcL+OpKtujv4rkyXxa-Qht4eV4z6cbCA@mail.gmail.com>
 <20180509134543.GF14276@lunn.ch>
 <CAFv23QkETCHYqpsp_1JR30A1F=x+xCCQQv2RM9VOg24qhQRMOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFv23QkETCHYqpsp_1JR30A1F=x+xCCQQv2RM9VOg24qhQRMOQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 01:58:24PM +0800, AceLan Kao wrote:
> Hi Andrew,
> 
> We have some machines using Qualcomm Atheros Killer E2400 Gigabit
> Ethernet Controller,
> but none of them has the unintentional wake up issue.
> We're willing to fix it if we encountered the issue, but before we can
> do it, we need this feature is supported by the driver.
> 
> Taking the feature has been removed for 5 years into account, I doubt
> if we still can reproduce this issue,
> but again, to verify this issue we need to add back this feature first.
> Set WoL disabled by default won't introduce any regression but give
> users and developers a chance to fix it.

The main problem here is the module parameter. That is not going to be
accepted.

Can you argue the cure is worse than the disease? Is WoL not working
considered by a lot of people as being a bug? Double wake up is also a
bug, but not many people care, it does not cause any data corruption,
etc. So can you argue overall we have a less buggy system, but still
buggy, if WoL is enabled?

If you can write a convincing Change Message arguing the case, a patch
simply re-enabling WoL might be accepted.

But you also need to take on the responsibility to help debug the
failed shutdowns in order to get to the bottom of this problem.

       Andrew
