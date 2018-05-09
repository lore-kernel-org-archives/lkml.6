Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934640AbeEIMhT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:37:19 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:37430 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932875AbeEIMhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:37:16 -0400
X-Google-Smtp-Source: AB8JxZr53d/xHDGN2+HQ2Z9ejsbHd5BWhGoEmX1WOFcit+TdChSetr5rkPQ8R6NF06b2CaNHL5W7hWLt+ljXaxnKGhc=
MIME-Version: 1.0
In-Reply-To: <20180509122454.GR32366@dhcp22.suse.cz>
References: <20180411104832.GF23400@dhcp22.suse.cz> <20180509122454.GR32366@dhcp22.suse.cz>
From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Date: Wed, 9 May 2018 18:07:16 +0530
Message-ID: <CAKTKpr5uPuZUHBnQtDwpGA_d=WTx_5O2SF_+WStO6OMVNe77QQ@mail.gmail.com>
Subject: Re: fd3e45436660 ("ACPI / NUMA: ia64: Parse all entries of SRAT
 memory affinity table")
To: Michal Hocko <mhocko@kernel.org>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, tiantao6@huawei.com,
        LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal


On Wed, May 9, 2018 at 5:54 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Wed 11-04-18 12:48:32, Michal Hocko wrote:
>> Hi,
>> my attention was brought to the %subj commit and either I am missing
>> something or the patch is quite dubious. What is it actually trying to
>> fix? If a BIOS/FW provides more memblocks than the limit then we would
>> get misleading numa topology (numactl -H output) but is the situation
>> much better with it applied? Numa init code will refuse to init more
>> memblocks than the limit and falls back to dummy_numa_init (AFAICS)
>> which will break the topology again and numactl -H will have a
>> misleading output anyway.

IIRC, the MEMBLOCK beyond max limit getting dropped from visible
memory(partial drop from a node).
this patch removed any upper limit on memblocks and allowed to parse
all entries of SRAT.

>>
>> So why is the patch an improvement at all?
>
> ping? I would be tempted to simply revert the patch as a wrong fix.
> --
> Michal Hocko
> SUSE Labs

thanks
Ganapat
sorry, somehow, i have missed your previous email
