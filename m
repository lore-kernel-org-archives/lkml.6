Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463C2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E78C20818
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8aI3XXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfBHEzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:55:39 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38210 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfBHEzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 23:55:39 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so1881916lja.5;
        Thu, 07 Feb 2019 20:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EcEG7vkZKJD4FnnKCZ+M3KBDCk304ATizi8OJA3NLb8=;
        b=n8aI3XXXebPN6GkFyE0rh/HZ9yNBCYLHC05Fub0lcWOjUCM+yXRuN4m6oAJiRybX+/
         VMqNXoWHpxNE1VN1X2L/UTCjKtw9HZp6muVYW6w9VBSqTEe/Sq8VxXmr7zpbRoH3DIDH
         LZZw+M7ObB+BPyy2s57HO32iTfS54QnG5pnhxLmv4Mu56yIKB59YZSdqgRJxxpnn+sGT
         jfIVTjh2ie6IdhI1LjbVCDf4nysuys9T1Hvv8eubydW2U9gN1EmsxvJV7oVwXELeN128
         5hiUnuUNguVilXE1WsdfR1zcJCAIJL/7cPgobwujQFjtATCgcMvQgrUGruZqhiAjRiH4
         saIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EcEG7vkZKJD4FnnKCZ+M3KBDCk304ATizi8OJA3NLb8=;
        b=nYXmJ2PltznIF6OI6+l3g1yd5d10xwF9frDX4A9zShle0rOg3F8AX1ooGAFKI5DLuF
         PhlausIRNo8oFLpB19ST/mCstP7/7w4qbv8uzmoQQs+lG3dAwFsEcI5/4sEDlAo9Keou
         vSza6bukW3IvkZ2snRw2SpA6H2sKLCZRKGT6RBalUl8EqrTOKGUjq1Re4gboMwsRPRbS
         5FJLbKuBNKZsfV5/69ZfAtrpEJB9xTJT3GrDXMG2QSxWBnFnqVIQmsGKZc3P8IgjuY70
         gMlxdNHLnTOIg8xrFjeTTyUHra5PGRVAev7jFHcz+5cyJqLFijjBeGvAQUGiEuux8Xdo
         RfkA==
X-Gm-Message-State: AHQUAuZSYFoYN0Yv/k8t6fPdfSkaAr6bh6F957TSwyaOeRF+/nb2MAY4
        /GEW82hNlilZdzQoOuzCgRDf3qi6IwE=
X-Google-Smtp-Source: AHgI3IZwWl7rxgqdEpRKBMLoJjfgFRiXFaprBsj9L+mMDiFpueck6g/Luh2amVu+xxwNVsVpQuslyA==
X-Received: by 2002:a2e:9b52:: with SMTP id o18-v6mr11902432ljj.108.1549601736316;
        Thu, 07 Feb 2019 20:55:36 -0800 (PST)
Received: from ?IPv6:2001:14ba:8017:3300:554b:539:3415:5da3? (dtynxhyc1lpcxwqy1n2vt-3.rev.dnainternet.fi. [2001:14ba:8017:3300:554b:539:3415:5da3])
        by smtp.googlemail.com with ESMTPSA id h82sm150373lfg.94.2019.02.07.20.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 20:55:35 -0800 (PST)
Subject: Re: [RFC PATCH] leds: multicolor: Add sysfs interface definition
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190130183005.833-1-dmurphy@ti.com> <20190130223542.GA22040@amd>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Message-ID: <6afa674b-9c4e-2568-c758-030e93aebd06@gmail.com>
Date:   Fri, 8 Feb 2019 06:55:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190130223542.GA22040@amd>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 31/01/2019 0.35, Pavel Machek wrote:
> On Wed 2019-01-30 12:30:05, Dan Murphy wrote:
>> Add a documentation of LED Multicolor LED class specific
>> sysfs attributes.
> 
> No, sorry. This does not most of the requirements.
> 
> 								Pavel
> 
> Requirements for RGB LED interface:

...

I have tried to capture relevant parts of ideas and requirements and 
usage in a wiki page in github:

https://github.com/vesajaaskelainen/linux-multicolor-leds/wiki

I believe the discussion is good to perform in mailing list -- I am 
happy to update or give you access to update the wiki so we could have 
easy to use summary/details source during discussions.

Ideas on the interface seem to be a bit drifting so I apologize if some 
of Your ideas were not captured.

There has been at least two direct proposals for userspace interface and 
I tried to provide usage example also for Dan's proposal. Feel free to 
correct me if I made a mistake.

I believe it is a good to create summary page as there seems to many 
aspects to be though out. What do you feel on this approach?

Thanks,
Vesa Jääskeläinen
