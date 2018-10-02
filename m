Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B812BC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D03120652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKOPYvba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D03120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbeJCEMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:12:37 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41324 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbeJCEMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:12:37 -0400
Received: by mail-yw1-f68.google.com with SMTP id q129-v6so1409484ywg.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzcqM/rVWwzc0wmX30nq1BkiMVJhHzG/51VLHzXTf0g=;
        b=iKOPYvbakSht5ae1MvLYMnmnd+zul+hndvaDxw1ZvN3VOuCYYhDQma2v2n61ixPBDr
         gaVX+9or6VwtNxPEXEOIxYyoJm0teNRAV5uk4OP/dci/K8dz3Qt8Oh5idD5Evmj5Cx6Z
         o6c3454IeKgrh1VlMtPqwtzwkIdEG5iHawsb3y72iEffy2b2laNjCpCgVyqUoUIR42UA
         Pa/otS4Y82uEhbNU91vEOAXtArCTuhQcVyUQJmhSxw+F0aaw8WvdCvSFEcS8mRn2nBUa
         lek1ZYijaHnhh3/9WkRflptn/iJUcxLaSCwImgvfXf4frXyshhv77NnmLOQEL+zR0hI+
         BRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzcqM/rVWwzc0wmX30nq1BkiMVJhHzG/51VLHzXTf0g=;
        b=fQRaS2hxf4xncmOyqwxPUZRsDbfIHkKSYYaAQM6FQQfiN/kVSsA+L4N+pwBIwDSedC
         9D1CYgZDKzl6txyA+tgZ9R6ZClMRhjDJTqUnd3ZPG1NJdzF2a8VCexr0RjUK0M6ZtVmQ
         x5NafoLr1Ui4J8YyGZCxs4CdjpoIVL/PdvLjNDrcaSpQXBQ/l5rnoHr1EVytvafVBsjg
         uhqBqbc/FdKNSIKJu2jbvGHMaHtp1n2HOCz1Cg5vzbxYsH+iUmtEkZyxD1i9Mvqa8qIc
         Cc1VcVQWFh93Fcg8HyVlfFDBU6X1crN+uM7apkdnhWx4fPXYC9uKg0fRCt8teadcyPCM
         deBg==
X-Gm-Message-State: ABuFfogtuqCkDVUzVbaHdrqK+PA5vKXwMh63XlI+HJxGK1FnJ8b580z/
        gcTxRGiCBv/aDlRCHEgOw1/+YALvzj54BUMK9Hp1
X-Google-Smtp-Source: ACcGV63dvkrxoaq+Sn+OisVlXCpMFLz46QbYaErT0Hyh7nLQpfYcfd6k+W/3lUKg8ENIY5oMV2bV6AodP/F9U0c1kCQ=
X-Received: by 2002:a81:4849:: with SMTP id v70-v6mr9706819ywa.204.1538515635409;
 Tue, 02 Oct 2018 14:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181002210426.2447078-1-arnd@arndb.de>
In-Reply-To: <20181002210426.2447078-1-arnd@arndb.de>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 2 Oct 2018 16:27:02 -0500
Message-ID: <CAErSpo6+nfBxSC3_33aP_yXLh_07zM9+bDej0U_-nUyR+BXFhg@mail.gmail.com>
Subject: Re: [PATCH] XXX PCI/AER: remove unused variables
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     poza@codeaurora.org,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        David Miller <davem@davemloft.net>,
        linux-net-drivers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        amritha.nambiar@intel.com, alan.brady@intel.com,
        Alex Duyck <alexander.h.duyck@intel.com>,
        shannon.nelson@oracle.com, brouer@redhat.com,
        dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 4:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> A couple of files now contain a function with a return
> code variable that is no longer used:

These are fixed already, thanks.

> drivers/net/ethernet/sfc/efx.c: In function 'efx_io_slot_reset':
> drivers/net/ethernet/sfc/efx.c:3824:6: error: unused variable 'rc' [-Werror=unused-variable]
>   int rc;
>       ^~
> drivers/net/ethernet/sfc/falcon/efx.c: In function 'ef4_io_slot_reset':
> Oza Pawandeep <poza@codeaurora.org>
> drivers/net/ethernet/sfc/falcon/efx.c:3163:6: error: unused variable 'rc' [-Werror=unused-variable]
>   int rc;
>       ^~
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_io_slot_reset':
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11143:6: error: unused variable 'err' [-Werror=unused-variable]
>   int err;
>       ^~~
> drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_pci_error_slot_reset':
> drivers/net/ethernet/intel/i40e/i40e_main.c:14555:6: error: unused variable 'err' [-Werror=unused-variable]
>   int err;
>
> drivers/dma/ioat/init.c: In function 'ioat_pcie_error_slot_reset':
> drivers/dma/ioat/init.c:1255:6: error: unused variable 'err' [-Werror=unused-variable]
>   int err;
>
> This removes all the ones I found during randconfig build testing.
>
> Fixes: 6dcde3e574b2 ("XXX PCI/AER: Remove pci_cleanup_aer_uncorrect_error_status() calls")
> Cc: Oza Pawandeep <poza@codeaurora.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/ioat/init.c                       | 1 -
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 1 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 1 -
>  drivers/net/ethernet/sfc/efx.c                | 1 -
>  drivers/net/ethernet/sfc/falcon/efx.c         | 1 -
>  5 files changed, 5 deletions(-)
>
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 80c475fb8ede..bd8db5c99597 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -1252,7 +1252,6 @@ static pci_ers_result_t ioat_pcie_error_detected(struct pci_dev *pdev,
>  static pci_ers_result_t ioat_pcie_error_slot_reset(struct pci_dev *pdev)
>  {
>         pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
> -       int err;
>
>         dev_dbg(&pdev->dev, "%s post reset handling\n", DRV_NAME);
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 4654ac69dfb6..bc71a21c1dc2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -14552,7 +14552,6 @@ static pci_ers_result_t i40e_pci_error_slot_reset(struct pci_dev *pdev)
>  {
>         struct i40e_pf *pf = pci_get_drvdata(pdev);
>         pci_ers_result_t result;
> -       int err;
>         u32 reg;
>
>         dev_dbg(&pdev->dev, "%s\n", __func__);
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 9bee51d900ac..0a2b9cad4b1c 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -11140,7 +11140,6 @@ static pci_ers_result_t ixgbe_io_slot_reset(struct pci_dev *pdev)
>  {
>         struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
>         pci_ers_result_t result;
> -       int err;
>
>         if (pci_enable_device_mem(pdev)) {
>                 e_err(probe, "Cannot re-enable PCI device after reset.\n");
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index ec941ca967b3..98fe7e762e17 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -3821,7 +3821,6 @@ static pci_ers_result_t efx_io_slot_reset(struct pci_dev *pdev)
>  {
>         struct efx_nic *efx = pci_get_drvdata(pdev);
>         pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
> -       int rc;
>
>         if (pci_enable_device(pdev)) {
>                 netif_err(efx, hw, efx->net_dev,
> diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
> index 9b728efd71a4..8b1f94d7a6c5 100644
> --- a/drivers/net/ethernet/sfc/falcon/efx.c
> +++ b/drivers/net/ethernet/sfc/falcon/efx.c
> @@ -3160,7 +3160,6 @@ static pci_ers_result_t ef4_io_slot_reset(struct pci_dev *pdev)
>  {
>         struct ef4_nic *efx = pci_get_drvdata(pdev);
>         pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
> -       int rc;
>
>         if (pci_enable_device(pdev)) {
>                 netif_err(efx, hw, efx->net_dev,
> --
> 2.18.0
>
