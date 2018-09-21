Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069C8ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC0A21565
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW0DNZVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC0A21565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390762AbeIUWfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:35:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33234 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUWfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:35:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id n11-v6so2273383wro.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 09:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SmbhsBgxxW9BD9P6dVyJl5no64zYUUwrHWVdYMgOj8o=;
        b=LW0DNZVZNah35JYrhDSTLQ0kqReDAZWslBdb0Bhif83UFc++kQ520SJ+50J6tUZ4OB
         mRo0ssG8vYzGwAVDS43+hoWzK3rzW5wUGkn04MN0iMVHIIzU5ywxrW/E8UIAM6Uosnsl
         K/xdaNHGQszkseesVM+Yfw2DjJzuGnEDA+OfKMnr+2DrQw0tvOZat1pX78ShaDiKsUqz
         TXunlMKZh2Q86GOIPcxgeuB2ruIPq/SG9sGsMMdaIYRVykexVEKFyuyYFcFzITzTZK+r
         h7sDDFAlXHXlBT/RwOOiZwBNmI5gLxhHOOx5zA4UkKZYIMprWQNGeUrYlXOExRsWiRsr
         0yfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SmbhsBgxxW9BD9P6dVyJl5no64zYUUwrHWVdYMgOj8o=;
        b=XWjN+DfFb/aotLXLlusJ062qnLp+5r/XrSHzIX7VGnCyhUk1foPGhkwiuQNyEUf3zJ
         k8Wo/P0qkiPxhSKELy9SsNPGIY0pdJTGWJFVppbIQAK+Iqhyeh6Myxa5u6aQlZMHteAA
         rnakzUZ+YYzFaRbloTZRMex3F875tbtsFq2MTtQgaIC/XRpKt6kCkImWdiYegBWOwriQ
         jeUKqHsPrrdG35EbWKSSjYDNC0X062synayq5/FJfU6u4J+mMhIKkH2Qpx52OCwcHILZ
         NzimqWbDqfg3PMLNcA5O785/yUBZMEtz1ahedsU7hK3LXM3RDmxgt6F0o/T/0zBm6Z2Y
         swAg==
X-Gm-Message-State: APzg51C2aWaMsUANpz8TvcXu5VMPrpc5zYkG04NvYmZ8VwBKRIFV8Skd
        zWOYPtiBCNKmMatxSm5tEndpR9H8Rq19GlJsdvo=
X-Google-Smtp-Source: ANB0VdbJO0MFJsP5Papv/vxOXTwx5pyq997kSv2xmwbE9LC+Q6i8DU8+yARb+tqH6LmyrAcDDozJE3NP+hwMOQqsO00=
X-Received: by 2002:adf:9404:: with SMTP id 4-v6mr41004574wrq.129.1537548336808;
 Fri, 21 Sep 2018 09:45:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:2d8e:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 09:45:36
 -0700 (PDT)
In-Reply-To: <1537545617-3710-1-git-send-email-ayan.halder@arm.com>
References: <1537545617-3710-1-git-send-email-ayan.halder@arm.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Fri, 21 Sep 2018 17:45:36 +0100
Message-ID: <CACvgo50BykaODmhQms3V-s2QsPHwAGWKmUaZqsoQiTRviBjoDQ@mail.gmail.com>
Subject: Re: [PATCH v2] libdrm: headers: Sync with drm-next
To:     Ayan Kumar Halder <ayan.halder@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        David Airlie <airlied@linux.ie>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        nd@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ayan,

On 21 September 2018 at 17:00, Ayan Kumar Halder <ayan.halder@arm.com> wrote:

>   radeon:
>     - Removed RADEON_TILING_R600_NO_SCANOUT
>
>   sis:
>     - Changed the data type of some structure members from 'int' to 'long'.
>
>   via:
>     - Removed inclusion of 'via_drmclient.h'.


These three need to be fixed properly. Having a look at the radeon
case - the define is used in mesa, so we should really add it to the
kernel copy.
Haven't looked closely at the rest.

Personally I'd omit touching those files for now. With that, the patch is
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

-Emil
