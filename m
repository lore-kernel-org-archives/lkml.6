Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936126AbeCHSKC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 13:10:02 -0500
Received: from mga01.intel.com ([192.55.52.88]:32067 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933221AbeCHSJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 13:09:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,441,1515484800";
   d="scan'208";a="33456795"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Lee@vger.kernel.org" <Lee@vger.kernel.org>, Chun-Yi <jlee@suse.com>,
        Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Zijlstra, Peter" <peter.zijlstra@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH V2 2/3] efi: Introduce efi_rts_workqueue and some
 infrastructure to invoke all efi_runtime_services()
Thread-Topic: [PATCH V2 2/3] efi: Introduce efi_rts_workqueue and some
 infrastructure to invoke all efi_runtime_services()
Thread-Index: AQHTtNngYFyf2e7B30yWdA6aWmV0oqPFMqUAgACLVvCAANmVgIAAD2Gg
Date: Thu, 8 Mar 2018 18:09:56 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F2E581AE7@ORSMSX114.amr.corp.intel.com>
References: <1520292190-5027-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1520292190-5027-3-git-send-email-sai.praneeth.prakhya@intel.com>
 <CANiq72m6_WCXSrBPesgvO1rsF1_AT5Jod_rY-y1f4JjO-SMCDg@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F2E5817F2@ORSMSX114.amr.corp.intel.com>
 <CANiq72krjVviT0mPqpK5jbLWEbDx_OhG6+eUmyT8thZPEjkJKg@mail.gmail.com>
In-Reply-To: <CANiq72krjVviT0mPqpK5jbLWEbDx_OhG6+eUmyT8thZPEjkJKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzAwZDBjYzItNDEyNy00ZjQ1LTgzOGQtZTI5ZmE4NDJkOWNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiI2XC9GTGhURUdsOGFGZSs0VVY2VmNJOVNlNENcLzZyR2J1cjduZ0c3c2E4UEx0MkJrcXdEaHNyYjFUZlE5TXVWODEifQ==
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w28IA65v001055

/*
> >> > +        * Since we process only one efi_runtime_service() at a time, an
> >> > +        * ordered workqueue (which creates only one execution context)
> >> > +        * should suffice all our needs.
> >> > +        */
> >> > +       efi_rts_wq = alloc_ordered_workqueue("efi_rts_workqueue",
> >> > + 0);
> >>
> >> efi_rts_wq or efi_rts_workqueue?
> >>
> >> > +       if (!efi_rts_wq) {
> >> > +               pr_err("Failed to create efi_rts_workqueue, EFI runtime services "
> >>
> >> Same here.
> >
> > Sure! I will make it consistent with "efi_rts_wq". Just tried to be
> > more verbose with names :)
> >
> 
> It is not a big deal, but using the exact same name is better for the purposes of
> grepping and things like that :-)

Yes, that makes sense.

> By the way, check the commit title/message, there are some others there too.

Sure! I will make changes to commit/title messages too.

Regards,
Sai
