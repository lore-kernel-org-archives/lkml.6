Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeCWTnD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:43:03 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40546 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeCWTnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:43:01 -0400
Date: Fri, 23 Mar 2018 20:42:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Subject: Re: [PATCH] of_net: Implement of_get_nvmem_mac_address helper
Message-ID: <20180323194259.GP24361@lunn.ch>
References: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl>
 <20180323151101.GB24361@lunn.ch>
 <b68d4540-b15d-ec31-05a8-e1a4632bb5ee@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b68d4540-b15d-ec31-05a8-e1a4632bb5ee@topic.nl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Indeed. I'll add my settings as an example. Where should I put this
> documentation, in the commit comment or somewhere in
> Documents/devicetree/bindings?

Documention/devicetree/bindings/net/ethernet.txt

> It's what I intended to do, but there were two problems with that:
> - of_get_mac_address() returns a pointer to constant data in memory, but the
> nvmem functions return an allocated memory object that must be freed after
> use. This changes the way the call is to be made.
> - The nvmem functions need the "struct device" pointer as well, while
> of_get_mac_address() only gets passed the DT node.

Does of_nvmem_cell_get() help?

      Andrew
