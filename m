Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF22EC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38DD20883
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfASJ0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:26:13 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:38601 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727646AbfASJ0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 04:26:12 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09436148|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l04364;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.DnpjTRx_1547889964;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DnpjTRx_1547889964)
          by smtp.aliyun-inc.com(10.147.40.200);
          Sat, 19 Jan 2019 17:26:04 +0800
Subject: Re: [RFC v5 2/4] pstore/blk: add sample for pstore_blk
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1546862462-19640-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1546862462-19640-3-git-send-email-liaoweixiong@allwinnertech.com>
 <CAGXu5j+4QdqSYokE-0Y_pm5RgBp6i+xMgeXjTnNGVVMKeUafYg@mail.gmail.com>
 <CAGXu5jKbqP=SaAGqUeP5yhObeLbWnDLXN1=tVQZAaOHxo+D5VQ@mail.gmail.com>
From:   =?UTF-8?B?5buW5aiB6ZuE?= <liaoweixiong@allwinnertech.com>
Message-ID: <6f61bd6c-a274-92ae-75df-83a2265d3338@allwinnertech.com>
Date:   Sat, 19 Jan 2019 17:26:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKbqP=SaAGqUeP5yhObeLbWnDLXN1=tVQZAaOHxo+D5VQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-18 08:21, Kees Cook wrote:
> On Thu, Jan 17, 2019 at 4:15 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Mon, Jan 7, 2019 at 4:01 AM liaoweixiong
>> <liaoweixiong@allwinnertech.com> wrote:
>>>
>>> It is a sample for pstore_blk, using general ram rather than block device.
>>> According to pstore_blk, the data will be saved to ram buffer if not
>>> register device path and apis for panic. So, it can only used to dump
>>> Oops and some things will not reboot.
>>
>> I'm not sure I see the purpose of this implementation? Doesn't this
>> just cause all the pstore machinery to skip any actions? i.e. without
>> bzinfo->part_path, won't blkz_sample_write() just return -EINVAL, etc?
> 
> Say, instead of a no-op driver, can you build something like the how
> ramoops processes module parameters, so that a person can define an
> arbitrary device at boot time for blkoops? This also allows for easier
> runtime testing too.

Sure, i will do it in next version. But it can only use for oops,
excluding panic.
I have no idea how to pass panic operation parameters.

> 
> This all looks good, with some minor tweaks as mentioned. And on
> closer review, yeah, it doesn't look like it shares much with ramoops.
> :)
> 
> Thanks for sending this series; I look forward to the next version. :)
> 
> -Kees
> 
