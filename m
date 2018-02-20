Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeBTIwz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:52:55 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60841 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbeBTIwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 03:52:54 -0500
Date: Tue, 20 Feb 2018 09:52:50 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "valdis.kletnieks@vt.edu" <valdis.kletnieks@vt.edu>,
        Jon Masters <jcm@jonmasters.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
In-Reply-To: <CA+55aFzm7zLd5BPtpp9MYMuP8We55bMd7noeLPrXiKfDynO6JA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1802200937330.24268@nanos.tec.linutronix.de>
References: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk> <1518449255-2182-2-git-send-email-dwmw@amazon.co.uk> <7e2e5ad1-49b6-1fdb-4a62-8ad6aefc30a0@redhat.com> <1518509708.12890.33.camel@infradead.org> <27c85759-e662-d281-f8a0-0a80ca8ee18f@redhat.com>
 <1518517262.12890.43.camel@infradead.org> <1518518198.12890.48.camel@infradead.org> <02bd3fdd-1b73-6cab-fb09-38ba933396bd@redhat.com> <1518775136.7876.13.camel@infradead.org> <75287047-77a0-e0ff-c2e8-61c81641251e@redhat.com> <1518776517.7876.21.camel@infradead.org>
 <d61edc94-8a51-62bd-65ed-8068451ca5b5@redhat.com> <1518783021.7876.34.camel@infradead.org> <4882860e-23c5-75b3-ac02-c700f615156e@jonmasters.org> <0575AF4FD06DD142AD198903C74E1CC87A61923C@ORSMSX103.amr.corp.intel.com> <10373.1519084385@turing-police.cc.vt.edu>
 <0575AF4FD06DD142AD198903C74E1CC87A619255@ORSMSX103.amr.corp.intel.com> <20180220001301.70101e1d@alans-desktop> <CA+55aFzm7zLd5BPtpp9MYMuP8We55bMd7noeLPrXiKfDynO6JA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2018, Linus Torvalds wrote:
> On Mon, Feb 19, 2018 at 4:13 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> >
> > In theory there's nothing stopping a guest getting a 'you are about to
> > gain/lose IBRS' message or having a new 'CPU' hotplugged and the old one
> > removed.
> 
> I'm not convinced we handle the case of hotplug CPU's with different
> CPU models correctly.
> 
> In fact, I'd be very surprised it it worked in the general case.

We pretend to work with different CPU models mostly by having per cpu
feature bits, but in practice this would fall apart in bits and pieces all
over the place. 

Thanks,

	tglx
