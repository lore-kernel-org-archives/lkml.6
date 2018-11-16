Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4BCC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5858D2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5858D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbeKPXGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:06:18 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:50426 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389692AbeKPXGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:06:17 -0500
Received: from [78.40.148.180] (helo=[0.0.0.0])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gNddG-0006uA-G4; Fri, 16 Nov 2018 12:53:58 +0000
Subject: Re: [PATCH] USB: host: ehci: allow tine of highspeed nak-count
To:     Alan Stern <stern@rowland.harvard.edu>,
        Ben Dooks <ben-linux@fluff.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.1811141338100.1637-100000@iolanthe.rowland.org>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <39eb9e8b-2b5d-ea75-3232-be77c3743dbc@codethink.co.uk>
Date:   Fri, 16 Nov 2018 12:53:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1811141338100.1637-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/18 18:47, Alan Stern wrote:
> On Wed, 14 Nov 2018, Ben Dooks wrote:
> 
>> From: Ben Dooks <ben.dooks@codethink.co.uk>
>>
>> At least some systems benefit with less scheduling if the NAK count
>> value is set higher than the default 4. For instance a Tegra3 with
>> an SMSC9512 showed less interrupt load when this was changed to 14.
> 
> Interesting.  Why do you think this is?  In theory, increasing the NAK
> count RL value should cause a higher memory bus load and perhaps a
> slight rise in the interrupt load (transfers will complete a little
> more quickly because the controller tries harder to poll the endpoints
> and see if they are ready).

I thought the NAK counter was decremented until the transfer is given
up on. I'm going to have to go back and get some actual figures from
a running system as this was originally done over a year ago with the
SMSC9512 (IIRC) network driver.

>> To allow the changing of this value, add a sysfs node to each of
>> the controllers to allow run-time changing.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> The patch looks okay to me.

I'll look at getting some tracing from the SMSC driver to see what
is going on.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
