Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756398AbeEASGS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:06:18 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:48142 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756369AbeEASGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:06:16 -0400
Date: Tue, 01 May 2018 14:06:14 -0400 (EDT)
Message-Id: <20180501.140614.228810492759253433.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: andrew@lunn.ch, netdev@vger.kernel.org, rmk@armlinux.org.uk,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        nikita.yoush@cogentembedded.com, vivien.didelot@savoirfairelinux.com,
        Nisar.Sayed@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [RFC net-next 0/5] Support for PHY test modes
From: David Miller <davem@davemloft.net>
In-Reply-To: <19a6bf90-03d5-aa63-5f35-3b26801b79a9@gmail.com>
References: <eea70076-891c-5caa-a590-ef1b0421f3b2@gmail.com>
        <20180430232448.GB25602@lunn.ch>
        <19a6bf90-03d5-aa63-5f35-3b26801b79a9@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 1 May 2018 10:21:54 -0700

> On 04/30/2018 04:24 PM, Andrew Lunn wrote:
>>> Turning these tests on will typically result in the link partner
>>> dropping the link with us, and the interface will be non-functional as
>>> far as the data path is concerned (similar to an isolation mode). This
>>> might warrant properly reporting that to user-space through e.g: a
>>> private IFF_* value maybe?
>> 
>> Hi Florian
>> 
>> I think a IFF_* value would be a good idea. We want to give the user
>> some indicate why they don't have working networking. ip link show
>> showing PHY-TEST-MODE would help.
> 
> IF_OPER_TESTING as defined in RFC 2863 looks like the correct way to
> signal that. I did a quick test and setting operstate to
> IFF_OPER_TESTING seems to correctly get reflected by iproute2/ifconfig
> which no longer see RUNNING though the interface is still UP. If we
> couple that with a proper phy_stop(), this would IMHO be consistent from
> an user experience perspective.
> 
> David, would that look reasonable to you?

Yes, it does.
