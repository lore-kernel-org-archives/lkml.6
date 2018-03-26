Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbeCZJn3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:43:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45167 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeCZJn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:43:28 -0400
Date: Mon, 26 Mar 2018 11:43:27 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] genirq: Pass desc to __irq_free instead of irq number
In-Reply-To: <20180325221213.ub5vurux7dqdkldd@pengutronix.de>
Message-ID: <alpine.DEB.2.21.1803261141230.1585@nanos.tec.linutronix.de>
References: <20180319105202.9794-1-u.kleine-koenig@pengutronix.de> <20180325221213.ub5vurux7dqdkldd@pengutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-882585705-1522057407=:1585"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-882585705-1522057407=:1585
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 26 Mar 2018, Uwe Kleine-König wrote:
> 
> On Mon, Mar 19, 2018 at 11:52:02AM +0100, Uwe Kleine-König wrote:
> > Given that irq_to_desc() is a radix_tree_lookup and the reverse
> > operation is only a pointer dereference and that all callers of
> > __free_irq already have the desc, pass the desc instead of the irq
> > number.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> > 
> > this is a micro optimisation I noticed while looking at the irq code.
> 
> This made it into next as 83ac4ca943affce56a2c408ddb2f5232f478fb11 and
> ba63053f018721a0ad60b083e21a15e324a4a8c4. Is it right that it is there
> twice?

No. It's only one instance.

> And in the Author line the - in my name is missing. Would be great if
> that could be fixed up.

Sorry, I'm surely not rebasing that branch just to add a missing dash.

Thanks,

	tglx
--8323329-882585705-1522057407=:1585--
