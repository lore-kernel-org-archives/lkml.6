Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5F6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B47A21B1A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XLRL3f7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405671AbfBNDpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:45:23 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37808 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405596AbfBNDpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:45:23 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1E3iSRF116925;
        Wed, 13 Feb 2019 21:44:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550115868;
        bh=cJA29mcYvc20X7ZBFzfiZecKA5xhoCxNAU8j/OIftuE=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=XLRL3f7lLScXlj4v2BCXuyJ4GvbDbCcSfAA8rTuuYmcupo+Us/3pgAGr57LmYOOWg
         EXg1yFK2Ce6WH5DpuW9ddRUkbQ1u3KCcE1WGpQ06dz6jerUXhwIOS9pqul10nFvMVS
         15JCw5cNQ5/C3IVVvvs6CIMBeUMsU2KbRoKrX6fA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1E3iSS7122084
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 21:44:28 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 21:44:27 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 21:44:26 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1E3iQ1B032665;
        Wed, 13 Feb 2019 21:44:26 -0600
Subject: Re: [PATCH v2 10/14] remoteproc/pru: Add PRU remoteproc driver
From:   Suman Anna <s-anna@ti.com>
To:     Roger Quadros <rogerq@ti.com>, <tony@atomide.com>,
        <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <david@lechnology.com>, <nsekhar@ti.com>, <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>, <m-karicheri2@ti.com>,
        <woods.technical@gmail.com>, <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-11-git-send-email-rogerq@ti.com>
 <acf08e5e-d65f-84cf-5d3f-a8e0977933f4@ti.com>
Message-ID: <448fc985-9822-54b1-c0aa-070d6dcaad1a@ti.com>
Date:   Wed, 13 Feb 2019 21:44:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <acf08e5e-d65f-84cf-5d3f-a8e0977933f4@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 8:35 PM, Suman Anna wrote:
> Hi Roger,
> 
> On 2/4/19 8:22 AM, Roger Quadros wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> The Programmable Real-Time Unit Subsystem (PRUSS) consists of
>> dual 32-bit RISC cores (Programmable Real-Time Units, or PRUs)
>> for program execution. This patch adds a remoteproc platform
>> driver for managing the individual PRU RISC cores life cycle.
>>
>> This remoteproc driver does not have support for error recovery
>> and system suspend/resume features. Different compatibles are
>> used to allow providing scalability for instance-specific device
>> data if needed. The driver uses a default firmware-name retrieved
>> from device-tree, and the firmwares are expected to be present
>> in the standard Linux firmware search paths. They can also be
>> adjusted by userspace if required through the sysfs interface
>> provided by the remoteproc core.
>>
>> The PRU remoteproc driver uses a client-driven boot methodology
>> - it does _not_ support auto-boot so that the PRU load and boot
>> is dictated by the corresponding client drivers for achieving
>> various usecases. This allows flexibility for the client drivers
>> or applications to set a firmware name (if needed) based on their
>> desired functionality and boot the PRU. The sysfs bind and unbind
>> attributes have also been suppressed so that the PRU devices cannot
>> be unbound and thereby shutdown a PRU from underneath a PRU client
>> driver.
>>
>> A new entry 'single_step' is added to the remoteproc debugfs dir.
>> The 'single_step' utilizes the single-step execution of the PRU
>> cores. Writing a non-zero value performs a single step, and a
>> zero value restores the PRU to execute in the same mode as the
>> mode before the first single step. (note: if the PRU is halted
>> because of a halt instruction, then no change occurs).
>>
>> pru_rproc_get() and pru_rproc_put() functions allow client drivers
>> to acquire and release the remoteproc device associated with a PRU core.
>> The PRU cores are treated as resources with only one client owning
>> it at a time.
>>
>> PRU interrupt mapping can be provided via devicetree using
>> ti,pru-interrupt-map property or via the resource table in the
>> firmware blob. If both are provided, the config in DT takes precedence.
>> For interrupt map via resource table, pru-software-support-package [1]
>> has been historically using version 0 for this. However, the current
>> data structure is not scaleable and is not self sufficient.
>> 1) it hard codes number of channel to host mappings so is not
>> scaleable to newer SoCs than have more of these.
>> 2) it does not contain the event to channel mappings within
>> itself but relies on a pointer to point to another section
>> in data memory. This causes a weird complication that the
>> respective data section must be loaded before we can really
>> use the INTC map.
>>
>> With this patch we drop support for version 0 and support
>> version 1 which is a more robust and scalable data structure.
>> It should be able to support a sufficiently large number (255) of
>> sysevents, channels and host interrupts and is self contained
>> so it can be used without dependency on order of loading sections.
> 
> Hmm, looks like you squashed a whole bunch of patches into this. I would
> prefer some of the logical ones to be separated out just like before,
> makes it easier to review the interfaces.
> 
> Looks like you have also changed usage behavior on couple of things and
> dropped some of my original changes. I was not able to test this series
> either on AM335x or on AM57xx to comment more on the behavior (not even
> seeing the pruss devices populated, not sure what pieces are missing still).

Able to get the PRUSS devices show up on AM335x atleast after enabling
the Reset Controller related configs, but no such luck on AM57xx.

regards
Suman

> 
>>
>> [1]  git://git.ti.com/pru-software-support-package/pru-software-support-package.git
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
