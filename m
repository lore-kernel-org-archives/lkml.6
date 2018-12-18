Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8B3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7B22133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKYFJ2kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeLRIrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:47:49 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33834 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRIrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:47:48 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so11637898lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X5CgS7jUAiqJQf0ucb6eTHfTAfDJqLeoyLHou9DH4tQ=;
        b=AKYFJ2ktDm/b1RtSOi6pSPs/C4bUfHferMRzS6dJA6Oeq9zgyQtagTa6lmZHm7tm7k
         1qS5XGHVWVhlA+glk4CrixN03dLcaH9Ae1q+KaGuKNl9UKK2AvpBcWGMfPtbmRUbAddw
         Uw4W99bhBI4D/Mabd54gwDBfjPB+0PBr6/XrL4ctgsqgQs5ygr2pF4F3sm/wD7ivbxt+
         YDMY06icnlqn1IVj4qrHDmvbGP7meAkPEQl8m98WC7E/DMoI5HkoKCTuSeuFoGl8H1Co
         vG6ttKicQ8i9g5thGgOoM8KIUEpE/jg/UxzIvVmZkhfj2Wm++zRigh+nBhkE/dCPgmgd
         u/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X5CgS7jUAiqJQf0ucb6eTHfTAfDJqLeoyLHou9DH4tQ=;
        b=hB7R2brbEhLingDivhuu02LiGwACDJr3BixXU/pGs3opx0fO73ZwdbtHYJ3e2AY6Za
         USD28LutxwUdr7xCtmfv/6nWOZQul2xPEU6bNcYqn2I3cPxZSVZNTsSs1km0ZranH4Ux
         fVJYyZIG8QIrwSBNwFfTyv1jjrOWG7FnR+GoJvHu+aU/AXfhAVWO3WdbZrBYgU5OEo09
         0mICpKkp+IzbF2ufNecl3k++q6qg6Oy6Ood1sEXoYo4f/nYbAuZ5+hOFaCPNm/y6phYw
         ETC1GTTaM8DxKjWvPhTeez7N3HvhtkQP8l/4ApJVbw8UJaWFRwxYPP0x1I0amLe4YgOg
         3lAA==
X-Gm-Message-State: AA+aEWbL7SkJVtsw0+gsyJzsa7ia7IveTJamXjSJWlM2twbXHrmnsAxR
        cpfvcejVlBX3cpVi8SzsvaE=
X-Google-Smtp-Source: AFSGD/XvTx9Vtlgg/jx3a9i+4RRvg9qAeR8S5sFR/OvuN1uYQo/SVOK3fCxLyLdADCtrOAOEbxvQcw==
X-Received: by 2002:a19:c203:: with SMTP id l3mr8919627lfc.113.1545122865959;
        Tue, 18 Dec 2018 00:47:45 -0800 (PST)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id 12-v6sm2988175ljs.29.2018.12.18.00.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 00:47:45 -0800 (PST)
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
 <686a8b1e-3588-32bc-abc7-79221dc9c74e@gmail.com>
 <19501fdd-eae6-295e-7394-777c25ea4cf1@oracle.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <e8c0ae01-a75d-ac08-b7d9-9ef4e1abd641@gmail.com>
Date:   Tue, 18 Dec 2018 10:47:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <19501fdd-eae6-295e-7394-777c25ea4cf1@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/18 5:26 PM, Boris Ostrovsky wrote:
> On 12/17/18 10:03 AM, Oleksandr Andrushchenko wrote:
>> On 12/17/18 4:52 PM, Boris Ostrovsky wrote:
>>> On 12/17/18 5:19 AM, Oleksandr Andrushchenko wrote:
>>>> Hello, Juergen, Boris!
>>>>
>>>> As this DRM part of the series is the only one which needs ack/nack
>>>>
>>>> (and it might take quite some time to complete) could we please
>>>>
>>>> merge the patches 1 and 3 now that already have ack/r-b?
>>>>
>>>
>>> TBH I am not sure it makes sense to do this without the second patch.
>>> Refactoring (and IIUIC this series is purely refactoring --- is it not?)
>>> is done to reduce amount of code, and with only first and third patch we
>>> end up with quite a significant increase in the number of LoC. (I am
>>> going purely by diffstat)
>>>
>>> Of course, the other reason for refactoring is to eliminate code
>>> duplication, but without second patch that will not happen.
>> Agree, but this is the basis for the new pv camera frontend
>>
>> I am working on now [1], so even if we do not remove the code from DRM
>>
>> then we at least do not add it to the camera driver
>
> Since 1 and 3 are already ACKed you should be able to start the camera
> series with these two patches as pre-requisites even if patch 2 is still
> stalled by the time your camera code is posted (which I assume will be
> 4.22 or later).
Agreed, maybe by that time DRM part will also get its r-b/ack
>
>
> -boris
>
>
>>> -boris
>> Thank you,
>>
>> Oleksandr
>>
>> [1]
>> https://github.com/andr2000/linux/blob/camera_front_v1/drivers/media/xen/Kconfig#L6
>>
