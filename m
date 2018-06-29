Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B9EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F53124F23
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NdA7pbAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F53124F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936634AbeF2OBV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:01:21 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55840 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932529AbeF2OBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:01:20 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5TE0E2Z060597;
        Fri, 29 Jun 2018 09:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530280814;
        bh=ECJ0d8jC+eo2FyA5TgCFykCzOSx/Xq+fFPmT3wy+DEY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NdA7pbAO8jvnc7k0ocSjEAZw/gU5xX+ETBSRivxYSVYtjLpk71JyhAAJIFQtTxiiB
         FEeSVFVMqHwkr5mNVXVNVNZRY3K4efL6mA+F8AsTlbgC63hVZA1kcl0docO3Rgz8Vd
         FgQDg0XUtmQuKmfd72GjfUJ3QwcefwlrenepPoNs=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5TE0Exk022577;
        Fri, 29 Jun 2018 09:00:14 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 29
 Jun 2018 09:00:14 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 29 Jun 2018 09:00:14 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5TE0B00011365;
        Fri, 29 Jun 2018 09:00:12 -0500
Subject: Re: [PATCH 2/2] ARM: davinci_all_defconfig: Enable Bluetooth
To:     David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Kevin Hilman <khilman@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180531202549.11255-1-david@lechnology.com>
 <20180531202549.11255-3-david@lechnology.com>
 <5d45fabc-cc25-fbdf-859c-c29111b42eb2@ti.com>
 <0525829c-3070-6aee-39cf-1154dcbb1e75@lechnology.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <b4c41d75-d253-c92e-8d3e-d9b83f0337f9@ti.com>
Date:   Fri, 29 Jun 2018 19:30:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0525829c-3070-6aee-39cf-1154dcbb1e75@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 June 2018 10:43 PM, David Lechner wrote:
> On 06/27/2018 06:11 AM, Sekhar Nori wrote:
>> On Friday 01 June 2018 01:55 AM, David Lechner wrote:
>>> This enables Bluetooth modules in davinic_all_defconfig needed for LEGO
>>
>> davinci_all_defconfig
>>
>>> MINDSTORMS EV3.
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>> ---
>>>   arch/arm/configs/davinci_all_defconfig | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>
>>> +CONFIG_SERIAL_DEV_BUS=y
>>
>> Any reason to build this into the kernel?
>>
> 
> Yes:
> 
> 
> config SERIAL_DEV_CTRL_TTYPORT
>     bool "Serial device TTY port controller"
>     help
>       Say Y here if you want to use the Serial device bus with common TTY
>       drivers (e.g. serial drivers).
> 
>       If unsure, say Y.
>     depends on TTY
>     depends on SERIAL_DEV_BUS != m

Patch applied to v4.19/defconfig. I added a note about this to commit
text in case I wonder again at a later time.

Thanks,
Sekhar
