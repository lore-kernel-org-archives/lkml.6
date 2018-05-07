Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1604446-1525727629-2-14367935648276351462
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525727629; b=LkSLZuacvwuOxhGzsHYtL6fd2kojaFZIYMALYLs9qSTa3bTngB
    LbHvtb9Q1/zOUzBxaZhnxWHLLcZhCm3y/LjZ+eL80vrCLDmW8JpsJGVRNY4B9qqz
    n89GaaSgopYUg/BZCX7JLPuo1we6OR5/BWKutVVSkVcL7xjK5QLsMXRnFJ2eAfpn
    TXahHZmqvYb2Y2/Te3hHYVAamWFSugGz1eOAnAL/FIWRnlFiEzEXSUd80ySYgyNP
    Mst3Rxo8O20RDQVJLT/Xe+hh7LeYYi4oO2SD6N5FSYKehsdRk6dBvPHm+xkoLAPc
    QfE1WBzDsgCPXaRMnQANVN92FSDVGPXzfWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525727629; bh=GKW653FQ2fKNWmTyMyG28T9xvW0h71v0s5qoSEbbHo
    Q=; b=m89M2U8KBjLmP01qtu7LmbGE1OkkPmoyaI9rRbKRosoQzi9vZu3i0iB7j2
    5pK7/k/NfdXjKF/lmV8UkkT8TWZK+wTj3YBgiUw3gJVTCu//dwfswabPRD5i2TDc
    Y0mr0b/jcARra6SvVIyAjZZj3bBByTBiv0zMeEeaaovQ/EwtUZTNgWr/23MD97cJ
    i3mZps2QGEi2P/tTPqI4k+Fnc9uKZ44jLlZXhVrUUD120XcTqt3IsXdV9k8mkf8l
    bhoYbhV/VKbt11AG+Beoa9DmetO/b9Vp6CoWdhOeRAKfvqR/RQZhlyztSK2ELvVj
    cPmqycIDWF/9MKxWAmQWWUZIcPbw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=D8FidOQO x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=D8FidOQO x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIFQSDZ2djc4uaiSRnJ1h1Z514d5C6mW4xjxAU+ipXcLd/DClnlnlf8COdvQZnVYWZ1nL6SP9XFXydgjRvdohg6Mgp282t+Wcof68PpPzv+IQF0LBiFC
    3wcbvLA7bLN1L1QOkHhpxoowPmB3SWiDKPIG6w2p10CDOPLLgNV5f8zm+6AI7223m8taOtdrVZZOoL/NXHRkez5mwJIYIXe1xvIEGSqcrTkWnizY5hjGXbIC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=5XA2BZfBV_XA0SGpN4EA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbeEGVNh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 17:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753368AbeEGVNf (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 7 May 2018 17:13:35 -0400
X-Google-Smtp-Source: AB8JxZq7mEViXGFmWcvvbJoqmTXgGzpILUYt0Kgkl0MPa0HbXoEXl2gghZfUAdxHhwklcq67K/XdUf3SkcZcYd133Tw=
MIME-Version: 1.0
In-Reply-To: <1525229431-3087-23-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com> <1525229431-3087-23-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 7 May 2018 16:12:53 -0500
X-Gmail-Original-Message-ID: <CANk1AXRzjFibdiO=kxDNOkUyrwQ9ASo1h=aHdMRNMXuGd7iW3g@mail.gmail.com>
Message-ID: <CANk1AXRzjFibdiO=kxDNOkUyrwQ9ASo1h=aHdMRNMXuGd7iW3g@mail.gmail.com>
Subject: Re: [PATCH v5 22/28] fpga: dfl: fme-region: add support for compat_id
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

> This patch adds compat_id support, it reuses fme manager's
> compat id, as the per region compat id is actually from the
> fme manager's register.
>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>

> ---
> v5: reuse fme manager's compat_id as per region compat_id
> ---
>  drivers/fpga/dfl-fme-region.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> index 696b313..b82a381 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -45,6 +45,7 @@ static int fme_region_probe(struct platform_device *pdev)
>         }
>
>         region->priv = pdata;
> +       region->compat_id = mgr->compat_id;
>         platform_set_drvdata(pdev, region);
>
>         ret = fpga_region_register(region);
> --
> 1.8.3.1
>
