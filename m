Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9FBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF28206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kDQ28QEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfBVT1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:27:14 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35573 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVT1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:27:13 -0500
Received: by mail-it1-f193.google.com with SMTP id v72so4850744itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 11:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFGMjvNm3dSJncI1twNm9IeVFhElnEWmN/QP375Qlfo=;
        b=kDQ28QEiycP5fJraKtvWqkepqHFwJPug/JnT3JkDQIk9YaPifxmLNPD36hrEGse/zH
         T2wnIMVXvIG+cw8Wr+8GwD4NVAxeCeFHhbM6PZ9CoAv2loR7KWk2EQHCI7198ahNAhKX
         iuMxgrO5gP6Lh9xh7Oo/hP9HejQtti/7SEdSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFGMjvNm3dSJncI1twNm9IeVFhElnEWmN/QP375Qlfo=;
        b=YCuQP5gEWbsekUCupVW/06klf3hlp9RB0PJyFJzIy0XVOJlbH6CJX638cCOW+XyeLI
         cMOEz2ACYcWJLbtvg75WxRCqYhZ4h9TaCSpn0gztXxYcdjZeHiapkS/FWLb6zo4paSuw
         V2+MZk7DZuPZeeyCVmxF68K/53UuXE83NsFkSquORQhnfSEaI8IVGmTEMFnrpySoOHXO
         UarPFypqLULRkcbQl2O9xOl9F0xT2JY2OPQacLNpQ+iJe2m6uMD9rAHGcBQu9tWWwXOa
         3sZhpJxUMjUhFD+O/pLyfc7/tYT7qUC0WT603m0jBn3szOzIliDP5Lv1q3h6CW/l0i/n
         3n0g==
X-Gm-Message-State: AHQUAuZlqrpsBZUwFb2ed4Lis7XObvJ5Nt2XGiGAdQXXUZXlrYSWKSN9
        ddTQtu3QmXTogzTL56b3z8jNrAiHfQaZh6JIZYG54Q==
X-Google-Smtp-Source: AHgI3Ia/hbwrzcs7wSnL5+bKXUAAe9xNwNFFvbuH8TBFqRhVKCPLU6gyHIhF7/D+ypv+XBt9K12zcHhFqZB6PERhF6w=
X-Received: by 2002:a05:660c:252:: with SMTP id t18mr3324313itk.173.1550863632174;
 Fri, 22 Feb 2019 11:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20190212112744.2332-1-jagan@amarulasolutions.com>
In-Reply-To: <20190212112744.2332-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sat, 23 Feb 2019 00:56:57 +0530
Message-ID: <CAMty3ZCSAAYmMn6x2jTpUWtY94fhX8HRAOydedFjjWNfKQoJsg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: Add vendor prefix for techstar
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

On Tue, Feb 12, 2019 at 4:57 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Add vendor prefix for techstar, known as
> Shenzhen Techstar Electronics Co., Ltd. a known producer for LCD modules.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - rebase for master
>
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 7eae7a95ab2a..a5ad57eaee20 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -397,6 +397,7 @@ tcl Toby Churchill Ltd.
>  technexion     TechNexion
>  technologic    Technologic Systems
>  tempo  Tempo Semiconductor
> +techstar       Shenzhen Techstar Electronics Co., Ltd.
>  terasic        Terasic Inc.
>  thine  THine Electronics, Inc.
>  ti     Texas Instruments
> --

Can you apply this, the relevant driver is mainline already. [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=849b2e3ff9698226ab91e034d52cbb1da92a5b4c
