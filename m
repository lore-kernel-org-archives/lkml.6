Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbeBFQuV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:50:21 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:47115 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752442AbeBFQuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:50:13 -0500
Date: Tue, 6 Feb 2018 17:50:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Sven Van Asbroeck <svendev@arcx.com>, Woojung.Huh@microchip.com,
        Tristram.Ha@microchip.com, f.fainelli@gmail.com,
        helmut.buchsbaum@gmail.com, Maarten.Blomme@flir.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Subject: Re: [PATCH v1 0/1] spi_ks8995: use regmap to access chip registers.
Message-ID: <20180206165009.GJ12679@lunn.ch>
References: <1517930036-17618-1-git-send-email-svendev@arcx.com>
 <20180206161447.GF12679@lunn.ch>
 <CAGngYiWYChnZmU7n9i1+nbY+1oWGXQGOopBhNiPHPUoYvTdgaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiWYChnZmU7n9i1+nbY+1oWGXQGOopBhNiPHPUoYvTdgaw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 11:41:14AM -0500, Sven Van Asbroeck wrote:
> On Tue, Feb 6, 2018 at 11:14 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> > Rather than invest time in this driver, it would be better to look
> > into writing a DSA driver.
> 
> Thank you Andrew. I know little of DSA, but at first sight it appears to
> be a _very_ complicated beast for a switch PHY which only
> needs a few static register settings applied to it on startup, and has
> no further Linux interaction?

Hi Sven

If you want to treat it as a dumb switch, then a simple driver is
sufficient. But it can do a lot more. Do you need spanning tree, or
are you happy for your network to collapse if there is a loop? Do you
want access to statistics? Know if links are up/down? VLAN support?
Save some power by enabling EEE? DSA will give you these features.

And a DSA driver does not need to be complex. You can start simple,
and add more features later.

     Andrew
