Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbeBPVJd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:09:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:36926 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750899AbeBPVJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:09:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="28657194"
From: "Luck, Tony" <tony.luck@intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joe Konno <joe.konno@linux.intel.com>,
        "Matthew Garrett" <mjg59@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Andi Kleen <ak@linux.intel.com>,
        Benjamin Drung <benjamin.drung@profitbricks.com>,
        Peter Jones <pjones@redhat.com>
Subject: RE: [PATCH 0/2] efivars: reading variables can generate SMIs
Thread-Topic: [PATCH 0/2] efivars: reading variables can generate SMIs
Thread-Index: AQHTpon7j1fhMwo5i0OsVK07IpAnmqOnXoKAgACqgID//3z6QA==
Date: Fri, 16 Feb 2018 21:09:30 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B37942B@ORSMSX110.amr.corp.intel.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
         <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
 <1518814319.4419.10.camel@HansenPartnership.com>
In-Reply-To: <1518814319.4419.10.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGU4OWM5NDUtZThkMS00ZDU3LThlYTktNTA3ZTMxNTFlZWRkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJcL29HKzRBZ3krc3RjSE5WRnNzSjgxTktjVUk5RXpWeHVGVXA5SlY1Y08zbzA1SDNzR1dkZ05Pc1VkbitWM2szTiJ9
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1GL9b2M027539

> That said, I'm not sure how many non-root users run the toolkit to
> extract their EFI certificates or check on the secure boot status of
> the system, but I suspect it might be non-zero: I can see the tinfoil
> hat people wanting at least to check the secure boot status when they
> log in.

Another fix option might be to rate limit EFI calls for non-root users (on X86
since only we have the SMI problem). That would:

1) Avoid using memory to cache all the variables
2) Catch any other places where non-root users can call EFI

-Tony
