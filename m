Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE92AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BC020852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ska-ac-za.20150623.gappssmtp.com header.i=@ska-ac-za.20150623.gappssmtp.com header.b="tacaOevN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BC020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ska.ac.za
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbeGXLLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:11:20 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:46458 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388260AbeGXLLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:11:20 -0400
Received: by mail-ua0-f177.google.com with SMTP id r18-v6so2361513ual.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 03:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ska-ac-za.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s3c4+yH9bl5Ti7gQdxfwfQAR0XmLeSW8UFuuGdteGAs=;
        b=tacaOevN1dQFENGflK1kpehxVf2jvf1ZXLZwd7jIkB1TeFOnc/QTNtS1qFyEE0jsxu
         h+cOG2LqD1H0NAJoSbs0dbskWGDGwn7ufe4+eeXHKKEP/IjYyxhGOIv2tGubsm6NzeQa
         wpqy48QDRTzjp50fmtHY4J4kuD5+eLFfad1iSw9LMxTgejkZeOGqjuIuXlkeCl6yiHXA
         kmCjHNEODA4YMRKadf5P9GcOt+XTaD5Pr9DtnHDBQ+NBCLBYrpfW6fe3tIS2xCjGVdpD
         zJ1Pl67cCzoSbA5c3KH/HnLI9WuHDINguH+5ZgqH2HyKXkiI+4KUVlRQImohahgPA5af
         haIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s3c4+yH9bl5Ti7gQdxfwfQAR0XmLeSW8UFuuGdteGAs=;
        b=jt49LmnOgG+2H48jElTZVx23fYUNfNKT3wuKrKXFJkl9fu55Wmhm8Kaf8IEiG8Zv8M
         B+DBO86X8sLwXeektKXrfeJOrm3GrBlyBikpZwXdguF0ej4yqAM0eAUNGsYH1iyagRRx
         ogN75vGuNH4Utoxji8Ga/hv4gpTA1bafVEcoFWScvVT2hjbL5gK6l8UOxp/DqMeB/kdp
         sY2Td7afGTv9jJf/QUcB8nrdqubtyzBtcUmxTJHqIQVs+pgyClj+2eK3FE78c05LDEnP
         HVibbBW51BtBqudTNZ+sjQIjlxISfsh2XC2d3iI9Nj8vujsaZm+pPrmMxdoHeUtW1AX+
         MKFg==
X-Gm-Message-State: AOUpUlEKddQIWreoX4Ojs64zAh4NdMo/CPKL2zvns8ynPIdJkFvzCXDj
        pv9ig1CXne8TtbqL0T9HWJl08pKHkguiE9a56UJGoQ==
X-Google-Smtp-Source: AAOMgpc5yPqdVWh8ttHJ5MGSmGLcCyZOg21ChNm2KM2t9tVdcVkLQBXJZ4ZLe6Ak8BbZuf7ubj5Mxnu0crLUdM187Cg=
X-Received: by 2002:ab0:7349:: with SMTP id k9-v6mr11209466uap.167.1532426736467;
 Tue, 24 Jul 2018 03:05:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:d97:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 03:05:35 -0700 (PDT)
In-Reply-To: <CAOm-9arxtTwNxXzmb8nN+N_UtjiuH0XkpkVPFHpi3EOYXvZYVA@mail.gmail.com>
References: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
 <20180717212307.d6803a3b0bbfeb32479c1e26@linux-foundation.org>
 <20180718104230.GC1431@dhcp22.suse.cz> <CAOm-9aqeKZ7+Jvhc5DxEEzbk4T0iQx8gZ=O1vy6YXnbOkncFsg@mail.gmail.com>
 <CALvZod7_vPwqyLBxiecZtREEeY4hioCGnZWVhQx9wVdM8CFcog@mail.gmail.com>
 <CAOm-9aprLokqi6awMvi0NbkriZBpmvnBA81QhOoHnK7ZEA96fw@mail.gmail.com>
 <CALvZod4ag02N6QPwRQCYv663hj05Z6vtrK8=XEE6uWHQCL4yRw@mail.gmail.com> <CAOm-9arxtTwNxXzmb8nN+N_UtjiuH0XkpkVPFHpi3EOYXvZYVA@mail.gmail.com>
From:   Bruce Merry <bmerry@ska.ac.za>
Date:   Tue, 24 Jul 2018 12:05:35 +0200
Message-ID: <CAOm-9aqYLExQZUvfk9ucCoSPoaA67D6ncEDR2+UZBMLhv4-r_A@mail.gmail.com>
Subject: Re: Showing /sys/fs/cgroup/memory/memory.stat very slow on some machines
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 19:40, Bruce Merry <bmerry@ska.ac.za> wrote:
>> Yes, very easy to produce zombies, though I don't think kernel
>> provides any way to tell how many zombies exist on the system.
>>
>> To create a zombie, first create a memcg node, enter that memcg,
>> create a tmpfs file of few KiBs, exit the memcg and rmdir the memcg.
>> That memcg will be a zombie until you delete that tmpfs file.
>
> Thanks, that makes sense. I'll see if I can reproduce the issue.

Hi

I've had some time to experiment with this issue, and I've now got a
way to reproduce it fairly reliably, including with a stock 4.17.8
kernel. However, it's very phase-of-the-moon stuff, and even
apparently trivial changes (like switching the order in which the
files are statted) makes the issue disappear.

To reproduce:
1. Start cadvisor running. I use the 0.30.2 binary from Github, and
run it with sudo ./cadvisor-0.30.2 --logtostderr=true
2. Run the Python 3 script below, which repeatedly creates a cgroup,
enters it, stats some files in it, and leaves it again (and removes
it). It takes a few minutes to run.
3. time cat /sys/fs/cgroup/memory/memory.stat. It now takes about 20ms for me.
4. sudo sysctl vm.drop_caches=2
5. time cat /sys/fs/cgroup/memory/memory.stat. It is back to 1-2ms.

I've also added some code to memcg_stat_show to report the number of
cgroups in the hierarchy (iterations in for_each_mem_cgroup_tree).
Running the script increases it from ~700 to ~41000. The script
iterates 250,000 times, so only some fraction of the cgroups become
zombies.

I also tried the suggestion of force_empty: it makes the problem go
away, but is also very, very slow (about 0.5s per iteration), and
given the sensitivity of the test to small changes I don't know how
meaningful that is.

Reproduction code (if you have tqdm installed you get a nice progress
bar, but not required). Hopefully Gmail doesn't do any format
mangling:


#!/usr/bin/env python3
import os

try:
    from tqdm import trange as range
except ImportError:
    pass


def clean():
    try:
        os.rmdir(name)
    except FileNotFoundError:
        pass


def move_to(cgroup):
    with open(cgroup + '/tasks', 'w') as f:
        print(pid, file=f)


pid = os.getpid()
os.chdir('/sys/fs/cgroup/memory')
name = 'dummy'
N = 250000
clean()
try:
    for i in range(N):
        os.mkdir(name)
        move_to(name)
        for filename in ['memory.stat', 'memory.swappiness']:
            os.stat(os.path.join(name, filename))
        move_to('user.slice')
        os.rmdir(name)
finally:
    move_to('user.slice')
    clean()


Regards
Bruce
-- 
Bruce Merry
Senior Science Processing Developer
SKA South Africa
