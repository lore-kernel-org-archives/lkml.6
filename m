Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1289C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA1C25D02
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmuQCuN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA1C25D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965340AbeF0QjK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:39:10 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33431 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752267AbeF0QjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:39:08 -0400
Received: by mail-ua0-f196.google.com with SMTP id u21-v6so1682762uao.0;
        Wed, 27 Jun 2018 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gjI3Ne/ln21BdK+QUDq4mpxavjfPCFRmsNpo76PxHPo=;
        b=pmuQCuN2Apa/CdvY1aK5L2UcE6y03WV6XW+jJkhc3uTgCjqfL98rxN9ZEexLeIXELE
         VtgdFspD4gn3RIsKVnXexetW1+7yTLZ2iRt1L2aIJYEBNVzITPoqhfzu9shRUSbZshzu
         cmMA6ooqaYejvP1NizKQ/Epwn2gnarLCAnCc6ki//YFCTGT+DNAkSTx4OIB4Gp5J8i1i
         OC5wv4Q5w6GpMgYt3KbAuWMokkCNtAWpKfXLAtYV5lj3d3BjslyGo06hD4mtJW/x2kyi
         6XrG7vebmkEGf6kyPdhgDkwGFuns+p/HSlQDK2ccQchvZz9WK5Xdim2G44zzR1458Q2s
         IJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gjI3Ne/ln21BdK+QUDq4mpxavjfPCFRmsNpo76PxHPo=;
        b=G8JQupIrdOQOApyBOYW6tnRLiFAli538Ie8LSZM77i1Uipj0PKvQ6xStcDFhu2UbLp
         7D75QwO3I/KMGmKbaTuTIo0GNtROaW5uyVdKExq2uu06JN9VrGXQ+xPxM7FHaJgsdhvM
         9bWEmwL9gw2CTg5LZmNBZ5Wef5bNQQi1TlBspeBVjnFoYvn/AXNFpP03Sq6ld0mzhyua
         bBh9hqeRVdksp2i7x3fbVcVPxD821XwDDLTQFmO1wbMg6Q3BN6EvM8NGniZcv6RQjo29
         nDDvvDtVe5JRvvqnViznXE65Nq+6xnVppRF7Ml7fJK/C9mWv++0P3pbCqhFd8NIR4DAm
         PjJA==
X-Gm-Message-State: APt69E082pONdCWI+lmC9edkL51KC2609iQ0wgK0J9Q3iM/j7yxzje/i
        v0BZ5FLbpT4fkxr+olb3NE2/sc0ZX9rvb/y+MJk=
X-Google-Smtp-Source: AAOMgpdbrbiLKrV5JYhIkYxkEFIJWvMJqysdytM3giKEwyv7TxfrPp8SZOrUxDu1oon/HtbEK2P8LgEFghUOdoCsy0U=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr4199375uai.47.1530117547254;
 Wed, 27 Jun 2018 09:39:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 09:39:06
 -0700 (PDT)
In-Reply-To: <1530091298-28120-5-git-send-email-honghui.zhang@mediatek.com>
References: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com> <1530091298-28120-5-git-send-email-honghui.zhang@mediatek.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jun 2018 19:39:06 +0300
Message-ID: <CAHp75VdsSZifb5xZ2Q8cmJV=PgAaoN=iOhMfyVX4uE4vNpo=Mg@mail.gmail.com>
Subject: Re: [PATCH 4/4] PCI: mediatek: Add loadable kernel module support
To:     Honghui Zhang <honghui.zhang@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        yingjoe.chen@mediatek.com, Eddie Huang <eddie.huang@mediatek.com>,
        ryder.lee@mediatek.com, hongkun.cao@mediatek.com,
        youlin.pei@mediatek.com, yong.wu@mediatek.com,
        YT Shen <yt.shen@mediatek.com>, sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 12:21 PM,  <honghui.zhang@mediatek.com> wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
>
> Implement remove callback function for Mediatek PCIe driver to add
> loadable kernel module support.

> +static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
> +{
> +       struct mtk_pcie_port *port, *tmp;
> +

> +       if (list_empty(&pcie->ports))
> +               return;

This is redundant.

> +
> +       list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> +               irq_set_chained_handler_and_data(port->irq, NULL, NULL);
> +
> +               if (port->irq_domain)
> +                       irq_domain_remove(port->irq_domain);
> +
> +               if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +                       if (port->msi_domain)
> +                               irq_domain_remove(port->msi_domain);
> +                       if (port->inner_domain)
> +                               irq_domain_remove(port->inner_domain);
> +               }
> +
> +               irq_dispose_mapping(port->irq);
> +       }
> +}

> +static void mtk_pcie_free_resources(struct mtk_pcie *pcie)
> +{
> +       struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> +       struct list_head *windows = &host->windows;
> +
> +       pci_unmap_iospace(&pcie->pio);
> +       pci_free_resource_list(windows);
> +}
> +
> +static int mtk_pcie_remove(struct platform_device *pdev)
> +{
> +       struct mtk_pcie *pcie = platform_get_drvdata(pdev);
> +       struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> +
> +       pci_stop_root_bus(host->bus);
> +       pci_remove_root_bus(host->bus);
> +       mtk_pcie_free_resources(pcie);
> +
> +       mtk_pcie_irq_teardown(pcie);
> +

> +       if (!list_empty(&pcie->ports))

I think this is also not needed. Do you put runtime PM by the way?

> +               mtk_pcie_put_resources(pcie);
> +
> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
