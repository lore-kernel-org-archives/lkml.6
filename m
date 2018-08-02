Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D386C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA380214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="BsoZgYsT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DmLYi6xA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA380214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbeHCBRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:17:36 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45878 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbeHCBRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:17:36 -0400
Received: by mail-yw1-f68.google.com with SMTP id 139-v6so292434ywg.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 16:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Bvup6mi8wiRtBQX5KgGj1+gKm5P9xft8H4Pwsbm6lBs=;
        b=BsoZgYsTUUFqqw5meFnPF+fx9O00JSTxZXDC2rqF5aJOfMSKE+/4I05h1BxcyX4ctJ
         hVS57VqsnnveIR8hJLlxlUHNd8OLV7I+M/EZzRRi7gFei8QP73bPl6X4nbTi7Os02kvP
         oxrhV5p7y6yr0/CyJ+F/n8MpzP7UCY25vTJU/xHMeQNSqJhId/p6hvW4nCsAnRLg92Rf
         abqlxY2zgnquS7uBt5sORHJo84/F6Dbyf5aRWHXpTxAVFGMF+9pOdC/D7HZ2nNGxc5Ed
         nhMzqV+Kc6nfyjJBmf/1OeLUcFwwjtQ11IjjhD8GvOHM/8W2ZQPJPlfGc5dErUVCXPuv
         N2jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Bvup6mi8wiRtBQX5KgGj1+gKm5P9xft8H4Pwsbm6lBs=;
        b=DmLYi6xAUGTv3MpdNHp1cOSm1Nd8LlNXC5gY9QXxHGiWQhJvDQDCiH5hFcFIYTaDRV
         xeurzso7GdGDAgB4tn9bwTkxZtshr/GoyeqeYwUWRBH1SryLO56NWhE0WsXPUPTLZemd
         u7nMiOk5+gLequ2ok8PonwM7O9f3KFx9XKO78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Bvup6mi8wiRtBQX5KgGj1+gKm5P9xft8H4Pwsbm6lBs=;
        b=FBiKQvoeoTUE33OtrrEYHNDV0NTtvlA6Pem+sCAOo0LYNea0VLFQx9f1eoPUi98IND
         KBAFrJlvVk3njh0tgIiyfARk5hEP0IvxVt2BVkV4g0Q6kTroruiOGgs4pmONjxBYXukN
         w+AMoVlfMPlra4RF9U98bLOARhn8pElPtnfx32APrpiFAUWhXtZByOLTtdNgkigI3lWW
         zZyva46wH/7E/y9S1eXQ+hv6tME1TxHp08/W6VSfBn0B7waunrhv1H/DnoZN4UtkY314
         baysHZYGGaOWwcajdqU2MbvivwFrDcK1OfQ4nLa+3+Bzrxwc0S72cX8DqolSQI4j60TQ
         USLg==
X-Gm-Message-State: AOUpUlFST1LHRtEjgb2VDNV3AZX/yhMjD09C4As7/PBhtab+P+0N1qtL
        6ZDGUtpQdLciRufWKq5ZHbr1qjCIYKZoYTOJ+jA6bw==
X-Google-Smtp-Source: AAOMgpcsNF4vMvElV/Y0F2+2yeNpsRd+oTigF0CPPPm6wRsPz7dRepZs6RTZufWnYo76BkvX0TzLg7R56PqalmWbtNQ=
X-Received: by 2002:a0d:f002:: with SMTP id z2-v6mr945766ywe.116.1533252252924;
 Thu, 02 Aug 2018 16:24:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 16:24:12 -0700 (PDT)
In-Reply-To: <20180629212047.GH24526@jcrouse-lnx.qualcomm.com>
References: <20180629184818.GA37439@beast> <20180629212047.GH24526@jcrouse-lnx.qualcomm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 2 Aug 2018 16:24:12 -0700
X-Google-Sender-Auth: g9iaRaNirCMtVUTJA-XsEdmgtmY
Message-ID: <CAGXu5jJ+mZyqq0WoNNuw96X9ukOuaHaEqX4PJL31PuSecZZDwQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: Remove VLA usage
To:     Rob Clark <robdclark@gmail.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 2:20 PM, Jordan Crouse <jcrouse@codeaurora.org> wrote:
> On Fri, Jun 29, 2018 at 11:48:18AM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> switches to using a kasprintf()ed buffer. Return paths are updated
>> to free the allocation.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Thanks for doing this.
>
> Acked-by: Jordan Crouse <jcrouse@codeaurora.org>

Hi Rob,

Is this something you can take via your tree?

Thanks,

-Kees

-- 
Kees Cook
Pixel Security
