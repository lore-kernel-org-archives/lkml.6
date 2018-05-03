Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbeECOR2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:17:28 -0400
Received: from mout.gmx.net ([212.227.17.21]:44123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeECORY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:17:24 -0400
Message-ID: <1525357015.5577.2.camel@gmx.de>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Date: Thu, 03 May 2018 16:16:55 +0200
In-Reply-To: <20180503135617.GC12217@hirez.programming.kicks-ass.net>
References: <20180417142119.GA4511@codeblueprint.co.uk>
         <20180420095005.GH4064@hirez.programming.kicks-ass.net>
         <20180424133325.GA3179@codeblueprint.co.uk>
         <1525349542.9956.2.camel@gmx.de>
         <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
         <1525351221.9956.4.camel@gmx.de>
         <20180503124943.GB12217@hirez.programming.kicks-ass.net>
         <1525354359.5576.1.camel@gmx.de>
         <20180503135617.GC12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:P1S5Al/8+5dbjTcBD70nCYfqNghpWZZF1hPeLGsdGl22TxYDQCu
 Nio4Z8GbJFHxLozKSrgUg/dt1KL9hNxf09bKV+sRX+ve4mh2RlJVNKFLVhcL5VP/Vx5LO7c
 rE4as59TGkVHcqq35AIaLdyzh+yCdl0oLNbNhghUcSZbblt7mp6PlC8nfEW8jDLVTd961MI
 ay0asyyWKhKU+EiX25Jlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8bST8YTjpvg=:Ac7uJarTWTdxo8wLuHazPt
 iCA9zNepswJykuzkbH1s3JE1TsLjLN7WazYZRqAjgmZT7YQQlh4v8xbBNoSs1o3NnuBdUf/9K
 su9OoQGVgC0uUGF1n7VWzzNY7xiN/lnHkeOuqcV9m/Or34bCQVg9Gz7JpOY3oDIy1/ifHCRfl
 /9jpD9C/si6cvm7envBcAzvvrZgYKcKCniY6z575lI28cIQG2bzoT1SZidnATKFe17JuA+Jv1
 GSfTbkDhuRI2XCjVtC4Qp9INFKi0VEI6qEjDYuVejBtjMysERBf3XeBhfQpWMO4DW7Z1YTmSS
 bdIBLRK4WGQ2v+UcvmGlGMEfJ/dCuro/TboV+FPeO6pBgruqWQrLUZBeK/jlKCPF44duQemUE
 Qr7S/9QFEbOj2M0zQ+jFMLSfR3j1DVQX7Awo2AjYk2D3dR1urMfyvBzDACaM9g87ePsa1HcB9
 TiIdiuDM03TZwhGku/7RJTc9q6l+mPIW68/IW8bec82ubys8qQQ4Afnsiyg77UJXAK7QnOsea
 LIYv/Z+0bD+5ygEsZ0RYwMwCWsfBTswJBn1M/BdLLLUqLGn34gAb5UUiZUU02KZpTOl+hkOcI
 Rw55YcyKxaJOFmUO4aHVPbsk8EGwqC+atY7cjQ6useNj2VGFyG/WEATRWQ8Fwdwl5k+aD97CN
 gi5Lf4Ym4Za5mJXXRrlE9ZuOcT7qMyTjHebM/at4LGT3fQiigFleaZ4KlKcd8WBdnfjH5T74N
 yBBktRVs4RWfS6JNOXUfaTz/CVM/9HsLNUf5hZPo0DdVj9wWUy/p6e8RVSksWAd0epv048mhV
 O95f7GY
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-03 at 15:56 +0200, Peter Zijlstra wrote:
> On Thu, May 03, 2018 at 03:32:39PM +0200, Mike Galbraith wrote:
> 
> > Dang.  With $subject fix applied as well..
> 
> That's a NO then... :-(

Could say who cares about oddball offline wakeup stat. <cringe>
