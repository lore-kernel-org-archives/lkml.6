Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeD3K4E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:56:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53587 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbeD3K4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:56:03 -0400
X-Google-Smtp-Source: AB8JxZrXKQTucAg5Xd/CNBlYkiBSq9oL3DlEWSD8oEvZKwXrNNEfhOkLteQQcBU7qHgx31UB7bEGGA==
Date: Mon, 30 Apr 2018 11:55:59 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Julien Thierry <julien.thierry@arm.com>
Cc: Joel Fernandes <joel.opensrc@gmail.com>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mark.rutland@arm.com, marc.zyngier@arm.com, james.morse@arm.com,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v2 0/6] arm64: provide pseudo NMI with GICv3
Message-ID: <20180430105559.ys6kcfoy76o3qpoj@holly.lan>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
 <e0b5ae90-f21e-f5db-a4af-52900a2e8c07@arm.com>
 <CAEi0qNkt75cqF=03HrQ81+pDdWVOpzGiHrk8_cTNTJo9os9D8Q@mail.gmail.com>
 <07a0b8c1-3d87-0cae-61df-dbff782be301@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a0b8c1-3d87-0cae-61df-dbff782be301@arm.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 10:53:17AM +0100, Julien Thierry wrote:
> 
> 
> On 29/04/18 07:37, Joel Fernandes wrote:
> > On Wed, Jan 17, 2018 at 4:10 AM, Julien Thierry <julien.thierry@arm.com> wrote:
> > > Hi,
> > > 
> > > On 17/01/18 11:54, Julien Thierry wrote:
> > > > 
> > > > This series is a continuation of the work started by Daniel [1]. The goal
> > > > is to use GICv3 interrupt priorities to simulate an NMI.
> > > > 
> > > 
> > > 
> > > I have submitted a separate series making use of this feature for the ARM
> > > PMUv3 interrupt [1].
> > 
> > I guess the hard lockup detector using NMI could be a nice next step
> > to see how well it works with lock up detection. That's the main
> > usecase for my interest. However, perf profiling is also a strong one.
> > 
> 
> From my understanding, Linux's hardlockup detector already uses the ARM PMU
> interrupt to check whether some task is stuck. I haven't looked at the
> details of the implementation yet, but in theory having the PMU interrupt as
> NMI should make the hard lockup detector use the NMI.
> 
> When I do the v3, I'll have a look at this to check whether the hardlockup
> detector works fine when using NMI.

That's what I saw on arch/arm (with some of the much older FIQ work).

Once you have PMU and the appropriate config to *admit* to supporting
hard lockup then it will "just work" and be setup automatically during
kernel boot.

Actually the problem then becomes that if you want to use the PMU 
for anything else then you may end up having to disable the hard 
lockup detector.


Daniel.
