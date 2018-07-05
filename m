Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C929C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C244D2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C244D2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=skynet.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbeGETD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 15:03:26 -0400
Received: from mailrelay102.isp.belgacom.be ([195.238.20.129]:17532 "EHLO
        mailrelay102.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753931AbeGETDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 15:03:24 -0400
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3ApDBqNBVApnCzj71lcGM7GPThlXbV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSAuqdThVPEFb/W9+hDw7KP9fy4BypYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uLRi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXTn?=
 =?us-ascii?q?dDUMlMTSxMGpm8YZYRAeoPPehWrIfzqFUBohS8GQaiC/jiyiNKi3LswaE2z+?=
 =?us-ascii?q?osHAPA0Qc9H9wOqnPUrNDtOacQS++1yrTDwDLdb/xIwzfy9pbHfQwiof6SR7?=
 =?us-ascii?q?5wc9DeyU80GgPejVWRqYrlMC2J1ugXqGeU8fNtWOSygGAkswF8uiWjytsoh4?=
 =?us-ascii?q?XTm44YxE3I+T96zYopP9G1Sk12bNi5G5VKrS6aLZF5QsY6TmFtvyY116MJtI?=
 =?us-ascii?q?agfCgP1JQn3xnfa+Gbc4SQ4hLsSuKRITBgiXJ+fbK/mw6y/VK+yuLiTMm7zk?=
 =?us-ascii?q?hFoTZGktbSrHwN0hvT6s+ASvdn4kih3jOP2xjS6uFCP080ibLWJ4M9zrM0jJ?=
 =?us-ascii?q?YfrErOEjLslEj1kKOabEcp9+uw5+TieLrmp5ucN4FuigH5N6QjgtK/DvoiMg?=
 =?us-ascii?q?cQQWeU5ee826P58U37WrpKiOY7krLasJHaI8QUuLK5DxVO3Yk98xq/FSup0M?=
 =?us-ascii?q?wEnXkbK1JIYBCHj4nqO1HJO/D1FvS/jEq2kDdt2f/GOqftApLXLnjMiL3hZ6?=
 =?us-ascii?q?py61ZAyAovytBS/4lbBa8HIPLxQEDxsd3YDhkjPwyowubnE8591oQfWWKVHK?=
 =?us-ascii?q?CZK7jfsUWW6e0yI+mDfpMVtCzhJPgi4v7klWU5lkMFfam1wZsXb2i1Hup4LE?=
 =?us-ascii?q?WDf3XjnMsOEWQUsQYkTuzlkluCXCVIZ3axX6M84C80CJ68AYjYWI+nmKaB0z?=
 =?us-ascii?q?ujHp1KemBGDUiBEXPpd4WCRvcNZzueIs5nkjwcSLihV5Qs1Q+htADk0bprNO?=
 =?us-ascii?q?nU9TMCtZLlytd14/fflRYo9Tx7F86dyX2CT3lonmMUQD87xKR/oU17ylee3q?=
 =?us-ascii?q?l0mv9YGsJJ5/NPTAg6MYXRz/J1C9/sQALNZNSJR0i8QtWgHz4xSsg9w9gUY0?=
 =?us-ascii?q?ZySJ2eiUXh3jCrS5wSjL2NDdRg8KPf2GPZJMtnzXvCkq47gA9iCtVCL2Crja?=
 =?us-ascii?q?1ysQraAabSkFSfmrrsf6lP5iPV8Ha/yj+QsVtVXQVzXOPHVHY3fUjHq9nloE?=
 =?us-ascii?q?nPHJG0DrFyMAJHgZqcJ7FHZ9bqgBNETfHLI9fPZW+t3W29U0XbjoiQZZbnLj?=
 =?us-ascii?q?1OlB7WD1IJxkVKpS6L?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BxBwCPaj5b/05Qg21cHAEBAQQBAQo?=
 =?us-ascii?q?BAYNJZWoSKIN6iGOLVgGBZCIxAUOUT4FmC4RsAoIsIjgUAQIBAQIBAQIBbCi?=
 =?us-ascii?q?CNSQBglwBAQEBAyMVHiMQCw4EBQECAiYCAjkQBggGAQwGAgEBgxyCBKlQghy?=
 =?us-ascii?q?ETIQDgTqBC4l3gQ8nDIInBy6ERwESAYMgglUCjQ2EWodlBwKCTQGMTIFGhAy?=
 =?us-ascii?q?CNw+FRYw3hVJafiFhcW1gCYEzgSCCJBcRjgg9MI0egjkBAQ?=
X-IPAS-Result: =?us-ascii?q?A2BxBwCPaj5b/05Qg21cHAEBAQQBAQoBAYNJZWoSKIN6i?=
 =?us-ascii?q?GOLVgGBZCIxAUOUT4FmC4RsAoIsIjgUAQIBAQIBAQIBbCiCNSQBglwBAQEBA?=
 =?us-ascii?q?yMVHiMQCw4EBQECAiYCAjkQBggGAQwGAgEBgxyCBKlQghyETIQDgTqBC4l3g?=
 =?us-ascii?q?Q8nDIInBy6ERwESAYMgglUCjQ2EWodlBwKCTQGMTIFGhAyCNw+FRYw3hVJaf?=
 =?us-ascii?q?iFhcW1gCYEzgSCCJBcRjgg9MI0egjkBAQ?=
Received: from 78.80-131-109.adsl-dyn.isp.belgacom.be (HELO smtp.vereecke.mooo.com) ([109.131.80.78])
  by relay.skynet.be with ESMTP; 05 Jul 2018 21:03:21 +0200
Received: from [192.168.4.54] (athene.vereecke.mooo.com [192.168.4.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.vereecke.mooo.com (Postfix) with ESMTPSA id A50AAE131F;
        Thu,  5 Jul 2018 21:03:21 +0200 (CEST)
Reply-To: vereecke.jan@skynet.be
Subject: Re: [PATCH] Patch enabling Fn function keys for Laptop Asus G730
 (keyboard 0x1869)
To:     Jiri Kosina <jikos@kernel.org>, vereecke.jan@skynet.be
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        benjamin.tissoires@redhat.com
References: <alpine.LNX.2.21.1806141112440.11126@Hermes.vereecke.mooo.com>
 <nycvar.YFH.7.76.1806251519190.6203@cbobk.fhfr.pm>
From:   jan <vereecke.jan@skynet.be>
Message-ID: <dc860e3a-c837-5571-95f4-e62065f1a7f4@vereecke.mooo.com>
Date:   Thu, 5 Jul 2018 21:02:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1806251519190.6203@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2018 15:20, Jiri Kosina wrote:
> On Thu, 14 Jun 2018, vereecke.jan@skynet.be wrote:
>
>> Attached is a patch enabling (most of) the Fn function keys for the Asus ROG
>> Strix GL730 Laptop. The keyboard identifies as a USB device 0x1869.
>>
>> This patch enables:
>>      volume/mute keys, ROG key, rew/play/ff,
>>      monitor and keyboard brightness keys,
>>      Touchpad toggle key,
>>      Calculator key
>>
>> 'Touchpad on/off' Key returns keycode 33, which is mapped to the 'p' key.
>> 'Display on/off' returns keycode 253, which is mapped in X11 to NoSymbol
>> 'Airplane Key' returns keycode 255, which is mapped in X11 to NoSymbol
>>
>> The following keys are not activated yet:
>>         Microphone Mute key, Fan key, Display Switch key
> Thanks a lot for the patch.
>
>> This patch is against the 4.17-rc7 kernel, for the x86 architecture
> This usually doesn't go to the changelog, it'd be unnecessary polution of
> the set-in-stone git changelog.
>
>> diffstat for this patch is:
>>   hid-asus.c   |    2 ++
>>   hid-ids.h    |    1 +
>>   hid-quirks.c |    1 +
>>   3 files changed, 4 insertions(+)
>>
>> To apply the patch, in the root of the kernel tree use:
>> patch -p1 < AsusGL703-Keyboard-Fn-keys.patch
> Neither does any of this.
>
> What is OTOH missing is your signoff.
>
> Could you please fix these up and resubmit (ideally with Subject: line
> also tailored to fit the subsystem customs, IOW something like "HID: asus:
> add support for ....").
>
> Thanks,
>
Thanks for your reply. However, I am confused. Pleas bear with me as 
this is the very first time that I submit a patch and I followed some 
guidance that I found on the internet (obviously not the correct one).

I suppose I just need to delete the parts of the email where you write 
"this doesn't go in the changelog".

I am not sure what my signoff should contain. Could you point me to a 
correct guide for this ?

Thanks.

