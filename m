Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8C18AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 05:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BACA2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 05:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiwV4p2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BACA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934215AbeFMFtg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 01:49:36 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35882 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933618AbeFMFte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 01:49:34 -0400
Received: by mail-lf0-f67.google.com with SMTP id u4-v6so1974645lff.3;
        Tue, 12 Jun 2018 22:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dMg97XHZ99jbMTtTQjVWryV4C0IY974/6XkKr/tNDcc=;
        b=EiwV4p2mOTAK+WK1W7fHVz9I7kS/HxAy/V6JElzf9CTztgE+lRQxkSE6HFP9AoPiFL
         /E010DJ2HRb8RcH5VAfQWtOLR7RwU6kEUyVR1Y2HkNcRvGUMLXR+tRtQXkz/pObc9fr4
         PLzdA6Av/d4vjzTNKco5XG8jReNG2I2lOGrVVE4c8Bg9H+ctL7ra6siOrZYdwDJqLpki
         eqPUnuRbO0PQ9uGzJiYrERK6//scIoimxivgcsJoz21oLbmcGrzO24/UskQA4lf+qtSA
         oxj7EIvMEqcwyAHAcWqZDYVNglcFKy9iu6926KLwsBTH69Xb15Cri1zxEXqFhGpvFZPI
         wKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dMg97XHZ99jbMTtTQjVWryV4C0IY974/6XkKr/tNDcc=;
        b=jpu9Rxav1gzuqZ7Mij61ip6aXmGGhX3z+YF2LlMbdwrCQZOaD6ZnLUtJZuSKmhUpUQ
         Q5aRUxMrfaU9N7AhHqvyzo3TkQ/l5fX9YpRk5z4abTjQUVApZNxWZpo/xRb+HfXcSU2d
         Cpggxu5Ap+L6CMbGN10ysBPzHMzkDSfeLEO89vu4poooDLKoWe3JxPzq7UkLqo/RMqQV
         78o3IsQH6HNxutHMNqKYaaLLS4zhzLZp6vPCUyjKT15gtCdfexipsXcTGqEY3L8L+jsZ
         PU7u/GtohxF4Q5syYPPWyLMdml9AEBd9LzhDxBPwoL9/il0AYXG3N3lAFBfJFtX5dMvw
         km6w==
X-Gm-Message-State: APt69E1uw99ZX0OOvwYLmU1uYowFP6aPowEbDZsOJeWAIJV9o5csZsDI
        0sqoq1L5e18/0jTH2VCfNPE=
X-Google-Smtp-Source: ADUXVKIdhHjzP47cvKiDtmG6NOmE3ksqZ3PaUU4u5iIjQcUCWsGmhoglRcLmIP5a2eFOMFmJGJDlCw==
X-Received: by 2002:a19:b203:: with SMTP id b3-v6mr1871762lff.84.1528868972831;
        Tue, 12 Jun 2018 22:49:32 -0700 (PDT)
Received: from [10.17.182.9] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id a67-v6sm386486lfa.48.2018.06.12.22.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 22:49:32 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] xen: Sync up with the canonical protocol
 definitions in Xen
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, lyan@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180612074856.28451-1-andr2000@gmail.com>
 <20180612074856.28451-2-andr2000@gmail.com>
 <9c579567-ebe2-f465-5443-b3a3e71d34a5@suse.com>
 <20180612234020.GI38773@dtor-ws>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <3605901d-4a72-3f5a-6d74-cb13d2414a0b@gmail.com>
Date:   Wed, 13 Jun 2018 08:49:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612234020.GI38773@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 02:40 AM, Dmitry Torokhov wrote:
> On Tue, Jun 12, 2018 at 03:46:10PM +0200, Juergen Gross wrote:
>> On 12/06/18 09:48, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> This is the sync up with the canonical definitions of the input,
>>> sound and display protocols in Xen.
>>>
>>> Changes to kbdif:
>>> 1. Add missing string constants for {feature|request}-raw-pointer
>>>     to align with the rest of the interface file.
>>>
>>> 2. Add new XenStore feature fields, so it is possible to individually
>>>     control set of exposed virtual devices for each guest OS:
>>>       - set feature-disable-keyboard to 1 if no keyboard device needs
>>>         to be created
>>>       - set feature-disable-pointer to 1 if no pointer device needs
>>>         to be created
>>>
>>> 3. Move multi-touch device parameters to backend nodes: these are
>>>      described as a part of frontend's XenBus configuration nodes
>>>      while they belong to backend's configuration. Fix this by moving
>>>      the parameters to the proper section.
>>>
>>> Unique-id field:
>>> 1. Add unique-id XenBus entry for virtual input and display.
>>>
>>> 2. Change type of unique-id field to string for sndif to align with
>>> display and input protocols.
>>>
>>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Reviewed-by: Juergen Gross <jgross@suse.com>
>>
>> I'm fine with this patch being added via the input tree with the other
>> patches. In case I should take it via the Xen tree, please send me a
>> note.
> Juergen,
>
> I created an immutable branch off v4.17 with these 3 patches in case you
> would want to merge them into your tree without waiting for them to
> appear in mainline:
>
> git pull git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git ib/4.17-xen-kbdfront-runtime-config
>
> Thanks.
>
Thank you,
I would prefer the fastest path of course
