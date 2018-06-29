Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8037CC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8E220685
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR/kOAj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8E220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935500AbeF2Vng (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:43:36 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46092 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933456AbeF2Vnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:43:33 -0400
Received: by mail-vk0-f68.google.com with SMTP id b14-v6so499905vke.13;
        Fri, 29 Jun 2018 14:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EUOdJhhuWtA1wWB8AkYtE0pFwG7sf1YJz09McQNBs/E=;
        b=dR/kOAj/hiLEWde/ZcipD4FNdJSVNdxpX6zWxsaEqN1fdtAn+V/1mRX5BJTpXKhL5v
         KnqUwJdwsfXGLpoMUXerAe4WASG0VUtwrpqRoMCOaNCr7Lol+w7xUxHkIMgRffqXtNIB
         TEdm2WokCanMxPk3rO5k7B8Nj60wmRXB57jb3ZJUdeZlDcA7HniVeT21NvkHk0paEgW8
         Va2af8jWiWiNERtsbKsn3W6k+Qvtl8PoYPouu+ZxgsCpz4ior9gU2sWsFr5YL19KMyaA
         SJTy1zG3H/GdcvoKA7KTea2OhH4OvEJD/fDZxV1920oFyCA+lZR+pUnIu3h6P/bM4FTD
         rXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EUOdJhhuWtA1wWB8AkYtE0pFwG7sf1YJz09McQNBs/E=;
        b=Q8xHAxpXxg0rRFpGXrpXDY+TX6Re6kRv1jCio8OI655umJpI+EMcW0FprnStd6hVSF
         y4P2QKWpjb1UKME3p+EPDjrwu3bAQA/fRSi5gAp2Tge05ly1yv1NrzCmqRGzTkYII62T
         pRwtxf8yw85W/KlNqEAs3+Votb4DrRovtxRlYxsc0icpAtSlfUJNPhCg47EqjZQv7Ul8
         zigzb2ThpnMBU95Q4Q9EAemaI8prcp1D4Cula24/bstetB598Pn8U2zlNIk9KDn6AefR
         23sdKY2aZdS+fo+rOe+sFLtpUoHI72gBgqjYBMIGUs75Uo3aXAiXpvNvq6zA/Hk1lFfc
         Qw5g==
X-Gm-Message-State: APt69E2Mhy5jGnCNusdJ77XIi5+IM52c4y82+XGWnYBN/ni0cMbHYDd8
        13eJocDNBzvUQxWE8vftLMGR8lf23WzzKqQ3NDE=
X-Google-Smtp-Source: AAOMgpdBY8XU84Up0eYx0CzL8gFyrD+eAFDcfOuf7t3tr0sIoTMRTnEFgo0ylEFAvrP7BOGWtJY0ae/k0CVI4ptL6qc=
X-Received: by 2002:a1f:82c7:: with SMTP id e190-v6mr9964952vkd.187.1530308612719;
 Fri, 29 Jun 2018 14:43:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 14:43:32
 -0700 (PDT)
In-Reply-To: <1530214274-21139-4-git-send-email-okaya@codeaurora.org>
References: <1530214274-21139-1-git-send-email-okaya@codeaurora.org> <1530214274-21139-4-git-send-email-okaya@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Jun 2018 00:43:32 +0300
Message-ID: <CAHp75VcYbeRTiggEiQnEV6DKR=F47RxNR0FZ+E-XKPpq8VNpqw@mail.gmail.com>
Subject: Re: [PATCH V4 4/7] PCI: Unify try slot and bus reset API
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VFIO DRIVER" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 10:31 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Drivers are expected to call pci_try_reset_slot() or pci_try_reset_bus() by
> querying if a system supports hotplug or not. A survey showed that most
> drivers don't do this and we are leaking hotplug capability to the user.
>
> Hide pci_try_slot_reset() from drivers and embed into pci_try_bus_reset().
> Change pci_try_reset_bus() parameter from struct pci_bus to struct pci_dev.

> +/**
> + * pci_try_reset_bus - Try to reset a PCI bus
> + * @pdev: top level PCI device to reset via slot/bus
> + *
> + * Same as above except return -EAGAIN if the bus cannot be locked
> + */
> +int pci_try_reset_bus(struct pci_dev *pdev)
> +{
> +       bool slot = false;
> +
> +       if (!pci_probe_reset_slot(pdev->slot))
> +               slot = true;
> +
> +       return slot ? __pci_try_reset_slot(pdev->slot) :
> +                       __pci_try_reset_bus(pdev->bus);

This can be as simple as

  return pci_probe_reset_slot(pdev->slot) ?
    __pci_try_reset_bus(pdev->slot) : __pci_try_reset_slot(pdev->bus);


> +}
>  EXPORT_SYMBOL_GPL(pci_try_reset_bus);


-- 
With Best Regards,
Andy Shevchenko
