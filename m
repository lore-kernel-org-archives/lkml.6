Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97922C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C73D21486
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFl//GiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C73D21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753306AbeF0JFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:05:40 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36233 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeF0JFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:05:37 -0400
Received: by mail-it0-f68.google.com with SMTP id j135-v6so6363730itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 02:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Vk2isHDja3JPqeU2FnSBKFDBjywE/EusRkOmcBoZErQ=;
        b=iFl//GiBw1zhPNAARuHREUv9ddInU4MxVAq3dIAvmzVZMN3T5iX2YR4eg4wDRW4dl+
         EJY3np/xILxZfinqDiLks/z/FMfeH4/LxkdUFYGCrl9dUaGw/RppJUczQ60rntJMESnV
         lXUprb+5mBIAMngzdZHiWNniD5RE1lA38l2i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Vk2isHDja3JPqeU2FnSBKFDBjywE/EusRkOmcBoZErQ=;
        b=pyhsss/siVDXmp40r4GxN+WMAyUpS0D+INGSKz66qoUxA84JxUUnMd4rQjfQtFHCeZ
         6R7eo/7VQ4/Hc/hIcDsijfYMvsfqVCVMA7R4CHw+YBtAJAQOpd9NOT3UIA1i7+J80z4R
         NvPc6CjIetwaECe5PTpXXwvC70ARbBXB6a7nMmQTZfW9goxCxbPC/PCocSMD506tR5lP
         JqfO7VL9iaHfbzimbF+z8zVuvwbnVjAL8/+c0D5YxNBf0VUHLLg6U4bTpzX+UwOo60RD
         GuMWWnaL07afJuHH6RTWrKqjM8HYpMd7Ow3YOmDDP8eKfVeWagHsFIfkb1ouen+bQtLy
         9PVg==
X-Gm-Message-State: APt69E35GQA0wwPNDvPUuqi7ICjlm4Si0Jgwp0Ytb2LjJRh6+75eTJYp
        rlP8wP3zuMaL8OZnta2kNk3jGpkGvcwDFWVtIXxyoA==
X-Google-Smtp-Source: AAOMgpet65zNwkAh5ok7vQfaXOc/yuaEU+hyXDdrNjxENM3MRF0GcLE2Osk53qMhXaYUpPw/m3ac+PRcLgCefj9/gJI=
X-Received: by 2002:a24:d00b:: with SMTP id m11-v6mr2363539itg.97.1530090336907;
 Wed, 27 Jun 2018 02:05:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 02:05:36
 -0700 (PDT)
In-Reply-To: <ebec2f66-d28d-7b94-3cef-be980617cd6f@codeaurora.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-10-ulf.hansson@linaro.org> <cc6f36ce-32b7-4b69-f9a9-98cf0b12a9d1@nvidia.com>
 <CAPDyKFoiEctBuyw1nVS6ruQ92-jOsMMSAUsWKew42dkmk64_8A@mail.gmail.com>
 <f214cf2b-49ee-2f7c-babd-1cee7dcae927@nvidia.com> <ebec2f66-d28d-7b94-3cef-be980617cd6f@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Jun 2018 11:05:36 +0200
Message-ID: <CAPDyKFqZVLfKXK7H+VLaiTh96xRwqBWHxaFfs5PDo7o+5hzRsQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] PM / Domains: Add dev_pm_domain_attach_by_id() to
 manage multi PM domains
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-tegra@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 10:55, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
> On 05/30/2018 08:00 PM, Jon Hunter wrote:
>>>> My only other comments on this series are ...
>>>>
>>>> 1. I think it would be nice to have an dev_pm_domain_attach_by_name() and
>>>>    that the DT binding has a 'power-domain-names' property.
>>> I think it makes sense, but my plan was to do that as second step on
>>> top. Are you okay with that as well?
>> Yes that is fine with me.
>
> Ulf, do you have a patch for this? I am working on moving some of qcom
> remoteproc drivers to use this series and it will help to have a
> dev_pm_domain_attach_by_name() api.

Right. Besides this I have been working on a little improvement,
avoiding to power the PM domain while attaching.

I post a series in a day or two.

Kind regards
Uffe
