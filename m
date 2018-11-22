Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5CBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F282A20659
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F282A20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404983AbeKWIY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:24:28 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:52397 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbeKWIY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:24:28 -0500
Received: from [192.168.0.3] (ip5f5bf24c.dynamic.kabel-deutschland.de [95.91.242.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 891452012BAC03;
        Thu, 22 Nov 2018 22:43:11 +0100 (CET)
Subject: Re: Logitech QuickCam USB detected by Linux, but not user space
 applications
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b9140bbf-1537-1431-1250-da0a21208992@molgen.mpg.de>
 <20181115033813.6ff626d5@silica.lan>
 <53bce637-985e-2c74-1d6b-151ba81550db@molgen.mpg.de>
 <dd498a43-75cd-eec1-415f-f9d4569a302e@xs4all.nl>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <90a7e0e2-ddbb-7762-3eb6-51db0570ffff@molgen.mpg.de>
Date:   Thu, 22 Nov 2018 22:43:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <dd498a43-75cd-eec1-415f-f9d4569a302e@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Hans,


Am 22.11.18 um 13:43 schrieb Hans Verkuil:

> On 11/16/2018 03:39 PM, Paul Menzel wrote:

>> On 11/15/18 12:38, Mauro Carvalho Chehab wrote:
>>> Em Thu, 15 Nov 2018 11:42:32 +0100 Paul Menzel escreveu:
>>
>>>> I tried to get a Logitech QuickCam USB camera working, but unfortunately, it is
>>>> not detected by user space (Cheese, MPlayer).
>>>
>>> Could you please try it with Camorama?
>>>
>>> 	https://github.com/alessio/camorama
>>
>> Thank you for the suggestion. At first, I only saw a black image, but changing the
>> resolution made it work. See the status below.
>>
>> 1.  does *not* work
>>
>>      a)  160x120
>>      b)  176x144
>>
>> 2.  works
>>
>>      a)  320x240
>>      b)  352x288
> 
> Try this patch:
> 
> https://patchwork.linuxtv.org/patch/53043/
> 
> It probably fixes the same problem you are experiencing.

It indeed does. I cherry picked it to Linus’ master branch, and it fixed 
the problem.

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> (Logitech QuickCam 046d:092e)

[…]


Kind regards,

Paul
