Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 91957C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD95208BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWthb03z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD95208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965471AbeFODYn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 23:24:43 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45828 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964995AbeFODYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 23:24:40 -0400
Received: by mail-ot0-f195.google.com with SMTP id a5-v6so9501608otf.12;
        Thu, 14 Jun 2018 20:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mYP4ToDnNhyYi54JAxCu1E9vs7qKUBBXvYZyvF67970=;
        b=SWthb03zZhcQf08iYM3AFGpWzpqg4qK9srl41O2bbYxn7qbT/9oBh5AffHHy7ebHR0
         p6we3MDe4pmHRKq3EF7PA+dfVSvpmRaR4j5uzVQkmpb6RyP+MNkFw5UDt2sJAms3w8ke
         QsRb5xZBufq4sowCrAQ8LL1OGJjg/bfPXQ2Lgp733zZtjhCcRabnKSH4A/80awvNh3Lp
         rvQtolIiABbLuO8mqITRYWpMEVv7CVidWai0kHvqZCpC1Sxsjj/cdFlk0abfeVsyB4m1
         WgrorQDx+zO0DDx6FjaQVCY8dqb/Sl5lG1Hlb/XSop9CrhTBqUR/hGp7gWtHMZLPUQLI
         TuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mYP4ToDnNhyYi54JAxCu1E9vs7qKUBBXvYZyvF67970=;
        b=NdQKsBgRVTmGwNHQSHvhUdP+g+C0PZGBtBnwo+XmaRDgqtmI8YeMtXdJpcxpTUT+LC
         zJUVUa1U92VGdtGQbga1F0MPYc9i6VuuiaRI+WrHHBV9WWPlLKeE8EXf4mMqRWdsz5s3
         8MGtD3dvNV7+2DJDifCgQoU9bFfgOe028rm8V92F/iCRpVrqxxv8QW28DDz/zsm1JKs2
         V1QHmP8K+fIGOBHHzbUCiYiaGOffQzRP+kA/M1Jjb7ixDcAQAQ38H7dnk124pXl+snrQ
         s2iJYXIiFTkq9gDXUMIxNzdjnn+LbfQrgbwFd9vWi8CZgzuCJmasIZbFhVXc3zH8QLac
         QEGg==
X-Gm-Message-State: APt69E0/pwHG2vdPC4n2OFyQkifQyUJNtyotoH1Pj0YmwItmts5tlYAf
        tpRKQpWSnTMqSWaWMYO8NRRKy1ho
X-Google-Smtp-Source: ADUXVKJGpSVVN87/xKudUfrfvSMJLtsFHaLQmWbqH6/TyEyP1NAyR3ZX6TxVAEJAmw14c85WV1Uqzw==
X-Received: by 2002:a9d:1a51:: with SMTP id u17-v6mr3373169otu.165.1529033079694;
        Thu, 14 Jun 2018 20:24:39 -0700 (PDT)
Received: from [192.168.1.3] (ip68-109-195-31.pv.oc.cox.net. [68.109.195.31])
        by smtp.gmail.com with ESMTPSA id c17-v6sm3013549otl.17.2018.06.14.20.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 20:24:38 -0700 (PDT)
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
To:     Don Bollinger <don@thebollingers.org>, Andrew Lunn <andrew@lunn.ch>
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
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
 <496e06b9-9f02-c4ae-4156-ab6221ba23fd@amd.com>
 <20180612181109.GD12251@lunn.ch>
 <20180615022652.t6oqpnwwvdmbooab@thebollingers.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <ef0baf6d-1d1f-ba5b-708a-d8179bd1ea3b@gmail.com>
