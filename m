Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63191C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3250D20578
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbfAKLnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:43:35 -0500
Received: from foss.arm.com ([217.140.101.70]:53790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbfAKLne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:43:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4000880D;
        Fri, 11 Jan 2019 03:43:34 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2968F3F70D;
        Fri, 11 Jan 2019 03:43:33 -0800 (PST)
Subject: Re: [RESEND PATCH v3 1/2] drivers: amba: Updates to component
 identification for driver matching.
To:     mike.leach@linaro.org, linux@armlinux.org.uk
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181218215944.2444-1-mike.leach@linaro.org>
 <20181218215944.2444-2-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b492ca38-0bc9-ae7e-486a-e56023e369c7@arm.com>
Date:   Fri, 11 Jan 2019 11:43:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218215944.2444-2-mike.leach@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 18/12/2018 21:59, Mike Leach wrote:
> The CoreSight specification (ARM IHI 0029E), updates the ID register
> requirements for components on an AMBA bus, to cover both traditional
> ARM Primecell type devices, and newer CoreSight and other components.
> 
> The Peripheral ID (PID) / Component ID (CID) pair is extended in certain
> cases to uniquely identify components. CoreSight components related to
> a single function can share Peripheral ID values, and must be further
> identified using a Unique Component Identifier (UCI). e.g. the ETM, CTI,
> PMU and Debug hardware of the A35 all share the same PID.
> 
> Bits 15:12 of the CID are defined to be the device class.
> Class 0xF remains for PrimeCell and legacy components.
> Class 0x9 defines the component as CoreSight (CORESIGHT_CID above)
> Class 0x0, 0x1, 0xB, 0xE define components that do not have driver support
> at present.
> Class 0x2-0x8,0xA and 0xD-0xD are presently reserved.
> 
> The specification futher defines which classes of device use the standard
> CID/PID pair, and when additional ID registers are required.
> 
> The patches provide an update of amba_device and matching code to handle
> the additional registers required for the Class 0x9 (CoreSight) UCI.
> The *data pointer in the amba_id is used by the driver to provide extended
> ID register values for matching.
> 
> CoreSight components where PID/CID pair is currently sufficient for
> unique identification need not provide this additional information.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Looks like you missed my Reviewed tags on the previous version. Anyways,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

