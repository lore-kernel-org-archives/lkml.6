Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2DAC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6586C2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyrILu8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6586C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbeLCIRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:17:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44225 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeLCIRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:17:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id n12so6775521qkh.11;
        Mon, 03 Dec 2018 00:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TaFtUFTT51sHfoaGHeygszhqmvfJuGYPS4fiCSVVGZU=;
        b=FyrILu8IxBUrm5mpKRCOWaTAK9SUfz5jCNDLh0goAlUD741av1kEN7UPiFb0LR5ExI
         CVqtiIfS5fWsi2tNhjzjiMHRgG03uVRTlNI1pNgz43qadzCuiacntQVwMvWCtQcSVzdu
         7sNigZnbwXDhE8rZUGsG2Mn+gvZABJVUMr0Zk/wG7ge7e0Q4Wb26w4MsFS5SEaLAhFuV
         mGlgPvoKkZCbM6h41bpnnDGDn7Cp2em1oDsCR738BLy0TO/SZV0X/XbWxwycGbGJ1UQP
         YpE0CaaHIQBa36s+q5BWDlY/ovMuA+rGasSEROM+jgVr7Ll4Kardjc5BRJhrOaxGbKT1
         iWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TaFtUFTT51sHfoaGHeygszhqmvfJuGYPS4fiCSVVGZU=;
        b=XqElxnp/c/mfbBUbQUXDwU/3Q0jDq+xes3xIDlvds3mINLb7ZTnmN6cud7gDDnqDhH
         s7GgsxWrL36UQ3nc12fOiJe5AC54R391gF6egdDGIzOBAI/jlfAnUFOxNzAaUJR9LCUe
         T7y/X8vOj9VToTIM9o28MVX5iL978QU0WA5+PcpwKOfsdyJuJn3JqZp1DfIUYQZ2wiyy
         WkjA791CnnnmkUDDOttO3JMimcGyvJtBc5NY/qN+2N76IydGESdLl2a9yUnF+HozeERu
         MXezMLC5UrHn3pCPU9pqqaB5JA3DFM8woCRlCz3hGuYdXaC+0RQvVlJa4KPW6ORILDwg
         M/gA==
X-Gm-Message-State: AA+aEWZIm8yx9me+v9M82sjUjxxGj0aIYSZVjTsAjoRFmIjACP41nHyc
        Mu27NWbBvWmbTrbbpQz5Uxey90EjYmifWydrZlMnMitjqKU=
X-Google-Smtp-Source: AFSGD/VAd6NpsosyK8en2/1fP47bE3MZiqunq81Izi+ivk9D9cPWPTGcoxKzP9VIjH/MPztJPWprTogn+qzB7lWESqY=
X-Received: by 2002:a37:4792:: with SMTP id u140mr14292305qka.301.1543825051795;
 Mon, 03 Dec 2018 00:17:31 -0800 (PST)
MIME-Version: 1.0
References: <20181203034515.91412-1-chenyu56@huawei.com> <20181203034515.91412-8-chenyu56@huawei.com>
In-Reply-To: <20181203034515.91412-8-chenyu56@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 10:17:20 +0200
Message-ID: <CAHp75VfUKAQ+Q0cQz-4-=i2JL9uACBX1bVvCeNjZLL1HStDGKQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/12] usb: roles: Find the usb role switch by also
 matching against the device node
To:     chenyu56@huawei.com
Cc:     USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:45 AM Yu Chen <chenyu56@huawei.com> wrote:
>
> This patch adds code for supporting find usb role switch by matching against
> the device node described using of_graph.

>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>

Keep it ordered.

> +static int __switch_match_by_of_node(struct device *dev, const void *name)
> +{
> +       if (!dev->parent || !dev->parent->of_node)
> +               return 0;
> +
> +       return of_node_name_eq(dev->parent->of_node, (const char *)name);
> +}

I think Heikki has introduced some more generic function for this.

>         sw = device_connection_find_match(dev, "usb-role-switch", NULL,
>                                           usb_role_switch_match);

> +       sw = of_graph_find_match_by_type(dev, "usb-role-switch");

Why this is here?! device_connection_find_match() should take care for OF case.

-- 
With Best Regards,
Andy Shevchenko
