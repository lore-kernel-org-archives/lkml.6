Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1945970AbeCBKSq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:18:46 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33840 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424221AbeCBKSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:18:13 -0500
X-Google-Smtp-Source: AG47ELtsMLtNZIKUp5H0/0XUnRo1BCB8wTqRHfGqSqaQF7ebuu1Nnfy0SpsDinVaFa/KgF55NqVAt/VOjcF8o5h8t4w=
MIME-Version: 1.0
In-Reply-To: <20180302094140.ncypewkdg6g6rs2g@intel.com>
References: <1519809638-24248-1-git-send-email-changbin.du@intel.com>
 <CAJZ5v0jqG0pcqOuvAVoP7sNKoOe+3ByMk4X5AZASp84OPcrgPg@mail.gmail.com>
 <20180301022719.xyfcu5tpmadjxbut@intel.com> <CAJZ5v0j8GsaK7kJ4hyvyQYOpa6QmoP2Pc69egg0hb=tb2EwpuA@mail.gmail.com>
 <20180302094140.ncypewkdg6g6rs2g@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Mar 2018 11:18:10 +0100
X-Google-Sender-Auth: SGO8HWsoehkz7YZTOYfT0HXnnyI
Message-ID: <CAJZ5v0jcTfjBsyR1NN-JjAN86xPm0rA0qr4mnOpJwiv6PSdy6Q@mail.gmail.com>
Subject: Re: [PATCH v2] tracing/power: Polish the tracepoints cpu_idle and cpu_frequency
To: "Du, Changbin" <changbin.du@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 10:41 AM, Du, Changbin <changbin.du@intel.com> wrote:
>> >> That rather isn't the case if negative values are ever passed to the
>> >> tracepoint, right?
>> >>
>> > yes.
>> >> Which seems to be the reason why you want to make this change, isn't it?
>> >>
>> > yes, to improve readability.
>> >
>> >> So maybe fix the code using the tracepoint(s) to avoid passing
>> >> negative values to it(them)?
>> > For cpu_idle event, [0, CPUIDLE_STATE_MAX) are used to index the idle state arrary,
>> > so I think a appropriate value for PWR_EVENT_EXIT is -1 (defined in include/trace/events/power.h).
>> > Or do you have a better idea? Thanks!
>>
>> Sorry, I'm not sure what you mean.
>>
>> I'm saying that the code using the CPU PM tracepoints is not expected
>> to pass -1 as the CPU number to them.  IOW, neither -1 nor its UL
>> representation should ever appear in the output of these tracepoints.
>> If that happens, it is a problem with the code using the tracepoints
>> which needs to be fixed.  Users should not see any of these values.
>
> This patch only changed 'state' field but cpuid. For cpu_idle event, 'state' is
> singned value, but for cpu_frequency it is unsinged.
> The cpuid is always unsinged value. So no one passes -1 as CPU number.

You are right, 'state' not 'cpuid', sorry.

Negative 'state' should not be passed to these tracepoints too, though.
