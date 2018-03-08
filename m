Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750898AbeCHVwS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:52:18 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37867 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCHVwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:52:17 -0500
X-Google-Smtp-Source: AG47ELvXmsp3pvahvlnU5mFIdCGwALoXvmIg1cNKhK/v1z1NsA1et08YseKIt9GX1V7qpjc1ae0c1MiKBljdUWSZZQM=
MIME-Version: 1.0
In-Reply-To: <20180307170411.GI25017@tassilo.jf.intel.com>
References: <20180306064353.31930-1-xiyou.wangcong@gmail.com>
 <20180306170011.GD25017@tassilo.jf.intel.com> <CAM_iQpUfRMW4aGfaTdFqCRwuuLXFX69Aewg+k-aa6BMUKSrhTA@mail.gmail.com>
 <20180306175320.GE25017@tassilo.jf.intel.com> <CAM_iQpVQs0YTckbo9F0zjPsSL+=ksVZvdcLO-QHTONcZc84eKg@mail.gmail.com>
 <CA+Xn3kw2FZ4m1TossMT35KKJ7EsSV=ykdWKCHtjRs1oefdXWNw@mail.gmail.com> <20180307170411.GI25017@tassilo.jf.intel.com>
From: Ilya Pronin <ipronin@twitter.com>
Date: Thu, 8 Mar 2018 13:52:15 -0800
Message-ID: <CA+Xn3kzwsHZU7wbgVVVGTtu-En9g8mWPTCe5q-8CPETSgMzatw@mail.gmail.com>
Subject: Re: [PATCH] perf stat: fix cvs output format
To: Andi Kleen <ak@linux.intel.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch merely eliminated those 2 unexpected fields. But from what I
saw they were violating the assumption that all lines have the same
number of fields.

On Wed, Mar 7, 2018 at 9:04 AM, Andi Kleen <ak@linux.intel.com> wrote:
> On Tue, Mar 06, 2018 at 12:31:03PM -0800, Ilya Pronin wrote:
>> Speaking from the user's seat. An optional (not just empty) cgroup
>> field is fine as long it consistently appears when requested with -G
>> option. The problem with print_metric_csv() was that in the case of
>> unsupported counters 2 additional empty fields in the output are
>> completely unexpected and not documented anywhere.
>>
>> Andi, in the output example in your commit
>> 92a61f6412d3a09d6462252a522fa79c9290f405 stalled-cycles-backend event
>> has counter run time field, counter run time percentage field, empty
>> metric value, empty metric unit, and then 2 other empty fields. Are
>> they expected? If yes, what are they and why other events, e.g.
>
> No two extra empty fields are not expected. All lines should
> have the same number of fields so that a tool that looks
> at the first like can keep using the same number.
>
> But I don't think that was it what the patch fixed, or did I
> misread it?
>
> -Andi



-- 
Ilya
