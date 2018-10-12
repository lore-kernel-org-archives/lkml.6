Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C16C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE0A2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE0A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeJLNT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:19:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56557 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbeJLNT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:19:59 -0400
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w9C5mv702225361
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 11 Oct 2018 22:48:58 -0700
Subject: Re: Insanely high baud rates
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
 <20181010211717.30c1f052@alans-desktop>
 <16D6AB22-697E-498C-A5B2-3AD90B567E86@zytor.com>
 <20181011133134.085624af@alans-desktop>
 <8A583BC1-A295-48D2-B4C3-3E70AA50D035@zytor.com>
 <20181011214035.GC565@thunk.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <e2d6b234-0127-78df-6d37-13e0c4777db8@zytor.com>
Date:   Thu, 11 Oct 2018 22:48:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181011214035.GC565@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/18 2:40 PM, Theodore Y. Ts'o wrote:
> On Thu, Oct 11, 2018 at 07:14:30AM -0700, hpa@zytor.com wrote:
>>>
>>> I mean - what is the baud rate of a pty  ?
>>
>> Whatever the master wants it to be...
> 
> I think Alan's point is that it is highly unlikely you would be able
> to push the equivalent of 4 gbps through a PTY layer.  The TTY later
> was never engineered for those speeds, and the real question is ---
> what's the point?  That's what Ethernet is for.
> 

I like to consider the far future; I think things like the Y2038 problem is a
good example. Or, as I like to put it, "numbers are cheap, running out of
numbers is expensive." Sounds like we have enough of a plan that we aren't
completely stuck should it ever become an issue.  It might never, of course.

	-hpa
