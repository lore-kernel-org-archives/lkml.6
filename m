Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeDDRpP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:45:15 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:39267 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeDDRpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:45:13 -0400
X-Google-Smtp-Source: AIpwx4+FqAtW0kuuebxoqRoE5ZfoT2stPRYCS+44hj9/ixG5VWnBnyy50NTzLemwYnfIih8S10019Q==
Date: Wed, 4 Apr 2018 20:45:09 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: alban@kinvolk.io
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH] [RFC][WIP] namespace.c: Allow some unprivileged proc
 mounts when not fully visible
Message-ID: <20180404174509.GA2540@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Instead, it introduces new options in proc to disable some proc entries (TBD).

No, no, no, no.

Blacklists are bad, mmkay.

The reason is that quite dangerous new /proc entries get added
(think /proc/kpageflags) and suddenly they are enabled inside container.

> The granularity does not need to be per proc entry.

I think it does. Grouping always becomes either too fine or too coarse.

> Granularity can be improved later if use cases exist.

Granularity can not be tightened as it may break existing users.
So new granularity options are going to be invented until finally it is
per file.

>	"maskedPaths": [
>		"/proc/kcore",
>		"/proc/latency_stats",
>		"/proc/timer_list",
>		"/proc/timer_stats",
>		"/proc/sched_debug",
>		"/sys/firmware",
>		"/proc/scsi"
>	],

Just say no to drugs.


> /proc/kcore

As a side note:
/proc/kcore should be more or less safe because it is under CAP_SYS_RAWIO.
