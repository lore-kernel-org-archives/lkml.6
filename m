Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbeDXQSA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:18:00 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38986 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751642AbeDXQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:17:56 -0400
X-Google-Smtp-Source: AIpwx48AoH5aLe8O+w+YtpYj8bWueU+XH+2Va9inYjdv477Wb9A07VKDA3JcY4P2fTPVTR9ZgfWK3v7hFL34Vm5FIS8=
MIME-Version: 1.0
In-Reply-To: <CADYN=9J5yfmZeQoEmUfF_zwGkru=L1V6G7Tbz8yxt12Z6=qPgg@mail.gmail.com>
References: <CADYN=9J5yfmZeQoEmUfF_zwGkru=L1V6G7Tbz8yxt12Z6=qPgg@mail.gmail.com>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Tue, 24 Apr 2018 09:17:55 -0700
Message-ID: <CAJieiUiBmDp1QOWkS9eons8vxZtGDEezdJXcqciWdWfYwaAvtw@mail.gmail.com>
Subject: Re: [net-next regression] kselftest failure in fib_nl_newrule()
To: Anders Roxell <anders.roxell@linaro.org>
Cc: David Miller <davem@davemloft.net>,
        David Ahern <dsa@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 2:46 AM, Anders Roxell <anders.roxell@linaro.org> wrote:
> Hi,
>
> fib-onlink-tests.sh (from kselftest) found a regression between
> next-20180424 [1] (worked with tag next-20180423 [2])
>
> here is tree commits that look suspicious specially this patch (sha:
> f9d4b0c1e969)
> rewrites fib_nl_newrule().his patch (sha: f9d4b0c1e969) rewrites
> fib_nl_newrule().
>
> b16fb418b1bf ("net: fib_rules: add extack support")
> f9d4b0c1e969 ("fib_rules: move common handling of newrule delrule msgs
> into fib_nl2rule")
> 8a14e46f1402 ("net/ipv6: Fix missing rcu dereferences on from")
>
> Cheers,
> Anders
> [1] https://lkft.validation.linaro.org/scheduler/job/195181#L3447
> [2] https://lkft.validation.linaro.org/scheduler/job/193410#L3438


Thanks for the report.

It should be fixed by my last commit:
9c20b9372fba "net: fib_rules: fix l3mdev netlink attr processing"

Just ran them again and they pass.
