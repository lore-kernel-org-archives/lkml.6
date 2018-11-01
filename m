Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4E6C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB42D2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB42D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbeKAU5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:57:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37657 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeKAU5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:57:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so8932683pgq.4;
        Thu, 01 Nov 2018 04:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=78i3pg8ptuOTmsNl18pKOHvOKUcCxjd24l9hQWTyZX0=;
        b=Lv8LwtiedJRthP3rlIHxjRblu94UrvNGeSaioUXTKeHIk5+ApLrknW06aOA/DPeRSg
         Rd8ZUkACWrMfi6FSN31AGpZSC2thotzoGHkFGDSGgJCulf+pUw91MZOLH/ih2ByCW5zR
         S1tlDQQwuFiCDotFqvlj0Id8gP+XEu26WtrHvwMLo8WSICTfg5drsHXdK7UyuJiTSppo
         0B+O57+iIvQk2//yTJjdXBSpegElwEAcHn4sSGcfhnNxVJpNyjKwenoQiNjpTBQOL5YF
         8883/28aBtGoluU4nkHSQL8sTcdhLKUmqcn0VJz+7YqrA+zum+4uZ2CvA4t7lZR+cRqH
         qP6A==
X-Gm-Message-State: AGRZ1gKAvXIfSP65dl1XTdANyDmDxTfYFz0Mr6e2BXsZQEWmUCAwq8K9
        euNtj96rIchxVihlHkY+eOQ=
X-Google-Smtp-Source: AJdET5eQr//F6fChGCFgYqN5VR3R0SKQpQ7mQ4HILhn8ZrvKXcZenYizl1K4a5sg1281g04mlvOsqA==
X-Received: by 2002:a62:2bd4:: with SMTP id r203-v6mr5766294pfr.105.1541073290168;
        Thu, 01 Nov 2018 04:54:50 -0700 (PDT)
Received: from ?IPv6:2405:6580:9660:3200:14e5:990f:76c0:4949? ([2405:6580:9660:3200:14e5:990f:76c0:4949])
        by smtp.gmail.com with ESMTPSA id s85-v6sm44257642pfi.15.2018.11.01.04.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 04:54:49 -0700 (PDT)
Subject: Re: [PATCH 17/28] tools include uapi: Update asound.h copy
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Perches <joe@perches.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
 <20181031164508.4784-18-acme@kernel.org> <s5hlg6ehwzk.wl-tiwai@suse.de>
 <97ff58b75de70d2b9dd8524f7899063d563a6a71.camel@perches.com>
 <20181031192951.GE6669@redhat.com>
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <68477e3f-695f-b269-c44d-dbca4295ad05@sakamocchi.jp>
Date:   Thu, 1 Nov 2018 20:54:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181031192951.GE6669@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Nov 1 2018 4:29, Arnaldo Carvalho de Melo wrote:
>> Wouldn't a symlink be simpler?
> 
> That would be equivalent to using it directly, see my response to
> Takashi for a few of the reasons this is done this way.

I have a plan to add changes to 'include/uapi/sound/asound.h' in a
development period for Linux kernel v4.21[1]. Would I need to add you to
C.C list of the future patch to notify the change, or things go well
without such special care for your side?

[1] 
https://github.com/takaswie/presentations/blob/master/20181021/contents.md


Regards

Takashi Sakamoto
