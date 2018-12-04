Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C39C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248E2214D9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1gPIIH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248E2214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeLDI4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:56:43 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33153 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDI4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:56:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id p6so4942118eds.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 00:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6AhkG52J24zaYlglrqaHX2iUIGtzEvFOA6z8myeF9/M=;
        b=Y1gPIIH1P2sfbktljfQstw2HXomqJGhNRKFSbrkeR633/0co+0FHX2LkCgT2tQD+pI
         OG5OEWRCMA++ulJDfnS36t77zBAorS0STGC4/wvTT3Ug7WHFeFmo+O1PEz3tavTaZBSj
         eCCNzrCRTEFREEeQvQ0YSkiOjLWyufBN1ZXLt1gdZwOHPuBrbVLxQJSeFhHl3Jv7F4bJ
         eXRriSaaSezGWw3wxnJeFQnWL3FLfX6QOHG3v9HwroyvlPgR4sOvB+z2591OpTPW0rdP
         8AqrpwSsUrV9ahjMkndcJLdSH+5erPBr/Nb285S091Lqku83XAKSVA5vw+1RUTo0qAN+
         zB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6AhkG52J24zaYlglrqaHX2iUIGtzEvFOA6z8myeF9/M=;
        b=LUzq/LoB2tW3b/0OKBcW2cd5unes55knDDbpJqbfblxtZA7QMLYKMwXNm9Tmt5pxDD
         gOm75yzhguhkEZvBifviwG7vJ0Y42ZqDP22QzWe7eYX+7PfMsckUwBlQ86J2O62zwyXe
         Avj0vYnAaVJSU6TpEciDdcVUtmVNJUTqurTFtfdSgKAfmUaiPU4YHaENlrcR+of8JKCw
         d3VfUHNyqBQ+8Jbq7iFuL9rsogD8rDJ68dl3OwtSj11Mf4bYHuExayivfGOcGp4IzJpC
         0Q5OuUq1VqTMTd1QITsgy1pwTYOVp6mSR0ygSfH5vocg+RPFn2kmY+zPXq0JI6ObRw5q
         rz9w==
X-Gm-Message-State: AA+aEWZ1lpR/D5TKudTwT1h8+FpXUGXKuev3mlQqeP7g0zQh6CQDByPk
        /i2V2hoRe1FRNeIkMV84I+5XMrepYTzlupkxZw==
X-Google-Smtp-Source: AFSGD/UnBjbkGD/VdlXLqDzZUQutNMLHofBHi5rXj84+UbrXNV7dZqBSrAE2piy5oKpBRZ4sFyOaZI7VX+/YddGNz1o=
X-Received: by 2002:a50:cdd0:: with SMTP id h16mr17694168edj.151.1543913801646;
 Tue, 04 Dec 2018 00:56:41 -0800 (PST)
MIME-Version: 1.0
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
 <20181204072251.GT31738@dhcp22.suse.cz> <CAFgQCTv56drDBx-sTr6KdeQNKJnojG3g_a-k8wKe_q2y9w9NtA@mail.gmail.com>
 <20181204084052.gpwwlnp6n2zehjy5@master>
In-Reply-To: <20181204084052.gpwwlnp6n2zehjy5@master>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 4 Dec 2018 16:56:29 +0800
Message-ID: <CAFgQCTuS_u5=EamGFcQtD-AqVtdVLytAJAjk6jCAXanU=oKV8g@mail.gmail.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node offline
To:     richard.weiyang@gmail.com
Cc:     mhocko@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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

On Tue, Dec 4, 2018 at 4:40 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> On Tue, Dec 04, 2018 at 04:20:32PM +0800, Pingfan Liu wrote:
> >On Tue, Dec 4, 2018 at 3:22 PM Michal Hocko <mhocko@kernel.org> wrote:
> >>
> >> On Tue 04-12-18 11:05:57, Pingfan Liu wrote:
> >> > During my test on some AMD machine, with kexec -l nr_cpus=x option, the
> >> > kernel failed to bootup, because some node's data struct can not be allocated,
> >> > e.g, on x86, initialized by init_cpu_to_node()->init_memory_less_node(). But
> >> > device->numa_node info is used as preferred_nid param for
> >> > __alloc_pages_nodemask(), which causes NULL reference
> >> >   ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
> >> > This patch tries to fix the issue by falling back to the first online node,
> >> > when encountering such corner case.
> >>
> >> We have seen similar issues already and the bug was usually that the
> >> zonelists were not initialized yet or the node is completely bogus.
> >> Zonelists should be initialized by build_all_zonelists quite early so I
> >> am wondering whether the later is the case. What is the actual node
> >> number the device is associated with?
> >>
> >The device's node num is 2. And in my case, I used nr_cpus param. Due
> >to init_cpu_to_node() initialize all the possible node.  It is hard
> >for me to figure out without this param, how zonelists is accessed
> >before page allocator works.
>
> If my understanding is correct, we can't do page alloc before zonelist
> is initialized.
>
> I guess Michal's point is to figure out this reason.
>
Yeah, I know. I just want to emphasize that I hit this bug using
nr_cpus, which may be rarely used by people. Hence it may be a
different bug as Michal had seen. Sorry for bad English if it cause
confusion.

Thanks

[...]
