Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6E5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29915218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4V9EvAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeLRSsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:48:46 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35787 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeLRSsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:48:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so15148905ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EDaH00EN90N7NHpZfe+Rbe9EkqkHn6xXIqUo1eYBQx8=;
        b=O4V9EvAh87M0okLEcTqrO9wGmi2ftxoYeVHSf0jqqBxa5I+qmDU1Yd/gPmx+mU7tlZ
         i49CXHbMddaW+VBQHFvKC8kTAJ8rhgE0QXQQXVyZfEVEZ1vA6VnmaMeVJld+EieB0UQZ
         +sMMHzixGWrlYKZC5ojvgJsjH6B+p6HA3GcMSFunMfy+XryIQuREEWTKQcGXz1EAnwdD
         4yetJ1p5FohiKeL6dcMjyUN1MLrLZKEgkcQAlfR/FC9Fjd9MVTAKKOmKlBvhoP2qL5Bn
         ahAhtGPF/e1fqJsBHNCvbGZZabnHf89gGl5JjUPWxLQFHOeWNdhAoduNk6yv72P+Dnfw
         UCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EDaH00EN90N7NHpZfe+Rbe9EkqkHn6xXIqUo1eYBQx8=;
        b=ltsmMtKBrvUBwvxIBL1cJqRKnsQhugVd88O30mWSDG2wDEFsJQ0jhXDbZkMVNSXL5A
         ukHtHpb81jTg16ov+eLPxpElFgO54L34O1ttnlAc4h9I4zD5b7WHo6zlZjLsrbxj+KS5
         0xy5vrxGC9H2T7ge8qPxn6afVacgbTWxUb66mQWv7gcieDcKdYK5KFnmallOQmUsbK2k
         v138ResE99qe6jyGy9YapweyVebDBoEeUJi/LRGZL1EQhbNCSQA7TCWSYawc559eJZf0
         vs+VgB/WD0G6mA87J51L3PEFL7YZtkvma4swJ/+Qx3iXr0Gw9QDoy3kABDLidrq6HVR/
         8PMw==
X-Gm-Message-State: AA+aEWakxaJvgKdbEiwSvllPGFkpwYUCZ0pOBDxqCwPhSXA0675Xf3qG
        eN3jJUxeeOwnNNJaaEBXCl0=
X-Google-Smtp-Source: AFSGD/WPKP9EwV7mgUPswdmTnZ/p9ZUXvxPh//ONYoFv4vEcYWNXrkYvK+djKp7j161fe6hg7fdeHA==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr2053223ljb.52.1545158924158;
        Tue, 18 Dec 2018 10:48:44 -0800 (PST)
Received: from [192.168.0.20] (169-62-132-95.pool.ukrtel.net. [95.132.62.169])
        by smtp.googlemail.com with ESMTPSA id x21sm3340563lfe.6.2018.12.18.10.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:48:43 -0800 (PST)
Subject: Re: [Xen-devel][PATCH v2 2/3] drm/xen-front: Use Xen common shared
 buffer implementation
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        jgross@suse.com
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20181130074205.20496-1-andr2000@gmail.com>
 <20181130074205.20496-2-andr2000@gmail.com>
 <75f3a715-94a0-a21d-04c1-aa3cf4cdb331@tronnes.org>
 <0f699d62-41be-33ec-d62c-6fce10f8fd30@oracle.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <ee6401d6-0e36-11f0-785a-ef0e26e2f60b@gmail.com>
Date:   Tue, 18 Dec 2018 20:48:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0f699d62-41be-33ec-d62c-6fce10f8fd30@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/18/18 20:31, Boris Ostrovsky wrote:
> On 12/18/18 11:15 AM, Noralf Trønnes wrote:
>> Den 30.11.2018 08.42, skrev Oleksandr Andrushchenko:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> Use page directory based shared buffer implementation
>>> now available as common code for Xen frontend drivers.
>>>
>>> Remove flushing of shared buffer on page flip as this
>>> workaround needs a proper fix.
>>>
>>> Signed-off-by: Oleksandr Andrushchenko
>>> <oleksandr_andrushchenko@epam.com>
>>> ---
>> Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
Thank you, Noralf!
>
> Now that all 3 have been acked/reviewed
>
> Applied to for-linus-4.21
Thank you, Boris, Juergen!
>
