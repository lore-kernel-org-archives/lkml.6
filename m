Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeCTMHL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:07:11 -0400
Received: from juno.mpi-klsb.mpg.de ([139.19.86.40]:33428 "EHLO
        juno.mpi-klsb.mpg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753006AbeCTMHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:07:09 -0400
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, milian.wolff@kdab.com
From: Jan-Oliver Kaiser <janno@mpi-sws.org>
Subject: `perf report` about 1000x(!) slower in linux 4.15
Message-ID: <c6aa77d0-3d0c-bd03-aaa9-f1c33eff277f@mpi-sws.org>
Date: Tue, 20 Mar 2018 12:57:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MPI-Local-Sender: true
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear perf maintainers,

After upgrading my system to linux 4.15 (from 4.14), `perf report` 
became unusably slow. I estimate a decrease in performance by a factor 
of 100x-1000x. Some 21M perf.data files take about 30 seconds in the 
"Processing events" step.  `git bisect` points to

commit d8a88dd243a170a226aba33e7c53704db2f82aa6 (HEAD, refs/bisect/bad)
Author: Milian Wolff <milian.wolff@kdab.com>
     perf util: Enable handling of inlined frames by default

The slowdown can be worked around with `--no-inline`. If the slowdown is 
expected, I would suggest reverting the default setting here or maybe 
printing a warning if a lot of time is spent on this feature.

Do you need any additional information about my system or the recorded 
data I am looking at?

Thanks,
Janno
