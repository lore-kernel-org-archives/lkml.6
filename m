Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA46C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17996214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBOYqy3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17996214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeLDIUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:20:46 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37397 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLDIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:20:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so13124936edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 00:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yWhpZVnl37B+74xL9TufmqWWQ1jY0zpiiIMndUDygX0=;
        b=iBOYqy3EB9EP5fJ38fqpwnGFhNss+e9ZZM/0m/HGsqlHW7Q3oAgruC0dOss4oSAcn2
         NvPewr3Yn8rVjvdPfNRfjCm+25enYlVWOM9BBrmRxoP5T8llUHrgGkXe4aJdNQ/fBrYK
         sxUi/nHus5q78XvOiaQLOLC34/p3AUz7rE0FN8cOA8b/1DiH/BMPJycVjgBxKq0VxD73
         5OL0rMn7B8adWUndG8F+R4MaKzWmELQ8Q4mx+qEyF7J1xl8eBloFSytSyK5u0Kupg9Nq
         UoJsU1Q7PmYQf2I/jD7uibgsBVYFjgtE1SQO1/YFQlvKmb3mVk0vJ/7eChrKkONi3MeM
         8Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWhpZVnl37B+74xL9TufmqWWQ1jY0zpiiIMndUDygX0=;
        b=dVHuVZGrT317Kfe+JvPUQuCzVc7KUOK131q4Tt8Z5RA8ckQqh1eeuyxOQNHxCtuOEo
         36FlrYe023wfZz0rgL/kFnYTZ/56UHHUWWCgwWmoocsPw3VBywlY6RY4iQsAE2hf9hNp
         2eKV0qffLz9Pl4dXAa26C9B1zI9sixQpfbuVgdRYXAHgZlIiEoQ0QFSYgXcJRgY84AxB
         L57PZflgTsstAZ6r6ztZtOadX0SxyqETYp/tF4mk6Yd6T9BQwr62YDNSSkRNI16qjnRP
         xZUcYCvuYTBXnMFLykypLmJQi26h98AgK+3LLVRwwCSWzMG/Tk8o7ECChlCaUo1iJJGV
         xIcA==
X-Gm-Message-State: AA+aEWa2sVgiierLcQq94y8QSH7GXWvStOiHwvLrTLxmE0BKZCzIvsHx
        DXeAgbPeXWuDw0Ih34mPwcju+qYtYKm+KBrjkA==
X-Google-Smtp-Source: AFSGD/VRo8UjEPaLiede2CIk5G1R/Jgvv9Qo2Oz/KCf/yNceFQXY9AkQlaHxsjuGH+XpM/K5f4uu6yGt4IgQoa6+Bss=
X-Received: by 2002:aa7:c711:: with SMTP id i17mr17169761edq.253.1543911643900;
 Tue, 04 Dec 2018 00:20:43 -0800 (PST)
MIME-Version: 1.0
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com> <20181204072251.GT31738@dhcp22.suse.cz>
In-Reply-To: <20181204072251.GT31738@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 4 Dec 2018 16:20:32 +0800
Message-ID: <CAFgQCTv56drDBx-sTr6KdeQNKJnojG3g_a-k8wKe_q2y9w9NtA@mail.gmail.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node offline
To:     mhocko@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 3:22 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 04-12-18 11:05:57, Pingfan Liu wrote:
> > During my test on some AMD machine, with kexec -l nr_cpus=x option, the
> > kernel failed to bootup, because some node's data struct can not be allocated,
> > e.g, on x86, initialized by init_cpu_to_node()->init_memory_less_node(). But
> > device->numa_node info is used as preferred_nid param for
> > __alloc_pages_nodemask(), which causes NULL reference
> >   ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
> > This patch tries to fix the issue by falling back to the first online node,
> > when encountering such corner case.
>
> We have seen similar issues already and the bug was usually that the
> zonelists were not initialized yet or the node is completely bogus.
> Zonelists should be initialized by build_all_zonelists quite early so I
> am wondering whether the later is the case. What is the actual node
> number the device is associated with?
>
The device's node num is 2. And in my case, I used nr_cpus param. Due
to init_cpu_to_node() initialize all the possible node.  It is hard
for me to figure out without this param, how zonelists is accessed
before page allocator works.

> Your patch is not correct btw, because we want to fallback into the node in
> the distance order rather into the first online node.
> --
What about this:
+extern int find_next_best_node(int node, nodemask_t *used_node_mask);
+
 /*
  * We get the zone list from the current node and the gfp_mask.
  * This zone list contains a maximum of MAXNODES*MAX_NR_ZONES zones.
@@ -453,6 +455,11 @@ static inline int gfp_zonelist(gfp_t flags)
  */
 static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 {
+       if (unlikely(!node_online(nid))) {
+               nodemask_t used_mask;
+               nodes_complement(used_mask, node_online_map);
+               nid = find_next_best_node(nid, &used_mask);
+       }
        return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
 }

I just finished the compiling, not test it yet, since the machine is
not on hand yet. It needs some time to get it again.

Thanks,
Pingfan
