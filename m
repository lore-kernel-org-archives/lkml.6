Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeDJNOu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752857AbeDJNOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:14:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8EE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 10 Apr 2018 09:14:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal
 OOM_SCORE_ADJ_MIN
Message-ID: <20180410091446.01c25c3b@gandalf.local.home>
In-Reply-To: <20180410091311.20bd8ccc@gandalf.local.home>
References: <20180410061447.GQ21835@dhcp22.suse.cz>
        <CAGWkznGrugH0VqJyd5ZPiSBMOZ4SbbNpKiHVXM27Q-ep4SYb-Q@mail.gmail.com>
        <20180410074921.GU21835@dhcp22.suse.cz>
        <CAGWkznHQSZ5jPF2njOp0BritTmKiGOToq5bAz1bhzzmFi_01nA@mail.gmail.com>
        <20180410081231.GV21835@dhcp22.suse.cz>
        <CAGWkznEM=AX=3LWDmgyz4GRkWy81TNdFQQXZ7+W4=Ek4ZsnsJw@mail.gmail.com>
        <20180410090128.GY21835@dhcp22.suse.cz>
        <CAGWkznEf0siz1-RFSJwuKCjUtbKM=P1djo2Nc7sU1GS0AgWv2w@mail.gmail.com>
        <20180410104902.GC21835@dhcp22.suse.cz>
        <20180410082316.263d34ec@gandalf.local.home>
        <20180410122706.GH21835@dhcp22.suse.cz>
        <20180410083625.2c904ab2@gandalf.local.home>
        <20180410091311.20bd8ccc@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 09:13:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Something like this:

Zhaoyang, would this work for you?

Then all you need to do is to:

 echo 0 > /d/tracing/options/mem-reclaim

and then you have the old behavior before Joel's patch. It will use
NORETRY and also not set up the OOM to kill your task.

-- Steve
