Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E045C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9B420883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9B420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbeFUIFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:05:55 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7415 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeFUIFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:05:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b2b5c470001>; Thu, 21 Jun 2018 01:05:27 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 Jun 2018 01:05:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 Jun 2018 01:05:51 -0700
Received: from [10.26.11.123] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 21 Jun
 2018 08:05:47 +0000
Subject: Re: [PATCH v2 2/8] dt-bindings: serial: Add bindings for
 nvidia,tegra194-tcu
To:     Mikko Perttunen <mperttunen@nvidia.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
 <20180620122042.10950-3-mperttunen@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <0e365f49-4188-608f-d3b2-54dbabe8282e@nvidia.com>
Date:   Thu, 21 Jun 2018 09:05:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620122042.10950-3-mperttunen@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/06/18 13:20, Mikko Perttunen wrote:
> Add bindings for the Tegra Combined UART device used to talk to the
> UART console on Tegra194 systems.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> Notes:
>     v2:
>     - Added Rob's Reviewed-by.
> 
>  .../bindings/serial/nvidia,tegra194-tcu.txt        | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> new file mode 100644
> index 000000000000..a8becf6efd2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> @@ -0,0 +1,35 @@
> +NVIDIA Tegra Combined UART (TCU)
> +
> +The TCU is a system for sharing a hardware UART instance among multiple
> +systems within the Tegra SoC. It is implemented through a mailbox-
> +based protocol where each "virtual UART" has a pair of mailboxes, one
> +for transmitting and one for receiving, that is used to communicate
> +with the hardware implementing the TCU.
> +
> +Required properties:
> +- name : Should be tcu
> +- compatible
> +    Array of strings
> +    One of:
> +    - "nvidia,tegra194-tcu"
> +- mbox-names:
> +    "rx" - Mailbox for receiving data from hardware UART
> +    "tx" - Mailbox for transmitting data to hardware UART
> +- mboxes: Mailboxes corresponding to the mbox-names. 
> +
> +This node is a mailbox consumer. See the following files for details of
> +the mailbox subsystem, and the specifiers implemented by the relevant
> +provider(s):
> +
> +- .../mailbox/mailbox.txt
> +- .../mailbox/nvidia,tegra186-hsp.txt
> +
> +Example bindings:
> +-----------------
> +
> +tcu: tcu {
> +	compatible = "nvidia,tegra194-tcu";
> +	mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM 0>,
> +	         <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM 1>;
> +	mbox-names = "rx", "tx";
> +};

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
