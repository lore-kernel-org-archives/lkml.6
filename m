Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33691C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C3F214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHJ4JkJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C3F214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbeHBOhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:37:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40971 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732130AbeHBOhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:37:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so1131636pgu.8;
        Thu, 02 Aug 2018 05:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wNife3HM+j4+7Svk4nK0pDwzdWpwW/h3E6Ppt9T7ANw=;
        b=oHJ4JkJh5B7qG4HyZO4HPW5+RJIOGkvFJRIbSbiDzVJrNtIrBYI6zTDc/vZKPJDPQF
         Xn10boJjAnozd4ZQuJ06p7tX9PLdPTk+HfuprX7L/AmidPpkI9PBEMs6gnO68Pgb30fb
         0s5orxAVYYNkD9XuApMrkwF8VdyYw2vrr6+fRDNT/sTv0VDFpX7eJDAWmaXoNM45W99V
         Fi1Xsu8zEPvZjQWfOghQ33YN6kJjK1OiWXZetg5A5MhTs2V2uWHBQ/LYeOCFtG3g6y3n
         xZ8wKxqa3GPEKVU5sSwGtdIj378z+DThu9Fml02g0lSs0aUpcpQZYAb7EqvqmfRKsDmk
         u++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wNife3HM+j4+7Svk4nK0pDwzdWpwW/h3E6Ppt9T7ANw=;
        b=uQpBN6xC4bi2p0Ci1tPL55wFGzMALFKGuWAqncxCfoAxpXH5PWKrl1TQH5npl66X4p
         t/OCqF/7YgILASlqL3GN317e4GQKDh0w9C39Tbjo718RhP/YbkPoDM0h4a9iPrYC4bZn
         u7fF5LD1XCm7oACglQdjQkA1tJkJ/KgG1XX0pWJRCUC7xUWlm57xlO3bD3+UgJOYk3me
         ACB+OXs20C3zwdnvrchk8eGLjGhvlaRo6Tj0XlT74MACnELJaeJnk3igt0ydyfC++r9I
         B5gocg6HD37ekyCICWDYhpnN7fztFfqJxlX6VRa0Vz5NGXxqqT2a6Jg3GXxxKV4t7HiX
         E42g==
X-Gm-Message-State: AOUpUlE4H6Y0f/xJOCrrtz4KLP44tPl1FX5XnSTlAQO1X//DoCJNC8Be
        /ctpaXS1P73WKoHwDAt/Jh7kYMRg
X-Google-Smtp-Source: AAOMgpd7jwFGqLJrYlvOUNp7lQosW0I5Xc7REPlNYdg/6CpW3dtTvCYMbMM5Sx512Aq7eJ9DPiEgvg==
X-Received: by 2002:a63:9741:: with SMTP id d1-v6mr2578335pgo.403.1533213982631;
        Thu, 02 Aug 2018 05:46:22 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u17-v6sm5611941pfa.176.2018.08.02.05.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 05:46:21 -0700 (PDT)
Subject: Re: linux-next: Tree for Aug 1
To:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>
Cc:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
References: <20180801175852.36549130@canb.auug.org.au>
 <20180801224813.GA13074@roeck-us.net>
 <1533163965.3158.1.camel@HansenPartnership.com>
 <20180801234727.GA3762@roeck-us.net>
 <CACVXFVMrzLRP5Q=cwZGnqeUeyODL3Pq9jMkT7czZouK9510fUA@mail.gmail.com>
 <1533168205.3158.12.camel@HansenPartnership.com>
 <171b2cdc-2e74-2b3c-e5f5-c656a196601a@roeck-us.net>
 <e3e32fd801cb1270cddec6fc1ea3dabad4473b64.camel@wdc.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <93cbb876-3a25-482a-a5b4-6e13d42ee535@roeck-us.net>
Date:   Thu, 2 Aug 2018 05:46:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e3e32fd801cb1270cddec6fc1ea3dabad4473b64.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 10:04 PM, Bart Van Assche wrote:
> On Wed, 2018-08-01 at 21:58 -0700, Guenter Roeck wrote:
>> I am running out of ideas. Any thoughts on how to track this down further ?
> 
> Is a shell available when the hang occurs? If so, it would be helpful if you
> could provide a dump of the information in /sys/kernel/debug/block. There is
> namely detailed information in that directory about pending commands.
> 

No, it hangs hard early in the boot process. See various logs at
http://kerneltests.org/builders/, in the 'next' column.

Here is some interesting information from the x86_64 boot tests.

Building x86_64:q35:Broadwell-noTSX:defconfig:smp:sata:rootfs ... running .................................. failed (timeout)
Building x86_64:q35:IvyBridge:defconfig:smp:nvme:rootfs ... running .................................. failed (timeout)
Building x86_64:q35:SandyBridge:defconfig:smp:usb:rootfs ... running .................................. failed (timeout)
Building x86_64:q35:Haswell:defconfig:smp:usb-uas:rootfs ... running ...... passed
Building x86_64:q35:Skylake-Client:defconfig:smp:mmc:rootfs ... running .................................. failed (timeout)
Building x86_64:q35:Conroe:defconfig:smp:scsi[DC395]:rootfs ... running ........ passed
Building x86_64:q35:Nehalem:defconfig:smp:scsi[AM53C974]:rootfs ... running ...... passed
Building x86_64:q35:Westmere-IBRS:defconfig:smp:scsi[53C810]:rootfs ... running ....... passed
Building x86_64:q35:Skylake-Server:defconfig:smp:scsi[53C895A]:rootfs ... running ....... passed
Building x86_64:pc:EPYC:defconfig:smp:scsi[MEGASAS]:rootfs ... running ...... passed
Building x86_64:q35:EPYC-IBPB:defconfig:smp:scsi[MEGASAS2]:rootfs ... running ....... passed
Building x86_64:q35:Opteron_G5:defconfig:smp:scsi[FUSION]:rootfs ... running ....... passed
Building x86_64:pc:phenom:defconfig:smp:initrd ... running .................................. failed (timeout)
Building x86_64:q35:Opteron_G1:defconfig:smp:initrd ... running .................................. failed (timeout)
Building x86_64:pc:Opteron_G2:defconfig:smp:sata:rootfs ... running .................................. failed (timeout)
Building x86_64:q35:core2duo:defconfig:smp:usb:rootfs ... running .................................. failed (timeout)
Building x86_64:pc:Opteron_G3:defconfig:nosmp:usb:rootfs ... running .................................. failed (timeout)
Building x86_64:q35:Opteron_G4:defconfig:nosmp:sata:rootfs ... running .................................. failed (timeout)

This is consistent across multiple test runs. In summary,

- Boot from initrd fails
- Boot from SATA drive fails (this is with CONFIG_ATA)
- Boot from NVME fails
- Boot from USB drive fails
- Boot from MMC (SD) fails
- Boot from USB UAS drive passes
- Boot from various real SCSI drives passes

Platform (pc,q35), CPU type, or SMP/NOSMP does not seem to make a difference.

Guenter
