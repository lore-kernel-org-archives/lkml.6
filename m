Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3ACC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA7F21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvg44wIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391474AbeLUSfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:35:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44354 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731525AbeLUSfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:35:43 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so2957598pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 10:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SJVdAMn3u/1jD44xLq1y25JgZtRFdtu4vOos6twk9NA=;
        b=Mvg44wIB+I3/OaqOoHVYFaB+kPhICqoKgZ/AZ9ZBjF+kuf6XWoFlkblQMBEUo1e0GY
         AyNcB+lIcF+8LHdxohQqCIUzuTF1sAvJiqdr8H4H+wqp2WqgCDkSnQ3boVX/I5EBB2oP
         gFIbeYwCuGJPAQVaKi8wSf1RulspsdmWYWDeDRteMjwe2AraHkjvOjiEZnHWVJQVJig0
         YZhhT8dnURE2SC69vOa9snMT6NgV423Mg9Xn+nvVyGK/dLnXaskVzBqp69jOQIbkKgPD
         8sNGUg3Oq2uNjUtNGU/kQg7P6hE/GARoN1uGP6ir8+AXrz0T+zUgXXN53j7Vj8YdnhV8
         mgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SJVdAMn3u/1jD44xLq1y25JgZtRFdtu4vOos6twk9NA=;
        b=k20fiaHfKwZnG5cVd8oeLkoLg+JQ3YU14FQR3Cgn2FI3S7XUSmUOLK5MC21xrDIuKZ
         Lt9wMnJT2JuF56L8ob6JZdbiAgXTKMNTUhWHJPli1S4vwSUgLZjP6mosrmHxXZ58+837
         VHx5FFRFK6QAT0RHTWKS/n0b49h5NYKODyP5J+Q74sgTwfSGxaNIeorffcyhyu2ORdtQ
         sRJFKFmypEHHGvPFVfvfhWpO14mmnaN6d8h9ntXeMurUzlzcjRi4UurZk59lLG1O9060
         aTw3LhWWNdTuSKoF+CDxm+3d8qw++iv1J8dIP2ZtBv4wFd8VkC/cOxQo8YLxTfEFvHKp
         vN+A==
X-Gm-Message-State: AJcUukfdwxGEnaDEtPSdeDMo0CwBeAB4eKbROsSWgCUkglXAFBUk4ljH
        R71i7ebXkIkljOQejzltGfo=
X-Google-Smtp-Source: ALg8bN6Suh2HDgKIF7R+2ICqjugui991mw3tW5j+yPbBqOk7QTs7hcr+D0L5tOUL/VbSAeIJe5rhbA==
X-Received: by 2002:a63:4384:: with SMTP id q126mr3443903pga.160.1545417342435;
        Fri, 21 Dec 2018 10:35:42 -0800 (PST)
Received: from [192.168.2.145] ([94.29.36.169])
        by smtp.googlemail.com with ESMTPSA id g190sm28653444pgc.28.2018.12.21.10.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:35:41 -0800 (PST)
Subject: Re: [PATCH 2/2] drm: Revert syncobj timeline changes.
To:     christian.koenig@amd.com, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, Jason Ekstrand <jason@jlekstrand.net>
References: <20181108160422.17743-1-eric@anholt.net>
 <20181108160422.17743-3-eric@anholt.net>
 <faf15d58-a076-49fb-c903-15acdf6f8ffe@gmail.com>
 <fadfc03c-7f80-216b-299f-27a1d8d7877b@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <44f25278-fbbd-f95b-c2ab-87834e5d095e@gmail.com>
Date:   Fri, 21 Dec 2018 21:35:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fadfc03c-7f80-216b-299f-27a1d8d7877b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.2018 21:27, Christian König wrote:
> Am 19.12.18 um 18:53 schrieb Dmitry Osipenko:
>> [SNIP]
>>> @@ -931,9 +718,6 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>>         if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
>>>           for (i = 0; i < count; ++i) {
>>> -            if (entries[i].fence)
>>> -                continue;
>>> -
>>>               drm_syncobj_fence_get_or_add_callback(syncobjs[i],
>>>                                     &entries[i].fence,
>>>                                     &entries[i].syncobj_cb,
>> Hello,
>>
>> The above three removed lines we added in commit 337fe9f5c1e7de ("drm/syncobj: Don't leak fences when WAIT_FOR_SUBMIT is set") that fixed a memleak. Removal of the lines returns the memleak because of disbalanced fence refcounting and it looks like they were removed unintentionally in this patch.
> 
> That was already fixed with 61a98b1b9a8c7 drm/syncobj: remove drm_syncobj_cb and cleanup.
> 
> This cleanup removed all the duplicate checking and is now adding the callback only once.

Okay, though that commit is not in linux-next. I assume it will show up eventually.
