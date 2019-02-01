Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE17C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DBC21917
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YeYygnQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfBAKww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:52:52 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49506 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbfBAKww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:52:52 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190201105250euoutp018689ac077afe180b8320dbcee4a9426c~-OABId0E82864528645euoutp019
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 10:52:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190201105250euoutp018689ac077afe180b8320dbcee4a9426c~-OABId0E82864528645euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549018370;
        bh=oxiHxLeSnX8glUpUS5lX2lchiOhys+WWc1HeM1KrBUc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YeYygnQvOfpAsgvZrQ4Xm803HHFuP/2gzD2pL/MrmKRuZaXyx9YnWR/Xfq3N2/wly
         aj7jC0fBeAyQ0QxpdlLq1HGhX4zP25B848p1v5c0XK42EzKw0XxefIY4Da7mn2FcnU
         zH2VNLMEfrHZ2xYnVeuI8gds/pah/KlmeP9k79fw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190201105249eucas1p2db685aee4e7158135ded89a6d0af90c5~-OAAc3ehg0527505275eucas1p2K;
        Fri,  1 Feb 2019 10:52:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 40.DA.04441.105245C5; Fri,  1
        Feb 2019 10:52:49 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190201105248eucas1p1dbce88efd5483701cd36cc95b7d6891e~-N--fxfyk0372403724eucas1p1D;
        Fri,  1 Feb 2019 10:52:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190201105248eusmtrp23417df602f98cedd9ae7d9b921a9be51~-N--RL7NL0927609276eusmtrp2Q;
        Fri,  1 Feb 2019 10:52:48 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-a2-5c542501900b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9C.29.04128.005245C5; Fri,  1
        Feb 2019 10:52:48 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190201105248eusmtip23c031219a9b52700566c7625644b00d8~-N-_1jZj93191231912eusmtip2U;
        Fri,  1 Feb 2019 10:52:48 +0000 (GMT)
Subject: Re: [PATCH v1 0/19] drm/panel: drmP.h removal and DRM_DEV*
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Stefan Mavrodiev <stefan@olimex.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <65d0b3cc-9d6b-737b-ded6-25d4174c16a8@samsung.com>
Date:   Fri, 1 Feb 2019 11:52:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87tvhnyf65.fsf@intel.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj2O2c7OxOnxzn1xSJxmJaUFwpbGJIUtH4UKRZRVk49THFe2Ly0
        LLISFUMKBS9DU7xNJVosL21GgUpzmJulSSqi1SQzZ5GZKF7yeJT893zP5XvfB14SF3Zxvcik
        1AxamSpTiAlHTsfbZcthtD86Jnhp3U9SbDFjkuHFn4REO6RDkiFjFSFpXm5HkonSXiRZn8jD
        JMvGJ5yTpNSgmeBJO/9OcaVPzJHSyYcmTLpiDZWajGM8aUPZR0K6oN93gbzieCKBViRl0cqg
        8FjHxKpWK5Fe53Wz5d4gNxctiYoQnwTqKJSszuJFyJEUUs0INjqsOCMIqT8IRl+fY4UFBHNj
        udydRPUvzXZCi6C4pZTDPuwIvrc1bbpI0o06BTUd3kxAROWARW9FjAenWhAUlU3zGIGgDsLa
        i1GCwQIqHOZ7bRiT5VC+ULAQydDu1GXoKZ5HrMUVzJU2DoP5lD+sTa9ufYNT3tBpr8JZ7Alj
        thqMmQWUhQctz+oJduvTUP+tkcdiN5g1tW3jvbBhYAIMvgv3K4dxNlyIoK9eux0Ogx7T+61i
        +ObSOmMQS0fAgzezWzRQzvDJ7sru4AwlHeU4SwugMF/Iun1gcqAdZ7EnNA4uEo+RWLOrmWZX
        G82uNpr/c2sRpxV50pmqFDmtCkmlswNVshRVZqo8MD4tRY82T6p/3fT7JVr8ENeNKBKJnQTP
        V6JihFxZlkqd0o2AxMUiQa1XdIxQkCBT36KVaTeUmQpa1Y32kByxpyDHYeqqkJLLMuhkmk6n
        lTsqRvK9cpGfy1lbub+7Xl5hq5k1JD/ynZm/k/5ZN+dRHXrpfOygVXTdY6SpqLXPfCZuReEd
        H0gvJR8JU2ANM33X+t3iDpWWm5u1Dl0F40762qcVNRE//ErfGW/rggOcv2AlrwxRx3R5ZN0I
        NtE1IKoL0y1+VWYfcAlVq/n54zqf8eP2iw1ijipRFhKAK1Wyf5V+BElOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7oMqiExBlemq1n0njvJZHHl63s2
        i+WX1zNaXN41h81ixc+tjBZ3Jx9htPh3t4XJ4ueueSwOHB47Z91l99j+7QGrx7yTgR73u48z
        efw6b+ZxfNctdo8l066yeXzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5r
        ZWSqpG9nk5Kak1mWWqRvl6CXMWfVebaCRVIVKxsvsDYwfhfpYuTkkBAwkZj7YRZzFyMXh5DA
        UkaJTbuOskAkxCV2z3/LDGELS/y51sUGUfSaUWLCpW/sXYwcHMICzhLzt8mD1IgIVEuc2/Kf
        FaSGWWAlo8SMmdeYIBr2MUksuTiVHaSKTUBT4u/mm2wgNq+AncS7I0+YQAaxCKhItH8OBAmL
        CkRIfHy6jwmiRFDi5MwnYAdxCqhL/H36B2wMM5D9Z94lZghbXmL72zlQtrjErSfzmSYwCs1C
        0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERiZ24793LKDsetd8CFG
        AQ5GJR7eDb+CYoRYE8uKK3MPMUpwMCuJ8C6QCokR4k1JrKxKLcqPLyrNSS0+xGgK9NtEZinR
        5Hxg0sgriTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2aWpBaBNPHxMEp1cBofpEzXp9D
        qkFji/yLXGONoudiO9zzNYPOagcInFhvv7C4P/ZmWXWTlEcfi/Han/MY6h6aNbk0NolEnd+Y
        denOqpTrUirxgfN+JEtXzL/G2lGn/nWrytpdgRaKhn+7FXQ19oU/S1z24u5SLU4mWYMdPsUq
        WUv284h5T9nT8y7ptFF/d2D9XyWW4oxEQy3mouJEAE45lp/iAgAA
