Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758283AbeBPPsw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:48:52 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36667 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756578AbeBPPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:48:50 -0500
X-Google-Smtp-Source: AH8x227Xx6WBnExdId1dYNtzDR/L4VQ1MMQoGqu5/9bmbgM5LelCoZEYw+eDQ33rrYWADWbn3oG9RA==
Date: Fri, 16 Feb 2018 07:48:46 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Brandon Streiff <brandon.streiff@ni.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: hwtstamp: fix potential negative
 array index read
Message-ID: <20180216154846.7ge6seynwxjkopmp@localhost>
References: <20180215183139.GA23076@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215183139.GA23076@embeddedor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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

NAK.   Port is already known to be valid in the callers.

See:

*** net/dsa/slave.c:  dsa_slave_ioctl[266]
*** net/dsa/slave.c:  dsa_skb_tx_timestamp[416]
*** net/dsa/dsa.c:    dsa_skb_defer_rx_timestamp[152]
 
> Addresses-Coverity-ID: 1465287 ("Negative array index read")
> Addresses-Coverity-ID: 1465291 ("Negative array index read")

Please check the code before posting.  These false positives are
really annoying.

Thanks,
Richard
