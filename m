Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7405060764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeFFNGg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:06:36 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:45104 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750864AbeFFNGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:06:35 -0400
X-IronPort-AV: E=Sophos;i="5.49,483,1520895600";
   d="scan'208";a="330612869"
Date: Wed, 6 Jun 2018 22:06:28 +0900 (JST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Takashi Iwai <tiwai@suse.de>
cc: perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: unnecessary test?
In-Reply-To: <s5h4lignk0q.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.20.1806062206070.4659@hadrien>
References: <alpine.DEB.2.20.1806062135430.4445@hadrien> <s5h4lignk0q.wl-tiwai@suse.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jun 2018, Takashi Iwai wrote:

> On Wed, 06 Jun 2018 14:39:05 +0200,
> Julia Lawall wrote:
> >
> > In the file sound/pci/ctxfi/cthw20k1.c, the function daio_mgr_dao_init
> > contains:
> >
> > set_field(&ctl->spoctl, SPOCTL_OS << (idx*8),
> >           ((conf >> 3) & 0x1) ? 2 : 2); /* Raw */
> >
> > Could the second argument just be 2?  It's true that the preceeding call
> > contains conf >> ..., but in a more useful way, so perhaps it could be
> > useful for uniformity?
>
> I guess this is a typo of "2 : 0".  The code seems toggling the
> control bit depending on the S/PDIF passthru mode.  It might be
> reversed, but I bet 1 for non-audio from a common sense.
>
> Ditto for cthw20k1.c.  This one is likely 1, not 2, though.

OK, should I send a patch?  I have no way to test it.

julia

>
>
> thanks,
>
> Takashi
>
