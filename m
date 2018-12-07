Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD71C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45ADB2146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjRPiBUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45ADB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbeLGO12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:27:28 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39086 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeLGO11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:27:27 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so3851113edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 06:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ofi9MX7MEGIvio94AZWeSpB3uNc4Ju5AMyFYF6XQLLE=;
        b=pjRPiBUDH6btJ+2jriXyJ/VoWq12NHWrroB1KGCa4t2W9JUg/WoZAMOWPp4qk//cMx
         4eM+waksPwVMQAnMkhxqkOPNdjK8fYJArQQ418kM3fiOLP/CpmDgRaX0/JbvRYN+1JT0
         Bv8ADQHy89Wk0064BNatfaFr25HVH4XXib5eVfUA0iVe6Gd9pKAgEAG0T+7ZRcXtFVVW
         fq8gjkWEU2SAlfU4QvJJwgwXw3Vg5a8bsOvgmqamAfn6JwaSEyxUVC4WoYOjn5Ndo9bk
         xi5Uht50muW252uoh6IH6PcwANtrH8+lHzEtXsemB0Du2Qwn+e3VXYXOjd+YFi4DepJH
         n4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ofi9MX7MEGIvio94AZWeSpB3uNc4Ju5AMyFYF6XQLLE=;
        b=TUIp4ErDBqShHFPi6t026yYDqb57ejqOiyRzcPbbaT44qSDVaAOgjJqanmBHYPmjr5
         tKnqKXYPP0G27IyKAiXCLrgrm1BQBhkYd2vucwqEVxToXPGZQkGYlpPjpLE7+0bKJLoD
         ndkQAYNqewf32E4SeD33tIrZ/oosNaQWvFR2mrnMo48lnb+mCr+YP07j458WaGK+MweB
         nCgtT/7thEpnyXfH6MlRunxeKijC2gmdrbaiktMbA8fy/0WYaAttSsU4sBGdUGwalVpy
         bsxda4A+Lzeq8s+TsCmgKvf0y6jN6vSwaWIY/tmKuWA3DT1TK5H1/1cSFI1kfbB+3sg5
         BF6A==
X-Gm-Message-State: AA+aEWZKkeu0Bn5lUtHzflRmD0I0F3LvluS0s/xLskpueHgZEeUOYBI2
        61tlBsOOpyOS9IByYKDlRyU654QPSe9L4Lov9cxS9Al3LQ==
X-Google-Smtp-Source: AFSGD/X1kz2yGTooG1MN7IG+AyQGoYZUKw4S+BYwJbUONZkjms47oIXUWc5OY46d1HB7RxlHqKOXG3e6wN6f8UVwJy8=
X-Received: by 2002:a17:906:838e:: with SMTP id p14-v6mr2097518ejx.94.1544192845622;
 Fri, 07 Dec 2018 06:27:25 -0800 (PST)
MIME-Version: 1.0
References: <CAFgQCTv5-jeqwRVkJuDHvv0vq6uCzfdV2ZmVAU3eUzn2w2ReEQ@mail.gmail.com>
 <20181206082806.GB1286@dhcp22.suse.cz> <CAFgQCTsMdQSRFruZRGBuo30TjfiQ=sbrf9kUJAGgwN6uw+LsBw@mail.gmail.com>
 <CAFgQCTv7ADVW3WvB0tuqpL1U2MFGADA113MUm6ZmVcgvqyBfTA@mail.gmail.com>
 <20181206121152.GH1286@dhcp22.suse.cz> <CAFgQCTuqn32_pZrLBDNvC_0Aepv2F7KF7rk2nAbxmYF45KfT2w@mail.gmail.com>
 <20181207075322.GS1286@dhcp22.suse.cz> <CAFgQCTsFBUcOE9UKQ2vz=hg2FWp_QurZMQmJZ2wYLBqXkFHKHQ@mail.gmail.com>
 <20181207113044.GB1286@dhcp22.suse.cz> <CAFgQCTuf95pJSWDc1BNQ=gN76aJ_dtxMRbAV9a28X6w8vapdMQ@mail.gmail.com>
 <20181207142240.GC1286@dhcp22.suse.cz>
In-Reply-To: <20181207142240.GC1286@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 7 Dec 2018 22:27:13 +0800
Message-ID: <CAFgQCTuu54oZWKq_ppEvZFb4Mz31gVmsa37gTap+e9KbE=T0aQ@mail.gmail.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node offline
To:     mhocko@kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 10:22 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 07-12-18 21:20:17, Pingfan Liu wrote:
> [...]
> > Hi Michal,
> >
> > As I mentioned in my previous email, I have manually apply the patch,
> > and the patch can not work for normal bootup.
>
> I am sorry, I have misread your previous response. Is there anything
> interesting on the serial console by any chance?

Nothing. It need more effort to debug. But as I mentioned, enable all
of the rest possible node, then it works. Maybe it can give some help
for you.
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 1308f54..4dc497d 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -754,18 +754,23 @@ void __init init_cpu_to_node(void)
 {
        int cpu;
        u16 *cpu_to_apicid = early_per_cpu_ptr(x86_cpu_to_apicid);
+       int node, nr;

        BUG_ON(cpu_to_apicid == NULL);
+       nr = cpumask_weight(cpu_possible_mask);
+
+       /* bring up all possible node, since dev->numa_node */
+       //should check acpi works for node possible,
+       for_each_node(node)
+               if (!node_online(node))
+                       init_memory_less_node(node);

        for_each_possible_cpu(cpu) {
-               int node = numa_cpu_node(cpu);
+               node = numa_cpu_node(cpu);

                if (node == NUMA_NO_NODE)
                        continue;

-               if (!node_online(node))
-                       init_memory_less_node(node);
-
                numa_set_node(cpu, node);
        }
 }

Thanks,
Pingfan
