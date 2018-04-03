Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755197AbeDCKoG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:44:06 -0400
Received: from listserv2.niif.hu ([193.225.14.155]:50620 "EHLO
        listserv2.niif.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbeDCKoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:44:05 -0400
From: wferi@niif.hu (Ferenc =?utf-8?Q?W=C3=A1gner?=)
To: linux-kernel@vger.kernel.org
Cc: wferi@niif.hu
Subject: What's the priority of the idle task?
Date: Tue, 03 Apr 2018 12:24:25 +0200
Message-ID: <87muykk2p2.fsf@lant.ki.iif.hu>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(Please let me ask my Stackexchange question [1] here as well in the
hope of getting an answer from this board of dedicated experts.)

As explained by several (if somewhat old) articles [2,3,4], the Linux
idle task (PID=0, one per CPU) is run when there are no other tasks to
run. To get the scheduler do this, the idle task must have the lowest
priority reserved for it. That old Documentation/ftrace.txt in the
linked LWN article explicitly says that

> The prio "140" is reserved for the idle task which is the lowest
> priority thread (pid 0).

This makes sense, but under Linux 4.9

# perf record -e sched:sched_switch sleep 1
# perf script
   sleep  6526 [000] 362661.310842: sched:sched_switch: sleep:6526 [120] S ==> swapper/0:0 [120]

reports a priority of 120 for swapper/0 (in the closing bracket),
contradicting the above.

How does the Linux scheduler handle the idle task nowadays? The commits
removing the quoted text from ftrace.txt (87d80de28, 294ae4011) didn't
help.

Please Cc me on answers/comments.

Thanks,
Feri.

[1] https://unix.stackexchange.com/questions/435089/whats-the-priority-of-the-idle-task
[2] https://superuser.com/a/972581/462180
[3] https://lwn.net/Articles/290277/
[4] https://unix.stackexchange.com/questions/361245/what-does-an-idle-cpu-process-do
