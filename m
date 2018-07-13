Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D74BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738A2208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738A2208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbeGMP7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:59:06 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:56272 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbeGMP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:59:05 -0400
Received: from [172.20.8.18] (unknown [207.96.227.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 0C42BC853E;
        Fri, 13 Jul 2018 17:43:51 +0200 (CEST)
Subject: Re: [PATCH] ieee802154: add rx LQI from userspace
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Romuald Cari <romuald.cari@devialet.com>,
        linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>
References: <20180607140802.22666-1-peron.clem@gmail.com>
 <ac0ff951-627d-9694-741d-03f6bc4d6ddc@datenfreihafen.org>
 <CAJiuCceN4uW1zOEwqNXFHgNn=HTHLT3Fy=bv78_dqw8LvRbpMQ@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <858d58d5-be9c-179e-c74c-3b47dee44993@datenfreihafen.org>
Date:   Fri, 13 Jul 2018 11:43:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCceN4uW1zOEwqNXFHgNn=HTHLT3Fy=bv78_dqw8LvRbpMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 10.07.2018 11:13, Clément Péron wrote:
> Hi Alexander, Stefan,
> 
> Thanks for your feedbacks,
> 
> On Mon, 9 Jul 2018 at 10:49, Stefan Schmidt <stefan@datenfreihafen.org> wrote:
>>
>> Hello Clement.
>>
>> Finally coming to review the patch. Sorry for the delay.
>>
>> On 07.06.2018 16:08, Clément Péron wrote:
>>> From: Romuald CARI <romuald.cari@devialet.com>
>>>
>>> The Link Quality Indication data exposed by drivers could not be accessed from
>>> userspace. Since this data is per-datagram received, it makes sense to make it
>>> available to userspace application through the ancillary data mechanism in
>>> recvmsg rather than through ioctls. This can be activated using the socket
>>> option WPAN_WANTLQI under SOL_IEEE802154 protocol.
>>
>> I can see that it makes the application life a lot easier to have data
>> send out and LQI value synced up by using the socket approach instead of
>> dealing with socket and ioctl's. I am good with this patch in general.
>>
>> So you have some public code that uses this approach? I would be
>> interesting in the userspace part of yours. A demo would be fine. If the
>> network handling part of your application is public anyway that would be
>> even better. :-)
> 
> I'm sorry but the userspace code that use this isn't open.

Fair enough.

> I will check if I can share this part.
> Just the idea is to compute an average LQI and when it reach a
> threshold we allow the remote to control the device.

Yes, I would be happy with a simple example just showing how to use the
socket opt and a very basic algo on how this LQI would be used.

regards
Stefan Schmidt
