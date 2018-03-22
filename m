Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeCVPpa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:45:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:47781 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750863AbeCVPp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:45:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,345,1517904000";
   d="scan'208";a="37229577"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>
CC: X86 ML <x86@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when
 FS/GS updated by ptracer
Thread-Topic: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when
 FS/GS updated by ptracer
Thread-Index: AQHTv61cgKpKrSnds0atXlLhYuaZSaPZns+A//+jdICAAP9OgIAAfB0AgAElGwCAAHavgA==
Date: Thu, 22 Mar 2018 15:45:25 +0000
Message-ID: <9C732DC6-F9CA-474F-B8F5-F8EBE406B12E@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-15-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXb5RRuAnKpU2_3Rac4F4tbv1Z+UHU6=QrYk-GCSLv4cw@mail.gmail.com>
 <C78DE381-C618-4370-9B06-F6E25C850661@intel.com>
 <CALCETrX03_AG-OuJdmfmsbvEt0UTdUpaUVDRQgbDZWGY7WD-Xw@mail.gmail.com>
 <E9221EFA-636C-4D36-AEBA-3A1EEBBF2F50@intel.com>
 <CALCETrUxQ1XOs7V1XKOsk-iQ-qOwn41sWGYkepkVOE7PtfX24A@mail.gmail.com>
In-Reply-To: <CALCETrUxQ1XOs7V1XKOsk-iQ-qOwn41sWGYkepkVOE7PtfX24A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
x-originating-ip: [10.254.180.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <83758ABCBFAA3648BFA83C00F78E14FC@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2MFjZTY001690

On 3/21/18, 18:41, "Andy Lutomirski" <luto@kernel.org> wrote:
> mov to gs changes GSBASE even if GS was unchanged.
In GDB, ptrace (syscall) doesn't happen when FS/GS unchanged as 
its (context) cache seems to be first checked. This does not allow to 
preserve GSBASE as you know.
 
> But it's not clear to me that you've identified any case where
> emulating this behavior is useful.
One argument I heard is (if debugging a legacy application) user
might want to (indirectly) access LDT during inferior call and this 
mov to fs/gs has been useful (maybe needed).
 
