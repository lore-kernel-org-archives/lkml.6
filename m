Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5509C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6097624007
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mRT92MEX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g73WYbUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6097624007
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753963AbeGEPzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:55:07 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34087 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753625AbeGEPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:55:05 -0400
Received: by mail-yb0-f195.google.com with SMTP id e9-v6so3396087ybq.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=CQISnLtFFrcIGb0vlubPFmY0nXAf1cghUjelEs773PQ=;
        b=mRT92MEXG5r8EekniKNXwrohmmBlw5rm7UkdjcgBOyUsTDRlJFONcuHft/BZ8xRwud
         nAKXHzve+wP6QgFPAFQfMwvm7PriXqnS9D+EQlhsZ8vQwyr1prRbPq15T6v/VRwHE6nj
         BBHtUFvLLqc+HFioC9f1eBI7rTWtLDWbt9DXqU6Lw2CVbrYArbAa4760FC0k6gaeLFaI
         +JXnWD1/NyxXN+1hCL/dTcum3RBtHlV4P3freyPlylX1Y4w3tofdxuuRi5QNdCC4PseZ
         kC0idDnWMRRQ/gKVW4qwI6eOGUM8+GauAbqPvDM7iLZR4nd8tUQmI6Wh6crnUkTU8ciS
         Xo+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=CQISnLtFFrcIGb0vlubPFmY0nXAf1cghUjelEs773PQ=;
        b=g73WYbUTC/StUuV81aNyXgdAK8D0N/9Ba/N4xCfUrwvzi8vGLgGKrLa0TY4/xHC89k
         nSF6oqPQLHrSn1WceQGSLjEd4KJwHeKce/xH9jtSemoRbclPjMbgsNVf8o6Qqgw9TF8X
         rmyzbajKK2g0SEqNpTM9x2GEVmV0D/WeJQJQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=CQISnLtFFrcIGb0vlubPFmY0nXAf1cghUjelEs773PQ=;
        b=lV/FFQm/TYPOps66IyXaeNn9hqo7h5k4VmiHN1ehOlPM26OVjwm/JFeiw7wM9VtKW3
         feNPlCE4myYuBM6M6EIaV/1WPGOBQ/FV4eh7MvqM5rDMZXk4zAyVjTVKwWOW7+HJ/zIc
         fAcYZvY6/US6k/csskQWE+9Ky1/cgvRXmUtEhZTXzSzn7yTULxKHyfGHQqVx/SpbA+js
         zhDoqkx7U507nKZJXepIFQUWQL8+fj1Vgdq/YbgYi3XneFmk/6VT4XhyvE+5F3bivghu
         YEnet+pnWGxLVWP2FBCPk42fF9mH4fRTMxYJzdw4xsoq0DwIls8kNRSEXZY4sskrQGJ1
         U6iQ==
X-Gm-Message-State: APt69E2lhfayl0hjgaNQebCzHdBnc23S/sAe/utpJWt7KO9CmQXHKl6J
        Fmd2qHtdUrRUZr1LWPmd9cJIrjVPb5D6PVafh9/9Og==
X-Google-Smtp-Source: AAOMgpe3b4kJQ2rm7wGVUU09CSLgEtSB5T+q2VXg+4eT980A5sHQjjJSiVarhYkCoqf/HaurfsccQQGe71d6+Fk6HYI=
X-Received: by 2002:a25:ce8e:: with SMTP id x136-v6mr3362622ybe.118.1530806104795;
 Thu, 05 Jul 2018 08:55:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 08:55:04 -0700 (PDT)
In-Reply-To: <5a3b3ab7-f5b2-bd66-0587-569411f9af78@daenzer.net>
References: <20180704172730.GA33562@beast> <5a3b3ab7-f5b2-bd66-0587-569411f9af78@daenzer.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 5 Jul 2018 08:55:04 -0700
X-Google-Sender-Auth: 6iIWj1WVP0jdNAr75ZbAfBROGvw
Message-ID: <CAGXu5jLMG915BZjYE=+BmfcWknHOZ2n93YakdNBPPfb9P7pyEw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use 2-factor allocator calls
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tony Cheng <Tony.Cheng@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Vitaly Prosyak <vitaly.prosyak@amd.com>,
        Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 6:37 AM, Michel D=C3=A4nzer <michel@daenzer.net> wro=
te:
> On 2018-07-04 07:27 PM, Kees Cook wrote:
>> As already done treewide, switch from open-coded multiplication to
>> 2-factor allocation helper.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/d=
rivers/gpu/drm/amd/display/modules/color/color_gamma.c
>> index 98edaefa2b47..ee69c949bfbf 100644
>> --- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
>> +++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
>> @@ -1723,8 +1723,8 @@ bool  mod_color_calculate_curve(enum dc_transfer_f=
unc_predefined trans,
>>               kvfree(rgb_regamma);
>>       } else if (trans =3D=3D TRANSFER_FUNCTION_HLG ||
>>               trans =3D=3D TRANSFER_FUNCTION_HLG12) {
>> -             rgb_regamma =3D kvzalloc(sizeof(*rgb_regamma) *
>> -                                    (MAX_HW_POINTS + _EXTRA_POINTS),
>> +             rgb_regamma =3D kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
>> +                                    sizeof(*rgb_regamma),
>>                                      GFP_KERNEL);
>>               if (!rgb_regamma)
>>                       goto rgb_regamma_alloc_fail;
>> @@ -1802,8 +1802,8 @@ bool  mod_color_calculate_degamma_curve(enum dc_tr=
ansfer_func_predefined trans,
>>               kvfree(rgb_degamma);
>>       } else if (trans =3D=3D TRANSFER_FUNCTION_HLG ||
>>               trans =3D=3D TRANSFER_FUNCTION_HLG12) {
>> -             rgb_degamma =3D kvzalloc(sizeof(*rgb_degamma) *
>> -                                    (MAX_HW_POINTS + _EXTRA_POINTS),
>> +             rgb_degamma =3D kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
>> +                                    sizeof(*rgb_degamma),
>>                                      GFP_KERNEL);
>>               if (!rgb_degamma)
>>                       goto rgb_degamma_alloc_fail;
>>
>
> Since the values are constant, kvcalloc incurs the overflow checking
> overhead for no gain.

The way the macros are designed, they'll get entirely optimized away
in that case:
http://lkml.kernel.org/r/CAGXu5jLw9kMZRkzL_Q7JdyyprntHF6bdVSE_vjyzect3CenDn=
g@mail.gmail.com

Using this patch means if the code ever changes away from constants,
it'll still be safe. And static checkers won't yell about the
open-coded multiplication here. So it's only up-sides. :)

-Kees

--=20
Kees Cook
Pixel Security
