Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBE1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFA121848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="O+psazMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfA3Dap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:30:45 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39834 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfA3Dap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 22:30:45 -0500
Received: by mail-qt1-f194.google.com with SMTP id u47so24797955qtj.6;
        Tue, 29 Jan 2019 19:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOazp/NWSDbCI8C+71UDBedskrp4jlovZVpb655hqvc=;
        b=O+psazMWvQoU6qhDFavivE6P9jLDHQZ3zpfhSE/LPFAGiKfXe7TrmCEsw4aNUdKK4K
         lpJ0kIdBwycUE7Kzr87i4aTSw1FnGlWGQmYfTMzdinb/1XmuW7PbG+rvT+umTqFBzID/
         ntKSqRUK2r2MzeLpRRXXA55Y33nfT3nVs66f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOazp/NWSDbCI8C+71UDBedskrp4jlovZVpb655hqvc=;
        b=r5/ZPOWkb4thdQbHtut6x7aoFREAESZO/pKS3GsPon0qLY3OfKNRgK3i0GIXsqg19A
         tcvCAUxVSNQ6k6kjd9z6DPWa/HN492QogZQkjoVlqiS53aBq2CnCtL8239uhiS4fxJMx
         uKkGGXhYibmekoftwKZn97KOGGrSb9a4BRt8gG9qkJ0X1eiKseq0DaWPy9kr0B0M4x3k
         V+647w8kyDbygiPTYSSpmiiSIEfLJqarj1oj/r4jLz+uLGZ5tscSN8FiQJsoH42SfGU3
         rct8XU/YGzd1vZZcUWn9LYMGI+gpyk+ejDGpmEqWhOQ/5KFF5EEFfWcF/x6z1qiMvPjr
         ap8Q==
X-Gm-Message-State: AJcUukelabJ+iOLCTU88zOS0jKApdvry7lUO0niFwFmz2zHvV9YUCoX5
        B9Kj3nYWxszoIsUBW+hgKDQ+VYTelp3z6eLIdnI=
X-Google-Smtp-Source: ALg8bN7LW70WzD86d3+LFpR4kdydSKb/yb44aVGHjpkQPeLKmhko7YcKakMv2eFQDtrtBDy9bist227w4b+PVjN7JKU=
X-Received: by 2002:a0c:e789:: with SMTP id x9mr27109614qvn.245.1548819044408;
 Tue, 29 Jan 2019 19:30:44 -0800 (PST)
MIME-Version: 1.0
References: <20190129230538.1044378-1-vijaykhemka@fb.com>
In-Reply-To: <20190129230538.1044378-1-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 30 Jan 2019 14:30:29 +1100
Message-ID: <CACPK8Xdg+mjqL-qnNGUnRPw03sqBJGf_ckcsFnw6_F7HA96o6Q@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: aspeed-lpc: Make parameter optional
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 at 10:05, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Memory-region and flash phandle is not a required parameter, it is
> optional to describe in device tree and needed only use basis.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Acked-by: Joel Stanley <joel@jms.id.au>

Thanks for following this up Vijay.
