Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935409AbeBMOdZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:33:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58642 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933612AbeBMOdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:33:23 -0500
Date: Tue, 13 Feb 2018 14:33:19 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Channa <ckadabi@codeaurora.org>
Cc: Matt Sealey <neko@bakuhatsu.net>, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-arm@lists.infradead.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        Stephen Boyd <sboyd@codeaurora.org>, kyan@codeaurora.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Documentation for qcom,llcc
Message-ID: <20180213143318.be2dmmmoiafkehqk@lakrids.cambridge.arm.com>
References: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org>
 <1516924513-20183-2-git-send-email-ckadabi@codeaurora.org>
 <CAHCPf3vt-ZCXgTfCZ-LSW3TSXAk5KBz3wCu-LuTOBdCB+sgGgw@mail.gmail.com>
 <0ce690ab886d4896506ba916d2d39554@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce690ab886d4896506ba916d2d39554@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 04:24:16PM -0800, Channa wrote:
> On 2018-02-08 08:52, Matt Sealey wrote:
> > On 25 January 2018 at 17:55, Channagoud Kadabi <ckadabi@codeaurora.org>
> > wrote:
> > > Documentation for last level cache controller device tree bindings,
> > > client bindings usage examples.
> > 
> > [snippety snip]
> > 
> > > +- llcc-bank-off:
> > > +       Usage: required
> > > +       Value Type: <u32 array>
> > > +       Definition: Offsets of llcc banks from llcc base address
> > > starting from
> > > +                   LLCC bank0.
> > > +
> > > +- llcc-broadcast-off:
> > > +       Usage: required
> > > +       Value Type: <u32>
> > > +       Definition: Offset of broadcast register from LLCC bank0
> > > address.

> > And if you need to describe register offsets... why aren't you able to
> > use the reg property?
> 
> Reg property did not suit well for my need, so I choose to maintain offsets
> instead.
> 
> The registers in the HW block are organized as
>                 (offset1)    (offset2)     (offset3)     (offset4)
> Base(Block0) -- Block1 -- Block 2 -- Block 3 -- Broadcast_Block
> 
> Each block has identical register mapping. You can think of it as 4
> instances of identical HW.

We have similar in other devices (e.g. GICv3 has multiple instances of
the same register block).

If there's nothing between those blocks, using a reg entry sounds
prefectly reasonable. You can list the broadcast block first, then the
others, or use reg-names.

Thanks,
Mark.
