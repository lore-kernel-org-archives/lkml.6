Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC9BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F249208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="P7+/vWz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F249208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeJFEKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:10:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45352 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725761AbeJFEKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:10:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id u22so14016392ota.12;
        Fri, 05 Oct 2018 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70yR39VTzj5T0z0bdNIjwvBTc2IFMhlfRm2XfClvHdU=;
        b=P7+/vWz2crgSkGa/r+m0FNI2BNfRXsLKD+QtYPFMcmGVddO7KSJBxUPJphQOf6vDm2
         LL8uZhZ+1Car6C77qK0BMb0l5vTLddFSwm3j+lGvE2Ndit1nt25X4UigOLzbCS3BRnrl
         /gWLlFkCLwpDVhwi0km+1PgrwpgeS1QHo3GEMDZWKEOEyDXNFVkIq/BtqWHXrlYUrgXC
         Q4M1zZw16tFEkDEnBsbbHw2radtME8bCgnxYH8jJ2eGICX3l9VhxqbH+fCDOjHu8JC+3
         QL5GvqIPD7eWO8PBt9NyteGGFwXGbXLWD3oRme9RJhGw7+a0i0Nkv82G+NfMgWT1+f8Z
         63sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70yR39VTzj5T0z0bdNIjwvBTc2IFMhlfRm2XfClvHdU=;
        b=RXdKU65ueTRIkf1sdXrUtvYLk0/lhH58bBNSbDEmkRd/4PUur/2q89AwuSqI7CZzM4
         +Jk2yUwxap3B40jSmFejhbDe3OrB0VTryxdVi3IxeIszY3X7VM9O+mRbd7giDS2OFMeL
         StSZxx5ndHP6P+092XgGeZsF7cmTriyUCDxdlVqkwN4sDNaTBLDnox+ZPko+BDdpQDXo
         34HCg1IElH7Ga9jKubjoI7sXuSl4ufuBmmNKgewbhoJh+6Yk0N1DEvA6sAls2UqNxB09
         dlzur9gA63IgOWMk2Za0EqhH71tf+n3fqnDrIJHmvjsJBJm066bILeqnfO1u/HwgCSAB
         utHw==
X-Gm-Message-State: ABuFfoiC569DoUekpc9A00wcjTJkZHVQPP0jI3O39L+MxJS7vK6xHTnS
        RkUloDay56Vy7Js6qJiXCsJCS6wuz/qwfxG3Suij/chT
X-Google-Smtp-Source: ACcGV60AO5YOW1AmwOq9m2Rh5ZozAD1BEehEF7/3u3d0sxLj53Vp9unryuG/rPzM5iGQrHlcDnbfWQPVaFhbqNAIOJ0=
X-Received: by 2002:a9d:624b:: with SMTP id i11mr3150440otk.232.1538773823174;
 Fri, 05 Oct 2018 14:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181005100903.GA32057@embeddedor.com>
In-Reply-To: <20181005100903.GA32057@embeddedor.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 5 Oct 2018 23:10:12 +0200
Message-ID: <CAFBinCDWUO74R_GKBJCmGRNSz=b75zxj4XB8LnYuQjdW9ecGLA@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdio: mark expected switch fall-through
To:     gustavo@embeddedor.com
Cc:     ulf.hansson@linaro.org, carlo@caione.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 12:15 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Notice that in this particular case, I replaced the "fall-through:"
> comment with a proper "fall through", which is what GCC is
> expecting to find.
>
> Addresses-Coverity-ID: 1373880 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for taking care of this!


Regards
Martin
