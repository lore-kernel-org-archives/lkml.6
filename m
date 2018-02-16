Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeBPTcz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:32:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:50902 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750788AbeBPTcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:32:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="28637911"
From: "Luck, Tony" <tony.luck@intel.com>
To: Peter Jones <pjones@redhat.com>, Joe Konno <joe.konno@linux.intel.com>
CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Borislav Petkov <bp@alien8.de>, Matthew Garrett <mjg59@google.com>,
        Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Benjamin Drung <benjamin.drung@profitbricks.com>
Subject: RE: [PATCH 0/2] efivars: reading variables can generate SMIs
Thread-Topic: [PATCH 0/2] efivars: reading variables can generate SMIs
Thread-Index: AQHTpon7j1fhMwo5i0OsVK07IpAnmqOnXoKAgAAD7QCAAADWgIAAAqyAgAACwACAAH3TAIAACXOA//96zpA=
Date: Fri, 16 Feb 2018 19:32:17 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B37917B@ORSMSX110.amr.corp.intel.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
 <20180216105548.GA29042@pd.tnic>
 <CAKv+Gu8qm2wFxY56-eRLkLZB6fRUCmZbZo=4cvo5e4JDFh01Gg@mail.gmail.com>
 <20180216110821.GB29042@pd.tnic>
 <CAKv+Gu_SD6yWJMGbTwGUWXtrgZKPkpANNaGe1PUruTG9j0yhcg@mail.gmail.com>
 <20180216184832.sqreq5zhar3jqdae@jbkonno-saint14>
 <20180216192220.wljl23g533sc3oxg@redhat.com>
In-Reply-To: <20180216192220.wljl23g533sc3oxg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzE4MThkM2QtZDMyMi00MjlkLWEyMWEtMmFjYWQ5YjIwYTVlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiIyblNtdFpcL2w2TnE0SU1mclRlMGZJRnBpenIreDI2T1lyeEg5UVlVUTEyNE5XU0M4RjY1OUM3a2duWFZuMkpMMSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1GJX3Gw018563

> tl;dr: I think changing everything to 0600 is probably completely fine,
> and whitelisting is probably pointless.  

But do you speak for all users? It will just take one person complaining
that efibootmgr no longer shows them what it used to show to bring down
the wrath of Linus on our (specifically Joe's) head for breaking user space.

I've got someone about to start looking at making efivarfs read and save
the values during mount, so all the read-only options can continue to work
without making EFI calls.

This will cost some memory (say 20-30 variables at up to 1K each).

-Tony
