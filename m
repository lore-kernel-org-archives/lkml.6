Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBF1C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E451E2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfAXDNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:13:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbfAXDNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:13:25 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 96D199E39B34B9A1959B;
        Thu, 24 Jan 2019 11:13:21 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 24 Jan 2019
 11:13:19 +0800
Subject: Re: [PATCH -next] usb: host: drop pointless static qualifier
To:     Alan Stern <stern@rowland.harvard.edu>
References: <Pine.LNX.4.44L0.1901231107030.1564-100000@iolanthe.rowland.org>
CC:     <geoff@infradead.org>, <gregkh@linuxfoundation.org>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-usb@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <d7fca6e4-2bfb-3c0c-97cc-2c1abcf117cf@huawei.com>
Date:   Thu, 24 Jan 2019 11:13:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1901231107030.1564-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/24 0:09, Alan Stern wrote:
> On Wed, 23 Jan 2019, YueHaibing wrote:
> 
>> There is no need to have the 'dummy_mask' variable static since new
>> value always be assigned before use it.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/usb/host/ehci-ps3.c | 2 +-
>>  drivers/usb/host/ohci-ps3.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-ps3.c b/drivers/usb/host/ehci-ps3.c
>> index 454d8c6..91cee02 100644
>> --- a/drivers/usb/host/ehci-ps3.c
>> +++ b/drivers/usb/host/ehci-ps3.c
>> @@ -86,7 +86,7 @@ static int ps3_ehci_probe(struct ps3_system_bus_device *dev)
>>  	int result;
>>  	struct usb_hcd *hcd;
>>  	unsigned int virq;
>> -	static u64 dummy_mask;
>> +	u64 dummy_mask;
>>  
>>  	if (usb_disabled()) {
>>  		result = -ENODEV;
>> diff --git a/drivers/usb/host/ohci-ps3.c b/drivers/usb/host/ohci-ps3.c
>> index 395f9d3..a1c1bdf 100644
>> --- a/drivers/usb/host/ohci-ps3.c
>> +++ b/drivers/usb/host/ohci-ps3.c
>> @@ -69,7 +69,7 @@ static int ps3_ohci_probe(struct ps3_system_bus_device *dev)
>>  	int result;
>>  	struct usb_hcd *hcd;
>>  	unsigned int virq;
>> -	static u64 dummy_mask;
>> +	u64 dummy_mask;
>>  
>>  	if (usb_disabled()) {
>>  		result = -ENODEV;
> 
> No.  You need to read the code and understand how a variable is used
> before you decide to modify it.

Sorry, I misread the code, so just leave it as is.

> 
> In this case, a suitable approach would be to change the declaration 
> so that it says:
> 
> 	status u64 dummy_mask = DMA_BIT_MASK(32);
> 
> and remove the line that does the assignment dynamically.
> 
> Alan Stern
> 
> 
> .
> 