X-CMS-MailID: 20190201105248eucas1p1dbce88efd5483701cd36cc95b7d6891e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190201102927epcas3p49ed77662feb619ac5977cccbbd98eac8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201102927epcas3p49ed77662feb619ac5977cccbbd98eac8
References: <20190131192619.9763-1-sam@ravnborg.org>
        <20190131200723.GZ114153@art_vandelay> <20190131210312.GA8947@ravnborg.org>
        <20190131215417.GA13156@mithrandir> <20190201092037.GA9251@ravnborg.org>
        <CGME20190201102927epcas3p49ed77662feb619ac5977cccbbd98eac8@epcas3p4.samsung.com>
        <87tvhnyf65.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.2019 11:30, Jani Nikula wrote:
> On Fri, 01 Feb 2019, Sam Ravnborg <sam@ravnborg.org> wrote:
>> Hi Thierry.
>>
>>> I personally like the DRM_DEV_* variants better because of the
>>> additional information that they provide. That can be useful when
>>> grepping logs etc.
>>>
>>> I'm slightly on the fence about this patch. The unwritten, and
>>> admittedly fuzzy, rules that I've been using so far are that dev_*() are
>>> used or messages that have to do with the panel device itself, whereas
>>> DRM_* variants are used for things that are actually related to DRM. So
>>> typically this would mean that roughly everything in ->probe() or
>>> ->remove() would be dev_*(), while the rest would be DRM_DEV_*().
>> For a rookie like me it is much simpler if one can use the same
>> logging primitives all over or at least the rules when to use what is simple.
>> It is simple to say that everything that exists below drivers/gpu/drm/
>> relates to drm.
>>
>> Suggested set of rules to follow:
>> - If in drm core, use DRM_XXX where XXX represent the core functionality
>> - If in a driver use DRM_DEV* if a struct device is available
>> - If in a driver and no struct device, use plain DRM_ERROR/INFO
> Core and drivers are already pretty conflated:
>
> http://patchwork.freedesktop.org/patch/msgid/20181227162310.13023-1-jani.nikula@intel.com
>
> ---
>
> Side note, I'd like to switch i915 to dev based debugs, but I absolutely
> hate the idea of changing:
>
> 	DRM_DEBUG_KMS("...")
>
> to:
>
> 	DRM_DEV_DEBUG_KMS(dev_priv->drm.dev, "...")
>
> I think the dev based macros are way too long, and would serve *most*
> (though not all) drivers better by having struct drm_device * rather
> than struct device * as the first param. In the above, just the
> boilerplate consumes half the line.
>
> Basically I'd like to see drm_ prefixed analogues to all the dev_ based
> logging functions, e.g. drm_dbg that takes drm_device. But it's so much
> churn that I'm contemplating just making i915 specific wrappers
> instead. :(


Does it means I am the only one who is not convinced to use all these
DRM_DEV helpers.

For me classic dev_(err|...) looks fine, if we really want to emphasize
that logs comes from DRM dev_* allows format modification, sth like this:

#define dev_fmt(fmt) "DRM: %s:%d: " fmt, __func__, __LINE__

but it is still something I do not see very helpful.


In general I think we have too many alternatives/flavours and developers
do not know what to choose, current usage of all these DRM_* shows it
clearly.


Regards

Andrzej



>
> BR,
> Jani.
>
>
>
>
>> If there is a need to distingush before/after one has a drm_device,
>> the best way would be to have a set of logging primitives that
>> take a drm_device. So we could extend the rule set:
>> - If in a driver use DRM_DRM* if a struct drm_device is available
>>   (This rule would take precedence over a struct device)
>>
>> DRM_DRM*, or DRM_DDEV* or ... But you get the idea.
>>
>> But this is not where we are today.
>>
>> Shall I redo the patch-set so we go back to dev_*() in probe() / remove()?
>>
>> 	Sam
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel


