Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E2EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4B3208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PIqlC+y6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4B3208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932960AbeFUKZh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:25:37 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:56073 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932855AbeFUKZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:25:35 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DED351E04F7;
        Thu, 21 Jun 2018 12:25:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529576733; bh=driYhRb60RBLIF08Nuc2CNva+bbOxHE0YpT8Z4zsqHk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=PIqlC+y6ivcGy7jRqitv3hrF33RWBzvAZWrcBWs9ysO0VRdHUfB5l3Pb49zbC510i
         3QYXk00+JuMG75+QRpIjzLeNEbe+HHE2WSd1mdphf32ijsk7kIjoK6X7DO0KEeZOyd
         6Tn59C2N2/oRMTBd5n2Y6q3DbeTF9an3FR+qJWh+n+pVaimnNw6PxMNY+V+tHDDMYg
         cOFZvwX1TS13h80n4YC6hfE2I7Q2Gj6PuPsswZq9Gi+fj4q9SB4b4NmDYE/0jHU3ag
         I2C4MkvCZqE8urO+Ddn6XhAAha/TgmSsr9e2xWEZU/1NkwXQrATGqiCYOV0PCFEgFY
         659pyunU+qYeg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id DD01B5C36;
        Thu, 21 Jun 2018 03:25:31 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 21 Jun 2018 03:25:31 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 21 Jun 2018 12:25:31 +0200
Received: from [10.107.25.102] (10.107.25.102) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 21 Jun 2018 12:25:31 +0200
Subject: Re: [PATCH v5 09/11] pci_endpoint_test: Add 2 ioctl commands
To:     Randy Dunlap <rdunlap@infradead.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
 <8695864db0191b2e85ed81e97a8990baea3468fa.1529507416.git.gustavo.pimentel@synopsys.com>
 <dd75ced1-e4c3-8c94-3bab-200e2ecdd8b8@infradead.org>
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <f16f99f4-0749-3273-7c5a-7c38503c27a9@synopsys.com>
Date:   Thu, 21 Jun 2018 11:23:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <dd75ced1-e4c3-8c94-3bab-200e2ecdd8b8@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.102]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2018 19:12, Randy Dunlap wrote:
> On 06/20/2018 09:28 AM, Gustavo Pimentel wrote:
>> Add MSI-X support and update driver documentation accordingly.
>>
>> Add 2 new IOCTL commands:
>>  - Allow to reconfigure driver IRQ type in runtime.
>>  - Allow to retrieve current driver IRQ type configured.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Change v2->v3:                                                                              |  --------------------------------------------------------------------------------------------
>>  - New patch file created base on the previous patch                                        |  --------------------------------------------------------------------------------------------
>> "misc: pci_endpoint_test: Add MSI-X support" patch file following                           |  --------------------------------------------------------------------------------------------
>> Kishon's suggestion.                                                                        |  --------------------------------------------------------------------------------------------
>> Change v3->v4:                                                                              |  --------------------------------------------------------------------------------------------
>>  - Rebased to Lorenzo's master branch v4.18-rc1.
>> Change v4->v5:
>>  - Nothing changed, just to follow the patch set version.
>>
>>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>>  drivers/misc/pci_endpoint_test.c                 | 177 +++++++++++++++++------
>>  2 files changed, 132 insertions(+), 48 deletions(-)
>>
>> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
>> index fdfa0f6..58ccca4 100644
>> --- a/Documentation/misc-devices/pci-endpoint-test.txt
>> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
>> @@ -28,6 +28,9 @@ ioctl
>>  	      to be tested should be passed as argument.
>>   PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
>>  	      to be tested should be passed as argument.
>> + PCITEST_SET_IRQTYPE: Changes driver IRQ type configuration. The IRQ type
>> +	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
>> + PCITEST_GET_IRQTYPE: Gets driver IRQ type configuration.
>>   PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
>>  		as argument.
>>   PCITEST_READ: Perform read tests. The size of the buffer should be passed
>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>> index 2b58887..82fa0c2 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
> 
> Hi,
> 
> The ioctl "type" (as "type" is used in <uapi/asm-generic/ioctl.h>),
> value of 'P' in this case, should be documented in
> Documentation/ioctl/ioctl-number.txt.

Hi Randy,

I wasn't aware of this file. Adding the entry bellow would be suitable?

'P'    01-09   drivers/misc/pci_endpoint_test.c        conflict!

Regards,
Gustavo

> 
> thanks,
> 

