Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeDEIko (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 04:40:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:60635 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbeDEIkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 04:40:41 -0400
Message-ID: <1522917620.5593.5.camel@gmx.de>
Subject: Re: sched_rt_period_timer causing large latencies
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 05 Apr 2018 10:40:20 +0200
In-Reply-To: <20180405082701.GL4082@hirez.programming.kicks-ass.net>
References: <20180405091138.6ef14d15@roar.ozlabs.ibm.com>
         <20180405082701.GL4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:I8fw30LbV454QAB9F7XmdJTpiCpxLBJhdlwX1LR6TdYMF4o55Hr
 q3k0SB0+ts3WjpBdcaWBzVMlJlBue+oeJr51PONk8g+P4EgKrucYpn8GrP03UZGYqzNXzAP
 kCr+vWzqwfxYGvaPmHYUedAF/edlE48lU+mhRBKhZSyKriBg5VtcVj3TZgIty6RDAwRvuxV
 nVyK+zQzNupamRuTZeuRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D+PTt5r+c6Q=:SPDk165sfyY4abIkreQR04
 e3JWX+LY7ba84IXEGdcysbslIfnR/+Zl9PHMrHKXaAryawhfc6rLGV23dpXU55tuMwSIFQtNc
 ZkbynIzgNM/MUnATTD4AijPs+27RMZBcQiyLQ5tos9Qv2CuM18LVRUXX4N+6r6bakoqZF5/Yu
 VnM4Zj/8N6DJsby6hhUOY2o9p3nxdTAu34MU97G2naujq41nX2wz5Xq45PRsL0DA89al3yPta
 GbcYRYmmkqDCnY5ziGIKa+p+60Yh8nyRd1qVTyT8DEYzv8xqemhQKBQEl7+tkg9vBn6BuGeaz
 bcp+E3hm9RwqUlRS7lKGrRv7xhdxVDRovRmdINB848v6oAHtxkE+hpsahgNorL6eA91WkbwdK
 /40yXMS9KGO/i7eilq1jFZHPX8DJagWho7rNaxvV47QQKtZgmKYNna3pllNLnq1+TydPy7lUK
 SPPppe0+ubcImcNVxWPG56yX3KHAqwPyLw1DnfNiQhxswMYybW2BOeJDs+Xzae7Uf5xb/cKEL
 2tt3tsqq5ODRew8h7chnhkbnH1raw/e+0+55gKrieudtpyNgUQQ3KSk5CIPU2ROX3td5GvL/p
 OyRzW9XbMyadZinGSZhJQzqX2f2W+7TTxNM9eYcjCqPX8PTWD0QxrBU6s9wVHEMghfECyuKT9
 osJQ06f73Ibb7tKqOYPeODOT2Z2HFDBX+MqUOVGPgKOXZF5M5bNWV3hEoEZGtOdPV7Hq0zNRN
 Zn//SgQf0k4q2f7JGnr6NQzwmGFyX40K+qYZUSy9937u3W4hU6Wvvlz3WRj9RGguEVypFyorv
 UVti3d/y7luBszPT8RDkw7IYFyM88GWCpp+WvMn0F2FNMg6/NM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-05 at 10:27 +0200, Peter Zijlstra wrote:
> On Thu, Apr 05, 2018 at 09:11:38AM +1000, Nicholas Piggin wrote:
> > Hi,
> > 
> > I'm seeing some pretty big latencies on a ~idle system when a CPU wakes
> > out of a nohz idle. Looks like it's due to the taking a lot of remote
> > locks and cache lines. irqoff trace:
> 
> On RT I think we default RT_RUNTIME_SHARE to false, maybe we should do
> the same for mainline.

Probably.  My very first enterprise encounter with the thing was it NOT
saving a box from it's not so clever driver due to that.

	-Mike
