Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbeCPUBH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:01:07 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42769 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbeCPUAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:00:45 -0400
X-Google-Smtp-Source: AG47ELuxvLY7Al3WtIEZ0FtAdS9IzlMkQQRXQbayhM7KV/MkZsT0YeOmK3zwd3q+yK/eZE0BaWXlUw==
Date: Fri, 16 Mar 2018 12:55:22 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Message-ID: <20180316195522.GC15968@tuxbook-pro>
References: <20180226175802.20052-1-ilina@codeaurora.org>
 <20180226175802.20052-3-ilina@codeaurora.org>
 <20180305231455.GJ18510@minitux>
 <20180306155703.GA4930@codeaurora.org>
 <20180307190249.GW93895@bjorns-mbp-2.lan>
 <152122480915.70929.13116557401450122973@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152122480915.70929.13116557401450122973@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16 Mar 11:26 PDT 2018, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2018-03-07 11:02:49)
> > On Tue 06 Mar 07:57 PST 2018, Lina Iyer wrote:
> > 
> > > On Mon, Mar 05 2018 at 16:15 -0700, Bjorn Andersson wrote:
> > > > On Mon 26 Feb 09:58 PST 2018, Lina Iyer wrote:
> > 
> > > > As such I think you should just describe only the 0x85fe0000 + 0x20000
> > > > region here and to support the dynamic aspect of this from a system
> > > > point of view you can have the boot loader read the information at
> > > > 0xc3f000c and adjust the reserved memory. (Or just keep the step of
> > > > manually update the dts without caring about the indirection)
> > > > 
> > > It would be incorrect and very board specific to just use the 0x85fe000
> > > as the address. It is not how the SoC defines the location. Upon request
> > > earlier, this memory location was added in DT and the location is
> > > typical reference platform usage only.
> > > 
> > 
> > The problem is that as the db resides in a chunk of memory in the middle
> > of what Linux considers System RAM the DTS must specify this region as
> > reserved. Which means that as you, like described above, update the
> > dictionary something (in your scheme a person) has to update the
> > reserved-memory region as well.
> > 
> > That's why I'm proposing that the appropriate implementation for this
> > is to have the boot loader to the dictionary part of this and Linux only
> > care about the actual reserved-memory region. This way you would still
> > implement the dictionary lookup on a system level, but the Linux
> > part no longer depend on a human updating the DTS to match the values of
> > the dictionary.
> 
> Agreed. I thought SMEM had a similar design of a cookie in IMEM to
> indicate location and size because coordinating changes across all the
> various software images is a hard problem. But coordinating between
> linux and the linux bootloader shouldn't be as hard.
> 

Correct, SMEM has exactly the same mechanism.

I get that the coordinating of these addresses between all involved
images can be a tricky thing, but the only way to make this automatic on
the application CPU is to split this between boot and Linux; as any
all-Linux solution requires a human to update the reserved-memory node
to match the values in the indirection.

So for SMEM we agreed that we implement this as "someone needs to tell
Linux where SMEM is" and that can be a human or the boot loader.

Regards,
Bjorn
