Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeCIIhE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:37:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:21897 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbeCIIhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:37:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,444,1515484800";
   d="scan'208";a="33649772"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>, "Borislav Petkov" <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH 07/12] efi: Use efi_mm in x86 as well as ARM
Thread-Topic: [PATCH 07/12] efi: Use efi_mm in x86 as well as ARM
Thread-Index: AQHTtrPK9lah9E/Y50aW5dd4kdO5vqPIDIUA//+I8OA=
Date: Fri, 9 Mar 2018 08:37:00 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F2E581F50@ORSMSX114.amr.corp.intel.com>
References: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
 <20180308080020.22828-8-ard.biesheuvel@linaro.org>
 <20180309074034.put3ko6zxmaoizzr@gmail.com>
In-Reply-To: <20180309074034.put3ko6zxmaoizzr@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWUxMzczZjktOGJiYy00YzY1LWFjNDktN2U5YjA4OTNjNDVhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJrdmNuWHozaDJ6ekNHT3VWYzNPZGh3UmpKTlJ0NDlHT2oxN2l3RUNVV1VNaHdjT0RDcWFFWkRBTjVcL2YrWGk2dSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/include/linux/efi.h b/include/linux/efi.h index
> > f5083aa72eae..f1b7d68ac460 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -966,6 +966,8 @@ extern struct efi {
> >  	unsigned long flags;
> >  } efi;
> >
> > +extern struct mm_struct efi_mm;
> > +
> >  static inline int
> >  efi_guidcmp (efi_guid_t left, efi_guid_t right)  {
> 
> Ugh, I can see three problems with this patch:
> 
> 1)
> 
> Why is the low level asm/efi.h header polluted with two of the biggest header
> files in existence, to add a type to _another_ header (efi.h)?
> 
> 2)
> 
> Why is <linux/sched/task.h> included if what is being relied on is mm_struct?
> 
> 3)
> 
> But even <linux/sched/mm.h> looks unnecessary in efi.h, a simple forward
> declaration of mm_struct would do ...
> 
> The high level MM and sched headers should be added to the actual .c files that
> make use of them.

Ok, makes sense.
Sorry! for that. I will fix the issues.

Regards,
Sai
