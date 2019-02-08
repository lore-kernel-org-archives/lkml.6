Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3D5C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611202147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6bBtkiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBHFJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:09:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39264 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfBHFJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:09:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so1902171ljh.6;
        Thu, 07 Feb 2019 21:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8vv6VBS1DcVpRo1o4q3JPCkiFSznywYK2L7AtxRYwPo=;
        b=t6bBtkiKzxQwVQYnp+bEmSz+r15qN2sD10szzjgPLQJdPth2ftRVxSVrttGzOg7NCQ
         idHW/Zdo4ki6BnX3Xf7RggSgVOydsoF4xvInK2NxlVT1M2aoNcjjlbILPCmRsrgtx1Nk
         erZs8jLTuRCusVutxQxf2oedVI0jYxLoMPopvY+uaKYJ+vTylpO0GbgwrfxT/nyW5JiZ
         TeGg0++uuMkNWeTdLCf/s/hoV9Te4Rd8LOjN1o+AKoWyd4M/l8pseISwZ+Buef5csF3T
         DKZGIMWZkeDytbFjNOvggLSMlF2RccDMrLdb6JrG4vrIughgHKy7GEYhWFszZk9DOrYx
         85FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8vv6VBS1DcVpRo1o4q3JPCkiFSznywYK2L7AtxRYwPo=;
        b=qvmezVPiSFpShLwdApw/B9CJXdfwYEOfL6ZW0+IaeJQkeX6L/1ibSxx+KONCKYgi1F
         x+41Z416Et5VGJpqW57Cf5KhYyLMTpYlCfFQKEF12F+5Q0j0qddyy0+PYkjn6ez77P9C
         ZjRNojETCf1JHQpMv7guv2YDIiXlK4kv455tdUe7FIa9G0otaYsk8340/bIqtXzLlp8o
         OnqfOj8CWWCfXMn6fn+oju6dMhFvCotSbilhJTlCbWAkf0+fB5chKPGbvUR06aYlxnTF
         uY5Fi5ifzC48vMlW/HxhcYu0ulaQ5T0uW2/zjOMCPxNA+MaO0L5tzmrxGNaA1FvVhHxs
         HowQ==
X-Gm-Message-State: AHQUAuazihRl+oanmtFX1hV4Mj5x1ty2JEpbCjeCEq2WmmAVxQDY8ppL
        tlNsa7QdmV0qtq1wdBUFEIRfpKAn8DKWXw==
X-Google-Smtp-Source: AHgI3IY3O6o2LsdAhtSaWENqH5jryP+oZA/g5D0059HKueQNf1wJdVRNHfznSNQ2GMs7ujOjAGLQwg==
X-Received: by 2002:a2e:5816:: with SMTP id m22-v6mr930198ljb.177.1549602556067;
        Thu, 07 Feb 2019 21:09:16 -0800 (PST)
Received: from ?IPv6:2001:14ba:8017:3300:554b:539:3415:5da3? (dtynxhyc1lpcxwqy1n2vt-3.rev.dnainternet.fi. [2001:14ba:8017:3300:554b:539:3415:5da3])
        by smtp.googlemail.com with ESMTPSA id d5sm160603lfi.65.2019.02.07.21.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 21:09:15 -0800 (PST)
Subject: Re: [RFC PATCH] leds: multicolor: Add sysfs interface definition
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190130183005.833-1-dmurphy@ti.com> <20190130223542.GA22040@amd>
 <6afa674b-9c4e-2568-c758-030e93aebd06@gmail.com>
Message-ID: <6d50b09c-87be-d48f-cfe5-f5143c18d38c@gmail.com>
Date:   Fri, 8 Feb 2019 07:09:14 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <6afa674b-9c4e-2568-c758-030e93aebd06@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 08/02/2019 6.55, Vesa Jääskeläinen wrote:
> Hi All,
> 
> On 31/01/2019 0.35, Pavel Machek wrote:
>> On Wed 2019-01-30 12:30:05, Dan Murphy wrote:
>>> Add a documentation of LED Multicolor LED class specific
>>> sysfs attributes.
>>
>> No, sorry. This does not most of the requirements.
>>
>>                                 Pavel
>>
>> Requirements for RGB LED interface:
> 
> ...
> 
> I have tried to capture relevant parts of ideas and requirements and 
> usage in a wiki page in github:
> 
> https://github.com/vesajaaskelainen/linux-multicolor-leds/wiki
> 
> I believe the discussion is good to perform in mailing list -- I am 
> happy to update or give you access to update the wiki so we could have 
> easy to use summary/details source during discussions.
> 
> Ideas on the interface seem to be a bit drifting so I apologize if some 
> of Your ideas were not captured.
> 
> There has been at least two direct proposals for userspace interface and 
> I tried to provide usage example also for Dan's proposal. Feel free to 
> correct me if I made a mistake.
> 
> I believe it is a good to create summary page as there seems to many 
> aspects to be though out. What do you feel on this approach?

And should we perhaps move this discussion only to linux-leds mailing 
list for successive replies :) ? So we don't generate too broad traffic.

Thanks,
Vesa Jääskeläinen
