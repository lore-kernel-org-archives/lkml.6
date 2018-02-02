Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeBBOSN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:18:13 -0500
Received: from mail.sssup.it ([193.205.80.99]:19199 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbeBBOSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:18:06 -0500
Date: Fri, 2 Feb 2018 14:17:50 +0100
From: Luca Abeni <luca.abeni@santannapisa.it>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: peterz@infradead.org, lizefan@huawei.com, mingo@redhat.com,
        rostedt@goodmis.org, claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/7] sched/deadline: fix cpusets bandwidth accounting
Message-ID: <20180202141750.5652d2b7@luca>
In-Reply-To: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
References: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Thu,  1 Feb 2018 09:51:02 -0700
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> This is the follow-up patchset to [1] that attempt to fix a problem
> reported by Steve Rostedt [2] where DL bandwidth accounting is not
> recomputed after CPUset and CPU hotplug operations.  When CPU hotplug and
> some CUPset manipulation take place root domains are destroyed and new ones
> created, loosing at the same time DL accounting information pertaining to
> utilisation.  Please see [1] for a full description of the approach.

I do not know the cgroup / cpuset code too much, so I have no useful
comments on your patches... But I think this patchset is a nice
improvemnt respect to the current situation.

[...]
> A notable addition is patch 7/7 - it addresses a problem seen when hot
> plugging out a CPU where a DL task is running (see changelog for full
> details).  The issue is unrelated to this patchset and will manifest
> itself on a mainline kernel.

I think I introduced this bug with my reclaiming patches, so I am
interested.
When a cpu is hot-plugged out, which code in the kernel is responsible
for migrating the tasks that are executing on such CPU? I was sure I
was handling all the relevant codepaths, but this bug clearly shows
that I was wrong.


			Thanks,
				Luca
