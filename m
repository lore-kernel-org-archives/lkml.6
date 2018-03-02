Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427221AbeCBSnb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:43:31 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34735 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423170AbeCBSn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:43:27 -0500
X-Google-Smtp-Source: AG47ELtR44PsIHov34GB0lOXTNyyKle6JCNTp995A/UX562B7s7+SrVO+P4xgm2wccfbsYNX4EE/2nZN55cOyIV4EHg=
MIME-Version: 1.0
In-Reply-To: <20180302180131.GA20579@arm.com>
References: <20180301193803.129195-1-dianders@chromium.org> <20180302180131.GA20579@arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 2 Mar 2018 10:43:24 -0800
X-Google-Sender-Auth: 7oYoikKlGUuQA2sWa_3FWBJg9zY
Message-ID: <CAD=FV=Ws0OHhsGZuqtLJ6gMr5e1QXDp6Fxx0vPfaAQzbTKFMmQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/debug: Fix registers on sleeping tasks
To: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Brian Norris <briannorris@chromium.org>, evgreen@chromium.org,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 2, 2018 at 10:01 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Mar 01, 2018 at 11:38:03AM -0800, Douglas Anderson wrote:
>> This is the equivalent of commit 001bf455d206 ("ARM: 8428/1: kgdb: Fix
>> registers on sleeping tasks") but for arm64.  Nuff said.
>
> It's a pity that 001bf455d206 doesn't explain *why* past_pt_regs doesn't
> work.

Ah, sorry.  I can add that to the description but Mark Rutland also
explained it.  task_pt_regs are the userspace registers.  That's not
what kgdb needs.


> Anyway, does this mean you're actually using kgdb on arm64? Does the rest of
> it appear to work?

Yeah, I've been using it for years.  I had this patch on my list to
upstream but it conflicted with commit 0d15ef677839 ("arm64: kgdb:
Match pstate size with gdbserver protocol") and I never had time to
figure out if that mattered, so it's been sitting at
http://crosreview.com/371942 forever.


NOTE: in general I haven't been using single step and breakpoints
since those have always been a bit iffy on serial kgdb and especially
since we have read-only text on our system, but maybe I'll try that
now that I'm running with a newer kernel.


-Doug