Date:   Thu, 14 Jun 2018 20:24:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615022652.t6oqpnwwvdmbooab@thebollingers.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/14/2018 07:26 PM, Don Bollinger wrote:
> On Tue, Jun 12, 2018 at 08:11:09PM +0200, Andrew Lunn wrote:
>>> There's an SFP driver under drivers/net/phy.  Can that driver be extended
>>> to provide this support?  Adding Russel King who developed sfp.c, as well
>>> at the netdev mailing list.
>>
>> I agree, the current SFP code should be used.
>>
>> My observations seem to be there are two different ways {Q}SFP are used:
>>
>> 1) The Linux kernel has full control, as assumed by the devlink/SFP
>> frame work. We parse the SFP data to find the capabilities of the SFP
>> and use it to program the MAC to use the correct mode. The MAC can be
>> a NIC, but it can also be a switch. DSA is gaining support for
>> PHYLINK, so SFP modules should just work with most switches which DSA
>> support.  And there is no reason a plain switchdev switch can not use
>> PHYLINK.
>>
>> 2) Firmware is in control of the PHY layer, but there is a wish to
>> expose some of the data which is available via i2c from the {Q}SFP to
>> linux.
>>
>> It appears this optoe supports this second case. It does not appear to
>> support any in kernel API to actually make use of the SFP data in the
>> kernel.
>>
>> We should not be duplicating code. We should share the SFP code for
>> both use cases above. There is also a Linux standard API for getting
>> access to this information. ethtool -m/--module-info. Anything which
>> is exporting {Q}SFP data needs to use this API.
>>
>>    Andrew
> 
> Actually this is better described by a third use case.  The target
> switches are PHY-less (see various designs at
> www.compute.org/wiki/Networking/SpecsAndDesigns). The AS5712 for example
> says "The AS5712-54X is a PHY-Less design with the SFP+ and QSFP+
> connections directly attaching to the Serdes interfaces of the Broadcom
> BCM56854 720G Trident 2 switching silicon..."
> 
> The electrical controls of the {Q}SFP devices (TxDisable for example)
> are organized in a platform dependent way, through CPLD devices, and
> managed by a platform specific CPLD driver.
> 
> The i2c bus is muxed from the CPU to all of the {Q}SFP devices, which
> are set up as standard linux i2c devices
> (/sys/bus/i2c/devices/i2c-xxxx).
> 
> There is no MDIO bus between the CPU and the {Q}SFP devices.
> 
>> 2) Firmware is in control of the PHY layer, but there is a wish to
>> expose some of the data which is available via i2c from the {Q}SFP to
>> linux.
> 
> So the switch silicon is in control of the PHY layer.  The platform
> driver is in control of the electrical interfaces.  And the EEPROM data
> is available via I2C.
> 
> And, there isn't actually 'a wish to expose' the EEPROM data to linux
> (the kernel).  It turns out that none of the NOS partners I'm working
> with use that data *in the kernel*.  It is all managed from user space.
> 
> More generally, I think sfp.c and optoe are not actually trying to
> accomplish the same thing at all.  sfp.c combines all three functions
> (PHY, electrical control, EEPROM access).  optoe is only providing EEPROM
> access, and only to user space.  This is a real need in the white box
> switch environment, and is not met by sfp.c.  optoe isn't better, sfp.c
> isn't better, they're just different.

sfp exposes standard ethtool hooks such as get_module_info() which pass
the whole data blob to user-space, e.g: ethtool where all of this is
better interpreted.

> 
> Finally, sfp.c does not recognize that SFP devices have data beyond 512
> bytes, accessible via a page register.  It also does not recognize QSFP
> devices at all.  QSFP devices have only 256 bytes accessible (one i2c
> address) before switching to paged access for the remaining data.  The
> first design requirement for optoe was to access all the available
> pages, because there is information and controls that we (optics
> vendors) want to make available to network management applications.

Patches welcome if you wish to extend sfp.c to support QSFP devices for
instances.

> 
> If sfp.c creates a standard linux i2c client for each SFP device, it
> should be possible to create an optoe managed device 'under' sfp.c to
> provide access to the full EEPROM address space:

It's the other way around, SFP relies on a standard Linux i2c bus master
to exist such that it can read the EEPROM from the standard slave
address location, same goes with a possibly present PHY.

>   # echo optoe2 0x50 >/sys/bus/i2c/devices/i2c-xx/new_device
> This might prove useful to user space consumers of that data.  We could
> also easily add a kernel API (eg the nvmem framework) to optoe to provide
> kernel access.  In other words, sfp.c could assign EEPROM management to
> optoe, while managing the electrical interfaces.  (This is actually
> pretty close to how the platfom drivers work in the switch environment.)
> sfp.c would get SFP page support and QSFP EEPROM access 'for free'.

That sounds like a possibly good approach.

> 
>>                       There is also a Linux standard API for getting
>> access to this information. ethtool -m/--module-info. Anything which
>> is exporting {Q}SFP data needs to use this API.
> 
> optoe simply provides direct access from user space to the full EEPROM
> data.  There is more data there than ethtool knows about, and in some
> devices there are proprietary registers that ethtool will never know
> about.  optoe does not interpret any of the EEPROM content (except the
> bare minimum to access pages correctly).  optoe also does not get in the
> way of ethtool.  It could prove to be a handy way for ethtool to access
> new EEPROM fields in the future.  QSFP-DD/OSFP are coming soon, they
> will have a different (incompatible) set of new fields to be decoded.

sfp is the same it only passes the EEPROM information to user-space and
interprets just what it needs to get the work done.

> 
> Bottom Line:  sfp.c is not a useful starting point for the switch
> environment I'm working in.  The underlying hardware architecture is
> quite different.  optoe is not a competing alternative.  Its only
> function is to provide user-space access to the EEPROM data in {Q}SFP
> devices.

I just don't understand why would we want optoe when the standard way to
expose both EEPROM and diagnostics modules has been through ethtool's
get_module_info since the basic paradigm is that a network port is a
net_device instance in the kernel. If that basic device driver model
does not exist, then it is unclear to me what are the benefits.

Would I be completely wrong if I wrote that you are likely working with
a switch SDK which primarily runs in user-space and so with lack of a
proper kernel-based device driver for your piece of hardware you are
attempting to create a driver which is some sort of a "tap" for some
specific portion of that larger hardware block?
-- 
Florian
