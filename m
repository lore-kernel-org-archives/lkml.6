Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 14190C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7FD208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7FD208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thebollingers.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936178AbeFOC1B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:27:01 -0400
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:54154 "EHLO
        resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936121AbeFOC07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:26:59 -0400
Received: from resomta-po-08v.sys.comcast.net ([96.114.154.232])
        by resqmta-po-08v.sys.comcast.net with ESMTP
        id TdnBfYAeouPXCTeS2fm3LG; Fri, 15 Jun 2018 02:26:58 +0000
Received: from thebollingers.org ([73.223.250.230])
        by resomta-po-08v.sys.comcast.net with ESMTPA
        id TeRyfGJXVAsWhTeRzfNLS6; Fri, 15 Jun 2018 02:26:58 +0000
Date:   Thu, 14 Jun 2018 19:26:52 -0700
From:   Don Bollinger <don@thebollingers.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, brandon_chuang@edge-core.com,
        wally_wang@accton.com, roy_lee@edge-core.com,
        rick_burchett@edge-core.com, quentin.chang@quantatw.com,
        steven.noble@bigswitch.com, jeffrey.townsend@bigswitch.com,
        scotte@cumulusnetworks.com, roopa@cumulusnetworks.com,
        David Ahern <dsa@cumulusnetworks.com>,
        luke.williams@canonical.com, Guohan Lu <gulv@microsoft.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
Message-ID: <20180615022652.t6oqpnwwvdmbooab@thebollingers.org>
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
 <496e06b9-9f02-c4ae-4156-ab6221ba23fd@amd.com>
 <20180612181109.GD12251@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612181109.GD12251@lunn.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfK3cHkWeA3/ZrJfgGabq1vg1Y5KQPXMzTBwSM6h8CPjweRJmioGQ51D/Nsz5i+TPssqkScy9llPdvEr6uEFpqupsFKLZ+RjP/ddR96yOs2C7vwL1Y5pb
 VeVn2+zYYaE3OVtbh/l2RMHv55kxG9K6WHdFMiKgYKj6g9gZCRXLuLaHqSnleAwTbeA0lyLQuSEu5j7bCwpiNfsRsWgIrZeNtZy9NevnNHgDMfDjt/JS5Mxy
 bIv+1zsqGpkyBPkuSUvtf+NTKiVTrNXt/j8hgddIvmjR2X0KjGmu7su3jZoPC2OPtDYLn7i04mJdmeFGSuyKdvKWtT5HkguxPOmt9p+ySKeQmLddAYbieuv3
 zDDhH3KqrHMB3eRtH50naI0EWSVzQ9TJjMd1oDsAIhJO0C1DJoSsCa3RgGa4DVVw+5HCu4XmNtKmjb62bz/oJxF8MWDvIdgCZgvXoOlWktQvFBXLcLuwTYuL
 oaoC/N31QZxaKRoiCvTDxIFORGrdp00sxL5E0gF+179jthwDrqAo4vv875t5Ts8uBFZLTHQrUO/ICFAq0zQUWEsW4jcMLX3iKxt8lxwF0SpIyW7n78Hy4E0G
 YNQ9DBieCXVP5tgMPCHPH/Vh5V60Kbp2I0Ox/vvdcSdJWrxAPECBq/5VH/7Y0gjf2k13SD/S/Q+PHGWhBi5jVb8C4TcuLfoWk8acKnBpt8ofuvY7W6ZUchJm
 zlGvWMHLPfTWMQFuCMVs+Hxu6HY3eRWuXswizm0T+f/EF0omgC+xhnbACe9XJ/GKY1UuXDn9fwwC+eFWazaoqWWVNjht5POAcLndutECnqfs7gQWyEMuttmj
 Qh5QI/DgEMOWvv1g7QE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 08:11:09PM +0200, Andrew Lunn wrote:
