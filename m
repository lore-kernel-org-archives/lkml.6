Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeBEP65 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:58:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:21046 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752955AbeBEP6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:58:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,465,1511856000";
   d="scan'208";a="15566822"
Date: Mon, 5 Feb 2018 07:58:37 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, luto@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, torvalds@linux-foundation.org
Subject: Re: [PATCH v2 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
Message-ID: <20180205155837.GK30338@tassilo.jf.intel.com>
References: <151776623555.23236.14152911329227555005.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151776624080.23236.1865339140666550495.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180205114250.zd3nbe5yl2mnd54m@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205114250.zd3nbe5yl2mnd54m@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>      - There's various conditional pieces of entry code that run before any 
>        RBP-clobbering C function is called. While none of them has an exploitable 
>        Spectre 'gadget' at the moment, we'd have to consider this for every future
>        change.

The Frame Pointer is always set up in assembler too, just in another macro.

There should be only a few pushes between this clear and the set up,
which are not exploitable.

But yes in the end it doesn't matter much either way so the ifdef
could be removed for slightly nicer looking code.

-Andi
