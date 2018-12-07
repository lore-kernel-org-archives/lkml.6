Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA28C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5092083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQt8PwvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5092083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLGC5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:57:06 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43379 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGC5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:57:06 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so2501206eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 18:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TrMVb01cMJC6LzGuY4FwPTJac0sY3J83+QzgLObCMAE=;
        b=KQt8PwvRcVOAG8sDx2kBWIPR4LBeRy8jenXgr4lD/qYSSKj42dy7apRNF4MYnDvdeL
         Nq+5Lc9oAdLKhR7B2BmzbpCQc74lZqwCT1/8Aj4PcBKk2z+2d8041QFZBH4M8gJD7JCy
         r58mrhAhhM3LMMMUC0fCBGw1WoQqJp/vWr++P7gVxkaypneTbi3Lim++VmqPJ5MFbKoT
         q/AtssSOdpFd1SbCE3uDe5i3pxejqJEKzT0i7CT5VXDhFjxZm+sKxh3w9vhEN+06KM4q
         mEYMMdbpyfnDKDHg/mcdaNpc0rFVrkqt4XzvzheJiSSZnCk7Npzcdqe/hK4ob9XaUVOj
         Vgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TrMVb01cMJC6LzGuY4FwPTJac0sY3J83+QzgLObCMAE=;
        b=IUL0MVVDXZVfeThNx7uK0VK53Y8EOvE4JDulFmnN/UyHrM/vuaK1UFE/nJxMp/K40L
         /ZdyAO7v7JNTbkvkLrMxOJJ+yLWE0GQ9ZI2ZIRdJCbKtfn6sGsEvUrv0qzofmmZpYL8G
         1urtwU+f90Otu+n5Z2VVG7QGvfby8A1BJod2uIjwON41EhS31VG5kN4fOvtVAm0KYFEt
         GGHPZLcolSIliYBP1q+O/v94ezkkMZFJE044x+xhhCeIWXPdlPbWJ1jsg4iQQjc2q3Ah
         JlPGMgwOvh+DEpIGc3Y1qifur0Tkjw8UnmzBrnQToCH7NTBByqFEz6yxbS++cQUSk/ia
         KXhg==
X-Gm-Message-State: AA+aEWaWB6jshXVdPuSGsAp10LLmSOn8CYdh3L90E9l7GpYh84mzlqLl
        wrgKozgy+HGbM3doQzCk8WsrtRTRttZISp4Rpw==
X-Google-Smtp-Source: AFSGD/VBUwY78QY2hxG7tKm58RexXRY05XJ/tOwqutHBuaVlnA3J3Wr474/MYsoOmvyL4bQ7WjEfIk1rhjCWucqQ72o=
X-Received: by 2002:a50:d2d6:: with SMTP id q22mr668893edg.121.1544151423509;
 Thu, 06 Dec 2018 18:57:03 -0800 (PST)
MIME-Version: 1.0
References: <CAFgQCTv56drDBx-sTr6KdeQNKJnojG3g_a-k8wKe_q2y9w9NtA@mail.gmail.com>
 <20181204085601.GC1286@dhcp22.suse.cz> <CAFgQCTuyKBZdwWG=fOECE6J8DbZJsErJOyXTrLT0Kog3ec7vhw@mail.gmail.com>
 <20181205092148.GA1286@dhcp22.suse.cz> <CAFgQCTtj4m637tAzConCfeWQXSrWeNY-DLD5=f9-ZSmJMRe31Q@mail.gmail.com>
 <186b1804-3b1e-340e-f73b-f3c7e69649f5@suse.cz> <CAFgQCTv5-jeqwRVkJuDHvv0vq6uCzfdV2ZmVAU3eUzn2w2ReEQ@mail.gmail.com>
 <20181206082806.GB1286@dhcp22.suse.cz> <CAFgQCTsMdQSRFruZRGBuo30TjfiQ=sbrf9kUJAGgwN6uw+LsBw@mail.gmail.com>
 <CAFgQCTv7ADVW3WvB0tuqpL1U2MFGADA113MUm6ZmVcgvqyBfTA@mail.gmail.com> <20181206121152.GH1286@dhcp22.suse.cz>
In-Reply-To: <20181206121152.GH1286@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 7 Dec 2018 10:56:51 +0800
Message-ID: <CAFgQCTuqn32_pZrLBDNvC_0Aepv2F7KF7rk2nAbxmYF45KfT2w@mail.gmail.com>
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

On Thu, Dec 6, 2018 at 8:11 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 06-12-18 18:44:03, Pingfan Liu wrote:
> > On Thu, Dec 6, 2018 at 6:03 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> [...]
> > > Which commit is this patch applied on? I can not apply it on latest linux tree.
> > >
> > I applied it by manual, will see the test result. I think it should
> > work since you instance all the node.
> > But there are two things worth to consider:
> > -1st. why x86 do not bring up all nodes by default, apparently it will
> > be more simple by that way
>
> What do you mean? Why it didn't bring up before? Or do you see some

Yes, this is what I mean. But maybe the author does not consider about
the nr_cpus, otherwise, using:
+       for_each_node(node)
+               if (!node_online(node))
+                       init_memory_less_node(node);
in init_cpu_to_node() is more simple.

> nodes not being brought up after this patch?
>
> > -2nd. there are other archs, do they obey the rules?
>
> I am afraid that each arch does its own initialization.

Then it is arguable whether to fix this issue in memory core or let
each archs to fix this issue. I check the powerpc code, it should also
need a fix, it maybe the same in arm and mips ..
 BTW, your patch can not work for normal bootup, and the kernel hang
without any kernel message.
I think it is due to the bug in the patch:
                alloc_node_data(nid);
+               if (!end)
+                       init_memory_less_node(nid); //which calls
alloc_node_data(nid) also.
How about the following:
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

Although it works, I hesitate about the idea, due to the semantic of
online-node, does the online-node require either cpu or memory inside
the node to be online?
In a short word, the fix method should consider about the two factors:
semantic of online-node and the effect on all archs

Thanks,
Pingfan

> --
> Michal Hocko
> SUSE Labs
