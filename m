Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04B6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57494223CA
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57494223CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeKLSuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:50:20 -0500
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:46764 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726220AbeKLSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:50:20 -0500
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id M82jg0s3MSskCM82mgmv0s; Mon, 12 Nov 2018 09:58:05 +0100
Subject: Re: [GIT PULL for v4.20-rc1] new experimental media request API
To:     Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181030105328.0667ec68@coco.lan>
 <CAHk-=whQKCA18MEi7FT=10c0HVa=kxSyYBJeAQH-C2mA5gBhbg@mail.gmail.com>
 <20181031154030.3fab5a00@coco.lan> <20181111202850.GA9704@amd>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <c5ff4492-9b53-3585-16b3-ddc73c667a82@xs4all.nl>
Date:   Mon, 12 Nov 2018 09:58:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181111202850.GA9704@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMMLeh7QOOP+BeMxsmNNDfdqWQgS7FIKODUCQ7Kjjrp4wq5oPuKyXM/dxq5Sq9MsD6WahuQBpHjB+Sos/sVAzbT7qI2zAQuJ1uEBPxgDDyEBAtNLDQG2
 Z97pGOpFY/cIJHuUcUihxJWAdiSaiK1KzVZFP9y3kQzYz61qLtzmlVkF7ze6CRCaVDd5VgS+eOX/sO3yZpaa0uAlVwG3bsNvuGXhv2XigrfHeaMLemZOrtSa
 gnhaJe+ZpF/263X+7GC+1t+kAbfwAIfmWuDKRBm+FQAtM6rU3FoSyQ4mxhku5792VNWNAjycQkNMC4nspIuKS9NlClRREipRrXVHyUuOS2Xks0/aK96YpJ9O
 HBvfSTlVe4S3WfgXPFAroS4c0vUWXhpUSj35bsL00GDCEHydZls=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2018 09:28 PM, Pavel Machek wrote:
> Hi!
> 
>> Em Wed, 31 Oct 2018 11:05:09 -0700
>> Linus Torvalds <torvalds@linux-foundation.org> escreveu:
>>
>>> On Tue, Oct 30, 2018 at 6:53 AM Mauro Carvalho Chehab
>>> <mchehab+samsung@kernel.org> wrote:
>>>>
>>>> For a new media API: the request API  
>>>
>>> Ugh. I don't know how much being in staging matters - if people start
>>> using it, they start using it.
>>>
>>> "Staging" does not mean "regressions don't matter".
>>
>> Yes, I know.
>>
>> This shouldn't affect normal cameras and generic V4L2 apps, as this
>> is for very advanced use cases. So, we hope that people won't start
>> using it for a while. 
>>
>> The main interested party on this is Google CromeOS. We're working 
>> together with them in order to do upstream first. They are well aware
>> that the API may change. So, I don't expect any complaints from their
>> side if the API would require further changes.
> 
> You may want to simply disable it in Kconfig... ChromeOS people can
> enable it easily, and if it never worked in the mainline, you get some
> wiggle room :-).
> 								Pavel
> 

For the record: there are no known issues with the Request API. The
only outstanding issue is with a control introduced in the staging cedrus
driver which will have to change since the method used to refer to MPEG
reference frames is wrong. We're working on that and should have this
fixed soon (patches have been posted and I'm waiting for test feedback).

This control has nothing to do with the Request API, so I see no reason
to put the Request API under a config option. Drivers needs to explicit
enable support for the Request API anyway, so all existing drivers will
return an error if userspace attempts to use this API.

Regards,

	Hans
