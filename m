Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeFBR5Y (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 13:57:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33848 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbeFBR5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 13:57:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 02 Jun 2018 13:57:19 -0400
From: okaya@codeaurora.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Add pci=safemode option
In-Reply-To: <20180602174307.GB14870@amd>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
 <20180530043103.GA19734@kroah.com>
 <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
 <20180602174307.GB14870@amd>
Message-ID: <f3d6c44829910cb09c6f72dba1c41b39@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-02 13:43, Pavel Machek wrote:
> Hi!
> 
>> > And you should explain what exactly in PCI is "optional".  Who defines
>> > this and where is that list and what can go wrong if those options are
>> > not enabled?
>> 
>> Bjorn and I discussed the need for such a "safe" mode feature when you
>> want to bring up PCI for a platform. You want to turn off everything 
>> as
>> a starter and just stick to bare minimum.
>> 
>> I can add a few words describing them. The goal of this option is to 
>> keep
>> base PCI features with MSI only. Things like PME, AER, ASPM, Extended
>> Tags, LTR, Relaxed Ordering, SRIOV are all considered optional. 
>> safemode
>> is certainly not intended for production environments.
>> 
>> I can taint the kernel as a suggestion.
> 
> I don't think tainting is required. even modern platforms should work
> in the safe mode.

Yeah, concern was getting used to the safe mode and never running the 
full stack to fix the actual issues like getting away with crappy 
hardware and firmware.

It becomes a support issue for the community.


> 									Pavel
