Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeEVJqi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:46:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:41845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEVJqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:46:37 -0400
Message-ID: <1526982375.6491.3.camel@gmx.de>
Subject: Re: [PATCH] x86: UV: raw_spinlock conversion
From: Mike Galbraith <gleep@gmx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Date: Tue, 22 May 2018 11:46:15 +0200
In-Reply-To: <20180522091408.nt4fodr4f5ikk5ow@linutronix.de>
References: <20180504111459.24825-1-bigeasy@linutronix.de>
         <20180504111459.24825-2-bigeasy@linutronix.de>
         <alpine.DEB.2.21.1805061225550.1685@nanos.tec.linutronix.de>
         <1525604359.28142.3.camel@gmx.de>
         <20180507073928.shmtfpqyhgxya53b@linutronix.de>
         <1526738996.5365.1.camel@gmx.de>
         <20180522065051.xy42nwvcxz2nekti@linutronix.de>
         <1526977462.6491.1.camel@gmx.de>
         <20180522091408.nt4fodr4f5ikk5ow@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/yS/BYRLkbOjKIlly+PbKeIH9Katjt1bJ5FSi7ToBe7H/JVpYw6
 V1/C1mlRKnVVbLQ1Vg5MxuWsC2+T0xZUYCWOv7JX701NywGaIyFaIms+umCxjILpGgFxA4L
 XLTy7ehNJAMGsttKQUgDcLxSuTB13aNT5x+rv9PMwXNfOvfjchiyZImyBLo9RtS2wPRgGcY
 gGv4MW0E+lcNYqeR05DAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k2DbBofPPfg=:DOm49sYoSNmX72qQEz7ACS
 RncFTsHmxDq0QRBgMezEKd1TYKc1WWf/WhXLw8VNiVJYmxEk8Ruf5G6E4a+vqlArFFaDSHMY1
 H05iR9u4/xV8S8tFf6JTqPbF2SLXPyt48faZFlcH5fsNbiOix8WfPuuyoU25O0H66Z7kUlP5h
 cnLgEpl+k8rtD5W4hvBNyIXad0ppD7TwxwT9pmcqJO5COghkGBROwDoPTvdsAY2NL1WJZRFjO
 EMXMBvzfkw8BkQ+2pk8xDBMTMX2IEOoFjrNkmGA+AEA3wqA85h46VD1iSw9XzV64O1O58gDGj
 UsV+9hAoW2Rip9NdMtuGbVx9grJQxUw4+N4ewmdXwQMTofD5jU5MTDiGSlwUTEIRgDDxi0JcO
 fzQ8vaNPZXX9U6HVKMwUWz4ndj4Oav9zFnA0RtwqIJVYRzfPbE8cf/LWWC+Qyh1bApZhdBduw
 wTKqKQIK4qZMUaK8gOAO+JswTa3wC6772u0/r/n0ydajRxeevW4YM5aFxJUeKTmGY3OMt8FYL
 7E+s/Isad1AAWukk71Pke5M7r2PME7yo4W7ImD5JaqWag1M2CfpuEb7jBESVY7Pfy4BUwoqK8
 sKDbPgRACSwcxQmzZpc370NbA+njU8uPFpGkwZJIh2Ac7vXaG0dW4NDRTGA8DceXef72ggd2B
 I/wp0gSInNJEjGEt3jbMMfwpMTH37zHQuFkS/bGiw6JoB44yDJX1vsCeOFRV6h1Aj1IxhdbQh
 JAQhU16duNt09iyXuswPGs56mbGhRlDsq9nvbsFXGw9fdL04biAYSUvQXLlV0TytrV2YIhpen
 PJYUA1I
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-22 at 11:14 +0200, Sebastian Andrzej Siewior wrote:
> On 2018-05-22 10:24:22 [+0200], Mike Galbraith wrote:
> 
> > If I were in your shoes, I think I'd just stop caring about UV until a
> > real user appears.  AFAIK, I'm the only guy who ever ran RT on UV, and
> > I only did so because SUSE asked me to look into it.. years ago now.
> 
> Okay. The problem I have with this patch is that it remains RT only
> while the problem it addresses is not RT-only and PREEMPT kernels are
> very much affected.

Ah, but when RT gets merged (someday... maybe), that patch will apply,
and instantly make all.. zero.. UV-RT users happy campers :)

> The thing is that *you* are my only UV user :)

Crash-test-dummies don't really qualify as users :)

>  If you suggest that I
> should stop caring about UV than I do so. Please post a patch that adds
> a dependency to UV on PREEMPT so that part of the architecture is
> documented.

Will do.

	-Mike
