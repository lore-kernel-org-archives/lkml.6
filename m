Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A530CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DFE208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+ScPGxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DFE208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933958AbeFMEIa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 00:08:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56046 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbeFMEI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 00:08:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so2178301wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 21:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ndYyowUvrt3zxVi+c5Qvk58jAdXlVQdWxZQJovoeiVs=;
        b=Q+ScPGxWNY/MixYjrUvOuSSz0rnfY6y5soJkfu7vfGG1vDwXHdzeoE9hKx0b7AXQ8G
         58ZYOtpYi8jn3UTDelFC/uZYt7SZNmtXiVNCzbHhLg/6U0BM3hCEMA5wUNoyfirMrddw
         4OWbVZGalKQ9cr/ziwEEgpN1OuiVgidjBh04Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ndYyowUvrt3zxVi+c5Qvk58jAdXlVQdWxZQJovoeiVs=;
        b=NTBCpgyRWXz6wbS9dw6fpgNpuWnv4FrY0WIWaWN7CZFwBxCaTK4gHpjGjZ34MyVEE/
         hcEVRJyrzDrw0yGGPID+4QU3fElSCeIE6jm9FkRVO6b0LSS80bs2fgnEQt+NHKfoeP+g
         6JFxjos9OEuOHBmInBzXYQDyXDR4sivi7U1+8F3Rp/ODsS6Ic0WX7p2GCd21NjWQUAag
         OPq9Yz/blDu8hCApYThdc9sU/Ll3gY5H0Jq5PZ+ecQn019Vj4x+DsYagIAKmzoAw67Nv
         gUFB1cvnMCxEMDazpBUtysaPXzqK9hls3RNpCwyA3EkSK2oug2G3wGu3qAWmBE9xGQ29
         NUcg==
X-Gm-Message-State: APt69E2Uelh6ZZlsUOAC8WKXCOhXnYkA77x2Bz04cHKsZnmrW3hglET7
        yt8jHfbcF9ak0zk0miVVCtScpUITgsbyrESJr7CnLl2XY6U=
X-Google-Smtp-Source: ADUXVKJdmHuI00aEe0JPWChR5/JrzvLjANTMot8DrPO78ZkFfOf9GFfPJZivCRE3Fe0ro1GvEJYyvgdZhHs2NCEkujU=
X-Received: by 2002:a1c:cc10:: with SMTP id h16-v6mr2059854wmb.155.1528862908154;
 Tue, 12 Jun 2018 21:08:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8ac3:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 21:08:27
 -0700 (PDT)
In-Reply-To: <CALAqxLXg8ry5hdNXhJRWE0vHuGbtP4xg=DWQ4t0w_Z-6MHmEmA@mail.gmail.com>
References: <CALAqxLXg8ry5hdNXhJRWE0vHuGbtP4xg=DWQ4t0w_Z-6MHmEmA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 12 Jun 2018 21:08:27 -0700
Message-ID: <CALAqxLXf1QtUYQAE3T0sFzzuKh728KGxpY8pkFnnTLML+idbwg@mail.gmail.com>
Subject: Re: OOPSes in mem_cgroup_protected
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 6:02 PM, John Stultz <john.stultz@linaro.org> wrote:
> Hey Tejun,
>   With the current linus/master, I'm able to fairly regularly trip
> OOPSes (two examples below) in mem_cgroup_protected(), which seems to
> be new.  I haven't managed to trigger this sort of thing with v4.17.
>
> I've not had much time to dig in or bisect it - I only know that
> enabling most of the memory debuging config options didn't seem to
> trip anything prior to the issue. So I wanted to send you a heads up
> to see if there was already known, or if there was anything you might
> suggest to help chase this down.


So the line where we're crashing seems to be in mem_cgroup_protected():
  parent_emin = READ_ONCE(parent->memory.emin);

where I'm guessing the parent->memory value is null, and emin is at
the 0x120 offset in the strucutre.

Reverting the following commits seems to avoid the issue.
bf8d5d52ffe8 ("memcg: introduce memory.min")
5f93ad67436b ("mm: treat memory.low value inclusive")
230671533d64 ("mm: memory.low hierarchical behavior")

I'm guessing I'm tripping over some path where the memory value never
gets initialized?

