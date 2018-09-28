Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEABDC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00B6204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENJKLdTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00B6204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbeI1Xm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:42:26 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35368 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeI1Xm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:42:26 -0400
Received: by mail-vs1-f67.google.com with SMTP id n25-v6so581204vsm.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=kYqmJBZOUhMvnpViRDm7LDJYSmDvSlwc74lk4ALniWo=;
        b=ENJKLdTIItYXKqe1z8XPaxkq6/CPzYw4347ZL/XNlwFPmtXtk2wIOmCiTpN66wIFZV
         Re91GttdLfHkVmDW4sIecRKy9z0vKgPtLklQWOdVaqpFui1VsdjYK6ag3kaIhYBo+EGL
         QuLPtdw+t4GKpQw2EAYWyrnvBMg5sCuzLqVi5wavkG9Bekrq6gmKdSptMzcHVynIV3WR
         hndqAU3w7uqOdiht60PmRNIIbX/W54dGFuYAFCAfKd0vI2DHlOQ614igQKfpAXAoaHqC
         9wp8oGbrzPrBz/2/5z4SDXFrKR2wN0Ao5GJuxqlTrH4z/ZX/efKhKY2UgfjR1kCuzJCe
         u4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=kYqmJBZOUhMvnpViRDm7LDJYSmDvSlwc74lk4ALniWo=;
        b=Z2dLiGFFLR1IAMAqnFNG2XoUGiPzf6iSW+Ik4Umx0goOUsiJ4C40V0SbHlmhpUIGc/
         oSuhtEFwjVJ22wbodMUwXpiKBveZHAOILK74Hxo9gsnYF4YqdRjxE/kGeiRMxSIfNsRg
         oEiJHaTYm9m+01LLUjRR4AKFV982/C06UnFEXzhMItgqLmjiQd9t1NsD2VSISPPaERNj
         T30G9Pl05Lli1eOl551HKeSNZYlfVl04DAUxPa2whbi+lhSWCPjOzkBq0iPtCbBU4zFF
         LmH1xWNWmmy3BwIu14+x/KUnaj/65ON+keLBgoNKbczKi6sLIEQuMok1IXHptU5l7Nk7
         3+ew==
X-Gm-Message-State: ABuFfogyNxl07xxTXK8AAbReGWJ+kXirnVswpE03DncF4iH6qfP3Vj3J
        ov7zVFms7lmZD9oOGGBSEWhtrMj00zAVa4Nywg==
X-Google-Smtp-Source: ACcGV62IhXETSjcZXpSZl0n0FnhVfhI0kygZgASn0DbXewVG/4UJSI1x5R6QyxvlOkzo2Z3AH/tekKOvAaZDEY0nVPY=
X-Received: by 2002:a67:6582:: with SMTP id z124-v6mr3087844vsb.11.1538155061432;
 Fri, 28 Sep 2018 10:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <22cc40a7-015b-6038-2093-8cd1ff0c807e@baylibre.com> <20180928170818.32124-1-jekarlson@gmail.com>
In-Reply-To: <20180928170818.32124-1-jekarlson@gmail.com>
From:   Emil Karlson <jekarlson@gmail.com>
Date:   Fri, 28 Sep 2018 20:16:21 +0300
Message-ID: <CAELSAVbQRGDEwR0o7R2KW91zODaYTRFgYOeikKtWW9Lxwcwa=A@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros-ec: copy the whole event in get_next_event_xfer
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, bleung@chromium.org,
        olof@lixom.net,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I failed in In-Reply-To:
<22cc40a7-015b-6038-2093-8cd1ff0c807e@baylibre.com> somehow.

I was urged to go for correct rather than conservative fix on IRC. I
have tested this on my message
version 0 Kevin and it fixes the original problem for me, but someone
should perhaps test this on
newer system that has message version 1. Background work documented in
commit message.

Best regards
-Emil
On Fri, Sep 28, 2018 at 8:08 PM Emil Karlson <jekarlson@gmail.com> wrote:
>
> Commit 57e94c8b974db2d83c60e1139c89a70806abbea0 caused cros-ec keyboard events
> be truncated on many chromebooks so that Left and Right keys on Column 12 were
> always 0. Use ret as memcpy len to fix this.
>
> drivers/platform/chrome/cros_ec_proto.c:509
> get_next_event_xfer uses ret from cros_ec_cmd_xfer for memcpy for msg->data len
> drivers/platform/chrome/cros_ec_proto.c:445
> cros_ec_cmd_xfer gets ret from send_command
> drivers/platform/chrome/cros_ec_proto.c:93
> send_command gets ret from bus specific xfer_fn
> drivers/mfd/cros_ec_spi.c:598
> cros_ec_cmd_xfer_spi copies len amount to ec_msg->data and returns len as ret
> drivers/mfd/cros_ec_i2c.c:267
> cros_ec_cmd_xfer_i2c copies len amount to ec_msg->data and returns len as ret
>
> so msg->data length is always the same as ret.
>
> Fixes: 57e94c8b974d ("mfd: cros-ec: Increase maximum mkbp event size")
> Signed-off-by: Emil Karlson <jekarlson@gmail.com>
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 398393ab5df8..b6fd4838f60f 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -520,7 +520,7 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
>         ret = cros_ec_cmd_xfer(ec_dev, msg);
>         if (ret > 0) {
>                 ec_dev->event_size = ret - 1;
> -               memcpy(&ec_dev->event_data, msg->data, ec_dev->event_size);
> +               memcpy(&ec_dev->event_data, msg->data, ret);
>         }
>
>         return ret;
> --
> 2.19.0
>
