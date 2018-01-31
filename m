Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeAaJOh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:14:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752715AbeAaJOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:14:34 -0500
Date: Wed, 31 Jan 2018 10:14:27 +0100
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Leo Yan <leo.yan@linaro.org>
Cc: brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, eas-dev@lists.linaro.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] samples/bpf: Add program for CPU state statistics
Message-ID: <20180131101427.4c55fc21@redhat.com>
In-Reply-To: <1517336999-5731-1-git-send-email-leo.yan@linaro.org>
References: <1517336999-5731-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2018 02:29:59 +0800
Leo Yan <leo.yan@linaro.org> wrote:

> CPU 0
> State    : Duration(ms)  Distribution
> cstate 0 : 47555        |*********************************       |
> cstate 1 : 0            |                                        |
> cstate 2 : 0            |                                        |
> pstate 0 : 15239        |*********                               |
> pstate 1 : 1521         |                                        |
> pstate 2 : 3188         |*                                       |
> pstate 3 : 1836         |                                        |
> pstate 4 : 94           |                                        |
> 
> CPU 1
> State    : Duration(ms)  Distribution
> cstate 0 : 87           |                                        |
> cstate 1 : 16264        |**********                              |
> cstate 2 : 50458        |***********************************     |
> pstate 0 : 832          |                                        |
> pstate 1 : 131          |                                        |
> pstate 2 : 825          |                                        |
> pstate 3 : 787          |                                        |
> pstate 4 : 4            |                                        |
> 
> CPU 2
> State    : Duration(ms)  Distribution
> cstate 0 : 177          |                                        |
> cstate 1 : 9363         |*****                                   |
> cstate 2 : 55835        |*************************************** |
> pstate 0 : 1468         |                                        |
> pstate 1 : 350          |                                        |
> pstate 2 : 1062         |                                        |
> pstate 3 : 1164         |                                        |
> pstate 4 : 7            |                                        |

The output gets very long as the number of CPUs grow...
What about using the following output:

state(ms)  cstate-0  cstate-1  cstate-2  pstate-0  pstate-1  pstate-2  pstate-3  pstate-4
CPU-0        47,555         0         0    15,239     1,521     1,836     1,836        94
CPU-1            87    16,264    50,458       832       131       825       787         4
CPU-2           177     9,363    55,835     1,468       350     1,062     1,164         7

Look at the code samples/bpf/xdp_redirect_cpu_user.c for an examples of
howto align the columns, and the trick to get printf to pretty print
with thousands separators use %' and setlocale(LC_NUMERIC, "en_US").


P.S. net-next and bpf-next is closed at the moment.
 Next time you submit read[1] and [2], especially howto indicate which
tree (bpf vs. bpf-next) the patch is against, as this helps the
workflow of the maintainers.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/Documentation/bpf/bpf_devel_QA.txt
[2] Documentation/networking/netdev-FAQ.txt 
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
