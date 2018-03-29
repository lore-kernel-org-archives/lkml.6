Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeC2Q3O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:29:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:22417 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeC2Q3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:29:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="41832985"
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        David Rientjes <rientjes@google.com>,
        "Igor Mammedov" <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>,
        "brice.goglin@gmail.com" <brice.goglin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] x86,sched: allow topologies where NUMA nodes share
 an LLC
Thread-Topic: [PATCH v3] x86,sched: allow topologies where NUMA nodes share
 an LLC
Thread-Index: AQHTxvDcp+bGdkoMwkiI93HntJp34qPnp64AgAAItoCAAA1MAIAAGlYAgAAEgYD//4r/AA==
Date: Thu, 29 Mar 2018 16:29:10 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B3BAF7B@ORSMSX110.amr.corp.intel.com>
References: <20180329000024.GA16648@alison-desk.jf.intel.com>
 <alpine.DEB.2.21.1803291505590.1477@nanos.tec.linutronix.de>
 <20180329134723.GA4043@hirez.programming.kicks-ass.net>
 <8a24d82e-a8dd-2f35-4764-a58fd6c64ae8@linux.intel.com>
 <20180329160914.GR4082@hirez.programming.kicks-ass.net>
 <224bbc83-125d-0507-92af-5b6b4af62834@linux.intel.com>
In-Reply-To: <224bbc83-125d-0507-92af-5b6b4af62834@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWZiZmEyOWEtZmJmMy00Y2VmLWJmMmQtNGNhY2U3ODIyNTkxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJWY2lmS1lxaEl4d1Y3T1RkblE1WHluc0R1K1ZSc0tjS2Z5amZNdWNjc1RiTkJ6dm54QlpkZHNmdncwOSs3K3haIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2TGTK5U024714

> Hmm, if we shrink llc-size by splitting it, do we also need to create a
> unique "id" for each slice?

RDT uses the cache id ... but it doesn't play well with cluster on die mode ... so our
recommendation is to not use RDT if COD mode is enabled.

If the result of these changes happens to be some easy way for RDT to tell that
COD mode is on, we'll add a check to the init/mount code to enforce not using
them together.

-Tony
