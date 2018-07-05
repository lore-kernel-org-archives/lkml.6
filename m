Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E585C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 04:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E5D24120
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 04:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO0WDhxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E5D24120
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbeGEEl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 00:41:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43616 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeGEEl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 00:41:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13-v6so5625254ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 21:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WPWu+bKpXywPMXqvS/nX5TDjBL6z6K5RAhDXzcCt6c8=;
        b=JO0WDhxQ1InQkxXXH7CV1KCmfSwZS2+1+ObuRVn3CGDPrLBGhSLY0aRwLx72SSyVpF
         S3VIejbd7MqDnuKpweJJfcBl/kBsHDyZseFwB0KJ77n3eEcoAA67jWE9UQKf7IlB5h6g
         I0tl2MtThDEIr6PIIfmTct2lrvSDRsqMwKcou5GlvCBiHv6HpjkBb8eOSUbSx3/nTNNN
         HMZ8yV8FAzfyU+CwaN677YAFHTSn+cBpYPNcXT2LnMVKmr0ssML/YAaLfkNzLAA7jWjd
         g5Q7AcoyKiMqvDApyB9kFu0Dg/U05AMOFjP9oWvalK5cQuSo7CRfcC5lGMOxEo5rRNSv
         Rydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WPWu+bKpXywPMXqvS/nX5TDjBL6z6K5RAhDXzcCt6c8=;
        b=bvYqBIjoskl0AWZ45Njqvr2OWYOPn9skB/zt3gGLz4OGtxKQ0eowpilvM7NHpuzbQs
         dzipGDkOrVRPxs9plg0z3LzJ0tqLp7Ekj/0kYRPBb4d+5ipvyuXkUO0eem3tekfBGlp/
         mHJT6UBTD9Gyx07YWusWe0ey512tWyOwth/D9EckA2T6vdfUawKeaRMnR1gBny9Nawmw
         hVHuqf69xyxqiIGpxi/WdRxzIZIpAVPw5l/gu/306jbglLY6V7AYDFynCTrjCSInrztw
         +UpgI2nO7yq8poj7BwiyKax/WIDwigzIlluLCwisVn2dGlpu3Ai5fG0gETUKsj2eOoec
         dT+g==
X-Gm-Message-State: APt69E0xkjORuv+diqClnj+0XKH2OrTExpZpY3T9YzAyVsrPPV2Y73vD
        ZEkDSoEIQaLMBk520Y057aJhgqcXEje03CRIiqE=
X-Google-Smtp-Source: AAOMgpdrRw4SUKp697kXRWIpHfDEFyzJedjVc+a4GUTi6UPyFwmlfK/TgyM050S1QsQPIDbZu0knORO8NWKyHBf2bsA=
X-Received: by 2002:a2e:740f:: with SMTP id p15-v6mr1327640ljc.130.1530765684648;
 Wed, 04 Jul 2018 21:41:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 21:41:23 -0700 (PDT)
In-Reply-To: <CAFqt6zYLPc=GzJBTTHH5MuUzer8aa7nwS6y8aPFn05hNXgoiEw@mail.gmail.com>
References: <20180522181357.GA31257@jordon-HP-15-Notebook-PC>
 <cf6ee7ab-5818-3309-5a0d-ba047d3f900c@ti.com> <CAFqt6zYLPc=GzJBTTHH5MuUzer8aa7nwS6y8aPFn05hNXgoiEw@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 5 Jul 2018 10:11:23 +0530
Message-ID: <CAFqt6zYBhzN1RWw1erXuo5x2zU6cq8akXLmfpYdLsvxAp+93OA@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: drm: omapdrm: Adding new typedef vm_fault_t
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 4:17 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Fri, Jun 8, 2018 at 11:47 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> Hi,
>>
>> On 22/05/18 21:13, Souptick Joarder wrote:
>>> Use new return type vm_fault_t for fault handler. For
>>> now, this is just documenting that the function returns
>>> a VM_FAULT value rather than an errno. Once all instances
>>> are converted, vm_fault_t will become a distinct type.
>>>
>>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>>
>>> Previously vm_insert_mixed() returns err which driver
>>> mapped into VM_FAULT_* type. Also return value of
>>> vm_insert_mixed() not handled correctly and 0 was
>>> returned inside fault_2d() as default. The new function
>>> vmf_insert_mixed() will replace this inefficiency by
>>> returning correct VM_FAULT_* type.
>>>
>>> vmf_error() is the newly introduce inline function
>>> in 4.17-rc6.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>>> ---
>>> v2: Fixed kbuild error by initialized ret
>>>     in fault_2d().
>>>
>>>  drivers/gpu/drm/omapdrm/omap_gem.c | 51 +++++++++++++++++---------------------
>>>  drivers/gpu/drm/omapdrm/omap_gem.h |  3 ++-
>>>  2 files changed, 25 insertions(+), 29 deletions(-)
>>
>> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>
>> It's too late to get this to 4.18 via my normal routes. If you have
>> other similar patches queued and Linus/maintainers are ok to merge this
>> late, feel free to queue this that way.
>>
>> Otherwise I can pick this up for my 4.19 patches.
>>
>
> 4.19 looks ok. In case, we have pushed this patch into 4.18-rc-x along
> with few others, will notify you.

Tomi, this patch can be merged in 4.19.
