Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE2EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CC024004
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UMvdOi7H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J3sNJnnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CC024004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeGEP4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:56:06 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:37165 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753802AbeGEP4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:56:05 -0400
Received: by mail-yb0-f196.google.com with SMTP id r3-v6so3400799ybo.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YLTSaIrJzhC4pbMC+6m16U+kwusrpxmLTbnP1AaQ9uE=;
        b=UMvdOi7HAsII8YwEgN8O9CyeFkq6bdF6OkUIOHWudOYR3lV4dH9th0rx0rnVEdtCK1
         gNmZmMV8o0G5GnBC7y0P+HLR+D/awASWFnC6mNJeEtIIGhTI5/CT+ETHGaU68FHt+041
         0izVC2/+j9E69t/MQCvKCjWZAE+GyKc5nKpIC2uO3GFav2bz/aCJgoHGAMGNMAMnTP8E
         TfwM9QgTnWxcQ/jaBdOP+Of2tc9EkJOW1cpDGU5VF3BYWT1IP0PdKmlgRi/VFFzSWg0Z
         c4qW1rDfRff/WT69yRgpr8zyMy+tPPn62Kbae6TknzBtYnnWSzwmXzZuRNcfSoRGa1WP
         qJGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YLTSaIrJzhC4pbMC+6m16U+kwusrpxmLTbnP1AaQ9uE=;
        b=J3sNJnnHrsTrdlLmnfy/07HqzD5oxlEeSJLS2SsGzOu0NJNWa50SuC6DFVvDfgqdCX
         JX9cakeWsev0j3NOQE2OCzx632pbKedqLFoz/rtU6Zo0eNEHU+ACAJeBnmPSmFZZe4k+
         tV07Cj3ppp68sqynw/5wJ+LrNiDNAp5+PlegE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YLTSaIrJzhC4pbMC+6m16U+kwusrpxmLTbnP1AaQ9uE=;
        b=d9O7M1z8L39X7sx+4UaV699PyMCkDKo3MFdghCTYX4RObuFpRnMjYHHGQPO1ePZy68
         RaDM6zwoLayibjgai9Hq98uMMI2cqLiOZzUB9ZSQ4lOa3Wr5gKdomMCR+YlX884WCIoN
         CjrOUanWTncA3zKr3Q3vFNMYBpp66qqoZon1XegLsJfT/u67MCpV01EEWmyMnxWYc1ud
         EgJT5p/m6liia3ant4l1VH8tYdyX6m22+SASl1z40EYNWw/HzaEUsdQ9seu8nYlhvlKc
         gP3UsrpukyO/i7j8IXGBmsL3DxErOg/+inFlJNsky3t5Kx41wlYzE2hXaMeBVLtm7PJZ
         66OA==
X-Gm-Message-State: APt69E3F8lckl8xr+2UmsUKIjzc78EBA/wgXQcbou8/1u8FEJHX3HTLy
        483fIAdFBZZtzlHPvX88bSYt0pN65iyGFFzSl9nVXA==
X-Google-Smtp-Source: AAOMgpfumTjD460nmXr/k935rX/1gNycSP/OTFs9dInGeONnqT8uIFXK3rDRIFd/WprcDGhVehCwDr3tWy2WTZRaYsQ=
X-Received: by 2002:a25:a483:: with SMTP id g3-v6mr3361066ybi.309.1530806164493;
 Thu, 05 Jul 2018 08:56:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 08:56:03 -0700 (PDT)
In-Reply-To: <20180705090312.1ca9ed5a@xps13>
References: <20180704172759.GA33591@beast> <20180705090312.1ca9ed5a@xps13>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 5 Jul 2018 08:56:03 -0700
X-Google-Sender-Auth: 89TLNj3dcB4C0V9j7Lu3_c6b-2s
Message-ID: <CAGXu5j+U67bo0fKf=75yi+X48bqydoq6CeYTJh5_o=rZpgUXZQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: spinand: Use 2-factor allocator calls
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Peter Pan <peterpandong@micron.com>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 12:03 AM, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> Hello,
>
> Kees Cook <keescook@chromium.org> wrote on Wed, 4 Jul 2018 10:27:59
> -0700:
>
>> As already done treewide, switch from open-coded multiplication to using
>> 2-factor allocator helpers.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>
> Indeed, we'll be more careful about this in the future.
>
> As this code has not been merged upstream yet, do you mind if I
> squash this with the initial patch?

Totally fine by me! Thanks! :)

-Kees


-- 
Kees Cook
Pixel Security
