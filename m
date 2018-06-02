Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbeFBDkW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 23:40:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:55817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbeFBDkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 23:40:18 -0400
Message-ID: <1527910776.7392.5.camel@gmx.de>
Subject: Re: [PATCH] x86,switch_mm: skip atomic operations for init_mm
From: Mike Galbraith <efault@gmx.de>
To: Andy Lutomirski <luto@kernel.org>, riel@surriel.com
Cc: LKML <linux-kernel@vger.kernel.org>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date: Sat, 02 Jun 2018 05:39:36 +0200
In-Reply-To: <CALCETrVE5ugmiSOjQ5sw7V+S4bRpMDs419rgrbTzfvjfhbWeqA@mail.gmail.com>
References: <20180601082811.4c0d33ba@imladris.surriel.com>
         <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
         <1527877328.7898.80.camel@surriel.com> <1527878882.4448.11.camel@gmx.de>
         <1527882207.7898.86.camel@surriel.com>
         <CALCETrVE5ugmiSOjQ5sw7V+S4bRpMDs419rgrbTzfvjfhbWeqA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rSHDma5L+XgHiVf+eJaN/Q3gmHNe4yjivmXRwVENcWwGdPQaePs
 jMW+DLIf4xmHE/1tjrszKljhOIUzDOmDFTR8ntyzBC8M3QRel+d6tx9GM8Uic79XOt8/ogo
 GGutsn3wcUnEOnSrmPtmJsJ8Iy1thJpliuKriu9NfUZLPH31ooHC9J/eZJVDJhbABCXM6Z+
 mcsdXxF9kazm0/snKW6PQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ubiB59eW3Kg=:7uk0aE51ifNxiFmmx9ASR+
 rf5s88hrN9U4oEcbsMw9xg7m6NupkbRLesc7JMuiq2kBYBPcbFAeMLTUSCrUvuh/SAZ2s36GP
 8aaeGFmHevBw7zBZ0u+l9bXDHhbWAYGxxp7yUyHIbDJL3iQdAQaDWnycg1WYgTqwOt8OiqBz7
 e6nen0oqoa2T9cGIr0dugv1vpgYs4Dmu/kqQZ41A+cVfr2HB9WoECujBi92ksVb0XSHReA1wz
 KnqVNb8yfo1lJ6QGP6B/IwC8FxDfeSI7MXyb4pw7K4mG/BjW0BxTn7GKde+mQI4G22LA3w01D
 coO7MUHgj6HNJ9h53RmflhwwU3h9DSuLbjR/V3YS9CjDA0IIrmACCn828c0gOczLeLm3j2aX3
 lRBmipEKW2/n6LBD2HMH65VywVXfQ1nO/Q81+AgPxTg0yYVZgxfL3p7mAHiEcQUDJbJbZ4mK9
 6iuuDcY82fd+lnhcw+6PuifKutL8XS/jB9qzaRXCaR83jekZd+z7ThHnQ0V7Ne7FSH69do+Z6
 vAoQ+nGs0RrxOppycb4bNmcXq0D+sc7N4/UD6eVS9XUiMi7i4TretCfCuktf5zYX/ZWqsvAtp
 /RcfeSwQum6NJogesFbetTiFY/81Lq//fSs9GnW1kO6nXXnfAFyU5mGiiD3e8pMx7t1yYCGWJ
 +1A/WxRu5muvGTMy3mxlmAjZzK4nbFaSQbk4XNj++BIp/GUMO5gWtZG9BjV7qh8V+8Q8acbd4
 DT7jRKynnn7mKkvxx7EtqxGKgdEhXnuss1hXn4788PmVStI6fzShgsIPDDrx3nurjUGC2r5rQ
 5E1yS33
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-01 at 13:03 -0700, Andy Lutomirski wrote:
> 
> Mike, you never did say: do you have PCID on your CPU?

Yes.

>   Also, what is
> your workload doing to cause so many switches back and forth between
> init_mm and a task.

pipe-test measures pipe round trip, does nearly nothing but schedule.  

	-Mike
