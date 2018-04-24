Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756255AbeDXJrB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:47:01 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33661 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754500AbeDXJq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:46:58 -0400
X-Google-Smtp-Source: AIpwx49Wg1jIcS+i/klmPaHWrZwbL8fFz6thE3uE22vKkrV3xvNNzOXFLvgRjoYBL1C7ZGoggl2Pb1BhkCYclf+BlCM=
MIME-Version: 1.0
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 24 Apr 2018 11:46:57 +0200
Message-ID: <CADYN=9J5yfmZeQoEmUfF_zwGkru=L1V6G7Tbz8yxt12Z6=qPgg@mail.gmail.com>
Subject: [net-next regression] kselftest failure in fib_nl_newrule()
To: roopa@cumulusnetworks.com, davem@davemloft.net,
        dsa@cumulusnetworks.com
Cc: netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

fib-onlink-tests.sh (from kselftest) found a regression between
next-20180424 [1] (worked with tag next-20180423 [2])

here is tree commits that look suspicious specially this patch (sha:
f9d4b0c1e969)
rewrites fib_nl_newrule().his patch (sha: f9d4b0c1e969) rewrites
fib_nl_newrule().

b16fb418b1bf ("net: fib_rules: add extack support")
f9d4b0c1e969 ("fib_rules: move common handling of newrule delrule msgs
into fib_nl2rule")
8a14e46f1402 ("net/ipv6: Fix missing rcu dereferences on from")

Cheers,
Anders
[1] https://lkft.validation.linaro.org/scheduler/job/195181#L3447
[2] https://lkft.validation.linaro.org/scheduler/job/193410#L3438
