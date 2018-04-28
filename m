Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759672AbeD1I3L (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 04:29:11 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34167 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759588AbeD1I3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 04:29:08 -0400
X-Google-Smtp-Source: AB8JxZqL83v/A25oLhMb/Sw+vZTOwY6+ORiwDUTrnKw0cpGvtKXoraOGSJyew7bXfPMayLkTU9u3Fw==
Date: Sat, 28 Apr 2018 10:29:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxram@us.ibm.com,
        tglx@linutronix.de, dave.hansen@intel.com, mpe@ellerman.id.au,
        akpm@linux-foundation.org, shuah@kernel.org, shakeelb@google.com
Subject: Re: [PATCH 0/9] [v3] x86, pkeys: two protection keys bug fixes
Message-ID: <20180428082904.ekzsbqx3ohqxygbg@gmail.com>
References: <20180427174527.0031016C@viggo.jf.intel.com>
 <20180428070553.yjlt22sb6ntcaqnc@gmail.com>
 <20180428071538.3whanph7r6v56h2a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428071538.3whanph7r6v56h2a@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> The hang problem is still there, if I run a script like this:
> 
>  while :; do date; echo -n "32-bit: "; ./protection_keys_32 >/dev/null; date; echo -n "64-bit: "; ./protection_keys_64 >/dev/null; done
> 
> then within a minute one of the testcases hangs reliably.
> 
> Out of 4 attempts so far one hang was in the 32-bit testcase, 3 hangs were in the 
> 64-bit testcase - so 64-bit appears to trigger it more frequently.

Note that even with all fixes in this series applied the self-test hang still 
triggers.

Thanks,

	Ingo
