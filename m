Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28C6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B172171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dXfTwVc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfA1Tbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:31:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32999 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfA1Tbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:31:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so8198690plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c4sq5QNCH6X83p5VVC8SEGlVPFetVhIWyH3awcb2tbQ=;
        b=dXfTwVc9OO27KTyVD87Z0yZ8nPCi+y0EhnKNbgAmbZT5yaO3dUhVCeQ/gycZ+ana8b
         plprhaeMM+mNP0KLhzYSf3c4IPJ3JfW9BHnMhyFq2ZTfUwYEFmcr9cIa3OIQ7HqgEIkA
         uAzQNyPLRojgVDSlipRp3Jztskt084fO2+Rvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c4sq5QNCH6X83p5VVC8SEGlVPFetVhIWyH3awcb2tbQ=;
        b=K68fQG3W48DNlMh4iMGV96o0IXKbghZeD35J4lpa0j8PaOTFsFxf2I+C+OfViNmHN1
         HDPAfipUKUNRG4+V406J/Gt8C7seoVXatLCwG1FVUHzJFdXOZQcz4uJdxXoAZHh9UcRQ
         tOFsOIiR+HL4IjeJfkMJGueY8ijpIps3WC+62AlpnWmpAdYS2QO76yqqutxOk/R38SEM
         OCc+x+0FrCYFnyp5ntBtsKCPLZpY6PvfM+2NatKLiQZ5twKNQt0rFCH6aim57VV03pq3
         Sqcz8icb3jMO5abqJdIGmzQCYuKZg09G5Kgia07GuV6robmw3wbf22Q9sESdy7bqRAwx
         hoTQ==
X-Gm-Message-State: AJcUukfwY5A9vPUKXBEiUUt/GGFvYV5nDMGTZGTQGp+YpShVQHYElWLB
        a58ho2FY4a9/7XYisDe41VchLg==
X-Google-Smtp-Source: ALg8bN60vUlnR5KheML4KFtRDNESKi8Gq3t8C3ZZui5R3UiAQb8S4CNvAh3NFU2deIKAIL6FiLz6bg==
X-Received: by 2002:a17:902:bc81:: with SMTP id bb1mr22538826plb.223.1548703901410;
        Mon, 28 Jan 2019 11:31:41 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c4sm67597103pfm.151.2019.01.28.11.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 11:31:40 -0800 (PST)
Subject: Re: [PATCH v3 0/8] Add IPROC I2C slave mode and NIC I2C support
From:   Ray Jui <ray.jui@broadcom.com>
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        rjui@broadcom.com, Wolfram Sang <wsa@the-dreams.de>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        shreesha.rajashekar@broadcom.com, sbranden@broadcom.com,
        wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ccheng@broadcom.com,
        heikki.krogerus@linux.intel.com, geert@linux-m68k.org,
        arnd@arndb.de, manivannan.sadhasivam@linaro.org, ajayg@nvidia.com,
        ard.biesheuvel@linaro.org, eajames@linux.vnet.ibm.com,
        kramasub@codeaurora.org, vigneshr@ti.com,
        mika.westerberg@linux.intel.com, pierre-yves.mordret@st.com,
        f.fainelli@gmail.com, aaron.wu@analog.com, jdelvare@suse.de,
        andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        rayagonoda.kokatanur@braodcom.com
References: <1547791464-3540-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <e658ce66-98e3-3ca6-5786-56bfea6d176e@broadcom.com>
Message-ID: <746cf074-69e0-7bd1-034e-c8d3156b5506@broadcom.com>
Date:   Mon, 28 Jan 2019 11:31:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e658ce66-98e3-3ca6-5786-56bfea6d176e@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Just want to check if you had a chance to review the following patch series?

Thanks,

Ray

On 1/20/2019 1:49 PM, Ray Jui wrote:
> Hi Rayagonda/Wolfram,
> 
> I reviewed the entire patch series and added my Reviewed-by tag on 1/8
> and 2/8. The rest of the patches in this series already had my
> Signed-off-by tag.
> 
> Thanks,
> 
> Ray
> 
> On 1/17/2019 10:04 PM, Rayagonda Kokatanur wrote:
>> Hi,
>> This patchset contains support for IPROC I2C slave and NIC I2C support.
>> Following are the brief changes done inorder to support both IPROC I2C
>> slave mode and NIC I2C,
>>
>> a. Add support to allow I2C rx transfer upto 255 bytes
>> b. Add polling mode support to the iProc I2C driver. Polling mode is used
>>    in certain SoCs where interrupt is not connected from the I2C block.
>> c. Add warpper read/write access for register to support indirect register
>>    access. This is required in certain SoCs with this iProc I2C
>>    block registered.
>> d. Remove the set RESET bit to LOW right after setting it to HIGH so that
>>    wait duration can be met.
>>
>> This patch series is based on kernel v5.0.0-rc2.
>>
>> Changes from v2:
>>  - Address Ray's review comments.
>>
>> Changes from v1:
>>  - Rebased to Linux v5.0.0-rc2
>>
>> Ray Jui (1):
>>   dt-bindings: i2c: iproc: make 'interrupts' optional
>>
>> Rayagonda Kokatanur (5):
>>   i2c: iproc: add polling support
>>   i2c: iproc: use wrapper for read/write access
>>   dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
>>   i2c: iproc: add NIC I2C support
>>   arm64: dts: Stingray: Add NIC i2c device node
>>
>> Shreesha Rajashekar (2):
>>   i2c: iproc: I2C read up to 255 bytes support
>>   i2c: iproc: Add Slave mode support
>>
>>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |  14 +-
>>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  18 +
>>  drivers/i2c/busses/Kconfig                         |   1 +
>>  drivers/i2c/busses/i2c-bcm-iproc.c                 | 757 +++++++++++++++++----
>>  4 files changed, 659 insertions(+), 131 deletions(-)
>>
