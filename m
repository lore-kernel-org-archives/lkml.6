Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeEQQ4U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:56:20 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeEQQ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:56:19 -0400
Date: Thu, 17 May 2018 18:55:26 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, linux-arm-kernel@lists.infradead.org
Message-ID: <307323036.63872.1526576126537@email.1und1.de>
In-Reply-To: <alpine.DEB.2.21.1805171233500.7984@macbook-air>
References: <20180517131727.29263-1-eric@anholt.net>
 <1412187220.62585.1526572780332@email.1und1.de>
 <alpine.DEB.2.21.1805171233500.7984@macbook-air>
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:aGq2ulLPCFSp+GvrXkPzBsbXJ7n0pv/6eQRZGsMnzKSNsg6jkq1
 3QA9DnOX5L9zcyQBjI3aKgZ6rBtDMByaHGooHAlJB3kU2ZQ6aN2EjqqSuHpBbXunRbpR7qw
 7BqkLPGTNg7sN4eCHw6Y6telFzU2IsNTznisHXdtnwQ2pXC3xUx/I2bjD8Q2nlmPQsoQmS/
 L/Gv9cxsI0wRWJC41DbCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u52ML8cg6HQ=:rzSnraGWxNafmB9xzU5Ske
 4pCyd5Y/AGx2uFQBEmTa+iR2Xu+7ZGlUVQHRRASwlnR+7MM9zyMtfWopC7fUfMGKmyp5vWKGm
 Odj2o/jHmaRTx6hcePDbsdNQjlMJ3Vwo3QGqZK1QCWguJVjK7NO2cg6YJdZU/gHC0cr34lHIc
 LX2jdBINyQSDq12siPHMUCkGAGkv0xUv1hBOSSohXeDipkyKD8NRk7dtpaAxAOXR/dRZz0h5F
 hE4uSe8XaXcDXnQqaqJAHIEpo2MtlRCnw2SfkooNDczU57AnbxT8G6Ie6+aypI9gVGkl3YXxe
 /cefUKGQoiNvBVaTBBisajF4WrQJfk9pzn537YGTtTrQ1/0tvQRcUiVEASjPyxNzSMK0NWDsM
 oxSKk7IkdCz9I60NWgF3TKz/m4zJ5oc9GAldFAmUgR18rn81qPtiKjVzE2o0SsNtKxXpdKmFa
 yD9d5tUDnGnAiT1l0H/ojhQYC/FZ7JgJz/uHxxCPKaPMvswev5tq++2hnbBrc5YP02M97Y982
 Uq75SDqR9X3MhwsBmBGR6ff9w6eeDhHg+WtXu9b6tDEoh1WdXnT9ejANXvFRLidIbHikCqXk6
 z4L22urNscaFxrrNOTUxmJnmvuRCIOLB1vDOQ4T8bFsiU85NBf5v9b5Nua824xMncZwxSYEzP
 hh3ptNWH57KclqQ1dfJwJBEsoROsuTKq3TBB8aWW9SWNhJ724ghILrTgBSIX8TzjdjVndMqAW
 DDonC6FyRWU86+qc
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[added Peter, Ingo and Arnaldo]

> Vince Weaver <vincent.weaver@maine.edu> hat am 17. Mai 2018 um 18:34 geschrieben:
> 
> 
> On Thu, 17 May 2018, Stefan Wahren wrote:
> 
> > 
> > > Eric Anholt <eric@anholt.net> hat am 17. Mai 2018 um 15:17 geschrieben:
> > > 
> > > 
> > > The a53 and a7 counters seem to match up, so we advertise a7 so that
> > > arm32 can probe.
> 
> so how closely did you look at the a53/a7 differences?  I see some major 
> differences, especially with the CPU_CYCLES event (0xff vs 0x11).
> 
> The proper fix here might be to add a cortex-a53 PMU entry to the armv7 
> code rather than trying to treat it as a cortex-a7.

we like to use the PMU of BCM2837 SoC (4x A53 cores) under arm32 and arm64.

What is the right way (tm) to the define the DT compatibles?
Does the arm32 PMU driver need patching for proper A53 support?

Stefan

> 
> Vince
