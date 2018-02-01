Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeBAIqK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:46:10 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:56841 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeBAIqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:46:09 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w118jl2u026599, This message is accepted by code: ctaloc0852
From: =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, Dave Jiang <dave.jiang@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBbUEFUQ0ggdjZdIG1m?= =?utf-8?Q?d:_Add_support_for_RTS5250S_power_saving?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENIIHY2XSBtZmQ6IEFkZCBz?=
 =?utf-8?Q?upport_for_RTS5250S_power_saving?=
Thread-Index: AQHTJ7MIjrIjfd7bG0634WfM0/yRkaNDf1uAgADNe5CAAEy0AIAGWBUwgA0QSACAINU9gIACyTfggBGIWICAAvnMQA==
Date: Thu, 1 Feb 2018 08:45:47 +0000
Message-ID: <2A308283684ECD4B896628E09AF5361E01A8ACA4@RS-MBS01.realsil.com.cn>
References: <1504772799-15173-1-git-send-email-rui_feng@realsil.com.cn>
 <20171214222522.GL30595@bhelgaas-glaptop.roam.corp.google.com>
 <2A308283684ECD4B896628E09AF5361E01A8150B@RS-MBS01.realsil.com.cn>
 <20171215151522.GT30595@bhelgaas-glaptop.roam.corp.google.com>
 <2A308283684ECD4B896628E09AF5361E01A8193C@RS-MBS01.realsil.com.cn>
 <20171227233750.GB79892@bhelgaas-glaptop.roam.corp.google.com>
 <20180117210121.GD7039@bhelgaas-glaptop.roam.corp.google.com>
 <2A308283684ECD4B896628E09AF5361E01A8A102@RS-MBS01.realsil.com.cn>
 <20180130191827.GI232763@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180130191827.GI232763@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.29.40.150]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w118kEDc030215

> 
> On Fri, Jan 19, 2018 at 07:38:22AM +0000, 冯锐 wrote:
> > > On Wed, Dec 27, 2017 at 05:37:50PM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Dec 19, 2017 at 08:15:24AM +0000, 冯锐 wrote:
> > > > > > On Fri, Dec 15, 2017 at 09:42:45AM +0000, 冯锐 wrote:
> > > > > > > > [+cc Hans, Dave, linux-pci]
> > > > > > > >
> > > > > > > > On Thu, Sep 07, 2017 at 04:26:39PM +0800,
> > > > > > > > rui_feng@realsil.com.cn
> > > > > > wrote:
> > > > > > > > > From: Rui Feng <rui_feng@realsil.com.cn>
> > > > > > > >
> > > > > > > > I wish this had been posted to linux-pci before being merged.
> > > > > > > >
> > > > > > > > I'm concerned because some of this appears to overlap and
> > > > > > > > conflict with PCI core management of ASPM.
> > > > > > > >
> > > > > > > > I assume these devices advertise ASPM support in their
> > > > > > > > Link Capabilites registers, right?  If so, why isn't the
> > > > > > > > existing PCI core ASPM support sufficient?
> > > > > > > >
> > > > > > > When L1SS is configured, the device(hardware) can't enter
> > > > > > > L1SS status automatically, it need driver(software) to do
> > > > > > > some work to achieve the
> > > > > > function.
> > > > > >
> > > > > > So this is a hardware defect in the device?  As far as I know,
> > > > > > ASPM and L1SS are specified such that they should work without
> > > > > > special
> > > driver support.
> > > > > >
> > > > > Yes, you can say that.
> > > > >
> > > > > > > > > Enable power saving for RTS5250S as following steps:
> > > > > > > > > 1.Set 0xFE58 to enable clock power management.
> > > > > > > >
> > > > > > > > Is this clock power management something specific to
> > > > > > > > RTS5250S, or is it standard PCIe architected stuff?
> > > > > > > >
> > > > > > > 0xFE58 is specific register to RTS5250S not standard PCIe
> > > > > > > architected
> > > stuff.
> > > > > >
> > > > > > OK.  I asked because devices often mirror architected PCIe
> > > > > > config things in device-specific MMIO space, and if I squint
> > > > > > just right, I can sort of match up the register bits you used
> > > > > > with things in the PCIe
> > > spec.
> > > > > >
> > > > > > > > > 2.Check cfg space whether support L1SS or not.
> > > > > > > >
> > > > > > > > This sounds like standard PCIe ASPM L1 Substates, right?
> > > > > > > >
> > > > > > > Yes.
> > > > > > >
> > > > > > > > > 3.If support L1SS, set 0xFF03 to free clkreq.
> > > > > > > > > 4.When entering idle status, enable aspm
> > > > > > > > >   and set parameters for L1SS and LTR.
> > > > > > > > > 5.Wnen entering run status, disable aspm
> > > > > > > > >   and set parameters for L1SS and LTR.
> > > > > > > >
> > > > > > > > In general, drivers should not configure ASPM, L1SS, and
> > > > > > > > LTR themselves; the PCI core should do that.
> > > > > > > >
> > > > > > > > If a driver needs to tweak ASPM at run-time, it should use
> > > > > > > > interfaces exported by the PCI core to do so.
> > > > > > > >
> > > > > > > Which interface I can use to set ASPM? I use
> "pci_write_config_byte"
> > > now.
> > > > > >
> > > > > > What do you need to do?  include/linux/pci-aspm.h exports
> > > > > > pci_disable_link_state(), which is mainly used to avoid ASPM
> > > > > > states that have hardware errata.
> > > > > >
> > > > > I want to enable ASPM(L0 -> L1) and disable ASPM(L1 -> L0),
> > > > > which interface can I use?
> > > >
> > > > You can use pci_disable_link_state() to disable usage of L1.
> > > >
> > > > Currently there is no corresponding pci_enable_link_state().  What
> > > > if we added something like the following (untested)?  Would that
> > > > work for you?
> > >
> > > Hi Rui,
> > >
> > > Any thoughts on the patch below?
> >
> > I'm busy with other work, the patch seems ok, I will test it later.
> 
> Any idea when you might get back to this?
> 
> If you can't do it, I can try doing it myself, but of course, I don't know the details
> about the device errata and I wouldn't be able to test it.
> 
Of course, you can do it first.

> Bjorn
> 
> ------Please consider the environment before printing this e-mail.
