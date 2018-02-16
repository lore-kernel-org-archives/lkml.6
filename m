Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751071AbeBPWCJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 17:02:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:41916 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbeBPWCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 17:02:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="175955782"
From: "Luck, Tony" <tony.luck@intel.com>
To: Matthew Garrett <mjg59@google.com>,
        "luto@kernel.org" <luto@kernel.org>
CC: James Bottomley <James.Bottomley@hansenpartnership.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "joe.konno@linux.intel.com" <joe.konno@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "jk@ozlabs.org" <jk@ozlabs.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "benjamin.drung@profitbricks.com" <benjamin.drung@profitbricks.com>,
        "pjones@redhat.com" <pjones@redhat.com>
Subject: RE: [PATCH 0/2] efivars: reading variables can generate SMIs
Thread-Topic: [PATCH 0/2] efivars: reading variables can generate SMIs
Thread-Index: AQHTpon7j1fhMwo5i0OsVK07IpAnmqOnXoKAgACqgID//3z6QIAAkeyAgAADtYD//3pYwA==
Date: Fri, 16 Feb 2018 22:02:05 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B3795A3@ORSMSX110.amr.corp.intel.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
 <1518814319.4419.10.camel@HansenPartnership.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37942B@ORSMSX110.amr.corp.intel.com>
 <CALCETrXD4qCwgnDcwnybUXzVk7zyJtzHC2xzLfcZvzrXvAB8PQ@mail.gmail.com>
 <CACdnJutPvMPUTWWjS3oRadQAqn+HpRpY+fhO0pXBj6OsQkAAag@mail.gmail.com>
In-Reply-To: <CACdnJutPvMPUTWWjS3oRadQAqn+HpRpY+fhO0pXBj6OsQkAAag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjM0ZjFmZDQtZmVmMi00YWMwLTgwZDktNzdmNDAwOWJkZTFkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJZb2ZITER1Vlwvd2tKdWoyZEFnZ3d2eXhKK2pkTEVvVVJybnQ5OXdkQ1VJYm5JZGxLSzBkaG91RUJGQ01Pcmd6QyJ9
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1GM2CfE018918

> If the default is 600 then it makes sense to allow a privileged service to
> selectively make certain variables world readable at runtime.

As soon as you make one variable world readable you are vulnerable to
a local user launching a DoS attack by reading that variable over and over
generating a flood of SMIs.

-Tony
