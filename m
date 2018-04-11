Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbeDKPYC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:24:02 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42480 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbeDKPYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:24:00 -0400
X-Google-Smtp-Source: AIpwx49qyciH3DHvvGdjpCaVPz5aRs0QNliF7KTd98mOX43ZC5OqDAdWkqG9udp9cfU2s+v1ga/VHA==
Subject: Re: [PATCHv2] mtd: spi-nor: Fix Cadence QSPI page fault kernel panic
To: thor.thayer@linux.intel.com, cyrille.pitchen@wedev4u.fr,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, richard@nod.at
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1522073537-27386-1-git-send-email-thor.thayer@linux.intel.com>
 <0b460613-4ac2-c4d8-429e-248a4742a408@linux.intel.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <c009725f-dbbc-d4b1-4f67-6cae7cdf6f05@gmail.com>
Date: Wed, 11 Apr 2018 17:23:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0b460613-4ac2-c4d8-429e-248a4742a408@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2018 05:17 PM, Thor Thayer wrote:
> Hi. Any comments on this patch?

None other than

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

sorry for the delay.

btw stop top-posting please.

> On 03/26/2018 09:12 AM, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> The current Cadence QSPI driver caused a kernel panic when loading
>> a Root Filesystem from QSPI. The problem was caused by reading more
>> bytes than needed because the QSPI operated on 4 bytes at a time.
>> <snip>
>> [    7.947754] spi_nor_read[1048]:from 0x037cad74, len 1 [bfe07fff]
>> [    7.956247] cqspi_read[910]:offset 0x58502516, buffer=bfe07fff
>> [    7.956247]
>> [    7.966046] Unable to handle kernel paging request at virtual
>> address bfe08002
>> [    7.973239] pgd = eebfc000
>> [    7.975931] [bfe08002] *pgd=2fffb811, *pte=00000000, *ppte=00000000
>> </snip>
>> Notice above how only 1 byte needed to be read but by reading 4 bytes
>> into the end of a mapped page, an unrecoverable page fault occurred.
>>
>> This patch uses a temporary buffer to hold the 4 bytes read and then
>> copies only the bytes required into the buffer. A min() function is
>> used to limit the length to prevent buffer overflows.
>>
>> Request testing of this patch on other platforms. This was tested
>> on the Intel Arria10 SoCFPGA DevKit.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>

[...]


-- 
Best regards,
Marek Vasut
