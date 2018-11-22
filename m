Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67458C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE8420824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVAleIf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE8420824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404161AbeKWBN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:13:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:56306 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395565AbeKWBN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:13:57 -0500
Received: by mail-it1-f194.google.com with SMTP id o19so14349313itg.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ASLIs+3fdXR7910zbZhkUAXyRblPiqobHmdvycUdmAg=;
        b=pVAleIf6c7bRk+Aej9A/iudyMLIX82Nj8zZr2U2wiIOpCZYNFZ3+xfBqMbJ+7MGHWQ
         2fa/tAiT0OiAc6RBhF9BGHjDTY52C5rMpMFHaW+9T/qRvYiqZo7d1MP4GdEa6ggDXe4V
         v8YG1Si3nWZyS0mA9V64ODZoAcyVk2XpQgWFrcYsW4JOcxAcen+nJCe3xhF/YPp4pdP2
         WyuxCHXlON4pc0tDJiOR8QGQrJtGzjME/58tBLj4oF+EzuyCmSCwQtfNSsh6Aq1/Rmt9
         kUsRURPl9q3cXkC0n/SnCM1wda/ffHwil15YeDrT7N8toOABi6UuemZnmOXF8q5r0ld3
         ECVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ASLIs+3fdXR7910zbZhkUAXyRblPiqobHmdvycUdmAg=;
        b=ZyfANdCVrv6PG7mvrD8G4dlf+MILBV1W9UMK1iX3xEo5Nx0gP9kplTn79CVQrdxTlo
         Rs8iyO6IytZC22IpBGpwMc31EDBr7lcbwFPQj9pW/XR6wK+5BHaaRSw3pCQpZiDJ3Yxh
         Kz/kg6525HKpF/YY6Q/KBrqL/0hvK/17QpTf5JTlZWdqbyW8QSpRoNyWm5FD5kqsDcxI
         mHrmjP1eANb9nsCR19F52OarTWRhFkMQYxDlpIzYoftTCOLCJozzGq+JX1W6xIvH7sF0
         A18wnnRhIfAKYRDSMxEGUG6a50KxBLYv3NJh+bqp8RfbfWfi3H5yMhfvNlkMc2BVLV9G
         3DMg==
X-Gm-Message-State: AA+aEWbTGEyGYe9Vsd3DQaj6KG+Gv2IoHztrOyGg4/XGKflWw4dxRGKj
        wOZuD7CCubS8jCTIcH+9cGE6dCuJBUuCkZET/Bo=
X-Google-Smtp-Source: AJdET5fC5G4lSCwsNhqBP/Kz9PaOXlnhdLeP8Si90MziJ1dVYC7A0qi8BgXulVmxFJnQoCYQvzsmHWdzyDyU8m88oOo=
X-Received: by 2002:a05:660c:681:: with SMTP id n1mr9404422itk.37.1542897259026;
 Thu, 22 Nov 2018 06:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20181120131853.19710-1-tiny.windzz@gmail.com> <5ea4da1e-65de-ddc3-5ca6-eb83c2347930@linaro.org>
In-Reply-To: <5ea4da1e-65de-ddc3-5ca6-eb83c2347930@linaro.org>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 22 Nov 2018 22:33:56 +0800
Message-ID: <CAEExFWsOh1gixoC4bbSkbawC-ybz1YUA-tmw5FW5W-GFyFGs7Q@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add of_node_put()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:26 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 20/11/2018 14:18, Yangtao Li wrote:
> > use of_node_put() to release the refcount.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> Applied, thanks!
Hi Daniel=EF=BC=9A

This patch is a bit small, I will resend=E3=80=82

Thanks=EF=BC=8C
Yangtao
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
