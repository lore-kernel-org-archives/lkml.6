Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeCOKSI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:18:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60562 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeCOKSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:18:06 -0400
Date: Thu, 15 Mar 2018 11:17:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: York Sun <york.sun@nxp.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
Message-ID: <20180315101725.GC27816@pd.tnic>
References: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
 <20180315010728.GF11061@pd.tnic>
 <VI1PR04MB20785DE79A7D33D453FF79869AD00@VI1PR04MB2078.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR04MB20785DE79A7D33D453FF79869AD00@VI1PR04MB2078.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 01:20:18AM +0000, York Sun wrote:
> The discussion led to using device tree to specify which cores have this
> feature. Since this feature is "implementation dependent", I can only
> confirm it is available on A53 core, and partially on A57 core (lacking
> error injection). It is not generic to ARM64 cores.

So my ARM person is telling me A53 is little and A57 is big.

In any case, I'd like to have a sane collection of RAS functionality,
either per uarch or per vendor. So I can imagine having edac_a53,
edac_a57, etc.

But not per functional unit. Especially if the functionality is shared
between core designs.

In that case, we'll have to do something like fsl_ddr_edac being shared
between MPC85xx and layerscape.

> We can leave this patch floating. If someone else finds it useful, we
> can resume the discussion on how to generalize it.

Yes. If you want to do a nxp_edac or so which supports your hardware,
that's fine. And then have the different functional units get built into
a final edac driver, that's fine with me too. Other drivers will reuse
those functional units since they're stock and should adhere to the
design...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
