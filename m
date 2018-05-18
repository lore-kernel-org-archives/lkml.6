Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeERSg1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 14:36:27 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33424 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbeERSgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 14:36:24 -0400
X-Google-Smtp-Source: AB8JxZoK0lNhpnwEZ/o3wIbo4sCmmXKLIpi4t55pObidqb2pwrSP4Sz0GsM2iv+oWG/TFiUend2SAg==
Date: Fri, 18 May 2018 11:36:23 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: paulmck@linux.vnet.ibm.com, rostedt@goodmis.org,
        byungchul.park@lge.com, mathieu.desnoyers@efficios.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Subject: Tasks RCU vs Preempt RCU
Message-ID: <20180518183623.GA163151@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was thinking about tasks-RCU and why its needed. Since preempt-RCU allows
tasks to be preempted in read-sections, can we not just reuse that mechanism
for the trampolines since we track all preempted tasks so we would wait on
all tasks preempted within a trampoline?

I am trying to understand what will _not_ work if we did that.. I'm guessing
the answer is that that would mean the trampoline has to be wrapped with
rcu_read_{lock,unlock} which may add some overhead, but please let me know
if I'm missing something else..

The advantage I guess is possible elimination of an RCU variant, and also
possibly eliminating the tasks RCU thread that monitors.. Anyway I was
thinking more in terms of the effort of reduction of the RCU flavors etc and
reducing complexity ideas.

thanks!

- Joel
