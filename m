Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAE3C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E1520883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E1520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbeFUIFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:05:46 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8322 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754374AbeFUIFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:05:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b2b5c450000>; Thu, 21 Jun 2018 01:05:25 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 Jun 2018 01:05:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 Jun 2018 01:05:20 -0700
Received: from [10.26.11.123] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 21 Jun
 2018 08:05:16 +0000
Subject: Re: [PATCH v2 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
To:     Mikko Perttunen <mperttunen@nvidia.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
 <20180620122042.10950-2-mperttunen@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a6364fc7-3586-b4fd-1b8b-e145f7163ce5@nvidia.com>
Date:   Thu, 21 Jun 2018 09:05:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620122042.10950-2-mperttunen@nvidia.com>
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
> HSP interrupts can be routed through exposed "shared interrupts". These
> interrupts can be mapped to various internal interrupt lines. Add
> interrupt properties for shared interrupts to the tegra186-hsp device
> tree bindings. At the same time, add the compatibility string for
> tegra194-hsp, which is backwards compatible with tegra186.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Edited commit message to not say that doorbell interrupts cannot be
>       routed to shared interrupts.
>     - Added tegra194 compatibility string.
> 
>  Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
> index b99d25fc2f26..620c249363ca 100644
> --- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
> +++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
> @@ -15,12 +15,15 @@ Required properties:
>      Array of strings.
>      one of:
>      - "nvidia,tegra186-hsp"
> +    - "nvidia,tegra194-hsp", "nvidia,tegra186-hsp"
>  - reg : Offset and length of the register set for the device.
>  - interrupt-names
>      Array of strings.
>      Contains a list of names for the interrupts described by the interrupt
>      property. May contain the following entries, in any order:
>      - "doorbell"
> +    - "sharedN", where 'N' is a number from zero up to the number of
> +      external interrupts supported by the HSP instance minus one.
>      Users of this binding MUST look up entries in the interrupt property
>      by name, using this interrupt-names property to do so.
>  - interrupts

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
