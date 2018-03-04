Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932248AbeCDV3L (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 16:29:11 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:37303 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752198AbeCDV3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 16:29:10 -0500
X-Google-Smtp-Source: AG47ELsShbdX91YV5e+R/Fgk1wX54OtUQFZ/G21cg9NELtwPLyhFSyLAORu8ggJBcQiQu9Do4wbZDO5t/H4OeUjExUg=
MIME-Version: 1.0
In-Reply-To: <20180304173025.19520-1-vaibhav@linux.vnet.ibm.com>
References: <20180304173025.19520-1-vaibhav@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 5 Mar 2018 08:29:09 +1100
Message-ID: <CAKTCnzmdB3g0Kh67Lo7HQUp=-qRROaq_3hh8dLnDdSan3guFYw@mail.gmail.com>
Subject: Re: [PATCH v2] xmon: Setup xmon debugger hooks when first break-point
 is set
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
        <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 4:30 AM, Vaibhav Jain <vaibhav@linux.vnet.ibm.com> wrote:
> Presently sysrq key for xmon('x') is registered during kernel init
> irrespective of the value of kernel param 'xmon'. Thus xmon is enabled
> even if 'xmon=off' is passed on the kernel command line. However this
> doesn't enable the kernel debugger hooks needed for instruction or data
> breakpoints. Thus when a break-point is hit with xmon=off a kernel oops
> of the form below is reported:
>
> Oops: Exception in kernel mode, sig: 5 [#1]
> < snip >
> Trace/breakpoint trap
>
> To fix this the patch checks and enables debugger hooks when an
> instruction or data break-point is set via xmon console.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
