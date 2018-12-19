Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4F1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD6A218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHl4Wl5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbeLSPhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:37:16 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33996 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbeLSPhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:37:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id u89-v6so7098854lje.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 07:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=38X3SiYJ7IeHkQ0u5m6xFXUttDO+deoOHzUxpbe/MI0=;
        b=GHl4Wl5EO6SQMDkKwkXOETCrtSwTsICyCfcsU43naJYEq9Mh1xEUqNuadDNMhADWa4
         R1/XX2SYBoBCUeb2N9rgc8npxI/iRBr86YSWZulp+Y1wNyZyp0GysVLhIJd4q/8wkTx9
         0hy+8rhUAedkh+R00ZutlxojtcyooUXksXVVlUzcb7pACItbyvZ8Caz/LnH0zkxRtkw0
         7t6D3tRfrCfGWNrIuw9BKOiNYvztp7Wb3w4ZWdRgAqg41sNuYEa3MR/tkI8BLj+Kcgw2
         Ycjls+EvYXmssUxOP+PxB3EEDwcFBA3tmArNXJgti0VsgC18T4XhRjrW4c7LIQZHoru6
         UiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=38X3SiYJ7IeHkQ0u5m6xFXUttDO+deoOHzUxpbe/MI0=;
        b=tCfBH1qMrHr7V+64iEvJnnPL1KeHvFr8jS+d0mRQyuaAxdW+Bw7h68izJi3mFvBj1y
         Dr+JrP7JqgF693rLfOOLWEZ2Oi6zrlXUmNJuyqaau+sse0KagNB5BHx9+68i1+hECOKY
         TDB6qcc092rgjWCGehRgl6shNw1BNB6M8fHuNR7gUanYTySRRvX69m2qB81pf/LMvpaC
         b1FutwdnetlncyI45FZ7e0ScOaZXUSHQxOmoem900cbhO2eG91E7X15iU0hY1UILLrCy
         59TCFA5y0gFsKcdPTyp2Natbbhc8s0GdOtZoQItIOmP7VLqnLzeoOYRQTXFG8TmcN/Yl
         5Vjg==
X-Gm-Message-State: AA+aEWaTQNLbV+TsqMkOTxxNK18n0DBRHwb6+zMsjJiUiRYPgJ3U7AmM
        EfXDnCzjTijoXW6YLElnPyE=
X-Google-Smtp-Source: AFSGD/XS1o+S/lxZKETyOicOT+QIcfmlGq0RvjSQ482rlMN39fM7aWDQOSD5jRtlWDOsWf8++31XHQ==
X-Received: by 2002:a2e:93d7:: with SMTP id p23-v6mr12474787ljh.22.1545233831692;
        Wed, 19 Dec 2018 07:37:11 -0800 (PST)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id b21sm3884083lfi.7.2018.12.19.07.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 07:37:10 -0800 (PST)
Subject: Re: [PATCH] drm/bochs: add edid present check
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181218073339.12160-1-kraxel@redhat.com>
 <93d72578-9567-9694-dbc7-62618b217f8f@gmail.com>
 <20181219152129.k7v4ttpsazguswke@sirius.home.kraxel.org>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <4a1897bf-2b48-fdd7-25e3-d7d25b9885c3@gmail.com>
Date:   Wed, 19 Dec 2018 17:37:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219152129.k7v4ttpsazguswke@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 5:21 PM, Gerd Hoffmann wrote:
>    Hi,
>
>> You could probably have a comment here explaining the magic below
>> (just like in the commit message to ease the task of understanding
>> while reading the code why 2 of 8 bytes of the EDID header is checked
>> and why it is all needed). Of course one can use git blame... Up to you
> Makes sense.
>
>>> +	if (readb(bochs->mmio + 0) != 0x00 ||
>>> +	    readb(bochs->mmio + 1) != 0xff)
>> bochs->mmio is defined as "void __iomem   *mmio;". Can we please avoid
>> void pointer arithmetic here?
> Why is that a problem?  gcc uses bytes when doing pointer arithmetic
> with void pointers (even though it is undefined in the C standard),
> and as far I know the linux kernel depends on that behavior anyway.
>
> Also the driver already does it everywhere.
Ok then, just to be consistent with the rest of the driver.
> cheers,
>    Gerd
>

