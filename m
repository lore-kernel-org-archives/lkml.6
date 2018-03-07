Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933858AbeCGRf7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:35:59 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35455 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933647AbeCGRfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:35:36 -0500
X-Google-Smtp-Source: AG47ELvNyvJ27BXtwolETGYPDrZPYnzwQSHcUHMCj3alXtualeWuh4SsLzXTfXLpC2yCQxkMXAd+0Y7biSAPuEQQYqA=
MIME-Version: 1.0
In-Reply-To: <20180307143832.GJ3701@kernel.org>
References: <20180307110803.32418-1-ganapatrao.kulkarni@cavium.com>
 <3384d33f-c927-740a-97f1-b20775ef2c7b@redhat.com> <20180307143832.GJ3701@kernel.org>
From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Date: Wed, 7 Mar 2018 23:05:33 +0530
Message-ID: <CAKTKpr4zMcRLykw8xwWJKf2eiuCrf2RuJ7kexGRQNN7_OdJ=uQ@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events arm64: Enable JSON events for
 ThunderX2 B0
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: William Cohen <wcohen@redhat.com>, mark.rutland@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>, Will Deacon <Will.Deacon@arm.com>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <Robert.Richter@cavium.com>,
        Ingo Molnar <mingo@redhat.com>, jnair@caviumnetworks.com,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org,
        Ganapatrao Kulkarni <gklkml16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will Cohen,

On Wed, Mar 7, 2018 at 8:08 PM, Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Em Wed, Mar 07, 2018 at 09:32:05AM -0500, William Cohen escreveu:
>> On 03/07/2018 06:08 AM, Ganapatrao Kulkarni wrote:
>> > There is MIDR change on ThunderX2 B0, adding an entry to mapfile
>> > to enable JSON events for B0.
>> >
>> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>
> Ganapatrao, can you please take this in consideration and if agreeing
> send a v2 patch?
>
> With that I can add an Acked-by: wcohen, Right?
>
> - Arnaldo
>> > ---
>> >  tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> > index e61c9ca..93c5d14 100644
>> > --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> > +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>> > @@ -13,4 +13,5 @@
>> >  #
>> >  #Family-model,Version,Filename,EventType
>> >  0x00000000420f5160,v1,cavium,core
>> > +0x00000000430f0af0,v1,cavium,core
>> >  0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
>> >
>>
>> Hi,
>> Like the cortex-a53 the last digit '0' of the match for the MIDR should be replaced with [[:xdigit:]] to allow for possible future revisions of chip:

for arm64 implementation,  bits 3:0(Revision) and bits 23:20(Variant)
are ignored/dont-care.

>>
>> 0x00000000430f0af[[:xdigit:]],v1,cavium,core
>>
>>
>> -Will Cohen
>

thanks
Ganapat
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
