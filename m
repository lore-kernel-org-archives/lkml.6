Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753971AbeCFRre (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:47:34 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36561 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeCFRrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:47:31 -0500
X-Google-Smtp-Source: AG47ELs88lmkVabr4zoxG6w6czBwV3XAzj0TZXpS2w0K7gKmf159oAs0cOjVXkM5tQK2bBYtksAXMUPsV4azZqfnElM=
MIME-Version: 1.0
In-Reply-To: <20180306170011.GD25017@tassilo.jf.intel.com>
References: <20180306064353.31930-1-xiyou.wangcong@gmail.com> <20180306170011.GD25017@tassilo.jf.intel.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 6 Mar 2018 09:47:09 -0800
Message-ID: <CAM_iQpUfRMW4aGfaTdFqCRwuuLXFX69Aewg+k-aa6BMUKSrhTA@mail.gmail.com>
Subject: Re: [PATCH] perf stat: fix cvs output format
To: Andi Kleen <ak@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Ilya Pronin <ipronin@twitter.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 9:00 AM, Andi Kleen <ak@linux.intel.com> wrote:
> On Mon, Mar 05, 2018 at 10:43:53PM -0800, Cong Wang wrote:
>> From: Ilya Pronin <ipronin@twitter.com>
>>
>> When printing stats in CSV mode, perf stat appends extra CSV
>> separators when counter is not supported:
>>
>> <not supported>,,L1-dcache-store-misses,mesos/bd442f34-2b4a-47df-b966-9b281f9f56fc,0,100.00,,,,
>>
>> which causes a failure of parsing fields. The numbers of separators
>
> Causes failure in what?

Failed to know how many fields in that line, clearly there are less
separators when it is supported.


>
>> is fixed for each line, no matter supported or not supported.
>
> I don't think they're extra fields, there are cases where they can be filled out
> for variance, metricvalue, unit. And other code in perf too uses empty
> fields when something is not available.

Are you saying there should be more fields when it is not supported?

Here is the output from your own commit:

      423470,,stalled-cycles-frontend,509102,100.00,65.69,frontend cycles idle
      <not supported>,,stalled-cycles-backend,0,100.00,,,,

so line 1 has 7 fields, line 2 has 9 fields, and this is expected?
