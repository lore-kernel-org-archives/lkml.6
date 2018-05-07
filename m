Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1604446-1525727584-2-4821552389221175510
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525727583; b=cbCUcbax2dX60CsyfDYUyBiATMPDMlNOllZO6ESq+q4A2X5XeR
    +CKmO8wKZQ++hPwWb+8EcxWEW2H5iM0yG5MtaS1UZVvoerX7ZJQUttMmzhHuLjbM
    DRJr3ypgQ9nedC7isRpEVCplk0+u9V6Dy4YByVcpC0Pcm4f0Agf/yDhHn8tdI2fq
    K1fnGsi6i1Za1SRBS5JVf1HGy+9V1ae5aYiPOZpX1lr2ViEOCXiafFseKZA4Tu09
    gtIwegU9DdRUNikAsfzYavRa9BW4MRUDoXNyFe8oumfgZIAIODyMzmmIwluzXQWY
    RpW6UZonVXa8zBVMEDIb40gAUWJDqV8J0Bww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525727583; bh=I2QGiVo8w60ffx+z6SOk1fRMBiDIxC13GB1WY9O6W1
    Q=; b=OAwjDtVkFvvNc/lKDAJ92binljxRz3EigjZLnpSDG6wVnviHzKttt+Biw+
    TywH5NTuJENpwlsbYPGs0iS4NPDVJ3IMO2ExpQgWjWWeob4HLIISxrTPQZS2k3W8
    ab4HxaaHLidSO3qy2h8RdN36+clc3BeajLTIvbVpeqFhaKYo6TO3XL4O17TPPoGy
    cWHR+kVKsFoXZWeUVq5m5RSSJmxB+dfqRY1b7S+/eQBGlGMBFLOtnxscWp5WNmi8
    Zb+CEst6+3zQt8DG30LwQCuyg/oCvhQDQUnYVa6FLPWDYCm8aYt3WeeyX63DRvOR
    Hn/5cYSKg2d47xYE31wRf0aFJ+kg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=evSbalSF x-bits=1024
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=evSbalSF x-bits=1024
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
X-CM-Envelope: MS4wfPwHHkwkusxlGvT2h64dRQCb38qRTxtUR9UCZ59xJLMJRqWtu/Ozbt6L2EY/NCyp1tH/gn5OGFivGXyH6kUXbJA7d5msf0xdR0dJbSS0ezn/xU9j7sYL
    ecDlHlkMkqLzreEzIEGl4faGxfPGspYCW360AOQQN/OXA1dzwm7Vd3G0kI7bOTW5KXuehIRIV54NYDji6Son7BeGGmflGf/MypSHXJP55mhv5yy6x8d9boBs
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=EVFJ7BQ72y2q6q7T_LYA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeEGVNA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 17:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbeEGVNA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 7 May 2018 17:13:00 -0400
X-Google-Smtp-Source: AB8JxZpPXIHiwA5kys9fKWLpcRHxtyhXbS/EwODGVamMARC/dsMajYSOM70vU8jYVzviH0neCZbBCtKggzywhzQ5dGg=
MIME-Version: 1.0
In-Reply-To: <1525229431-3087-20-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com> <1525229431-3087-20-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 7 May 2018 16:12:17 -0500
X-Gmail-Original-Message-ID: <CANk1AXRjZMnAtFMxka-O+AgMedGrbXNYZsNH7cLx=yJwmhFm=g@mail.gmail.com>
Message-ID: <CANk1AXRjZMnAtFMxka-O+AgMedGrbXNYZsNH7cLx=yJwmhFm=g@mail.gmail.com>
Subject: Re: [PATCH v5 19/28] fpga: dfl: fme-mgr: add compat_id support
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

> This patch adds compat_id support to fme manager driver, it
> reads the ID from the hardware register. And it could be used
> for compatibility check before partial reconfiguration.
>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>

> ---
>  drivers/fpga/dfl-fme-mgr.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index 1c5bc5a..afcdb39 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -272,9 +272,17 @@ static u64 fme_mgr_status(struct fpga_manager *mgr)
>         .status = fme_mgr_status,
>  };
>
> +static void fme_mgr_get_compat_id(void __iomem *fme_pr,
> +                                 struct fpga_compat_id *id)
> +{
> +       id->id_l = readq(fme_pr + FME_PR_INTFC_ID_L);
> +       id->id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
> +}
> +
>  static int fme_mgr_probe(struct platform_device *pdev)
>  {
>         struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
> +       struct fpga_compat_id *compat_id;
>         struct device *dev = &pdev->dev;
>         struct fme_mgr_priv *priv;
>         struct fpga_manager *mgr;
> @@ -295,11 +303,18 @@ static int fme_mgr_probe(struct platform_device *pdev)
>                         return PTR_ERR(priv->ioaddr);
>         }
>
> +       compat_id = devm_kzalloc(dev, sizeof(*compat_id), GFP_KERNEL);
> +       if (!compat_id)
> +               return -ENOMEM;
> +
> +       fme_mgr_get_compat_id(priv->ioaddr, compat_id);
> +
>         mgr = fpga_mgr_create(dev, "DFL FME FPGA Manager",
>                               &fme_mgr_ops, priv);
>         if (!mgr)
>                 return -ENOMEM;
>
> +       mgr->compat_id = compat_id;
>         platform_set_drvdata(pdev, mgr);
>
>         ret = fpga_mgr_register(mgr);
> --
> 1.8.3.1
>
