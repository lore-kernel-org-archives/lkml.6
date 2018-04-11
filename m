Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeDKMEw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:04:52 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35347 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbeDKMEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:04:51 -0400
X-Google-Smtp-Source: AIpwx49LHq6zpogX9je0J4oap+KdaKZGBlvp/ACL8/AYqvRhFwZO6/D1X6Vo/GBVjOb5HiwYMziPAg==
Date: Wed, 11 Apr 2018 14:04:47 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Song Liu <songliubraving@fb.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf: fuzzer leads to trace_kprobe: Could not insert message
 flood
Message-ID: <20180411120447.2gzrwijrtayjv3eg@gmail.com>
References: <alpine.DEB.2.21.1804101043490.6068@macbook-air>
 <A3B3905F-3364-462A-BE02-B01D52482791@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A3B3905F-3364-462A-BE02-B01D52482791@fb.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Song Liu <songliubraving@fb.com> wrote:

> 
> 
> > On Apr 10, 2018, at 7:48 AM, Vince Weaver <vincent.weaver@maine.edu> wrote:
> > 
> > Author: Song Liu <songliubraving@fb.com>
> > Date:   Wed Dec 6 14:45:15 2017 -0800
> > 
> > When running the perf_fuzzer on a current git checkout my logs are flooded 
> > with messages such as this:
> > [71487.869077] trace_kprobe: Could not insert probe at unknown+0: -22
> > [71488.174479] trace_kprobe: Could not insert probe at unknown+0: -22
> > 
> > Presumably this is due to the introduction of the perf_kprobe PMU in
> > 	commit e12f03d7031a977356e3d7b75a68c2185ff8d155
> > 	Author: Song Liu <songliubraving@fb.com>
> > 	Date:   Wed Dec 6 14:45:15 2017 -0800
> > 
> > Is there a way to get this error disabled, or else rate-limited?
> > 
> > Vince
> 
> Hi Vince, 
> 
> Thanks for the report. 
> 
> This is a new API that creates probe together with perf_event_open(). Based on 
> my limited understanding of perf_fuzzer, it doesn't understand this API, and uses 
> it in an abnormal way. [...]

Vince's point is valid: the kernel log should not be flooded with pointless 
messages as a response to user-space ABI uses ...

Why is there a kernel log message at all, isn't an error returned?

> [...] I would recommend perf_fuzzer to understand this new API and test it. 
> [...]

This bug needs to be fixed: a new API must not effectively DoS fuzzing efforts by 
spamming the kernel log ...

Thanks,

	Ingo
