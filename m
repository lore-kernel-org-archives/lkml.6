Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751633AbeBTOIc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 09:08:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:61754 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751203AbeBTOI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 09:08:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,539,1511856000";
   d="scan'208";a="205546158"
From: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        "valdis.kletnieks@vt.edu" <valdis.kletnieks@vt.edu>
CC: Jon Masters <jcm@jonmasters.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>
Subject: RE: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
Thread-Topic: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
Thread-Index: AQHTpBYQl8Dyc4mRm0iZ20KRHB9/vaOif+eAgAADjgCAABy9AIAABnAAgAAEXACAAAFigIAEqxQAgAACw4CAAAOrgIAAC+oAgAASX4CABXcSgP//eu2wgACJV4D//3ujYIABSuKA//+iJWA=
Date: Tue, 20 Feb 2018 14:08:26 +0000
Message-ID: <0575AF4FD06DD142AD198903C74E1CC87A619465@ORSMSX103.amr.corp.intel.com>
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
 <aa3fbaf1-0efc-64b1-4f7b-3d00b0493d48@redhat.com>
In-Reply-To: <aa3fbaf1-0efc-64b1-4f7b-3d00b0493d48@redhat.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1KE8bxO031538

> >> For bonus points:  What should happen to a VM that is live migrated
> >> from one hypervisor to another, and the hypervisors have different
> >> IBRS support?
> >
> > Doctor Doctor it hurts when I do this....
> >
> > Migration tends to only work between HV's that are relatively
> > homogeneous, that's nothing new...
> 
> No Arjan, this is just wrong.  Well, I suppose it's right in the present
> tense with the IBRS mess on Skylake, but it's _not_ been true until last
> year.


I meant software wise. You're not going to live migrate from xen to kvm or backwards. or between very radically different versions of the kvm stack.
