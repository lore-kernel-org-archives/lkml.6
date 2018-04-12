Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeDLUP2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:15:28 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:44142 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeDLUP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:15:26 -0400
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix tx vlan priority mapping
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
CC: <davem@davemloft.net>, <linux-omap@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1523543140-20747-1-git-send-email-ivan.khoronzhuk@linaro.org>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <d4456c5c-6746-dd57-303f-cc2174e5a2e7@ti.com>
Date: Thu, 12 Apr 2018 15:15:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523543140-20747-1-git-send-email-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2018 09:25 AM, Ivan Khoronzhuk wrote:
> The CPDMA_TX_PRIORITY_MAP in real is vlan pcp field priority mapping
> register and basically replaces vlan pcp field for tagged packets.
> So, set it to be 1:1 mapping.

"Otherwise, it will cause unexpected change of egress vlan tagged packets,
 like prio 2 -> prio 5"


> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
> Based on net/master

Fixes: e05 107 e6b 747 ("net: ethernet: ti: cpsw: add multi queue support")

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com> 

> 
>   drivers/net/ethernet/ti/cpsw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 3037127..74f8284 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -129,7 +129,7 @@ do {								\
>   
>   #define RX_PRIORITY_MAPPING	0x76543210
>   #define TX_PRIORITY_MAPPING	0x33221100
> -#define CPDMA_TX_PRIORITY_MAP	0x01234567
> +#define CPDMA_TX_PRIORITY_MAP	0x76543210
>   
>   #define CPSW_VLAN_AWARE		BIT(1)
>   #define CPSW_RX_VLAN_ENCAP	BIT(2)
> 

-- 
regards,
-grygorii
