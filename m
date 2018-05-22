Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2771174-1527006517-2-12160639753211169141
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527006517; b=KY2UBfTeYxGt+82KN8yKWfZUYK5x2sLAUgBO1P1kNDdCL9ylKM
    yA27ILP6udW4qLcn7chGl6H1UaIb16wTir7K9gLDS1MI/2ZOqGNyrZs2NNG2VpRL
    qOoIuttK6WpzEhAV3bUi3UgvTP3lnZ6z9XYBy8qhDKYcRItWJYeYB6OtuYGFBFf3
    dKv/0BMKg7iXs5usEDr5EXL7TKsXOByX+zEqPaCkRpCGi3mf1NdWBTNCqm0ImS+T
    waxYxd6Q/tKMi9Z3eXE8OOlKa18xUx2lMxCnsbp6SE3Z3ccJPfGVttKflDJclHN8
    A80Ibat6qingiaS9ybBU8XPkZkQcPbSht2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527006517;
    bh=2dT6MqF3koZE05LYHRnLnkSI3of41O5c1Ipd7bAjlhs=; b=iRwTm3szJ3Ga
    yG6Pfa+sTGmVM7IWr1CaWGebgXki6OuHj270RQrBlUoNV/ZFgjdeH8MJK4hEJeC1
    wrhsHqrY/9OABri1xG0w/gqwdX7jcXGfeh/MKOu3zzfCuggFHapkkl84umVbK9aq
    frrYsRfb0bpMs8+sdHyWiOSQE3IQGBONbdU9KWMjvRyPDxZkWwql+BbgrzKUselI
    Gi76tYFtH1mZrboi4zQAdPzcLVIqBOsLnHpD15QMDBrGFXePUhvI2lhLZpWvgsfT
    I9D3w/H8PwUP1745211tyRnuMgpbMKC2krzs1x7pEpgD0iw6dcMsMOEz0+jwU0Hk
    7oJNY9ScqQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG4XrpiiyHIvOt0aR64GPVzxP1ou1T0UH44SJPIBRSsKTFoZbljkRyUJqVoKaNZV0ENSc8a4lsNI6Q0yfqf6WhNJwAFsW3AnyT0pbwXCFjWpFL72eRFo
    Rg3+SGc8Wpaqf1zCxLKP2sE9/aLnqLkOJsu9OaUXfapXRcL41C3RO/SP/WB6POKHVLrurEQQSoCt0H5cnUGo+V13qi0UEbW5XW/Ijaa85zr3MZ1Zl5bQy625
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4Zbj-4zmMWkA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=vb2Ji17uwYWtfcF2XEoA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeEVQ2e (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 12:28:34 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14136 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeEVQ2d (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 May 2018 12:28:33 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 22 May 2018 09:28:32 -0700
Subject: Re: [PATCH 7/8] arm64: tegra: Add nodes for tcu on Tegra194
To: Mikko Perttunen <mperttunen@nvidia.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>
CC: <araza@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-8-mperttunen@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <295c8125-6cdc-92b6-d0d7-01bf6ba0f8bd@nvidia.com>
Date: Tue, 22 May 2018 17:28:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508114403.14499-8-mperttunen@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 08/05/18 12:44, Mikko Perttunen wrote:
> Add nodes required for communication through the Tegra Combined UART.
> This includes the AON HSP instance, addition of shared interrupts
> for the TOP0 HSP instance, and finally the TCU node itself. Also
> mark the HSP instances as compatible to tegra194-hsp, as the hardware
> is not identical but is compatible to tegra186-hsp.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 34 +++++++++++++++++++++++++++++---
>   1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index 6d699815a84f..d7f780b06fe2 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -217,10 +217,31 @@
>   		};
>   
>   		hsp_top0: hsp@3c00000 {
> -			compatible = "nvidia,tegra186-hsp";
> +			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";

I might be wrong, but I think we may need to update the binding doc 
compatibility property for hsp. For example see 
'Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt'.

Cheers
Jon

-- 
nvpublic
