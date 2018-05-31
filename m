Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750831AbeEaVDL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:03:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:46741 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750738AbeEaVDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:03:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="60250768"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 01/15] x86/fsgsbase/64: Introduce FS/GS base helper
 functions
Thread-Topic: [PATCH V2 01/15] x86/fsgsbase/64: Introduce FS/GS base helper
 functions
Thread-Index: AQHT+QkbMOVz9zP+IUmxbRlouJz4eaRKql0A//+oXAA=
Date: Thu, 31 May 2018 21:03:00 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66BB9450@CRSMSX101.amr.corp.intel.com>
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
 <1527789525-8857-2-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXp5at9nQgz0x9TZOpajDGfbMhQXM-igBFjrQGJ_w_Wsg@mail.gmail.com>
In-Reply-To: <CALCETrXp5at9nQgz0x9TZOpajDGfbMhQXM-igBFjrQGJ_w_Wsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmU1NTJiYTMtOTA3Ni00ZGY2LThjZWUtZTg5OWI3MjkyYjA4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJ4eEFcL2FUbjV3WEttM2VaVVA3MFY1aG53NVBiMEVjSnlmNDZmbEU4d1lQd1FZQ2JvUE1aZ0JJS1BvZHBMRXhIMCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4VL3EB0009888

>> Notion of "active" and "inactive" are used to distinguish
>> GS bases between "kernel" and "user". "inactive" GS base
>> is the GS base, backed up at kernel entries, of inactive
>> (user) task's.

> I'm fine with the code, but the changelog entry is confusing.  A bunch
> of the active helpers don't contain the term "active".

Okay, will take "active" out from the note.

>> +/*
>> + * Read/write an (inactive) task's fsbase or gsbase. This returns
>> + * the value that the FS/GS base would have (if the task were to be
>> + * resumed). The current task is also supported.
>> + */

> Please change to "Read/write a task's fsbase or gsbase. ... These work
> on current or on a different non-running task."

Will do that.

>> +
>> +unsigned long read_task_fsbase(struct task_struct *task)
>> +{
>> +       unsigned long fsbase;
>> +
>> +       if (task == current)
>> +               fsbase = read_fsbase();
>> +       else
>> +               /*
>> +                * XXX: This will not behave as expected if called
>> +                * if fsindex != 0
>> +                */
>> +               fsbase = task->thread.fsbase;
>> +

> Please put braces around the if and else blocks whenever either of
> them spans multiple lines.  Also, maybe change add a note to the
> comment and/or the changelog that this is preserving an existing bug
> and that it's fixed later in the series.

Okay, thanks.
