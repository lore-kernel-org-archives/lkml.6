Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754047AbeEWGPp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753866AbeEWGPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:15:40 -0400
Date: Wed, 23 May 2018 11:45:36 +0530
From: Vinod <vkoul@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] PCI: qcom: add runtime pm support to pcie_port
Message-ID: <20180523061536.GE20991@vkoul-mobl>
References: <20180518070736.3003-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518070736.3003-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-05-18, 00:07, Bjorn Andersson wrote:

> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index 5897af7d3355..3f35098b71b1 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -1088,6 +1088,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>  	int ret;
>  
> +	pm_runtime_get_sync(pci->dev);
> +
>  	qcom_ep_reset_assert(pcie);
>  
>  	ret = pcie->ops->init(pcie);
> @@ -1124,6 +1126,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	phy_power_off(pcie->phy);
>  err_deinit:
>  	pcie->ops->deinit(pcie);
> +	pm_runtime_put_sync(pci->dev);

Wondering if there is a reason for sync put here?

-- 
~Vinod
