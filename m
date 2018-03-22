Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbeCVVRz convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:17:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:47031 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751661AbeCVVRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:17:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,345,1517904000";
   d="scan'208";a="26244244"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>
CC: X86 ML <x86@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when
 FS/GS updated by ptracer
Thread-Topic: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when
 FS/GS updated by ptracer
Thread-Index: AQHTv61cgKpKrSnds0atXlLhYuaZSaPZns+A//+jdICAAP9OgIAAfB0AgAElGwCAAHavgIAAe5+A//+VaACAAHdSAP//4dlL
Date: Thu, 22 Mar 2018 21:17:49 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66AC932C@CRSMSX101.amr.corp.intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-15-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXb5RRuAnKpU2_3Rac4F4tbv1Z+UHU6=QrYk-GCSLv4cw@mail.gmail.com>
 <C78DE381-C618-4370-9B06-F6E25C850661@intel.com>
 <CALCETrX03_AG-OuJdmfmsbvEt0UTdUpaUVDRQgbDZWGY7WD-Xw@mail.gmail.com>
 <E9221EFA-636C-4D36-AEBA-3A1EEBBF2F50@intel.com>
 <CALCETrUxQ1XOs7V1XKOsk-iQ-qOwn41sWGYkepkVOE7PtfX24A@mail.gmail.com>
 <9C732DC6-F9CA-474F-B8F5-F8EBE406B12E@intel.com>
 <CALCETrWyuDC9Visx2-7rwpicVfS3wVMVFBykysaYcoBBe2y+tg@mail.gmail.com>
 <E3872173-6EDB-4861-896E-4D636A5A9B55@intel.com>,<CALCETrUZk0m2-aJpzBbUR1-rSZkKCX6hKS3K3O_3LQJSkKKKGg@mail.gmail.com>
In-Reply-To: <CALCETrUZk0m2-aJpzBbUR1-rSZkKCX6hKS3K3O_3LQJSkKKKGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.9.46]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


________________________________________
From: Andy Lutomirski [luto@kernel.org]
Sent: Thursday, March 22, 2018 09:53
>>> But your patch doesn't actually do this, since gdb will just do
>>> SETREGS anyway, right?
>> GDB does SETREGS on any exclusive (FS/GS) updates in inferior call.

> This means that your patch has exactly the same effect as the code in
> my git tree, right?  Then let's stick with something like what's in my
> git tree, since it's far simpler.

Difference is if flipping FS/GS multiple times, user may check the base from LDT.
But I don't have strong will to keep arguing this; Markus or somebody might 
want to say something.

The whole point as I understand is to avoid any regression on legacy ptracers.
If a strong confidence lies on the simple version, let me. My first thought bought
this in fact.

Thanks,
Chang
