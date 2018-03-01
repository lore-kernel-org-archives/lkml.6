Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2399589-1519892760-2-17932404281657465488
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519892759; b=QqwMzpN+kuudJ4Fttus3mHHUZQwSMAPbP/0rbbq+IHiMyb6
    KY3beb54qv4tTD8TSnEjA4Kb3bww3r1JydfIpL8ZepYV6tN0pDOP4AreeOfJO5/D
    vFetLTFKxkWmecXTfmuPJJ80YkAsojVjou2xnc/QvO69kiyin2aSku8a9DALiEUp
    Jzaze1BPhMDYtAFkhKYNU6Jfjcf6Btb1Xfx8ka3UIdmKZA4wt3vaoeR1eyZcJYQ2
    lRHnApZYbOSINvUY8DcgDcm/I98Niwv2Z8QtcGCN9KfOsthjOGiMnLPHRoDVux5D
    9rqox7pOagMLOP7r9PSRRUpCyLna+vb3mDxmEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519892759; bh=gvIv5IVz0KnuXlFV9RIhli0Wjn
    hwsbxCA+gHre0M/aY=; b=GBtwSTf4Ubku8uS3AK1XRRseFpxpxMOGeuv5p47EfO
    eTP9UWXUviqoeWD03IbFuKTMQr4jvpz7jdPF0775CqDw2Tz3sapG5jm9QHW2dVQg
    9i0HsWhLQqc4FK6cx4rPri6eOUfF98+rEyKXtBQchvFhK8wtsgS4f0oZeru/FuIj
    wTQgCBx//NiK7+G/NuzBqoxJBcRo69IvanZQk2TE9Py56Hk7MyEj5VGIv0q9+qG8
    GQHTX/rCref4OSffVhVdR3Gl/aYe8VN4AvxZjlm+oZYS9Xg+++y8rXysi5sBkeir
    xIX/v7XrKZJUNYJ8mw4iONZxwEGhLpQcjfnqlLnyMMfA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965201AbeCAIZq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 03:25:46 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:63078 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965138AbeCAIZo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 03:25:44 -0500
X-IronPort-AV: E=Sophos;i="5.47,407,1515481200";
   d="scan'208";a="11878920"
Date: Thu, 1 Mar 2018 09:25:16 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Maxime Jayat <maxime.jayat@mobile-devices.fr>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: at_xdmac: fix rare residue corruption
Message-ID: <20180301082516.GL22457@rfolt0960.corp.atmel.com>
References: <20180222113955.4043-1-maxime.jayat@mobile-devices.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180222113955.4043-1-maxime.jayat@mobile-devices.fr>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Maxime,

On Thu, Feb 22, 2018 at 12:39:55PM +0100, Maxime Jayat wrote:
> Despite the efforts made to correctly read the NDA and CUBC registers,
> the order in which the registers are read could sometimes lead to an
> inconsistent state.
> 
> Re-using the timeline from the comments, this following timing of
> registers reads could lead to reading NDA with value "@desc2" and
> CUBC with value "MAX desc1":
> 
>  INITD --------                    ------------
>               |____________________|
>        _______________________  _______________
>  NDA       @desc2             \/   @desc3
>        _______________________/\_______________
>        __________  ___________  _______________
>  CUBC       0    \/ MAX desc1 \/  MAX desc2
>        __________/\___________/\_______________
>         |  |          |  |
> Events:(1)(2)        (3)(4)
> 
> (1) check_nda = @desc2
> (2) initd = 1
> (3) cur_ubc = MAX desc1
> (4) cur_nda = @desc2
> 
> This is allowed by the condition ((check_nda == cur_nda) && initd),
> despite cur_ubc and cur_nda being in the precise state we don't want.
> 
> This error leads to incorrect residue computation.
> 
> Fix it by inversing the order in which CUBC and INITD are read. This
> makes sure that NDA and CUBC are always read together either _before_
> INITD goes to 0 or _after_ it is back at 1.
> The case where NDA is read before INITD is at 0 and CUBC is read after
> INITD is back at 1 will be rejected by check_nda and cur_nda being
> different.
> 
> Fixes: 53398f488821 ("dmaengine: at_xdmac: fix residue corruption")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>

Nice work! I agree with the change you propose.

I am disappointed we didn't spot this case so I would like to double-check with
the hardware guy there is no issue with the sequence you propose. That's
why I am waiting a bit before giving my ack.

Regards

Ludovic

> ---
> Hi,
> 
> I had a bug where the serial ports on the Atmel SAMA5D2 were sometimes
> returning the same data twice, for up to 4096 bytes.
> 
> After investigation, I noticed that the ring buffer used in
> atmel_serial (in rx dma mode) had sometimes a incorrect "head" value,
> which made the ring buffer do a complete extraneous loop of data
> pushed to the tty layer.
> 
> I tracked it down to the residue of the dma being wrong, and after
> more head scratching, I found this bug in the reading of the
> registers.
> 
> Before fixing this, I was able to reproduce the bug reliably in a few
> minutes. With this patch applied, the bug did not reappear after
> several hours in testing.
> 
> 
>  drivers/dma/at_xdmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index c00e3923d7d8..94236ec9d410 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1471,10 +1471,10 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>  	for (retry = 0; retry < AT_XDMAC_RESIDUE_MAX_RETRIES; retry++) {
>  		check_nda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA) & 0xfffffffc;
>  		rmb();
> -		initd = !!(at_xdmac_chan_read(atchan, AT_XDMAC_CC) & AT_XDMAC_CC_INITD);
> -		rmb();
>  		cur_ubc = at_xdmac_chan_read(atchan, AT_XDMAC_CUBC);
>  		rmb();
> +		initd = !!(at_xdmac_chan_read(atchan, AT_XDMAC_CC) & AT_XDMAC_CC_INITD);
> +		rmb();
>  		cur_nda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA) & 0xfffffffc;
>  		rmb();
>  
> -- 
> 2.14.1
> 
