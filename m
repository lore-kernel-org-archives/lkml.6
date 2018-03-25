Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeCYWMQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:12:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57255 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbeCYWMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:12:15 -0400
Date: Mon, 26 Mar 2018 00:12:13 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] genirq: Pass desc to __irq_free instead of irq number
Message-ID: <20180325221213.ub5vurux7dqdkldd@pengutronix.de>
References: <20180319105202.9794-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180319105202.9794-1-u.kleine-koenig@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 19, 2018 at 11:52:02AM +0100, Uwe Kleine-König wrote:
> Given that irq_to_desc() is a radix_tree_lookup and the reverse
> operation is only a pointer dereference and that all callers of
> __free_irq already have the desc, pass the desc instead of the irq
> number.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> this is a micro optimisation I noticed while looking at the irq code.

This made it into next as 83ac4ca943affce56a2c408ddb2f5232f478fb11 and
ba63053f018721a0ad60b083e21a15e324a4a8c4. Is it right that it is there
twice? And in the Author line the - in my name is missing. Would be
great if that could be fixed up.

Something like:

	git filter-branch -f --env-filter 'test "$GIT_AUTHOR_NAME" != "Uwe Kleine König" || GIT_AUTHOR_NAME="Uwe Kleine-König"' linus/master..

should do the trick.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
