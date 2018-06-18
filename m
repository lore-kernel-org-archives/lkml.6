Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A97FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0538720864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0538720864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mev.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966122AbeFRJgC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:36:02 -0400
Received: from smtp113.ord1c.emailsrvr.com ([108.166.43.113]:39244 "EHLO
        smtp113.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964990AbeFRJfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:35:45 -0400
Received: from smtp15.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp15.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 7500D201BD;
        Mon, 18 Jun 2018 05:35:44 -0400 (EDT)
X-Auth-ID: siepeng@mev.co.uk
Received: by smtp15.relay.ord1c.emailsrvr.com (Authenticated sender: siepeng-AT-mev.co.uk) with ESMTPSA id C1C2420180;
        Mon, 18 Jun 2018 05:35:43 -0400 (EDT)
X-Sender-Id: siepeng@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 18 Jun 2018 05:35:44 -0400
Subject: Re: can we drop the comedi serial2002 drivers from staging?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org,
        Anders Blomdell <anders.blomdell@control.lth.se>
References: <20180616090645.GA3997@lst.de> <20180616093740.GA9816@kroah.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <9fa51c9d-b56f-01be-0822-8b2f4e525a47@mev.co.uk>
Date:   Mon, 18 Jun 2018 10:35:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180616093740.GA9816@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/18 10:37, Greg Kroah-Hartman wrote:
> On Sat, Jun 16, 2018 at 11:06:45AM +0200, Christoph Hellwig wrote:
>> As far as I can tell there has been no targeted work on the driver
>> since merging it at all, and since 2014 even the comedi-wide
>> cleanups stopped, laving just drive by tree wide changes since.
>>
>> At the same time the driver badly abuses the tty layer and is one
>> of only two major abusers of the poll code for in-kernel waits.
> 
> Yeah, it's an ugly driver.  It should be rewritten to use the new serdev
> api instead of trying to open a tty device node from within the kernel.

I was thinking about that, but it looks tricky to use for a "normal" 
PC-based distro due to typical lack of device-tree support.

Another possibility is to support comedi drivers in userspace via CUSE, 
which would require a comedi-cuse interface library that user-space 
comedi drivers could link to similar to how kernel-mode comedi drivers 
link to the comedi core.

> I don't object to dropping it.  Ian and Hartley, do you know of any
> users of this driver anymore?

The only place I know it was in use was in Anders Blomdell's lab at Lund 
University.  I've added him to the Cc: list.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
