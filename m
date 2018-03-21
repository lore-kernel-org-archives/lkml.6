Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeCUPPm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:15:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:46850 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752200AbeCUPPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:15:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,340,1517904000";
   d="scan'208";a="184760150"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>
CC: X86 ML <x86@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/15] x86: Enable FSGSBASE instructions
Thread-Topic: [PATCH 00/15] x86: Enable FSGSBASE instructions
Thread-Index: AQHTv61V3qMp+UmTzky3sKjvzQBrlKPZnvsAgAAAXQD//6L7AIAA/UYAgAB/MwA=
Date: Wed, 21 Mar 2018 15:15:35 +0000
Message-ID: <CC541B7E-C639-49EA-A6D9-626E5C2F6723@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXCRYvLthy2FMccoDhnPzyPT5J_hcvD63e-DM9okVaxeg@mail.gmail.com>
 <CALCETrXwRoCyOMd0jTmY7zzt6asvB8ac0KCoHOyZgYhJyuhEVw@mail.gmail.com>
 <3EEB68A1-2C6B-4E8F-B400-1893E49DA1B2@intel.com>
 <CALCETrU9DiumP9ODKm-dW-MubJSmkFKjGkSJyw34-WbxAK0Xrw@mail.gmail.com>
In-Reply-To: <CALCETrU9DiumP9ODKm-dW-MubJSmkFKjGkSJyw34-WbxAK0Xrw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
x-originating-ip: [10.254.180.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A00E92B6F8C214789267F47E30ED13F@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2LFFnid015803

> Summary please.

These deltas I found as comparing with your old codes [4]
* Paranoid entry changes to avoid vulnerability 
* Ptrace changes to support the legacy behavior (conditionally)
* Dropped [1] to be aligned with what is concluded in [3]
* Dropped [2] since save_fsgs() doesn’t copy base when index is zero; now open code with FSGSBASE instructions.
* Re-wrote assembly macros and dropped (redundant) SWAPGS intrinsic
* Revised helper functions -- dropped unused helpers and factor out write_task_fs/gsbase
* Introducing all of helper functions at the beginning of patch series
* Factor out load_fsgs()
* One of the test cases will be included later (as published 15 patches already)

[1] Refresh FS and GS when modify_ldt changes an entry
https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fsgsbase&id=fbe2c2a0ba5b879f8229ca7dfc0d434dbe31a805
[2] When copying a thread, safe FS and GS for real
https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fsgsbase&id=e51eceeefbd587b514ca357b745b46e8e2746d34 
[3] FSGSBASE ABI discussion
https://marc.info/?l=linux-kernel&m=150212735223392&w=2 
[4] https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/fsgsbase     
