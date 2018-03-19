Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755380AbeCSJcN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:32:13 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:37459 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752957AbeCSJcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:32:09 -0400
X-Google-Smtp-Source: AG47ELug2ZKMtHLX6pCdETHAhrxGKJfrq9OkupW+UnRjknw4bQu/+8DKQkasc4yyuwLT/BRrgyqFcg==
Subject: Re: [PATCH net-next v2 2/2] dt: bindings: add new dt entries for
 brcmfmac
To: Alexey Roslyakov <alexey.roslyakov@gmail.com>, andrew@lunn.ch,
        kvalo@codeaurora.org, robh+dt@kernel.org, mark.rutland@arm.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        chi-hsien.lin@cypress.com, wright.feng@cypress.com,
        netdev@vger.kernel.org
References: <20180319014032.9394-1-alexey.roslyakov@gmail.com>
 <20180319014032.9394-3-alexey.roslyakov@gmail.com>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AAF838D.2030105@broadcom.com>
Date: Mon, 19 Mar 2018 10:31:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20180319014032.9394-3-alexey.roslyakov@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/2018 2:40 AM, Alexey Roslyakov wrote:
> In case if the host has higher align requirements for SG items, allow
> setting device-specific aligns for scatterlist items.
>
> Signed-off-by: Alexey Roslyakov <alexey.roslyakov@gmail.com>
> ---
>   Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> index 86602f264dce..187b8c1b52a7 100644
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> @@ -17,6 +17,11 @@ Optional properties:
>   	When not specified the device will use in-band SDIO interrupts.
>    - interrupt-names : name of the out-of-band interrupt, which must be set
>   	to "host-wake".
> + - brcm,broken-sg-support : boolean flag to indicate that the SDIO host
> +	controller has higher align requirement than 32 bytes for each
> +	scatterlist item.
> + - brcm,sd-head-align : alignment requirement for start of data buffer.
> + - brcm,sd-sgentry-align : length alignment requirement for each sg entry.

Hi Alexey,

Thanks for the patch. However, the problem with these is that they are 
characterizing the host controller and not the wireless device. So from 
device tree perspective , which is to describe the hardware, these 
properties should be SDIO host controller properties. Also I am not sure 
if the broken-sg-support is still needed. We added that for omap_hsmmc, 
but that has since changed to scatter-gather emulation so it might not 
be needed anymore.

Regards,
Arend
