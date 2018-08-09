Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E5AC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EF021EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZSVKd9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EF021EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732597AbeHITEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:04:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36903 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732458AbeHITEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:04:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so3003975pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wjG0Q+HJhOgCtH1B42bgQh1hqetpp2hvzZqcY6UrI4=;
        b=MZSVKd9v9g0BE4VY/e4EO6cuwew4WiiTa9wrdfCQc1MpaGnjsKsVI+H8AVDeEPXqax
         L9ox+MPlkzxlxUpAq3Pjp2ZQHoiovdQpyOpgL2XfGdFpqDRwslAnpFOwtEAac6RJSzCI
         NuYYR7nkqK/XgYJV5/Oad9qiYKMZvxeqvOPTrg1F3g0haeAMUS86SqDObs6pGo0NxUKU
         Oj7Du988sXzZmkqfHMjbh1M2iA/zrQkmpUtiKkaQ42tuKmvJNn5CLsafGeHBcWV8Ad9j
         4k5UxkfC+T7gWqGIAWHGrVOeesPk7Ja5t5a9qzbI5j1S80IIqObwFg24aJfnPPYBVhiJ
         RXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wjG0Q+HJhOgCtH1B42bgQh1hqetpp2hvzZqcY6UrI4=;
        b=RwA+Sq6R3VCO5SrO2uL9Ouke7rQu2ptCJcp4bSwlrJsqIA02xvfh6FBekUKICr+NAD
         ve7iJ7QsstKJU8isAM1XNlthpG2XIz4XkT37iGKvogbah8NPxNIGz6I6kSeWthQAbglW
         5LoqTe6T+TvDi6TkLE1qiPF56q2E04swjylOUXBPiv6jBvuhVJEC15Az9+ApFxr8gBNK
         VQvLNyv1Zu0CIE+0E/SYGMLdoGxOHfh7iAQn31WuWTld7HbcjVd0DfsgRmyN4pLoOm9q
         d5dyS1az2iCxyNeWJWMNU9pUBVgmuPbCLYQDtPaaIrmnDj+CnpRi7M80+NRgJXa1OQfi
         mPxw==
X-Gm-Message-State: AOUpUlGf/S0IIDRNRuD/pva7nP0zJr+QD6X0Ic/1exuKXmtj5m2rCTzJ
        3OumGw27y7ShqR3pEqgZyMHf1v3pnyTXb3pot5MXbw==
X-Google-Smtp-Source: AA+uWPycTGIYWHBD8/8geg0utmtyAlDFeti4omElXemMIwbDuInLu1jqUWYTXK45CNhMJW7ampomHWwmYKsZbgm+Hd0=
X-Received: by 2002:a63:e914:: with SMTP id i20-v6mr2899867pgh.10.1533832733270;
 Thu, 09 Aug 2018 09:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180615223749.149073-1-ndesaulniers@google.com> <20180809095957.GA21639@ulmo>
In-Reply-To: <20180809095957.GA21639@ulmo>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 9 Aug 2018 09:38:42 -0700
Message-ID: <CAKwvOd=JdHFkbKFRCCTdb5qwk=gmbA41NngYGUYbGhVVwONP8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: simple: fix -Wliteral-conversion warning
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     airlied@linux.ie, Jagan Teki <jagannadh.teki@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 3:00 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Fri, Jun 15, 2018 at 03:37:49PM -0700, Nick Desaulniers wrote:
> > Fixes commit 8cfe83419cdb ("drm/panel: simple: Add
> > support for KEO TX31D200VM0BAA")
> >
> > drivers/gpu/drm/panel/panel-simple.c:1250:27: warning: implicit conversion from
> >       'double' to 'u32' (aka 'unsigned int') changes value from 33.5 to 33
> >       [-Wliteral-conversion]
> >         .vfront_porch = { 6, 21, 33.5 },
> >                         ~        ^~~~
> > drivers/gpu/drm/panel/panel-simple.c:1251:26: warning: implicit conversion from
> >       'double' to 'u32' (aka 'unsigned int') changes value from 33.5 to 33
> >       [-Wliteral-conversion]
> >         .vback_porch = { 6, 21, 33.5 },
> >                        ~        ^~~~
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Alternatively, should these be rounded up to 34?  I'm guessing the
> > current behaviour (truncation) is correct since that's how the patch was
> > operating.
>
> Looks like this is a duplicate of what was merged as:
>
> commit c9b6be7dc13e2f87592ee4c9812cb450dba484d5
> Author: Stefan Agner <stefan@agner.ch>
> Date:   Thu Apr 19 23:20:03 2018 +0200

Ah, cool.  I need to be better about checking maintainers' trees.

Just curious, how come a patch from April hasn't hit torvalds/linux yet?
-- 
Thanks,
~Nick Desaulniers
