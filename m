Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFFCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442ED20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jm7VmfaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442ED20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeHaNg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:36:28 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37010 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHaNg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:36:28 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so6370920itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 02:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjQZpBrpcA67O6SX4HCHLEzUsLordbbqZcWwngO5AJQ=;
        b=Jm7VmfaSBLm9YBy+aNVXmzlmQ1RSUD98/LtOCB7oZnQ0Q665a1BdSe0FeNNnb6Wz01
         slVmya0afNxjrCY+o9kv8wDnk4TnCwMB0rD6tApM77Qe5na3jKBqsGfPAMaMxOEw2TZu
         wB8i+NasN7d3g1vJWNhmrDMeiur/bKWJO9qX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjQZpBrpcA67O6SX4HCHLEzUsLordbbqZcWwngO5AJQ=;
        b=GPvbmZnWYqFyEJfnKcZiMMeJ15ynMqTHeTAm8z/VPdho5w0GSyXKsQU7HbWZSD24po
         2xApmZqUeYXIN25wk3NEsPOPahukjR2rTNDGRhUMy2IChPuxB41L+KuBeoQLp+Ys4zFs
         vkEmzBzzjL6QZAM4Cu0MVyBwz1dTwEQJ0lzapLOTn+NlmmL5DjvMc3MrXXASi3SucX9Q
         7nH+ShekfPSfdLiTRJXefCXDOl0xnHZnQM1JNi3OgUPVLsQbfz+5UNKTm16zwNOjbpZm
         o2/oCYFjAN8OsSjcMCo5nMV9cPkHhK92UVwI/E5cFrA63P2aoF4eNs4G7oerdFMnW+fr
         +RCA==
X-Gm-Message-State: APzg51CF7RoAjPTGfgCApFfXBwc0HMxU6+jURxvp3kykUexwUDtG3eub
        SNKC+NA7onc/a2ReIOpNkm2KS4HtVvZf6azp1KkY7WkF8zs=
X-Google-Smtp-Source: ANB0VdbGYb8nnnu8NgiLwC5jqVmusxNhNwp2Q7ntz7xxYjpYaqdgdH/APErnt3peaxtunHsV/WhraFDop8GS3dqz2Wo=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr4735626itd.130.1535707792774;
 Fri, 31 Aug 2018 02:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180830223429.30051-1-igor.stoppa@huawei.com> <20180830223429.30051-20-igor.stoppa@huawei.com>
In-Reply-To: <20180830223429.30051-20-igor.stoppa@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 31 Aug 2018 11:29:40 +0200
Message-ID: <CACRpkdZg2WU=eZQGVm9fbkG=bVbY2qRvdx-nY8P=FvaRF4d9Kw@mail.gmail.com>
Subject: Re: [PATCH 19/23] pinctrl: remove unnecessary unlikely()
To:     igor.stoppa@gmail.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        igor.stoppa@huawei.com, Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:35 AM Igor Stoppa <igor.stoppa@gmail.com> wrote:

> WARN_ON() already contains an unlikely(), so it's not necessary to
> wrap it into another.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Patch applied as obviously correct.

Yours,
Linus Walleij
