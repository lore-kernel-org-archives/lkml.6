Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964997AbeBLQcS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:32:18 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:54544 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964902AbeBLQcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:32:17 -0500
Date: Mon, 12 Feb 2018 11:32:15 -0500 (EST)
Message-Id: <20180212.113215.529432620125895990.davem@davemloft.net>
To: mhiramat@kernel.org
Cc: mislam4@kent.edu, tom.zanussi@linux.intel.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        stephen@networkplumber.org, mathieu.desnoyers@polymtl.ca,
        rostedt@goodmis.org
Subject: Re: [PATCH net-next] trace_events_filter: conditional trace event
 (tcp_probe full=0)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180213012903.ef6b0efe5b896994ef8fc713@kernel.org>
References: <CAFgPn1C0Yc+QDkA3szkYgRXqK6PWDDJE1fGhJkfYM-hXR3ABQg@mail.gmail.com>
        <20180213012903.ef6b0efe5b896994ef8fc713@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Tue, 13 Feb 2018 01:29:03 +0900

> On Mon, 12 Feb 2018 00:08:46 -0500
> "Md. Islam" <mislam4@kent.edu> wrote:
> 
>> Recently tcp_probe kernel module has been replaced by trace_event. Old
>> tcp_probe had full=0 option where it only takes a snapshot only when
>> congestion window is changed. However I did not find such
>> functionality in trace_event.
> 
> Yes, that seems broken to me. You should filter by using perf script or
> bpf. I'm not so clear about network stack, but it seems that cwnd can be
> set for each tcp connection. This means "current snd_cwnd" must be stored
> for each connection.

'bpf' is definitely the way to do custom stateful things like this.
