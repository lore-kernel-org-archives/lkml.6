Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeDJIzp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:55:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752666AbeDJIzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:55:44 -0400
Date: Tue, 10 Apr 2018 10:55:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com,
        pmorel@linux.vnet.ibm.com
Subject: Re: [PATCH 4/4] vfio: ccw: add traceponits for interesting error
 paths
Message-ID: <20180410105540.310ea82a.cohuck@redhat.com>
In-Reply-To: <20180410021639.GN5428@bjsdjshi@linux.vnet.ibm.com>
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
        <20180321020822.86255-5-bjsdjshi@linux.vnet.ibm.com>
        <20180326155902.12bed785.cohuck@redhat.com>
        <20180327075114.GK12194@bjsdjshi@linux.vnet.ibm.com>
        <20180327120723.192f7577.cohuck@redhat.com>
        <20180410021639.GN5428@bjsdjshi@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 10:16:39 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

>   Does the following effect make sense?
> 
> # tracer: nop
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _---=> hardirq/softirq
> #                            || / _--=> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>  qemu-system-s39-4252  [006] ....   231.457214: vfio_ccw_cp_prefetch: schid=0.0.013f errno=0
>  qemu-system-s39-4252  [006] ....   231.457222: vfio_ccw_fsm_io_helper: schid=0.0.013f errno=0
>  qemu-system-s39-4252  [006] ....   231.457223: vfio_ccw_io_fctl: schid=0.0.013f fctl=4 errno=0
>   ... ...

I would likely find this useful for following a code path and making
sure the right things are called.

We certainly want error conditions traced as well (although the code
has been working too well for me to trigger that easily :)
