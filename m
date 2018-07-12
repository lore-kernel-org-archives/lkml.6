Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B96C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D88F213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFXV52nL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D88F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbeGLMHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:07:18 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36095 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeGLMHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:07:18 -0400
Received: by mail-lf0-f66.google.com with SMTP id b22-v6so11589411lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hH68eWHM1PmXzpkV09JL5fqbHGV1gdGbXz40n6wgnFU=;
        b=jFXV52nLm98WOB9k1fSIet835hE4dHpv0QA6YtD7mLbQatpNHVvNltBIJXbJBqsYtg
         0Cwy+J/dSuustAwuIgc7YEK2c0ubuNskeYQ0GuFnCeWEaAqsV+LEPqnbH8q2jFqOAfXu
         2I21SS0v05sXN2I0LBRhcwvUmoGNyQ9dOW9oPZFtxcHc4+TMXMKBtOV+hx5pR/P8Frcw
         1OUqY0H6+jAnt+xTIg+1PhnoluF1yvMHW+6J0LStDoC3St6pMOS4xW6A3wY/xjHOVXEi
         2g1ArjEW3hq7kStBA+1ldsYg7PkBKdShRCXR+jZvfNVUsISjAoL+UbYV+AM1ReAG73UV
         XOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hH68eWHM1PmXzpkV09JL5fqbHGV1gdGbXz40n6wgnFU=;
        b=q65DowMZ/b3Orscl3roqH3aS3OKa4TwDnLogXFw+ci3ALXIQAHVnUlhu4asUS2WMrn
         mbEVW87YtDY+30xXMDKXlo0XFsTCAxTtt723/gZz28y++o//rGxl1zzea2eq8tGSzOdh
         oVGzYG11rn92LhEUwwsZXHOZpsLMSG1qFFGwzrh9iiUudf0H37Yu5l1qwHUXZXnUU3Jz
         ZiwpGKo6furT6e+mv+SHt+xfWSuo0pwvp00nkO14AXLuPO0q4edfXQTse3QrNLGYiQFf
         ZlX7vtMF0ZoKzEdlzSMhAAk3aQUQ9/j+ALpDO1lg2pfl3S8SVQGCubKrSopNwBvsh6HD
         EkxA==
X-Gm-Message-State: AOUpUlHKArfwJ+JJIapl2k9zL3WN9hJ64Pl7lcEsbfcTEZRPV4n75Qtp
        xUvUXGvZaPQq7ol5OQrfM2M=
X-Google-Smtp-Source: AAOMgpeDFH0b4eMw4+32dxF9nOqePhdnuPv3wHRaSHCk0/rptejFR6yTygLYofTDyIvI6HZNUGyIKQ==
X-Received: by 2002:a19:385a:: with SMTP id d26-v6mr1739718lfj.47.1531396682548;
        Thu, 12 Jul 2018 04:58:02 -0700 (PDT)
Received: from [10.17.182.9] (ll-56.209.223.85.sovam.net.ua. [85.223.209.56])
        by smtp.gmail.com with ESMTPSA id u16-v6sm5241202lfi.12.2018.07.12.04.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 04:58:01 -0700 (PDT)
Subject: Re: [PATCH v2] drm: Replace NULL with error value in
 drm_prime_pages_to_sg
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, jgross@suse.com, boris.ostrovsky@oracle.com
References: <20180618060709.14290-1-andr2000@gmail.com>
 <20180618122951.v55dxtjg4azezjvg@mwanda>
 <a0b8ffa2-cf75-5a8c-7341-29855780fc00@epam.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <a9167704-e687-2688-18b8-f5e6320b1089@gmail.com>
Date:   Thu, 12 Jul 2018 14:58:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a0b8ffa2-cf75-5a8c-7341-29855780fc00@epam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 03:32 PM, Oleksandr Andrushchenko wrote:
> On 06/18/2018 03:29 PM, Dan Carpenter wrote:
>> On Mon, Jun 18, 2018 at 09:07:09AM +0300, Oleksandr Andrushchenko wrote:
>>> drivers/gpu/drm/drm_gem_cma_helper.c    | 2 +-
>>>   drivers/gpu/drm/xen/xen_drm_front_gem.c | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c 
>>> b/drivers/gpu/drm/drm_gem_cma_helper.c
>>> index 80a5115c3846..ce868ce288fb 100644
>>> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
>>> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
>>> @@ -436,7 +436,7 @@ struct sg_table 
>>> *drm_gem_cma_prime_get_sg_table(struct drm_gem_object *obj)
>>>         sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
>>>       if (!sgt)
>>> -        return NULL;
>>> +        return ERR_PTR(-ENOMEM);
>>>         ret = dma_get_sgtable(obj->dev->dev, sgt, cma_obj->vaddr,
>>>                     cma_obj->paddr, obj->size);
>>
>> If dma_get_sgtable() fails then we return NULL.
>>
>> Fix that and it should be good.
> You mean I can put your r-b with that fixed?
ping
>> regards,
>> dan carpenter
>>
>

