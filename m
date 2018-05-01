Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3231568-1525183717-2-12842705988276228621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525183717; b=XZ7yw6E7P3GtQDcRFzkEClsQ5qTdKS+2za7X9q8sQRrsjKamLo
    TYwh3UqKdPQLM63cfi+F1BQcgxWJt2bdDDLUbAaCEQuBbC3HhXwE57oa3HPmyvFd
    X876/rNSm69xJO6w536rPXqYhKfDUmkFBo11wbBUcAKN/b9U8WpdJW9THn2RE8GF
    wALj7Sp8JmLjOO37tKZcC0Ye2aXSrqHEGfvWQjWw3PxJs8df1gcAbvSTx9Ynsvyd
    VrOwVYi9Qr8O72nAqJpkNYSsjxPELB2dThcAtPgKvDuq9hDNK5Zi8AhTU2c70f48
    Y3xPPxd0eWgZ514fTrr68WqsSjqEadAVzRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525183717; bh=FvJHv/dhTVqH9TkZGn5/ZQwSS/BxVqqNvJFWMoageT
    g=; b=aoIhlyZ7x7P4BPNg/EW3TMJ+CgKJyYhWlh9kQr0svWkjwqcUWxZ1wIxi6i
    0CWgHSnQxykIlJwlKYb/fquSdSlCi+dI6675y/BCgKqNEJe5l0vtss0p5iHOAQA9
    my0Wt3otQ4uN7KFNrSGXC3ddRlGGZtGQ5YtarRtArWSdqoGZ520jSsmMn91fdKnC
    d0r7KfshYir/qm7iB+iX0Gdi6SPX2CpX7ORSYjvt9g5jhY81hqIhEdmfUnEOGrMN
    6OTxoI20n/RpVqfHW+9wtiVuoHXSYmeeo0m+NZl7Mb6THyq78ieksLezySbWFfEy
    u4z8BY8GI+g8To4QvwktcrF7uv6w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=nifty.com header.i=@nifty.com header.b=YBJXcTkx x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=socionext.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=nifty.com header.i=@nifty.com header.b=YBJXcTkx x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=socionext.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDKgOp6GVpSgEL4odWhPvzZzEj1ygsRVX7dJSmyo03N59wsAG+6ACaSjkpFEVA2i9VN/kmYG5I38QNaFosyAThgnahDytrmYqLYaXxnX1yYfy5Fy3Nhc
    86gTLZfco/gZi3o12sT6K13fkm3cXf9pfbVe4YAUXNfKba9UBGtCE+39kbFlFs8V/uwiyeBMmBHRdzII6Wt9ZpFRqESCoxIuplQ9IgjkxZQXcYwcWJ0xIpzp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=c-n4J4-pAAAA:8 a=VwQbUJbxAAAA:8 a=hsqrQ9mG0DeuFLRPhqIA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=L0NDqeB7ZLmQzAogN4cw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755492AbeEAOIZ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 10:08:25 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:17948 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755199AbeEAOIW (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 1 May 2018 10:08:22 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w41E7q7x011885
X-Nifty-SrcIP: [209.85.213.53]
X-Google-Smtp-Source: AB8JxZpcNQg63BMMYrnaQ/zQaJyrgvyrxoyz81KskHTbGEbGaDKKnamVHkxAIaJrg6Tna2EQLj5Bp2il3TkNlZ5AdTk=
MIME-Version: 1.0
In-Reply-To: <1524135818-14825-2-git-send-email-yamada.masahiro@socionext.com>
References: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com> <1524135818-14825-2-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 1 May 2018 23:07:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ45=EM2pu01MYA7AuXRfqYCLzzOR3sTa+RmaK09CYtJw@mail.gmail.com>
Message-ID: <CAK7LNAQ45=EM2pu01MYA7AuXRfqYCLzzOR3sTa+RmaK09CYtJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: use local copy of resource to fix-up
 register offset
To: linux-usb@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Felipe,


2018-04-19 20:03 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> It is not a good idea to directly modify the resource of a platform
> device.  Modify its local copy, and pass it to devm_ioremap_resource()
> so that we do not need to restore it in the failure path and the remove
> hook.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>


I want this patch applied first
unless you are opposed to this clean-up.

I'd like to avoid re-sending a trivial patch like this.




> ---
>
> Changes in v2: None
>
>  drivers/usb/dwc3/core.c | 32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index a15648d..8e66edd 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1245,7 +1245,7 @@ static void dwc3_check_params(struct dwc3 *dwc)
>  static int dwc3_probe(struct platform_device *pdev)
>  {
>         struct device           *dev = &pdev->dev;
> -       struct resource         *res;
> +       struct resource         *res, dwc_res;
>         struct dwc3             *dwc;
>
>         int                     ret;
> @@ -1270,20 +1270,19 @@ static int dwc3_probe(struct platform_device *pdev)
>         dwc->xhci_resources[0].flags = res->flags;
>         dwc->xhci_resources[0].name = res->name;
>
> -       res->start += DWC3_GLOBALS_REGS_START;
> -
>         /*
>          * Request memory region but exclude xHCI regs,
>          * since it will be requested by the xhci-plat driver.
>          */
> -       regs = devm_ioremap_resource(dev, res);
> -       if (IS_ERR(regs)) {
> -               ret = PTR_ERR(regs);
> -               goto err0;
> -       }
> +       dwc_res = *res;
> +       dwc_res.start += DWC3_GLOBALS_REGS_START;
> +
> +       regs = devm_ioremap_resource(dev, &dwc_res);
> +       if (IS_ERR(regs))
> +               return PTR_ERR(regs);
>
>         dwc->regs       = regs;
> -       dwc->regs_size  = resource_size(res);
> +       dwc->regs_size  = resource_size(&dwc_res);
>
>         dwc3_get_properties(dwc);
>
> @@ -1350,29 +1349,14 @@ static int dwc3_probe(struct platform_device *pdev)
>         pm_runtime_put_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>
> -err0:
> -       /*
> -        * restore res->start back to its original value so that, in case the
> -        * probe is deferred, we don't end up getting error in request the
> -        * memory region the next time probe is called.
> -        */
> -       res->start -= DWC3_GLOBALS_REGS_START;
> -
>         return ret;
>  }
>
>  static int dwc3_remove(struct platform_device *pdev)
>  {
>         struct dwc3     *dwc = platform_get_drvdata(pdev);
> -       struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
>         pm_runtime_get_sync(&pdev->dev);
> -       /*
> -        * restore res->start back to its original value so that, in case the
> -        * probe is deferred, we don't end up getting error in request the
> -        * memory region the next time probe is called.
> -        */
> -       res->start -= DWC3_GLOBALS_REGS_START;
>
>         dwc3_debugfs_exit(dwc);
>         dwc3_core_exit_mode(dwc);
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
