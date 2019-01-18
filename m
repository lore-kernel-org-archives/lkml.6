Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B4DC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA36A2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZPXu84Od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfARWDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:03:10 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:46383 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfARWDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:03:09 -0500
Received: by mail-vk1-f196.google.com with SMTP id j23so3403719vke.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3uJ1ajCk9Nsy9OEImebwkg45lCPRYKa5n+S7Qe9t7Q=;
        b=ZPXu84Od/F7wHXKrBWR29rC5cL9TwjbpbcDJlbcaCHKlDWEXs3re1+/+sLCOSuAWXh
         Xy6pNz+l3XxzbtoRa1rS9NAc/7WNGD7yKcxb/UuDMSIXPhdVKkkN1WlmL+VlVvshvOQt
         y0zSx3iiSbdF0PRGB51BZcsPUn92ivkWYiL7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3uJ1ajCk9Nsy9OEImebwkg45lCPRYKa5n+S7Qe9t7Q=;
        b=EL3+r05kHcdneDI/2xU0inuTg/ged5EoIWpAZ7XhT8vwswcMFc7ob4Hepq0q3po+7R
         rcPUdaVVeHEhoCNUmTTV665Jgi6Nk6ORrFbQLsX9LDUqddj/XlKxDZVJvHTwwWoPPjWn
         0O+VZu5viUjMKtxeKj1eY4MXgq7OtoU3uxkWT6feus0lJGrC8jbAv+Uh0fhWGkIUFsU+
         cAoFyWbyqm+uSm6x/ZtisYciMfV8C2EB3uuiIqmISi4lCWEl4l9ATRu+O76G1hoE/N3T
         Ipecs6uY6SHHR7yp0TG1QCi16ABdCqgUAJ4tXqGnjlMlEnTtrI/Z34J55D8z9HOMNNea
         k6AQ==
X-Gm-Message-State: AJcUukfbye99mXe2Ad76JY7eFW75dilfCbnvcBhfaSunKTmO5f+o3zaY
        SHKYLhkwLzJ7FEVEHPqB6G0wZsadtiw=
X-Google-Smtp-Source: ALg8bN5myPnmVKN0Kw4kdrGq4fUSSmMbTfdRL+jsLXID3DuUJSJt6gvNB/C8SJOQNp2COBHHBwiPrA==
X-Received: by 2002:a1f:e7c5:: with SMTP id e188mr7746470vkh.92.1547848987951;
        Fri, 18 Jan 2019 14:03:07 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id g14sm815521uah.10.2019.01.18.14.03.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 14:03:07 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id d19so5170935uaq.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:03:07 -0800 (PST)
X-Received: by 2002:ab0:16c:: with SMTP id 99mr7915328uak.15.1547848494291;
 Fri, 18 Jan 2019 13:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20181220173026.3857-1-jcrouse@codeaurora.org> <20181220173026.3857-2-jcrouse@codeaurora.org>
 <CAD=FV=WjLB8TV80cMef9ZqYn7h3szJ6x67_6pL9FnM1Q+8i_2A@mail.gmail.com>
In-Reply-To: <CAD=FV=WjLB8TV80cMef9ZqYn7h3szJ6x67_6pL9FnM1Q+8i_2A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Jan 2019 13:54:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V2N19Thv3SNzw-2SRzg0iPRQ0Ev=gr0+9ADb9r6Fvcng@mail.gmail.com>
Message-ID: <CAD=FV=V2N19Thv3SNzw-2SRzg0iPRQ0Ev=gr0+9ADb9r6Fvcng@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/msm/a6xx: Add support for an interconnect path
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Johan Hovold <johan@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Evan Green <evgreen@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 18, 2019 at 10:06 AM Doug Anderson <dianders@chromium.org> wrote:
> It's be nice if whoever is planning to
> land this could indicate whether they'd prefer Jordan send a new
> version to handle the API change or if the relevant maintainer can
> just do the fixup when the patch lands.

Breadcrumbs: Jordan went ahead and posted a new version ("[PATCH v6]
drm/msm/a6xx: Add support for an interconnect path"):

https://patchwork.kernel.org/patch/10771501/

-Doug
