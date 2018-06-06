Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o6pZEtar"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A61A560290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeFFPbI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:31:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34144 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbeFFPbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:31:04 -0400
Subject: Re: linux-next: Tree for May 29 (usb/gadget/udc/aspeed-vhub)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180529204410.63477f88@canb.auug.org.au>
 <00c69bdc-0b70-cb82-ee1e-2718acc19582@infradead.org>
 <3731dd7511b6a0ee74b062caf616e8041382fb90.camel@kernel.crashing.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <be9159d4-f53e-1f1a-e87b-dfd55c458c9a@infradead.org>
Date: Wed, 6 Jun 2018 08:30:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <3731dd7511b6a0ee74b062caf616e8041382fb90.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 03:16 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2018-05-29 at 10:04 -0700, Randy Dunlap wrote:
>> On 05/29/2018 03:44 AM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20180525:
>>>
>>
>> on i386:
>>
>> when builtin:
>> drivers/usb/gadget/udc/aspeed-vhub/hub.o: In function `ast_vhub_std_hub_request':
>> hub.c:(.text+0x3aa): undefined reference to `usb_gadget_get_string'
>>
>> or when modular:
>> ERROR: "usb_gadget_get_string" [drivers/usb/gadget/udc/aspeed-vhub/aspeed-vhub.ko] undefined!
>>
>>
>> Full randconfig for modular build is attached.
> 
> Somebody already sent a fix for this. Thanks. (Missing a dependency on
> LIBCOMPOSITE).

Hi,

linux-next is still having this build error.
Can we get that fix merged somewhere, please?

thanks,
-- 
~Randy
