Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeCWPq5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:46:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCWPq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:46:56 -0400
Date: Fri, 23 Mar 2018 16:46:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        stuyoder@gmail.com, ruxandra.radulescu@nxp.com, arnd@arndb.de,
        razvan.stefanescu@nxp.com, Roy.Pledge@nxp.com
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Message-ID: <20180323154654.GA382@kroah.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 10:38:56AM -0500, Ioana Ciornei wrote:
> +#include "fsl-mc-private.h"
> +
> +#define FSL_MC_BUS_MAX_MINORS	1

As you only need/want one character device here, why not just use the
misc device api?  It's much simpler, and handles all of the housekeeping
for you correctly.  It also means I don't have to audit all of your
chardev code to verify it is correct :)

And it will save you lines-of-code, always a good thing.

thanks,

greg k-h
