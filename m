Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DAAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30002147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfA2OLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:11:46 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44555 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfA2OLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:11:46 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1goU72-0006hA-Uk; Tue, 29 Jan 2019 15:11:41 +0100
Date:   Tue, 29 Jan 2019 15:11:40 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jessica Yu <jeyu@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Christoph Hellwig <hch@lst.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH][RFC] module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
 bogosity
In-Reply-To: <20190129130658.GA19205@linux-8ccs>
Message-ID: <alpine.DEB.2.21.1901291510060.1513@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de> <20190129130658.GA19205@linux-8ccs>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Jessica Yu wrote:
> +++ Thomas Gleixner [28/01/19 23:38 +0100]:
> > +    "GPL"			  Module is licensed under GPL version 2. This
> > +				  does not express any distinction between
> > +				  GPL-2.0-only or GPL-2.0-or-later. The exact
> > +				  license information can only be determined
> > +				  via the license information in the
> > +				  corresponding source files.
> > +
> > +    "GPL v2"			  Same as "GPL v2". It exists for historic
> > +				  reasons.
> 
> Did you mean to say 'Same as "GPL"' here? (as in, "GPL v2" conveys the same
> information as the "GPL" module license string)

Of course. After staring at all this for too long I confused myself and did
not spot it even if I read through the whole thing several times.

> > +
> > +    "GPL and additional rights"   Historical variant of expressing that the
> > +				  module source is dual licensed under a
> > +				  GPL v2 variant and MIT license. Please do
> > +				  not use in new code.
> > +
> > +    "Dual MIT/GPL"		  The correct way of expressing that the
> > +				  module is dual licensed under a GPL v2
> > +				  variant or MIT license choice.
> > +
> > +    "Dual BSD/GPL"		  The module is dual licensed under a GPL v2
> > +				  variant or BSD license choice. The exact
> > +				  variant of the BSD license can only be
> > +				  determined via the license information
> > +				  in the corresponding source files.
> > +
> > +    "Dual MPL/GPL"		  The module is dual licensed under a GPL v2
> > +				  variant or Mozilla Public License (MPL)
> > +				  choice. The exact variant of the MPL
> > +				  license can only be determined via the
> > +				  license information in the corresponding
> > +				  source files.
> > +
> > +    "Proprietary"		  The module is under a proprietary license.
> > +				  This string is soleley for proprietary third
> 
> s/soleley/solely/
> 
> Otherwise looks good. Thanks for clearing this all up.

Thanks for having a sharp look!

       tglx
