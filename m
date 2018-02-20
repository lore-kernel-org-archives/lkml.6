Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932322AbeBTBIg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 20:08:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:26280 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932273AbeBTBIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 20:08:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,537,1511856000";
   d="scan'208";a="205422369"
From: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC: "valdis.kletnieks@vt.edu" <valdis.kletnieks@vt.edu>,
        Jon Masters <jcm@jonmasters.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>
Subject: RE: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
Thread-Topic: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
Thread-Index: AQHTpBYQl8Dyc4mRm0iZ20KRHB9/vaOif+eAgAADjgCAABy9AIAABnAAgAAEXACAAAFigIAEqxQAgAACw4CAAAOrgIAAC+oAgAASX4CABXcSgP//eu2wgACJV4D//3ujYIAAie+AgAAInACAAAVygP//ewJA
Date: Tue, 20 Feb 2018 01:08:32 +0000
Message-ID: <0575AF4FD06DD142AD198903C74E1CC87A619290@ORSMSX103.amr.corp.intel.com>
References: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk>
        <1518449255-2182-2-git-send-email-dwmw@amazon.co.uk>
        <7e2e5ad1-49b6-1fdb-4a62-8ad6aefc30a0@redhat.com>
        <1518509708.12890.33.camel@infradead.org>
        <27c85759-e662-d281-f8a0-0a80ca8ee18f@redhat.com>
        <1518517262.12890.43.camel@infradead.org>
        <1518518198.12890.48.camel@infradead.org>
        <02bd3fdd-1b73-6cab-fb09-38ba933396bd@redhat.com>
        <1518775136.7876.13.camel@infradead.org>
        <75287047-77a0-e0ff-c2e8-61c81641251e@redhat.com>
        <1518776517.7876.21.camel@infradead.org>
        <d61edc94-8a51-62bd-65ed-8068451ca5b5@redhat.com>
        <1518783021.7876.34.camel@infradead.org>
        <4882860e-23c5-75b3-ac02-c700f615156e@jonmasters.org>
        <0575AF4FD06DD142AD198903C74E1CC87A61923C@ORSMSX103.amr.corp.intel.com>
        <10373.1519084385@turing-police.cc.vt.edu>
        <0575AF4FD06DD142AD198903C74E1CC87A619255@ORSMSX103.amr.corp.intel.com>
        <20180220001301.70101e1d@alans-desktop>
        <CA+55aFzm7zLd5BPtpp9MYMuP8We55bMd7noeLPrXiKfDynO6JA@mail.gmail.com>
 <20180220010319.19c60053@alans-desktop>
In-Reply-To: <20180220010319.19c60053@alans-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1K18fTA001112

> > On Mon, Feb 19, 2018 at 4:13 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> wrote:
> > >
> > > In theory there's nothing stopping a guest getting a 'you are about to
> > > gain/lose IBRS' message or having a new 'CPU' hotplugged and the old one
> > > removed.
> >
> > I'm not convinced we handle the case of hotplug CPU's with different
> > CPU models correctly.
> 
> We don't. And even if we did the user space doesn't. It would be a
> painful task to resolve.


in a cloud world it ends up being the launch/restart of the VM in reality.
Just the JIT caches all over in userspace make this case not pretty.

And we as kernel don't even really do mixed cpus without hotplug afaict
(other than maybe taking lowest subset, while the case here would be the opposite direction)
