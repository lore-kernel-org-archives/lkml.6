Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1659370-1519223249-2-17761477521609824853
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519223248; b=D8hfCjjpBI5PfYmO95edW2SdaIKd3bJK7wk52rjbdzLbfVD
    51InLV500I3AD0MdqA9UkvUUj4c9T2HXWgnj8/xSqWIVafjL4uoojVjq86tG1uQn
    nrMb2Al+mZXiJCqaEn0UK68A9mHIxfZ+XxAWOhSQ+jgcru+cl5T2wh4rKccwW1tx
    pNwEWTQADmo6/4liO2sqx/7El2y20C8vzjxLIE2T9nef4+iHnxEbIiZcLTL4z+7V
    hOcOS2YVBDezjfWlF3vdUzHW2ym+r5zStaKmXpcFWc25W8d8F7o3cUOoo/5gHHkd
    9QhyyhuOtV40MEzzj44zE4I1XEkoCdsrO9f5aaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519223248; bh=LT+VWAEwR+wkIvszlDysFRVgpSBwNXEHsVkimt
    Adewo=; b=QhdNmp4JrD7j7w//yPVc9K5yVg4eo6p4lNkXzPYC47Joovst2r6hqT
    g/DU9aUb0GBxbnbRikrVTEU8oy3jko3DcKWPMXieqiUljOGbg+qF02TQlYVLzxp2
    Tz7VmHqKYyF3W8CUB/lMvDG7sHw+hn/Dv/d+VOq+M3OiFjmjPvZiIgS4odEfAVev
    vUpN3TZ/xQDeSwCUnwNbdLHnsVpveeXJASkyjf9LeJmW4NF7t/965gMhQV4cRPqc
    uRZ4KUPUQEwC3WZAbwfUvDj6yFDp9upbW63iuPlTChjWNBcHvSxHp/gSSIDU4Oh1
    0ziZjUcNHtvTCOtHtkAveebxQFkIaPDA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oxk9jS0W x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gUdcLVoT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=oxk9jS0W x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gUdcLVoT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934772AbeBUO1P (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 09:27:15 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33086 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934654AbeBUO1N (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 21 Feb 2018 09:27:13 -0500
X-Google-Smtp-Source: AG47ELsFG1V8RLu4HWkxP6xjyUtmkvBhCAfvoUSOoRPMZWQw8rFf5loFcuUoqRyXXOy0thLNFjDX66ixWKXwm2Lu8oQ=
MIME-Version: 1.0
In-Reply-To: <20180221085541.14556-6-a.hajda@samsung.com>
References: <CGME20180221085608eucas1p162d2e579a1cc887672b722458edb98fe@eucas1p1.samsung.com>
 <20180221085541.14556-1-a.hajda@samsung.com> <20180221085541.14556-6-a.hajda@samsung.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 16:27:11 +0200
Message-ID: <CAHp75VdxGDCGQBN05bL3_h8P62-v6+5oGW3M7CA+701o15ZXnQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] extcon: add possibility to get extcon device by OF node
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org, USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 10:55 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> Since extcon property is not allowed in DT, extcon subsystem requires
> another way to get extcon device. Lets try the simplest approach - get
> edev by of_node.

> +/*
> + * extcon_get_edev_by_of_node - Get the extcon device from devicetree.
> + * @node       : OF node identyfying edev
> + *
> + * Return the pointer of extcon device if success or ERR_PTR(err) if fail.
> + */
> +struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)

First of all, the all other similar cases use "_by_node" in the name.
Second, it's not _get_, it's _find_.

> +{
> +       struct extcon_dev *edev;
> +
> +       mutex_lock(&extcon_dev_list_lock);
> +       list_for_each_entry(edev, &extcon_dev_list, entry)
> +               if (edev->dev.parent && edev->dev.parent->of_node == node)
> +                       goto out;
> +       edev = ERR_PTR(-EPROBE_DEFER);
> +out:
> +       mutex_unlock(&extcon_dev_list_lock);
> +
> +       return edev;

Can't it be done using bus_find_device()?

> +}

See good example in i2c-core-of.c

of_find_i2c_adapter_by_node()
of_get_i2c_adapter_by_node()

-- 
With Best Regards,
Andy Shevchenko
