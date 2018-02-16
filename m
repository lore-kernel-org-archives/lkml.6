Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030694AbeBPPzy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:55:54 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:57565 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030613AbeBPPzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:55:53 -0500
Date: Fri, 16 Feb 2018 16:55:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Richard Cochran <richardcochran@gmail.com>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Brandon Streiff <brandon.streiff@ni.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: hwtstamp: fix potential negative
 array index read
Message-ID: <20180216155535.GE3080@lunn.ch>
References: <20180215183139.GA23076@embeddedor.com>
 <20180216154846.7ge6seynwxjkopmp@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216154846.7ge6seynwxjkopmp@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 07:48:46AM -0800, Richard Cochran wrote:
> On Thu, Feb 15, 2018 at 12:31:39PM -0600, Gustavo A. R. Silva wrote:
> > _port_ is being used as index to array port_hwtstamp before verifying
> > it is a non-negative number and a valid index at line 209 and 258:
> > 
> > if (port < 0 || port >= mv88e6xxx_num_ports(chip))
> > 
> > Fix this by checking _port_ before using it as index to array
> > port_hwtstamp.
> 
> NAK.   Port is already known to be valid in the callers.

Then we should take out the check. It is probably this check which is
causing the false positives.

	Andrew
