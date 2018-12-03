Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645ACC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2769D21486
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn4ldKhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2769D21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbeLCJ0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:26:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38096 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbeLCJ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:26:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id p17so12889325qtl.5;
        Mon, 03 Dec 2018 01:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQpCfpIrbfdhUwDtFFizKV/Mg/I6D9g1P8O0splyJ2Q=;
        b=Fn4ldKhhEBCpvbLc4uHN8PBScCJzhernTZ58qcvrb5+9qDL9ozlOM/YEfdXFil/ha6
         xUSRoLHL1Et2XcDRxHn9Dhjnw+bgL0pSQzAWaVXOeBR6W+LcTouKVd0iLQMJkTPmaFnU
         6exhTfTePSI9S5yoB554Y42ksbRc7dkKqQe5xdyBZ3jFzA0xzg/8In4hn9qQox5aN0+6
         9ZtC1eatSOPD7Ojvgzie4LcLXOWjG5+7UK2ZFVSN6r+b3WWOykqL6z/K8TH8dRH40RUo
         NrSEyYSdNDqzs3W1OlY9VOrlZRv+7sPYNyrpUqgBF4eXCXZVwkgUEPwR26ilIrHzsGYK
         43HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQpCfpIrbfdhUwDtFFizKV/Mg/I6D9g1P8O0splyJ2Q=;
        b=uiXyihgzmifq9TwqMwlg7e/qqCpcxlF9Js1LRKaCRPjHKhXUfzrLEM7T67lvlLP3PY
         VBFqtZWvZC3g75cASEFdcFiIttN0bPf1dvIHt5pAGB+hi/UDpdEn6paqQWO0WkYrTHfC
         SQMcQWRVYunmT8L8Ro0QIijyNjVgkyjWrM5avL9jZX8NjmLCbzsN31bWUM4txC4MhjSp
         vz/RE4TZgcUcXHnP5XFAg5SwRaUWoZrDj5obsrROtlvZT6Cmvk5hG0bgtiqRQvcP9CW6
         STpI4tOPL2iskvZ6rq5IRw+dVCzrcyW8tqn15SlZLjNx1XN2zlOTlJ/RDjXmu2bKWMTV
         kiAQ==
X-Gm-Message-State: AA+aEWZTfxF65c0m+g+7nbO48NddWm0Km/aUceMevXcdpGiXDkDJnlNw
        TiM4ZszUjXjEvaLr4ErAkFasskyElTELMnW1OZo=
X-Google-Smtp-Source: AFSGD/UyOAm2RV7PSCcDcxMz+0s/PLxnqobhJm+L1EAvhCQb2/r80IJxV0qK3FKcvvI0DALU+9E/fiF8FENwuvE2cO0=
X-Received: by 2002:ac8:6151:: with SMTP id d17mr14378795qtm.194.1543829147508;
 Mon, 03 Dec 2018 01:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20181203034515.91412-1-chenyu56@huawei.com> <20181203034515.91412-12-chenyu56@huawei.com>
In-Reply-To: <20181203034515.91412-12-chenyu56@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 11:25:36 +0200
Message-ID: <CAHp75VcUQN_PuXDVkeR+jagTsUaOWLtytVt+f_eR+x2iw9B5-A@mail.gmail.com>
Subject: Re: [PATCH v1 11/12] usb: gadget: Add configfs attribuite for
 controling match_existing_only
To:     chenyu56@huawei.com
Cc:     USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Wangbinghui <wangbinghui@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:47 AM Yu Chen <chenyu56@huawei.com> wrote:
>
> Currently the "match_existing_only" of usb_gadget_driver in configfs is
> set to one which is not flexible.
> Dwc3 udc will be removed when usb core switch to host mode. This causes
> failure of writing name of dwc3 udc to configfs's UDC attribuite.
> To fix this we need to add a way to change the config of
> "match_existing_only".
> This patch adds a configfs attribuite for controling match_existing_only
> which allow user to config "match_existing_only".

> +static ssize_t gadget_driver_match_existing_only_store(struct config_item *item,
> +               const char *page, size_t len)
> +{

> +       struct usb_gadget_driver *gadget_driver =
> +               &(to_gadget_info(item)->composite.gadget_driver);

It would be easier for reader to see two lines with two variables
instead of this.

> +       bool match_existing_only;
> +       int ret;
> +
> +       ret = kstrtobool(page, &match_existing_only);
> +       if (ret)
> +               return ret;
> +

> +       if (match_existing_only)
> +               gadget_driver->match_existing_only = 1;
> +       else
> +               gadget_driver->match_existing_only = 0;

          gadget_driver->match_existing_only = match_existing_only;
But the question rather why is it not direct parameter to kstrtobool?

> +
> +       return len;
> +}

> +       struct usb_gadget_driver *gadget_driver =
> +               &(to_gadget_info(item)->composite.gadget_driver);

Make it neat.

-- 
With Best Regards,
Andy Shevchenko
