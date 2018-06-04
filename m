Return-Path: <linux-pci-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2973495-1528075505-2-10522228802559311777
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-pci-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528075505; b=N4/rh6dpzXw+G+xHR1UgTVBHCtCndCdSXsW4VBxVD6DqRnF1Yh
    +RKEY/Koso8s/qLLi+5yuGVie1bLu3Ih9rFUD/3rv0HQ7XODG4Yc1f0vHeQqrAai
    fGN464KtKxwcwULTFQX20LQ9h+J48reNc28erNSQ0YnAzK28WWbUhUmEfdSkvlIS
    hemqyFyUUCCO+BTK/7ctv4/DIUeXvcMxbiFhOCrcjVbvN9283bhnvPuhygEeTZaG
    ciWESbxoK3sItzywFOqZFhuTR6Ejk+/k1pWrpODjQ5ETpqLhJuiAGaFbz/3dgaiV
    nJu0ztpVzb9fzqONbkPWlh5xCMXYchZv8a6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1528075505; bh=adc2/4L1aNr+5LyEVaLDbzK0z2MiiU
    wwVGSvQemCGRk=; b=eP2xtUNbpxVlEsCSVqSoCFSvQ+4Epiy4b7PEM61jCH0iCk
    JhXJGwDuSguSD0vFFwb5y1mewopiXF30IySc1o2xBRn2JeQW81C3PWzU8dIWFUvz
    opXeKiPEktj/hu9ZJDNc8hO2dKSCFP4lP2X9F0AGdUeF7pTA5wA0yHNCs/5O9Eet
    JyW4NPBpgH+8wGlWwZDM+NC7nGS0TJKIRikA1wIsY4EiNSng8jBEGaBVXuspolJc
    kYNxP+LA6gXcaRvhZYHuaoTLtZ7DKY6ZjxTjl1p3H1DoAsaIz4XYDaX11EMS2STD
    9PG8G2CjlIYVSIr1kDXqMK0iUeOnrx/g5NlBXa1w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=XRLZmhBn header.a=rsa-sha256
    header.s=google x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Y49yDL1v;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=XRLZmhBn header.a=rsa-sha256
      header.s=google x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Y49yDL1v;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJPyIu9yt5/BrXg3PJI4IksUt/jgRbni6WxPq78jbmv+q5oGoLWHKJ5kNCyEYH015xtQ1dHBUBeSZrEUlEt3Twdma0TC58hCM0iTEgf+WlOBZLOtIKiu
    91W5VYi1/OCjXvzgV6JYCNOAvnnOBsJ0R1DRPtHLOhhE7daBvZU7QhOk70CVIny+/n28a4UG/kydMbE7gmJBW60wJ8ub4BbgsS/wie/CYiXoxEILW/opNG4A
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=KKAkSRfTAAAA:8 a=Cq3FnctH2xhL_tSUadMA:9 a=CjuIK1q_8ugA:10
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeFDBZA (ORCPT <rfc822;linux@kroah.com>);
        Sun, 3 Jun 2018 21:25:00 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39486 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbeFDBY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jun 2018 21:24:58 -0400
X-Google-Smtp-Source: ADUXVKKaL3QO+9iTP1wb+So2+JooiKGEbHa9R3lo3f1rdn+ByxaRp1ejYrwei+lp7dtYv8JCTfXiJw==
Date: Sun, 3 Jun 2018 18:24:55 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-gpio@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: qcom: include gpio/consumer.h
Message-ID: <20180604012455.GA3374@builder>
References: <20180530215324.1178564-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530215324.1178564-1-arnd@arndb.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-pci-owner@vger.kernel.org
X-Mailing-List: linux-pci@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 30 May 14:53 PDT 2018, Arnd Bergmann wrote:

> When CONFIG_GPIOLIB is disabled, we run into a build failure:
> 
> drivers/pci/dwc/pcie-qcom.c: In function 'qcom_pcie_probe':
> drivers/pci/dwc/pcie-qcom.c:1223:16: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
>   pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
> 
> Including gpio/consumer.h directly is the correct fix.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/pci/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index b65bbf7c284e..17df19db851e 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -10,7 +10,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> -- 
> 2.9.0
> 
