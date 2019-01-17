Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538F720855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DXn+8lMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfAQTkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:40:24 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34047 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfAQTkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:40:23 -0500
Received: by mail-ua1-f65.google.com with SMTP id c24so3901714uak.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 11:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyUCyCnHBmSBfMUjqgdfF7JKmw7FO8Zu5HTtKTOIlAc=;
        b=DXn+8lMr7ZyqZ1mNa2UzpSkDvP1lAmIq959QGxufJw8urRV5KGiUOdkGLRcR9n6V86
         /3CJT5OATJyt2lgt+CWLMsQ51Lhnjx0/o4iQ9Zg/+/Gg/2jkRfpcui7jaLkrs7+sKQiP
         q/b/tttwbPFz4emiQDosx2FWZqVGfLQza2Db0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyUCyCnHBmSBfMUjqgdfF7JKmw7FO8Zu5HTtKTOIlAc=;
        b=HaHIbCcdfIxY7sK4B2vm/cAC8e3e9jE1OqK+7BSMvjjNut8rqNqHS/db7HT0Dj/Vu7
         OE+hU/pRyIe7T0aiIaDTD79A1B/UII1rlCyJdPjAMecHfj+oibpRZtKcjGoIdax+jt10
         /1+vJ+ot0aL/a8GFBU4Sq8YAjgqYcxb9/CwxivNksTX0qph2ygxEWtVvjroTsSCgn+kx
         Bryvd5+j9k5AgdN3ZREwolHBks4iDMSl0tw+Uz1RBrNUwBYQ12Ua1zXUqj5Km1B7yN4n
         hjXvdEzBfb7H1nu2I9Z9FbmB/X1ogjLInhwTtOjnQdD+7j9+9fnootR2SQowLbI25kKt
         Altw==
X-Gm-Message-State: AJcUukdM+bAiOcDrpxg/amgHYviFCKNHbEPtmJsipMcN8AYWwaQCnKUe
        Jvg8h8KSINyIxskKN18NyUUWQD626+o=
X-Google-Smtp-Source: ALg8bN6KdGYEWav+uEqDdGmf2EeGmhr73SWqQbewLnwdNO4eHjuMwegpFgebEbGdzJL5f4yfX8HLgQ==
X-Received: by 2002:ab0:3402:: with SMTP id z2mr6352404uap.6.1547754022795;
        Thu, 17 Jan 2019 11:40:22 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id d7sm21299435vke.12.2019.01.17.11.40.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 11:40:22 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id y27so6998923vsi.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 11:40:21 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr6210138vsv.20.1547754021603;
 Thu, 17 Jan 2019 11:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20190117192955.16515-1-bjorn.andersson@linaro.org>
In-Reply-To: <20190117192955.16515-1-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Jan 2019 11:40:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WyR3g=uhPtOnr6bx6RkktsRMKt4V9KfoHxJiMOVb4dQQ@mail.gmail.com>
Message-ID: <CAD=FV=WyR3g=uhPtOnr6bx6RkktsRMKt4V9KfoHxJiMOVb4dQQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Fix lpasscc reg
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Thu, Jan 17, 2019 at 11:30 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Fix up the lpasscc address and size, missed during the conversion to
> address- and size-cells of 2.
>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> This goes ontop of my pull request to Andy available until it's picked up at:
> https://github.com/andersson/kernel/commits/for-andy/arm64-for-5.1
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks fine.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
