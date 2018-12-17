Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9399C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E7920874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvJOy9y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbeLQPDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:03:50 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37738 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387831AbeLQPDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:03:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so9695388lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dN14FaNhOIxVXbKsJ6vs+2KaYqUA+chJtAj2u7CutYc=;
        b=LvJOy9y2Go7qYo1zQghvDl7WyeMx+2/VIo/MqiQDBKw1hDrMD9XLtLIXbWL7j3o/Mw
         7GhKPqdPuTGZHR878zB2AGGh74vWIBqETITG0YSF4A7SSMrfeTwvBM0FcQYzDbHJAEXn
         JrvapPkgKE3TRFfdItkQwbixQ/fDNDMvRHL//aISNV3DTlziiNdUFlH/2boRg5ZSRXIB
         PP9n889bLqGDDUsyTGJCRoaWIJIpCvNPxlv1YLEe1dt5bDuY21zc9waa2TlsDTxPb0OX
         ngCeDiiBydKa57xDw6k4/+VtVblXRc2PJTS+HlL66k+UnF85whsOZsiIlSeI2dJB/rYR
         /hNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dN14FaNhOIxVXbKsJ6vs+2KaYqUA+chJtAj2u7CutYc=;
        b=PcjzsefyswVrQgDcc9fIc0y03t2giyYzH421XcSHwd+2Dge1F642/tqU3puMeV0acX
         i2wrpbwIZusCLjpVFcb0O+OTN3YlG53XssIwCw5qY96jUXOUKY2zkANBDdNcl+HjYVAI
         Iax2S9aeZ//kxtXWEi788PWI1+Y4iWWgN5SpcGLmkQJA9CI1zSFJ1vXJb24v+p+ikAM1
         dSVvVZPK4SQ4hI4k6I1rnoesT1AA+x6Van0T83+0zqViPWHad1JsEN6Qfrkjlcy1qzfP
         4zLlncRKWTXU512b0NTrQyFn/wZHXTOb0euHJqzNpjVI0OagKdsvImKZFDxeNhXwOtKR
         ihpQ==
X-Gm-Message-State: AA+aEWa3uCGXLCZSBYehhR5fO/2gWznFWTphz1mbfTL17/Dv4f2G9zGG
        IPuDb0uB2D4ixMGmwxnkSGo=
X-Google-Smtp-Source: AFSGD/UO7EA0ArIDYylBWBkVOE7HHm+Xg1eTpQ/7LVyz1+qGBWwd2Hb5q7YxkbEAqEyPNvIxlMwB6A==
X-Received: by 2002:a19:9508:: with SMTP id x8mr7868719lfd.112.1545059025007;
        Mon, 17 Dec 2018 07:03:45 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id x204sm2705527lfa.5.2018.12.17.07.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 07:03:44 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH v2 2/3] drm/xen-front: Use Xen common shared
 buffer implementation
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>, jgross@suse.com
Cc:     alsa-devel@alsa-project.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xenproject.org
References: <20181130074205.20496-1-andr2000@gmail.com>
 <20181130074205.20496-2-andr2000@gmail.com>
 <3c69d924-11e1-7037-bfa5-276d22b245fe@gmail.com>
 <27491aa5-3548-4c39-13a2-132c738fae14@gmail.com>
 <71920419-f0ef-8489-35ff-ff8375cb7361@gmail.com>
 <ce52ec2e-1b22-8a2f-7f99-d90fcfdbfebd@oracle.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <686a8b1e-3588-32bc-abc7-79221dc9c74e@gmail.com>
Date:   Mon, 17 Dec 2018 17:03:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ce52ec2e-1b22-8a2f-7f99-d90fcfdbfebd@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/18 4:52 PM, Boris Ostrovsky wrote:
> On 12/17/18 5:19 AM, Oleksandr Andrushchenko wrote:
>> Hello, Juergen, Boris!
>>
>> As this DRM part of the series is the only one which needs ack/nack
>>
>> (and it might take quite some time to complete) could we please
>>
>> merge the patches 1 and 3 now that already have ack/r-b?
>>
>
>
> TBH I am not sure it makes sense to do this without the second patch.
> Refactoring (and IIUIC this series is purely refactoring --- is it not?)
> is done to reduce amount of code, and with only first and third patch we
> end up with quite a significant increase in the number of LoC. (I am
> going purely by diffstat)
>
> Of course, the other reason for refactoring is to eliminate code
> duplication, but without second patch that will not happen.

Agree, but this is the basis for the new pv camera frontend

I am working on now [1], so even if we do not remove the code from DRM

then we at least do not add it to the camera driver

> -boris

Thank you,

Oleksandr

[1] 
https://github.com/andr2000/linux/blob/camera_front_v1/drivers/media/xen/Kconfig#L6

