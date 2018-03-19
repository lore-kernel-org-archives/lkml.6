Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969465AbeCSSTn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969417AbeCSSTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:19:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7742177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <87bmfs1a8w.fsf@bootlin.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>,
        Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>,
        Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>
References: <20180228140751.10819-1-gregory.clement@bootlin.com>
 <87bmfs1a8w.fsf@bootlin.com>
Message-ID: <152148357023.242365.11271637218580901412@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: mvebu: cp110: Fix clock tree representation
Date: Mon, 19 Mar 2018 11:19:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gregory CLEMENT (2018-03-13 04:32:47)
> Hi,
>  
>  On mer., févr. 28 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
> 
> > Thanks to new documentation, we have a better view of the clock tree.
> > There were few mistakes in the first version of this driver, the main one
> > being the parental link between the clocks. Actually the tree is more
> > flat that we though. Most of the IP blocks require two clocks: one for
> > the IP itself and one for accessing the registers, and unlike what we
> > wrote there is no link between these two clocks.
> >
> > The other mistakes were about the name of the clocks: the root clock is
> > not the Audio PLL but the PLL0, and what we called the EIP clock is named
> > the x2 Core clock and is used by other IP block than the EIP ones.
> 
> Do you have any feedback on this patch?
> 
> I would like to have time to address them if you have any remark.
> 
> Else do you want a Pull Request or could you apply it directly?
> 
> The only other patch around the mvebu clocks was set a few days ago [1]
> and seems to be eventually a fix patch. That means that there would be
> only one patch in the Pull Request for 4.17, but I can do it if you
> prefer.
> 

Please don't send single patch PRs. I'll pick this up. Thanks.
