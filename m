Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeC0GzC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:55:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:39801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751349AbeC0GzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:55:00 -0400
Message-ID: <1522133652.5996.2.camel@gmx.de>
Subject: Re: [PATCH v6 2/2] cpuset: Add cpuset.sched_load_balance to v2
From: Mike Galbraith <efault@gmx.de>
To: Waiman Long <longman@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Date: Tue, 27 Mar 2018 08:54:12 +0200
In-Reply-To: <bf79b45e-7716-65af-03ca-7112dc367371@redhat.com>
References: <1521649309-26690-1-git-send-email-longman@redhat.com>
         <1521649309-26690-3-git-send-email-longman@redhat.com>
         <20180322084120.GE7231@localhost.localdomain>
         <e754e128-0a93-800e-e71b-2c8dc316ba8a@redhat.com>
         <20180323075952.GA4763@localhost.localdomain>
         <a8860a42-31b5-4620-7b23-b7515ee11d7d@redhat.com>
         <20180326124711.GE5942@localhost.localdomain>
         <bf79b45e-7716-65af-03ca-7112dc367371@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:lAzZqiduz1T6QX/X1Q6FJGJzdkh4racHg7nUUGBygmjduwryX5D
 ZdxUtKhEeTGF0PfCx2ZfSjj2Hc0zARHh9qxFKuaOa1HL9HkHeLgRBQmp06l0SvnlM1DVMa2
 3Q2X4/VFopsBT/hRZdKVY2GTAggUjwZOF3hptgSD+s2lYgnkqzy+SSkF2BhY5v1FKswipAO
 EIB/VWyMCXsuTayxIznIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dbIY+EfO/s8=:1OjkQvtOSaDELZ4d1ZFIrE
 dTgeWsGnwl8KC9q06Df0+Sch00f6feX8GRWfmIsy5ryfK6pXOOfcRfgVipDI2u63Y4hWkZoQ4
 FzGdMlZKr0ky6DyCamPpUep6aAxSCb47m0ZBMFA+J6BVWhXwws4qsIp/iOtCt4GToPwaNUH5H
 yCwn2gl6H1ZVbTDTDYeBtVI/P0AhtIN2mIW7nZMabnKa2BHAhHqQtif7pxDsHSN0MYk1c0Zpy
 HFfTqA90inaHCrrEeEECO/MPW5bI7C+fyVC8Tp9NT4T7Q8CWquoCDeyk2O4WerO1/CTla58yt
 wHupw4P5unJkjgLkXn0lQQBnlvWLb9cLvRrprpkbUP7W4SWNdYnrKSrr5mBpwoPpN8mnL0vy4
 ciTgjIayio3Hou8HTacN8yH2bRkVrNspX0o+hs48448rJdeB8ifT1v6mjiP3g6Tv+q0X2SA9J
 lr3zp/a/WX/paONXMBBgqBgvnNedJW4UBDuTRJ5inlSY+ciymA1qH0XwxiPxPacmLdZWIBiBl
 sH784yZTPObWhhlX1ZWHlDAYSkkrxMMTgeGBHpxKLXL7IDZLaqYlD/7jOFqwoDC6IOMcjZNem
 hLGdtzG89AvMkLiXR5jBM/IG7cHBQF3jMuWHQwCDUdmeuPO57NSxmqSsvCTpt1pdXhuIAXUar
 EGOpIPDnI5/QKyJpoppK9xas4KGQgsAPfAu7Tn8KF47C/vVfbNP5GEjmC+5RNBxsC/2qhiO7i
 JWHhQi5fUwPl5zT/yLrwo1628y9F2fb7MephzFqvBSfFPsoyC0w7usdiX2xbY8jfj9VUca9yA
 pWrYZW6XPIgxVeU2gb74ctsnoa2WgnTtoZKMAD8Q494C7DZBck=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-26 at 16:28 -0400, Waiman Long wrote:
> 
> The sched_load_balance flag isn't something that is passed to the
> scheduler. It only only affects the CPU topology of the system. So I
> suspect that a process in the root cgroup will be load balanced among
> the CPUs in the one of the child cgroups. 

Yes, among CPUs that remain part of topology (and intersect affinity).

> That doesn't look right unless
> we enforce that no process can be in the root cgroup in this case.

caveat: quite a few kthreads are nailed to the floor of root.

	-Mike
