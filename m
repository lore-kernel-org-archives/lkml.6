Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030804AbeBPP4W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:56:22 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38865 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030613AbeBPP4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:56:20 -0500
X-Google-Smtp-Source: AH8x2254PRZXnA/JXVh1p4qI5w8vkynSTKg046CJcmFLDcZYO2FBhD8H/o9atK2FqKMlCYjQQg0jIA==
Date: Fri, 16 Feb 2018 07:56:17 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Brandon Streiff <brandon.streiff@ni.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: hwtstamp: fix potential negative
 array index read
Message-ID: <20180216155617.ykf77vq45bxejfg3@localhost>
References: <20180215183139.GA23076@embeddedor.com>
 <20180216154846.7ge6seynwxjkopmp@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216154846.7ge6seynwxjkopmp@localhost>
User-Agent: NeoMutt/20170113 (1.7.2)
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

And so the real bug is the pointless range checking tests.  I would
welcome patches to remove those.

Thanks,
Richard
