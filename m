Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25EAC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7624120671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7624120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbeJXEkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:40:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38459 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbeJXEkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:40:14 -0400
Received: from hanvin-mobl2.amr.corp.intel.com ([192.55.54.42])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w9NKEvJh3162800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 23 Oct 2018 13:14:58 -0700
Subject: Re: [PATCH stable v2 1/2] termios, tty/tty_baudrate.c: fix buffer
 overrun
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-alpha@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        stable@vger.kernel.org
References: <20181022161905.26589-1-hpa@zytor.com>
 <20181023145351.GA28516@kroah.com>
 <DD4A5EC1-E0A8-4DB0-907F-F334C27CE54D@zytor.com>
Message-ID: <93f9d420-99e4-b84a-930f-a459f53a5ef7@zytor.com>
Date:   Tue, 23 Oct 2018 13:14:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DD4A5EC1-E0A8-4DB0-907F-F334C27CE54D@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/18 09:02, hpa@zytor.com wrote:
>>
>> As I think Al's big termios cleanups are going to be hitting Linus's
>> tree soon, do you know how these patches interact with that?
>>
>> This patch seems like it will not, so I'll be glad to queue that up
>> after my first round of patches get merged to Linus later this week,
>> but
>> the second one worries me.
>>
>> thanks,
>>
>> greg k-h
> 
> I have been working with Al; we had approached much the same problems but from different directions. Mine ended up being a bit more comprehensive as a result, so I think we're going to end up using my code with Al's reviews.
> 
> So bottom line is that it should be all good.
> 

[Al: Feel free to yell at me if I got that wrong.]

	-hpa