> > There's an SFP driver under drivers/net/phy.  Can that driver be extended
> > to provide this support?  Adding Russel King who developed sfp.c, as well
> > at the netdev mailing list.
> 
> I agree, the current SFP code should be used.
> 
> My observations seem to be there are two different ways {Q}SFP are used:
> 
> 1) The Linux kernel has full control, as assumed by the devlink/SFP
> frame work. We parse the SFP data to find the capabilities of the SFP
> and use it to program the MAC to use the correct mode. The MAC can be
> a NIC, but it can also be a switch. DSA is gaining support for
> PHYLINK, so SFP modules should just work with most switches which DSA
> support.  And there is no reason a plain switchdev switch can not use
> PHYLINK.
> 
> 2) Firmware is in control of the PHY layer, but there is a wish to
> expose some of the data which is available via i2c from the {Q}SFP to
> linux.
> 
> It appears this optoe supports this second case. It does not appear to
> support any in kernel API to actually make use of the SFP data in the
> kernel.
> 
> We should not be duplicating code. We should share the SFP code for
> both use cases above. There is also a Linux standard API for getting
> access to this information. ethtool -m/--module-info. Anything which
> is exporting {Q}SFP data needs to use this API.
> 
>    Andrew

Actually this is better described by a third use case.  The target
switches are PHY-less (see various designs at
www.compute.org/wiki/Networking/SpecsAndDesigns). The AS5712 for example
says "The AS5712-54X is a PHY-Less design with the SFP+ and QSFP+
connections directly attaching to the Serdes interfaces of the Broadcom
BCM56854 720G Trident 2 switching silicon..."

The electrical controls of the {Q}SFP devices (TxDisable for example)
are organized in a platform dependent way, through CPLD devices, and
managed by a platform specific CPLD driver.

The i2c bus is muxed from the CPU to all of the {Q}SFP devices, which
are set up as standard linux i2c devices
(/sys/bus/i2c/devices/i2c-xxxx).

There is no MDIO bus between the CPU and the {Q}SFP devices.

> 2) Firmware is in control of the PHY layer, but there is a wish to
> expose some of the data which is available via i2c from the {Q}SFP to
> linux.

So the switch silicon is in control of the PHY layer.  The platform
driver is in control of the electrical interfaces.  And the EEPROM data
is available via I2C.

And, there isn't actually 'a wish to expose' the EEPROM data to linux
(the kernel).  It turns out that none of the NOS partners I'm working
with use that data *in the kernel*.  It is all managed from user space.

More generally, I think sfp.c and optoe are not actually trying to
accomplish the same thing at all.  sfp.c combines all three functions
(PHY, electrical control, EEPROM access).  optoe is only providing EEPROM
access, and only to user space.  This is a real need in the white box
switch environment, and is not met by sfp.c.  optoe isn't better, sfp.c
isn't better, they're just different.

Finally, sfp.c does not recognize that SFP devices have data beyond 512
bytes, accessible via a page register.  It also does not recognize QSFP
devices at all.  QSFP devices have only 256 bytes accessible (one i2c
address) before switching to paged access for the remaining data.  The
first design requirement for optoe was to access all the available
pages, because there is information and controls that we (optics
vendors) want to make available to network management applications.

If sfp.c creates a standard linux i2c client for each SFP device, it
should be possible to create an optoe managed device 'under' sfp.c to
provide access to the full EEPROM address space:
  # echo optoe2 0x50 >/sys/bus/i2c/devices/i2c-xx/new_device
This might prove useful to user space consumers of that data.  We could
also easily add a kernel API (eg the nvmem framework) to optoe to provide
kernel access.  In other words, sfp.c could assign EEPROM management to
optoe, while managing the electrical interfaces.  (This is actually
pretty close to how the platfom drivers work in the switch environment.)
sfp.c would get SFP page support and QSFP EEPROM access 'for free'.

>                       There is also a Linux standard API for getting
> access to this information. ethtool -m/--module-info. Anything which
> is exporting {Q}SFP data needs to use this API.

optoe simply provides direct access from user space to the full EEPROM
data.  There is more data there than ethtool knows about, and in some
devices there are proprietary registers that ethtool will never know
about.  optoe does not interpret any of the EEPROM content (except the
bare minimum to access pages correctly).  optoe also does not get in the
way of ethtool.  It could prove to be a handy way for ethtool to access
new EEPROM fields in the future.  QSFP-DD/OSFP are coming soon, they
will have a different (incompatible) set of new fields to be decoded.

Bottom Line:  sfp.c is not a useful starting point for the switch
environment I'm working in.  The underlying hardware architecture is
quite different.  optoe is not a competing alternative.  Its only
function is to provide user-space access to the EEPROM data in {Q}SFP
devices.

Don
