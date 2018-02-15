Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162490AbeBOVNJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:13:09 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:57097 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161133AbeBOVNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:13:07 -0500
Date: Thu, 15 Feb 2018 22:12:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Brandon Streiff <brandon.streiff@ni.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: hwtstamp: fix potential negative
 array index read
Message-ID: <20180215211251.GC3080@lunn.ch>
References: <20180215183139.GA23076@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215183139.GA23076@embeddedor.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 12:31:39PM -0600, Gustavo A. R. Silva wrote:
> _port_ is being used as index to array port_hwtstamp before verifying
> it is a non-negative number and a valid index at line 209 and 258:
> 
> if (port < 0 || port >= mv88e6xxx_num_ports(chip))
> 
> Fix this by checking _port_ before using it as index to array
> port_hwtstamp.
> 
> Addresses-Coverity-ID: 1465287 ("Negative array index read")
> Addresses-Coverity-ID: 1465291 ("Negative array index read")
> Fixes: c6fe0ad2c349 ("net: dsa: mv88e6xxx: add rx/tx timestamping support")
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
