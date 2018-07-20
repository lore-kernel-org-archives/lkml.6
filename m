Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE39ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D17A20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qidpnx3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D17A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbeGTO0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:26:40 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34678 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731035AbeGTO0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:26:40 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so21423772ois.1;
        Fri, 20 Jul 2018 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RoZRTg6lA/wGmRUZrRVyUQzhtMEt/oNg+uEPbBGsYiY=;
        b=qidpnx3SHdbtDumWm2kMyUYKbtIZ0OZBawjg9eKqk4h0LA48IfR7ggY/70QaNm+jBi
         1wcKAhk+wkOlQ3HbnGxbYKrEDdcsLvwsUoKhUN7EBzkTIGDEvbLiw9/WmnkvjCDCZi4X
         +nIj/tMkmCZg4YvU2VDxxw/aQhtsTU6juVQdwUUnFS+O8M9WARMzrIhatvLNeB7608sm
         o/xxoUhTWN6dDNua/0PvwNzA21E8uh9wjPl7EtGIzVPqT83pLacd4nMFFJXkCzuUpyLB
         a4X6Y1jh9QRuVftLUvaMMK0SBoyjY1pVU3epbOWdX2lXi8a9AGUSzy7zO7YJVo6ZEgwq
         xItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RoZRTg6lA/wGmRUZrRVyUQzhtMEt/oNg+uEPbBGsYiY=;
        b=pPxqhGBxe0ptsfQuqVz9ghpiq56Q3spy2CIz3zqkG7Jnns/Arpvg9ZP7hxCvqpLzU/
         qG6WzthYeBIiWFig1v1npsyDVd3tHS05lcLqsYaABXOz8fPT+k6uPPSDteiDucOSIMBA
         w3kyX3sHHYCWtUvUf6fIJeoldK1e/3egEFjE0WWTcqaGERwWiEfI7yjSppQzJ17IJJTt
         YUwVAB9rVNtEL8oEYDs4q22oCduIVwko1C4b+ciEkYWZVQAp3hnik5hMD0HrKBWLTsR+
         dTHzpdGmXvhejnCF6uVc2LlUxgEisBI7TfJK9BsUe+Eq3gWs/KUNjQ4vZbwjx3bQRUJx
         1NmA==
X-Gm-Message-State: AOUpUlFde7Sg2ggc8PX5pdty4WqvyxcSxkjmWQGagNKFpysRp7Ca1y09
        NZI30xIeHh+OufTSCytlDtSVcmdbax2XUiwlCdk=
X-Google-Smtp-Source: AAOMgpdU2jsEL80PMFO2DNWnv3/l4DUeGIkUQVCsjOCkOFQ+/vvaSHx0tsht8xMSMuvM4j+W4qOdVCucflLWk2bBZUQ=
X-Received: by 2002:aca:e510:: with SMTP id c16-v6mr2287595oih.44.1532093899163;
 Fri, 20 Jul 2018 06:38:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 06:38:18
 -0700 (PDT)
In-Reply-To: <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com> <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 20 Jul 2018 10:38:18 -0300
Message-ID: <CAOMZO5BQjxeGOUE3jwbA_sRuYWQkHTJo3AeywXXpm-9kVdsYfw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Initial imx7d pm support
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>, linux-pm@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

On Fri, Jul 20, 2018 at 9:47 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> +static int imx6_pcie_resume_noirq(struct device *dev)
> +{
> +       int ret = 0;

There is no need for initializing 'ret' here.

> +       struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +       struct pcie_port *pp = &imx6_pcie->pci->pp;
> +
> +       if (imx6_pcie->variant != IMX7D)
> +               return 0;
> +
> +       imx6_pcie_assert_core_reset(imx6_pcie);
> +       imx6_pcie_init_phy(imx6_pcie);
> +       imx6_pcie_deassert_core_reset(imx6_pcie);
> +       dw_pcie_setup_rc(pp);
> +
> +       ret = imx6_pcie_establish_link(imx6_pcie);
> +       if (ret < 0)
> +               pr_err("pcie link is down after resume.\n");

Shouldn't the error be propagated?

Also, dev_err() is preferred instead of pr_err().
