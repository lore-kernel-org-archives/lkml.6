Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2880FC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9642081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9642081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbeKAXBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:01:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43293 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbeKAXBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:01:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so4989083plb.10;
        Thu, 01 Nov 2018 06:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GjH52ZJh7QSIVOaMryfWZNnQaQe1mrAuAQRmW8fsPj0=;
        b=fkiQjyPomNVxsmVVdxBCnSdhv46QiL6/CgedFVI+M4VKYn8660yHrSzwRCK+yRQD7K
         4ViVpoK/vxziY2Vn2jVa6y9w4b372DZswQX71/MQnPKjxuaakZpp5TM29B7/flMXC9G9
         gdntooWtoem+VljBq8UpfVfyfIK6tf5lhPh7DNowZ168J/OohJOPYOInujo+LfGYOsAT
         gbNie7QdrvXsOg8yQR5vja+pXv90OUZCbsf29gfH6Po6BitjPLTGSZRagknlzlo0LdlG
         ZxW+lQjUML9kVIh+ZoEJz0e6428IVzmnqkmw1Hd6+JywZjntVohegZv+dXI6Mxm3LM3I
         wLZw==
X-Gm-Message-State: AGRZ1gLraZYnrYLlC1JO5lEWM4YxvHRSGNn+xPvNPfQqMEOnFxRLC+7C
        NkkGl4hLhCMNTNGeiJZOWvM=
X-Google-Smtp-Source: AJdET5ePBlALTaK1cMTLRAaFMetKuecQEZ9aDxrWrnPFY91GNseao9dan7zzrytkh7FGxOHXZklcjQ==
X-Received: by 2002:a17:902:e00a:: with SMTP id ca10-v6mr7627056plb.166.1541080677910;
        Thu, 01 Nov 2018 06:57:57 -0700 (PDT)
Received: from ?IPv6:2405:6580:9660:3200:14e5:990f:76c0:4949? ([2405:6580:9660:3200:14e5:990f:76c0:4949])
        by smtp.gmail.com with ESMTPSA id 3-v6sm33248666pga.12.2018.11.01.06.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:57:56 -0700 (PDT)
Subject: Re: [PATCH 17/28] tools include uapi: Update asound.h copy
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Perches <joe@perches.com>, Takashi Iwai <tiwai@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
 <20181031164508.4784-18-acme@kernel.org> <s5hlg6ehwzk.wl-tiwai@suse.de>
 <97ff58b75de70d2b9dd8524f7899063d563a6a71.camel@perches.com>
 <20181031192951.GE6669@redhat.com>
 <68477e3f-695f-b269-c44d-dbca4295ad05@sakamocchi.jp>
 <20181101130431.GA10588@kernel.org>
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <37fca067-21c3-e8b2-58f6-b65de667731b@sakamocchi.jp>
Date:   Thu, 1 Nov 2018 22:57:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181101130431.GA10588@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018/11/01 22:04, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 01, 2018 at 08:54:45PM +0900, Takashi Sakamoto escreveu:
>> Hi Arnaldo,
>>
>> On Nov 1 2018 4:29, Arnaldo Carvalho de Melo wrote:
>>>> Wouldn't a symlink be simpler?
>>>
>>> That would be equivalent to using it directly, see my response to
>>> Takashi for a few of the reasons this is done this way.
>>
>> I have a plan to add changes to 'include/uapi/sound/asound.h' in a
>> development period for Linux kernel v4.21[1]. Would I need to add you to
>> C.C list of the future patch to notify the change, or things go well
>> without such special care for your side?
> 
> Don't worry, the system was designed not to create any extra work for
> kernel developers.
> 
> The CC messages is just informative. :-)
> 
> - Arnaldo
>   
>> [1]
>> https://github.com/takaswie/presentations/blob/master/20181021/contents.md

Thanks, and I note that my work will neither change value of each ioctl
command for PCM/Control interfaces nor add new commands, thus no worries
in your side at this point.

I'll enjoy the beauty output from perf tools after rebasing my runtime
environment to v4.19 kernel, Thank you.


Takashi Sakamoto
