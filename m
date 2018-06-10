Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id v8OiCXTJHFv2bwAAmS7hNA
	; Sun, 10 Jun 2018 06:47:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0791D60850; Sun, 10 Jun 2018 06:47:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 41E10604D4;
	Sun, 10 Jun 2018 06:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41E10604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932270AbeFJGrL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 02:47:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:38537 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932183AbeFJGrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 02:47:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5A6krn3008435;
        Sun, 10 Jun 2018 01:46:55 -0500
Message-ID: <626a3d2bc30dac29c06ab44fb2c56d17095fca51.camel@kernel.crashing.org>
Subject: Re: [PATCH 00/15] fsi: Overall improvements and new SBE fifo driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>
Date: Sun, 10 Jun 2018 16:46:53 +1000
In-Reply-To: <CACPK8XdvnGHz6Om2RQmgu+7F4h9AEh+Ay=A_b4+3vDGqD4SKbA@mail.gmail.com>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
         <CACPK8XdvnGHz6Om2RQmgu+7F4h9AEh+Ay=A_b4+3vDGqD4SKbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Greg, see below)

On Tue, 2018-05-29 at 22:00 +0930, Joel Stanley wrote:
> On 29 May 2018 at 11:00, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > This series brings in a number of improvements to our FSI stack
> > (one of the service interfaces for communicating between a BMC chip and
> > our POWER processors).
> > 
> > The GPIO based "Soft FSI" performance is significantly improved, and
> > it's reliability as well.
> > 
> > The SBE fifo driver provides the interface to the processor "Self Boot
> > Engine"
> > 
> > Some of these patches have been simmering for a while in the OpenBMC
> > tree.
> 
> I run this series atop of 4.17-rc7 today, and they look solid.
> 
> Tested-by: Joel Stanley <joel@jms.id.au>

So how do we proceed ? I have more coming on top of this, but we should
start with getting this series merged.

Greg, should we create a FSI git repo with a 3-member maintainer team
(Jeremy, Chris and myself) and send you pull requests ? Or are you
happy to continue picking up patches ?

We have more stuff to come in there, including support for a HW master
contoller in a future BMC chip, some more slave drivers, etc..

It also looks like the s390 guys might start using some of that as well
(their chips use FSI as well, so far they used our old service
processor which uses an ancient non-uptream set of drivers & stack, but
that's likely to change).

Cheers,
Ben.

> Cheers,
> 
> Joel
