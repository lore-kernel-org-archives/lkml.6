Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5C0C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF0D2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VK6svXw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF0D2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbeKOVQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:16:05 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35104 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeKOVQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:16:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so16940018ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 03:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycBf29sIaN5VQ2JHnb77IwBI7KrQXoEagmFxshM/On4=;
        b=VK6svXw1KyJrNgJVBUEgirh+93W/zLU+GHUOFzQ05IXCYcX49SD93mKzRqk/RA3izi
         wX5EynUQv9Q8XTI4/rmy+cyX1dfyghpixEsPp9uUe5rSGXD+pAxcoLy6IXjdYXSiE5rn
         rn0XHPRYoFCu/ae5wRRaMKVdUKYkr4pYTcH34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycBf29sIaN5VQ2JHnb77IwBI7KrQXoEagmFxshM/On4=;
        b=s3OCHGbNuGgvsZdU9in6oCdNhLizFrNcGfBRcESfhX3kRxu4g33OlkLvFP9+hReoK/
         yOPI0H/MrMgVK8n1IBPQJ3e5I6729pZOvZo5MphB15VURTKS8OI4ZnELOkGXFldku0cI
         Ikiu/i6CdVmqKJ9nkCVMXZ67HPNxpvP2WDHzZnv1uA/wfC/vAEV53Q30ofZiLMWdj5bS
         kVoGZ55ex0ulH3A/QYjDBO8PB4N913Cdek/J+XdsXOEDDN4ay503GHtFC0xzTkJHdr6l
         FmdcqRvQTR6D+LsFxiENh/ALGu+LTH/SDl/afpc2pkTIAIO6wuIkiMS7rDFTLamRlH83
         LJyA==
X-Gm-Message-State: AGRZ1gIsiuIe5gknhwOrNoJiyTWQdnXtITPAQc5Z51npGN1gweKIywCT
        4fkjnyuRJRHLVE96e8TqINYO5Z3VyqqucgpCUP2DXw==
X-Google-Smtp-Source: AJdET5cy9JDQPi1aKQXRvTh5cZbZo2C37j+zofPsdsIh8s0aiLCiVWaQM1vyoDPRfH/STw9UDjMRjLfyLI24EKE9GJQ=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr3338231ljp.12.1542280119895;
 Thu, 15 Nov 2018 03:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20181107195856.43223-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20181107195856.43223-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 12:08:27 +0100
Message-ID: <CACRpkdabENLZQbYgJufF9_Bcn5QTsETLPN8zT=+BKs982P0NCw@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: Move Rohm vendor ID to generic list
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     vkoul@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 8:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Move the Rohm vendor ID to pci_ids.h from dozen of drivers.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please merge it in a way that doesn't upset Greg! :)

Yours,
Linus Walleij