Any ideas or suggestions?

thanks
-john

(usually I'd trim the backtraces below, but keeping them as I added
Roman to the CC list)

> console:/ $ [  170.530896] Unable to handle kernel read from
> unreadable memory at virtual address 0000000000000120
> [  170.540158] Mem abort info:
> [  170.543092]   ESR = 0x96000005
> [  170.546193]   Exception class = DABT (current EL), IL = 32 bits
> [  170.552251]   SET = 0, FnV = 0
> [  170.555444]   EA = 0, S1PTW = 0
> [  170.558698] Data abort info:
> [  170.561624]   ISV = 0, ISS = 0x00000005
> [  170.565572]   CM = 0, WnR = 0
> [  170.568650] user pgtable: 4k pages, 39-bit VAs, pgdp = 00000000190bb04e
> [  170.575374] [0000000000000120] pgd=0000000000000000, pud=0000000000000000
> [  170.582297] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [  170.587929] CPU: 7 PID: 663 Comm: kswapd0 Not tainted
> 4.17.0-11699-gb4f23f3 #411
> [  170.595358] Hardware name: HiKey Development Board (DT)
> [  170.600623] pstate: a0400005 (NzCv daif +PAN -UAO)
> [  170.605478] pc : mem_cgroup_protected+0x34/0x120
> [  170.610142] lr : shrink_node+0x120/0x478
> [  170.614093] sp : ffffff8009d23c50
> [  170.617438] x29: ffffff8009d23c50 x28: ffffff8009d23d48
> [  170.622808] x27: ffffffc074ca1000 x26: ffffff8009d23e28
> [  170.628160] x25: ffffff8009d23d88 x24: 0000000000000000
> [  170.633481] x23: 0000000000000000 x22: ffffff8009071f80
> [  170.638802] x21: 0000000000000012 x20: 0000000000000012
> [  170.644124] x19: 0000000000000000 x18: 0000000000000400
> [  170.649444] x17: 0000000000000000 x16: ffffffc074ca2000
> [  170.654765] x15: 0000000000000000 x14: 0000000000000400
> [  170.660087] x13: 00000000000000b1 x12: 0000000000000003
> [  170.665408] x11: 0000000000000020 x10: 0000000000000000
> [  170.670729] x9 : 0000000000000001 x8 : 0000000000000004
> [  170.676050] x7 : ffffffc074d43c00 x6 : 0000000000000000
> [  170.681370] x5 : 0000000000000000 x4 : 0000000000000000
> [  170.686690] x3 : 000000000000dafa x2 : 0000000000000000
> [  170.692010] x1 : ffffffc074ca1000 x0 : ffffffc0386e8000
> [  170.697335] Process kswapd0 (pid: 663, stack limit = 0x00000000e0f0ae51)
> [  170.704039] Call trace:
> [  170.706497]  mem_cgroup_protected+0x34/0x120
> [  170.710775]  balance_pgdat+0x1cc/0x418
> [  170.714529]  kswapd+0x180/0x3b8
> [  170.717674]  kthread+0xf8/0x128
> [  170.720824]  ret_from_fork+0x10/0x18
> [  170.724411] Code: b40007a2 d103e042 eb02001f 540006c0 (f9409046)
> [  170.730542] ---[ end trace 7c961b6d409886f1 ]---
> [  170.839299] Kernel panic - not syncing: Fatal exception
> [  170.844549] SMP: stopping secondary CPUs
> [  170.848488] Kernel Offset: disabled
> [  170.851982] CPU features: 0x24802004
> [  170.855556] Memory Limit: none
> [  170.888494] Rebooting in 5 seconds..
>
>
>
>
> console:/ # [  348.612152] Unable to handle kernel read from
> unreadable memory at virtual address 0000000000000120
> [  348.617384] Unable to handle kernel access to user memory outside
> uaccess routines at virtual address 0000000000000120
> [  348.621360] Mem abort info:
> [  348.632086] Mem abort info:
> [  348.634870]   ESR = 0x96000005
> [  348.634885]   Exception class = DABT (current EL), IL = 32 bits
> [  348.637686]   ESR = 0x96000005
> [  348.640785]   SET = 0, FnV = 0
> [  348.646740]   Exception class = DABT (current EL), IL = 32 bits
> [  348.649799]   EA = 0, S1PTW = 0
> [  348.652892]   SET = 0, FnV = 0
> [  348.652901]   EA = 0, S1PTW = 0
> [  348.652913] Data abort info:
> [  348.658905] Data abort info:
> [  348.662041]   ISV = 0, ISS = 0x00000005
> [  348.662050]   CM = 0, WnR = 0
> [  348.662071] user pgtable: 4k pages, 39-bit VAs, pgdp = 00000000697cecc4
> [  348.665129]   ISV = 0, ISS = 0x00000005
> [  348.668298] [0000000000000120] pgd=000000003a915003, pud=000000003a915003
> [  348.671224]   CM = 0, WnR = 0
> [  348.671242] user pgtable: 4k pages, 39-bit VAs, pgdp = 00000000c568bd29
> [  348.674193] , pmd=0000000000000000
> [  348.678021] [0000000000000120] pgd=0000000000000000, pud=0000000000000000
> [  348.691540] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [  348.723733] CPU: 5 PID: 3246 Comm: CrRendererMain Not tainted
> 4.17.0-11699-gb4f23f3 #412
> [  348.731857] Hardware name: HiKey Development Board (DT)
> [  348.737121] pstate: a0400005 (NzCv daif +PAN -UAO)
> [  348.741975] pc : mem_cgroup_protected+0x34/0x120
> [  348.746640] lr : shrink_node+0x120/0x478
> [  348.750590] sp : ffffff800ac9b8a0
> [  348.753934] x29: ffffff800ac9b8a0 x28: ffffff800ac9b9d8
> [  348.759304] x27: ffffffc071982480 x26: ffffff800ac9bb30
> [  348.764673] x25: ffffff800ac9ba18 x24: 0000000000000000
> [  348.770038] x23: 0000000000000000 x22: ffffff8009113d00
> [  348.775404] x21: 000000000000000f x20: 000000000000000f
> [  348.780769] x19: 0000000000000000 x18: 0000000000000000
> [  348.786134] x17: 0000000000000000 x16: ffffffc071985a80
> [  348.791500] x15: 0000000000000000 x14: 00000000d5e75c2f
> [  348.796868] x13: 00000000d7237d18 x12: 0000000000000003
> [  348.802233] x11: 0000000000000020 x10: 0000000000000000
> [  348.807598] x9 : 0000000000000001 x8 : 0000000000000004
> [  348.812963] x7 : ffffffc072d58c80 x6 : 0000000000000000
> [  348.818311] x5 : 0000000000000000 x4 : 0000000000000000
> [  348.823626] x3 : 000000000000e1fc x2 : 0000000000000000
> [  348.828941] x1 : ffffffc071982480 x0 : ffffffc038700080
> [  348.834258] Process CrRendererMain (pid: 3246, stack limit =
> 0x00000000b82069c1)
> [  348.841652] Call trace:
> [  348.844100]  mem_cgroup_protected+0x34/0x120
> [  348.848370]  do_try_to_free_pages+0xd0/0x3c0
> [  348.852639]  try_to_free_pages+0xf8/0x120
> [  348.856651]  __alloc_pages_nodemask+0x460/0xb68
> [  348.861181]  do_huge_pmd_anonymous_page+0x328/0x7d8
> [  348.866061]  __handle_mm_fault+0x57c/0xea0
> [  348.870157]  handle_mm_fault+0x128/0x1f8
> [  348.874082]  do_page_fault+0x1d0/0x490
> [  348.877830]  do_translation_fault+0x5c/0x68
> [  348.882012]  do_mem_abort+0x54/0x118
> [  348.885587]  el0_da+0x20/0x24
> [  348.888557] Code: b40007a2 d103e042 eb02001f 540006c0 (f9409046)
> [  348.894651] ---[ end trace 58afd90183767ac2 ]---
> [  348.942150] Kernel panic - not syncing: Fatal exception
> [  348.947448] SMP: stopping secondary CPUs
> [  349.784747] SMP: failed to stop secondary CPUs 2,5
> [  349.789569] Kernel Offset: disabled
> [  349.793089] CPU features: 0x24802004
> [  349.796691] Memory Limit: none
> [  349.909567] Rebooting in 5 seconds..
