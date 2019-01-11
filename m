Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1DEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB704214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ec+yIOBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbfAKMdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:33:49 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36608 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732372AbfAKMds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:33:48 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so12810063ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 04:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gg/juwHMoYXvq35apqcfFmSANXXLjDLHR1u7Jt3Y4Ac=;
        b=ec+yIOBtq1lXSBMab4HO9DAu25YdKJmJJVVmxl3fWVDHfP2poOpja/hXN0rEdic+Wm
         3C9Cjz3CGIxLvI8m8Pvd0YISBZT/AFBWsWyplqJny5Zdp+1WmvwW5rCtp+go/bkCqKI6
         0UATV63Xi4iIs9Y+O/bn2M7+bJLXVhChh/p8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gg/juwHMoYXvq35apqcfFmSANXXLjDLHR1u7Jt3Y4Ac=;
        b=pfZpvjDdrlIkPwM0OKfU2FLrm8pKS3WksXyWyAPjK1JUFSrHploO7lQquWu1USRYHf
         n6TTEFPH9af7qjO9jsI76A/UW+C0PdrhKVIgFQa+4PmvbpoEdwDRdXkuX7W0iP0jedAj
         aeFoPlJOFRzFQXI6XSDv5Q5xavgJkthMxNo9P4j80bBMeBziDxrTxT/2xA5qM/YqsONL
         IZeK8Tj+682bmoOOGbvhL7s0hA+aQuE7afFov2ZScxliD8iLnz3F4fU0GulC6Y2kXjgL
         uWVxN1v/Q/BK/+5LCLtHwRQvOogm5JHWI/5dVgY72YDnRLOLZmLL//+8oWTVOmBNJeDX
         fWDA==
X-Gm-Message-State: AJcUukfOs86MXv+snz2ajvtDSO9TEAiNpTZL8e3uJZyz3we0bwUV8F7z
        k/MstyNQp9Xgwjtfk1h8qfOKEWu4OLdrjACzLA5JNQ==
X-Google-Smtp-Source: ALg8bN6di5M2gpyAbwClUybTIXjCcAsHVfhQ8DTWyGiTkkAnF0zk/qPZDR93oi7LY912mQODc409qxTHDOxqCrdJ350=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr8462600ljj.9.1547210026288;
 Fri, 11 Jan 2019 04:33:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1546667177.git.gustavo@embeddedor.com> <2795c5ba939fe23dda6c86135d56e68433f7d68a.1546667177.git.gustavo@embeddedor.com>
In-Reply-To: <2795c5ba939fe23dda6c86135d56e68433f7d68a.1546667177.git.gustavo@embeddedor.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 13:33:35 +0100
Message-ID: <CACRpkdZkrsKo_=Wpps54jVaCADwL68JOLvUC1TeJYf8ZmLj=4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: integrator: impd1: use struct_size() in devm_kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 6:55 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     void *entry[];
> };
>
> instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Fix devm_kzalloc parameter reported by kbuild test robot.

Patch applied.

Yours,
Linus Walleij
