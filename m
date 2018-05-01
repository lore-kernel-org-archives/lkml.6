Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756228AbeEARsB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 13:48:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46148 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755443AbeEARr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 13:47:59 -0400
Date: Tue, 1 May 2018 19:47:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        rmk@armlinux.org.uk, linux-kernel@vger.kernel.org, cphealy@gmail.com,
        nikita.yoush@cogentembedded.com, vivien.didelot@savoirfairelinux.com,
        Nisar.Sayed@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [RFC net-next 0/5] Support for PHY test modes
Message-ID: <20180501174752.GA1265@lunn.ch>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
 <20180429.225554.2165914401649980919.davem@davemloft.net>
 <eea70076-891c-5caa-a590-ef1b0421f3b2@gmail.com>
 <20180430232448.GB25602@lunn.ch>
 <19a6bf90-03d5-aa63-5f35-3b26801b79a9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19a6bf90-03d5-aa63-5f35-3b26801b79a9@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:21:54AM -0700, Florian Fainelli wrote:
> On 04/30/2018 04:24 PM, Andrew Lunn wrote:
> >> Turning these tests on will typically result in the link partner
> >> dropping the link with us, and the interface will be non-functional as
> >> far as the data path is concerned (similar to an isolation mode). This
> >> might warrant properly reporting that to user-space through e.g: a
> >> private IFF_* value maybe?
> > 
> > Hi Florian
> > 
> > I think a IFF_* value would be a good idea. We want to give the user
> > some indicate why they don't have working networking. ip link show
> > showing PHY-TEST-MODE would help.
> 
> IF_OPER_TESTING as defined in RFC 2863 looks like the correct way to
> signal that. I did a quick test and setting operstate to
> IFF_OPER_TESTING seems to correctly get reflected by iproute2/ifconfig
> which no longer see RUNNING though the interface is still UP.

Hi Florian

I should really play with this.... but is the opstate printed by ip
link show? Not showing RUNNING is not the best hint something else is
going on. Actually saying TESTING somewhere is much clearer.

      Andrew
