Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64244C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAEF21738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfBUIhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:37:38 -0500
Received: from mail.steuer-voss.de ([85.183.69.95]:46268 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBUIhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:37:37 -0500
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id EE6174D00E; Thu, 21 Feb 2019 09:37:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id EB0564CFFE;
        Thu, 21 Feb 2019 09:37:33 +0100 (CET)
Date:   Thu, 21 Feb 2019 09:37:33 +0100 (CET)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] usb: typec: tps6598x: handle block writes separately
 with plain-I2C adapters
In-Reply-To: <20190220162214.GA2017@kroah.com>
Message-ID: <alpine.DEB.2.20.1902210915480.18662@fox.voss.local>
References: <20180425142209.30745-1-heikki.krogerus@linux.intel.com> <20190220110017.BFA344CE86@mail.steuer-voss.de> <20190220125731.02E274CFE0@mail.steuer-voss.de> <20190220150227.GA17103@kroah.com> <alpine.DEB.2.20.1902201618090.8597@fox.voss.local>
 <20190220162214.GA2017@kroah.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, 20 Feb 2019, Greg Kroah-Hartman wrote:
> On Wed, Feb 20, 2019 at 04:22:00PM +0100, Nikolaus Voss wrote:
>>>> v2: fix tps6598x_exec_cmd also
>>>> ---
>>>>  drivers/usb/typec/tps6598x.c | 26 ++++++++++++++++++++------
>>>>  1 file changed, 20 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
>>>> index c84c8c189e90..c54b73fb2a2f 100644
>>>> --- a/drivers/usb/typec/tps6598x.c
>>>> +++ b/drivers/usb/typec/tps6598x.c
>>>> @@ -110,6 +110,20 @@ tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
>>>>  	return 0;
>>>>  }
>>>>
>>>> +static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
>>>> +				void *val, size_t len)
>>>> +{
>>>> +	u8 data[len + 1];
>>>
>>> I thought the build system now warned when you did this :(
>>
>> I must admit I'm developing on 4.19 stable series, so no warnings...
>
> Ick, no, you are 6 months behind where the rest of us are :(
>
> Always, at the very least, work off of Linus's tree.  For best results,
> work off of linux-next.

we are a medical device manufacturer and our prototypes run stable 
kernels because our main development goal is the patient therapy.

However, what I do check is that my patches apply cleanly onto Linus's 
tree and if I see any other changes of files my patch touches I rebase and 
compile.

I'll try to always do the last before I submit a patch in the future but 
testing can only be done on our prototype branch (with reasonable effort).

Nikolaus
