Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D32C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8776821746
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UocgWsUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8776821746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeHMOIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:08:16 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42725 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbeHMOIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:08:16 -0400
Received: by mail-yw1-f65.google.com with SMTP id y203-v6so13246039ywd.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a7BNQtqU1pD6rElJXpAgFiYEXTd8111gFvtpH6it5Kg=;
        b=UocgWsUYoejNkDzMkZNNXLiFDgoxrNkoGMxOhGt/s5a1/ObdOhXtAolyLCMw4yUp8K
         bH0phXSxiIb/PGeMipgsrNHAaWMIvo67SVRBWBKIFoua/cMzagzbo5cxPnjJqrAOSepU
         mEcAg72cPMgUpZNVENKAKqNt+QyAnRs+pCGjy52zyOK+3q3fJU/JHebwZvUVGI0Rm7Ac
         YGE9UPOiE9zxVPRo7IMo4HRZW4LMPEBH8LQe5XoJalnncPjblhUYAJOnirZA+e3ilvyd
         4ixnf5lJIzRpeah6XBGLCmEwLJn+NiFXyIyRuzLZAtR0vPY4H8qtlFYaaX3iJ8GkECJx
         FZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a7BNQtqU1pD6rElJXpAgFiYEXTd8111gFvtpH6it5Kg=;
        b=sulHn0PBvPTBxDzOj8lKnkv+w1SuKZCNhHm5RsKQd5wM9qmc61tyZ5giq9mSaX2416
         TsmibqX1gE0xU64LG3AR8pN2aAVWUZz+nZy8L9Kt8/j2oCjmXYhdVng0d44ISuY3yUxr
         8/3XJQL7JfymPXwyZ8Nd2SRcZ8115bHZ6GMCc9aA0FB5MGf41NZTRcrXb7jPPPw0/RRZ
         GPg/WByqn9J8wIuzLGXy3YZpV6EyDTzWQQpqsBrXR+gT8KguLRb5euCXesJTPwpCD9bc
         GlKsGmz5gFOhU4Vl1QS5jvJUtEIU+UCZ74oQ1EuDUpqWcMDB+2JxKD6YoHJ4Xn4h55tt
         QGAA==
X-Gm-Message-State: AOUpUlEQq0XQfgpMHVp5dH1ZU7izjp5wdwARfoPaAazNnTYuQ8aQrKMa
        lb5Y4iQOBwh0aYDXxZ7ojhUk+eRRbQPW1ttxiANiNCLl
X-Google-Smtp-Source: AA+uWPyk/yHLyEgc4XxPW/QjoPrlgEhfXZxHddZLU2Gi9uQkgU8lmlx+v1aAXVCDs9kGVnDLZPX9nmxZrlbppp2gbuc=
X-Received: by 2002:a81:128d:: with SMTP id 135-v6mr9025506yws.107.1534159585703;
 Mon, 13 Aug 2018 04:26:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2594:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 04:26:25
 -0700 (PDT)
In-Reply-To: <1534157699-23637-1-git-send-email-zhongjiang@huawei.com>
References: <1534157699-23637-1-git-send-email-zhongjiang@huawei.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 13 Aug 2018 13:26:25 +0200
Message-ID: <CAMhs-H9+FBfjvtYb0ehoAz7hHaaoKiO6-Ypmb+q-aXRO-xYG6Q@mail.gmail.com>
Subject: Re: [PATCH] staging:pci-mt7621: Use PTR_ERR_OR_ZERO to replace the
 open code
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, NeilBrown <neil@brown.name>,
        peter.vernia@gmail.com, oliver.huebers@web.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 12:54 PM, zhong jiang <zhongjiang@huawei.com> wrote:
> PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
> just replace them rather than duplicating its implement.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/staging/mt7621-pci/pci-mt7621.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
> index a49e279..9a8ff1d 100644
> --- a/drivers/staging/mt7621-pci/pci-mt7621.c
> +++ b/drivers/staging/mt7621-pci/pci-mt7621.c
> @@ -403,10 +403,8 @@ static int mt7621_pcie_parse_dt(struct mt7621_pcie *pcie)
>         }
>
>         pcie->base = devm_ioremap_resource(dev, &regs);
> -       if (IS_ERR(pcie->base))
> -               return PTR_ERR(pcie->base);
>
> -       return 0;
> +       return PTR_ERR_OR_ZERO(pcie->base);
>  }

Hi Zhong,

Thanks for this. This driver is in the middle of cleanup and this
function is not doing all the DT parse
yet, so this patch looks good but after applying this series (if they
work and are good enough to be applied)
has no sense.

See: http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-August/124890.html

Best regards,
    Sergio Paracuellos

>
>  static int mt7621_pcie_request_resources(struct mt7621_pcie *pcie,
> --
> 1.7.12.4
>
