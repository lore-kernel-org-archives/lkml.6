Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbeBVKeM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:34:12 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36221 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753279AbeBVKeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:34:10 -0500
X-Google-Smtp-Source: AH8x226qox6j+pKluIdCD4/WnMYA5lc0OMXYKPggH8xisILdA+IrNLTjevVpBzAq3mA3Rn+8BktcV0Sig01xhagTBMM=
MIME-Version: 1.0
In-Reply-To: <20180131092216.GB3313@krava>
References: <20180129154805.GA6284@localhost.didichuxing.com> <20180131092216.GB3313@krava>
From: Weiping Zhang <zwp10758@gmail.com>
Date: Thu, 22 Feb 2018 18:34:08 +0800
Message-ID: <CAA70yB5TB3mxL1uN-sXvUsf578k+_GWkq1gHgF_HRa_1p770gw@mail.gmail.com>
Subject: Re: [PATCH v2] perf cgroup: simplify arguments if track multiple
 events for a cgroup
To: acme@redhat.com
Cc: Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-31 17:22 GMT+08:00 Jiri Olsa <jolsa@redhat.com>:
> On Mon, Jan 29, 2018 at 11:48:09PM +0800, weiping zhang wrote:
>> if use -G with one cgroup and -e with multiple events, only the first
>> event has correct cgroup setting, all events from the second will track
>> system-wide events.
>>
>> if user want track multiple events for a specific cgroup, user must give
>> parameters like follow:
>> $ perf stat -e e1 -e e2 -e e3 -G test,test,test
>> this patch simplify this case, just type one cgroup, like following:
>> $ perf stat -e e1 -e e2 -e e3 -G test
>>
>> $ mkdir -p /sys/fs/cgroup/perf_event/test
>> $ perf stat -e cycles -e cache-misses  -a -I 1000 -G test
>>
>> before:
>>      1.001007226      <not counted>      cycles                    test
>>      1.001007226              7,506      cache-misses
>>
>> after:
>>      1.000834097      <not counted>      cycles                    test
>>      1.000834097      <not counted>      cache-misses              test
>>
>> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Hi Arnaldo,

Ping...
