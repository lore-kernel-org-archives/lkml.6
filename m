Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14BCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7AC20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Zc3CsACo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7AC20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbeKHBy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:54:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38488 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbeKHByz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:54:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id q186-v6so15268851ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 08:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfqKMeqoPfXjyVhqROAYvGYhkqC401xIrTMJMJp/Svw=;
        b=Zc3CsACoDNWsCeeqrk6Hb4Hrfhn+oPeA5JExHi9dL1JQ4Xzeg4INE5uoaaot4MNeVh
         H2v/qrDNVfu2jS+fIH8azS5/eEicjg3yu9ldy1h1JAmJ4cpRepX0CQi8Lr2BYlGMxhkR
         dmyADIpp5XCBPg4PP297/Sv23HoS3x1neDsQvgbWfvX+HmMvbshULq3NRVGTIo2iwaOK
         Lq13wpeOVaO8OdtO/ZQ30M5OeHvACz/YR8V2ERTOxtJKttyat8TJ0TJBqQUKjYmpWd40
         g67W2pcBKRbmTeJ5N4QyHwyOHf3lwWX8qB4UudkJ8mMSVnndrky4bLiZIm84CpDc6q+q
         V90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfqKMeqoPfXjyVhqROAYvGYhkqC401xIrTMJMJp/Svw=;
        b=KNHZYOzgjPYUbzR2sD7l/Y5jTp7jYKRWCHv3Ilv7DykUiezCgjVQ7MMurTkysrD0B3
         q2qWi1u+v6pzP6N52gKgqWcSdXS1uwdgsDU4HcSJrXbtv1IiOsqCvyDD2dpbd6zc0yoX
         i56qrEl9FwedwaGgRJzURHmB7yvRNinEoNZ/ruPrjMxYwIrQ1F/D8FCExRfXhUr+GzL+
         CCwSVKPpHgfH58x/7mWffBOYviuVxHmKjIgukDIqjinYkHvey15po9DGIyQMENyvZ7l+
         ckH+W0W5/Q8WKqXPrfr7gwveNr+PIh+czWEhy3Vx46PE2behOBrgBH9XsW9K0DFD0X3q
         Fy6A==
X-Gm-Message-State: AGRZ1gL+u+1q10yRkoPYtdUtkPSGN0POu7kJ+emn1Auk9T0RI9LeQKmO
        hTp5w+fRBFj1tsq8/8oYLFGij76D8u7FnEuq3EmKgw==
X-Google-Smtp-Source: AJdET5ejDC75lp+dS4hvFc2qbbHH1e7+Mm5otyzgjoEU9JTXpPqn0NmtpwsVR4w1zaItjNy5p9+z34OY/Wfn7uEcdPo=
X-Received: by 2002:a2e:350e:: with SMTP id z14-v6mr549125ljz.49.1541607830569;
 Wed, 07 Nov 2018 08:23:50 -0800 (PST)
MIME-Version: 1.0
References: <CAOesGMi-vkYPDrL2drJ70zf3_xTMWrsfPoW68TkiRJCj8uWBLg@mail.gmail.com>
 <20181107144516.4587-1-aryabinin@virtuozzo.com>
In-Reply-To: <20181107144516.4587-1-aryabinin@virtuozzo.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 7 Nov 2018 08:23:38 -0800
Message-ID: <CAOesGMgHxsgRcc6BvWFztZ6ypK6bxrh8CNsXRUusx=iL7TH0vA@mail.gmail.com>
Subject: Re: [PATCH v2] ubsan: don't mark __ubsan_handle_builtin_unreachable
 as noreturn
To:     aryabinin@virtuozzo.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 6:45 AM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc-8 complains about the prototype for this function:
>
> lib/ubsan.c:432:1: error: ignoring attribute 'noreturn' in declaration of a built-in function '__ubsan_handle_builtin_unreachable' because it conflicts with attribute 'const' [-Werror=attributes]
>
> This is actually a GCC's bug. In GCC internals
> __ubsan_handle_builtin_unreachable() declared with both 'noreturn' and
> 'const' attributes instead of only 'noreturn':
>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84210
>
> Workaround this by removing the noreturn attribute.
>
> [aryabinin: Add information about GCC bug in changelog]
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

Acked-by: Olof Johansson <olof@lixom.net>

While it's a GCC bug, it's there in official releases now and it makes
warnings noisy so we'd rather silence it.


-Olof
