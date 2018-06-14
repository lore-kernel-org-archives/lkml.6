Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D297CC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D390208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ChsXs47M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D390208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755435AbeFNUUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:20:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45568 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755280AbeFNUUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GbRfGqJMmKz8bIahQF8EvQ/oIG35NyDJJBnavO6WQ7Q=; b=ChsXs47MiCHFC2QvnuYXfgfN7k
        Gmvrvd44MYoq23xW0SlosxgATjkoic5rRRzud9wbA2+YUXfRuCdEBVW9VtzMFC8Jq8iO33XDhglBY
        o1lwYQUSyT6XCns/W5HAun9ibmAJdWt7mgD9sSq1eHjI17y6VB5WwQHWcY9ihwgFJeij/LUAFCyk8
        bi9tDLCepw53oN0tIrvejT14y1OeiK7Fjj4qxI9Ln+fNQ+A8BltFOsTlCU9VMNv+5ELoVr8HAU7Kv
        QAHV9DKPzBwQqM5qnHee4rkKkKbBKSrc1t6kFIBc+UZSgp1/RpmbJaO3iX8mYRJ6zCLQaSzdfXvid
        hq0Pk3PA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTYj7-0007kh-15; Thu, 14 Jun 2018 20:20:17 +0000
Subject: Re: [PATCH] usb/gadget: aspeed-vhub: add USB_LIBCOMPOSITE dependency
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <balbi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20180525160729.92026-1-arnd@arndb.de>
 <87o9gxcono.fsf@linux.intel.com>
 <71cfc192be06d07e79bfdfe43a566d3260e19cd6.camel@kernel.crashing.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <db22cad5-c25f-1b34-1784-5df5ed1ac0b2@infradead.org>
Date:   Thu, 14 Jun 2018 13:20:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <71cfc192be06d07e79bfdfe43a566d3260e19cd6.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 09:29 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2018-05-30 at 15:29 +0300, Felipe Balbi wrote:
>> Hi,
>>
>> Arnd Bergmann <arnd@arndb.de> writes:
>>> Without that option, we run into a link failure:
>>>
>>> drivers/usb/gadget/udc/aspeed-vhub/hub.o: In function `ast_vhub_std_hub_request':
>>> hub.c:(.text+0x5b0): undefined reference to `usb_gadget_get_string'
>>>
>>> Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> 
> Greg, can you send this to Linus asap ? Some people are hitting build
> breakages upstream because of this.

Agreed.

> Thanks !

ditto.

-- 
~Randy
