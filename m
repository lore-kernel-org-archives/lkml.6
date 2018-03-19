Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220729-1521445928-2-1536578477363348912
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521445928; b=p6RHFtq13E888KqS7NLM/uaYJFCR1nZRV8TEenJiyII6tzx
    5n/DCVu6M712fF7phWV+dvi+DUOBDQT70NEfIkUkMNU4jB59C6kgDRzuewDJPzw6
    CGJsCHfnUFnpyjKF/ptCog6zw1jFmOtZGzWrZlKK+54dNA+K5Mx9bvme8TOloPr2
    LXZOHfvCI7JOkJ6y78HoeMl67HOY1/qZvXdvY8NfYYYFaVGfxEzn/hKXLi3mor1/
    gml5hlSXReFdF/07GKcrG/wcC7E4RwAikONMshfJ+PvRMKduwUacX4+6wIKOa9Ta
    IMgS1nXWf8HvQadTLRPneINA/kklSRfkGpN9e5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521445928; bh=sQPjGERTuNVnLs4WZVMiuMhjXe
    qCGB7liOhADzdsbTA=; b=tr5g1U6uhtsEO3ftRlAfYw+BhChk2BJJRE5khFiulI
    nUKfjTwNmDfC/dry+zn1+UdeMrnvDgYS1/WVqPFqbccLT7IOuLH2nI6BNFRPVl0J
    M9lua7vX02cy1q6SRF+dqxxbFkNSdPU/NlexViJP0JhMgdlMAXifzG/D0uXIcVwY
    OuEW3WNQOciSwZcQgbFkFZSHCoWlf76Q+cJ0isWS5cN8DQdy1T1v5z0TRVo+ku8h
    37Lgs07AdVbXHjuBAc0cL7Yz2wiGha8pr7nfJiy+8Sa25eChI/H17KBr4hwEn1LJ
    36VKV+rzXtt8WoK4mWC5wSQIAjrXvFajEK0iMkv3qx2Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduudehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfshhpjeesthdtredttdervdenucfhrhhomhepgghinhhougcumfhouhhluceovhhinhhougdrkhhouhhlsehinhhtvghlrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpddufeegrddufeegrddufeeirdefudenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehieelieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduudehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfshhpjeesthdtredttdervdenucfhrhhomhepgghinhhougcumfhouhhluceovhhinhhougdrkhhouhhlsehinhhtvghlrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpddufeegrddufeegrddufeeirdefudenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehieelieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755329AbeCSHwF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 03:52:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:5384 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754524AbeCSHwE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 03:52:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,329,1517904000";
   d="scan'208";a="26831891"
Date: Mon, 19 Mar 2018 13:26:09 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdmac: fix rare residue corruption
Message-ID: <20180319075608.GM15443@localhost>
References: <20180222113955.4043-1-maxime.jayat@mobile-devices.fr>
 <20180301082516.GL22457@rfolt0960.corp.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301082516.GL22457@rfolt0960.corp.atmel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 09:25:16AM +0100, Ludovic Desroches wrote:
> Hi Maxime,
> 
> On Thu, Feb 22, 2018 at 12:39:55PM +0100, Maxime Jayat wrote:
> > Despite the efforts made to correctly read the NDA and CUBC registers,
> > the order in which the registers are read could sometimes lead to an
> > inconsistent state.
> > 
> > Re-using the timeline from the comments, this following timing of
> > registers reads could lead to reading NDA with value "@desc2" and
> > CUBC with value "MAX desc1":
> > 
> >  INITD --------                    ------------
> >               |____________________|
> >        _______________________  _______________
> >  NDA       @desc2             \/   @desc3
> >        _______________________/\_______________
> >        __________  ___________  _______________
> >  CUBC       0    \/ MAX desc1 \/  MAX desc2
> >        __________/\___________/\_______________
> >         |  |          |  |
> > Events:(1)(2)        (3)(4)
> > 
> > (1) check_nda = @desc2
> > (2) initd = 1
> > (3) cur_ubc = MAX desc1
> > (4) cur_nda = @desc2
> > 
> > This is allowed by the condition ((check_nda == cur_nda) && initd),
> > despite cur_ubc and cur_nda being in the precise state we don't want.
> > 
> > This error leads to incorrect residue computation.
> > 
> > Fix it by inversing the order in which CUBC and INITD are read. This
> > makes sure that NDA and CUBC are always read together either _before_
> > INITD goes to 0 or _after_ it is back at 1.
> > The case where NDA is read before INITD is at 0 and CUBC is read after
> > INITD is back at 1 will be rejected by check_nda and cur_nda being
> > different.
> > 
> > Fixes: 53398f488821 ("dmaengine: at_xdmac: fix residue corruption")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
> 
> Nice work! I agree with the change you propose.
> 
> I am disappointed we didn't spot this case so I would like to double-check with
> the hardware guy there is no issue with the sequence you propose. That's
> why I am waiting a bit before giving my ack.

any update on that? This has been pending for a while...

> 
> Regards
> 
> Ludovic
> 
> > ---
> > Hi,
> > 
> > I had a bug where the serial ports on the Atmel SAMA5D2 were sometimes
> > returning the same data twice, for up to 4096 bytes.
> > 
> > After investigation, I noticed that the ring buffer used in
> > atmel_serial (in rx dma mode) had sometimes a incorrect "head" value,
> > which made the ring buffer do a complete extraneous loop of data
> > pushed to the tty layer.
> > 
> > I tracked it down to the residue of the dma being wrong, and after
> > more head scratching, I found this bug in the reading of the
> > registers.
> > 
> > Before fixing this, I was able to reproduce the bug reliably in a few
> > minutes. With this patch applied, the bug did not reappear after
> > several hours in testing.
> > 
> > 
> >  drivers/dma/at_xdmac.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> > index c00e3923d7d8..94236ec9d410 100644
> > --- a/drivers/dma/at_xdmac.c
> > +++ b/drivers/dma/at_xdmac.c
> > @@ -1471,10 +1471,10 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> >  	for (retry = 0; retry < AT_XDMAC_RESIDUE_MAX_RETRIES; retry++) {
> >  		check_nda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA) & 0xfffffffc;
> >  		rmb();
> > -		initd = !!(at_xdmac_chan_read(atchan, AT_XDMAC_CC) & AT_XDMAC_CC_INITD);
> > -		rmb();
> >  		cur_ubc = at_xdmac_chan_read(atchan, AT_XDMAC_CUBC);
> >  		rmb();
> > +		initd = !!(at_xdmac_chan_read(atchan, AT_XDMAC_CC) & AT_XDMAC_CC_INITD);
> > +		rmb();
> >  		cur_nda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA) & 0xfffffffc;
> >  		rmb();
> >  
> > -- 
> > 2.14.1
> > 

-- 
~Vinod
