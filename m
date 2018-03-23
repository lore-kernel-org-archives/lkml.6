Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeCWQKA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:10:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbeCWQJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:09:59 -0400
Date: Fri, 23 Mar 2018 17:09:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stuyoder@gmail.com" <stuyoder@gmail.com>,
        Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Razvan Stefanescu <razvan.stefanescu@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Message-ID: <20180323160957.GA3113@kroah.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <20180323154654.GA382@kroah.com>
 <HE1PR04MB32123F0FF506534B11A1CE5BE0A80@HE1PR04MB3212.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR04MB32123F0FF506534B11A1CE5BE0A80@HE1PR04MB3212.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 03:56:24PM +0000, Ioana Ciornei wrote:
> 
> > 
> > On Fri, Mar 23, 2018 at 10:38:56AM -0500, Ioana Ciornei wrote:
> > > +#include "fsl-mc-private.h"
> > > +
> > > +#define FSL_MC_BUS_MAX_MINORS	1
> > 
> > As you only need/want one character device here, why not just use the misc
> > device api?  It's much simpler, and handles all of the housekeeping for you
> > correctly.  It also means I don't have to audit all of your chardev code to verify it
> > is correct :)
> 
> I have considered the misc device api but the fsl-mc bus, since it is
> a platform driver, is probing before the misc char driver.

How?  The misc code is just "core code" there's nothing to "probe" here.
Is this an init-call ordering issue somehow?  A platform driver probe
should be after the misc core is initialized.  And if not, you can
always defer your probe.

thanks,

greg k-h
