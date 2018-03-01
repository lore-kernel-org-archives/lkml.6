Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033043AbeCAQib (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:38:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:52309 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033005AbeCAQi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:38:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="35173016"
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@suse.de>, Yazen Ghannam <Yazen.Ghannam@amd.com>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 0/8] Decode IA32/X64 CPER
Thread-Topic: [PATCH v2 0/8] Decode IA32/X64 CPER
Thread-Index: AQHTsHBDTWX8DJU2o0qxDkwqqFc+OKO7lLbg
Date: Thu, 1 Mar 2018 16:38:24 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B388473@ORSMSX110.amr.corp.intel.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180228084321.GA2969@pd.tnic>
In-Reply-To: <20180228084321.GA2969@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2I2OThkOTgtZGRhMS00MDExLTg5MTQtZDA2NTJlOTM4MDYwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiI1TVl6OW1mZ1RaVHdPczNvOGhXWmlcL0gxNXY3MnB2TnJkeXBJVTE1Nk1tNGl4ZE8yM0V4M1BjYkpneWZlRTIwcyJ9
x-ctpclassification: CTP_NT
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21GcZ2Y027979

> One much more important thing I forgot about yesterday: how is
> this thing playing into our RAS reporting, x86 decoding chain, etc
> infrastructure?
>
> Is CPER bypassing it completely and the firmware is doing everything
> now? I sure hope not.

Intel gives OEMs lots of options to catch and tweak the error path in
BIOS SMM code.  So it is possible that some systems may go into
BIOS which would do platform level analysis and create a CPER to
feed to the OS. Hopefully anyone doing that would clear the machine
check bank and suppress CMCI to avoid double reporting the same
error.

> If not, it needs to tie into our infrastructure and the errors need
> to go into the decoding chain where different things look at them and
> filter them.

Good point.

> Tony, what are your plans here?

Nothing solid yet.

> Perhaps we can finally get MCE decoding on Intel too :-)

It's on a mental list ... I should probably add it to our internal
trackers so that we actually do it sooner rather than in some
distant future.

-Tony 
