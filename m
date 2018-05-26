Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030899AbeEZAWO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 20:22:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42332 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968411AbeEZAWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 20:22:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBAF460290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH, net-next] qcom-emag: hide ACPI specific functions
To: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>
Cc: Hemanth Puranik <hpuranik@codeaurora.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180525213714.2120604-1-arnd@arndb.de>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <d625691f-a240-23ee-3751-d577c5e72423@codeaurora.org>
Date: Fri, 25 May 2018 19:22:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180525213714.2120604-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/18 4:37 PM, Arnd Bergmann wrote:
> +#ifdef CONFIG_ACPI
>   static int emac_sgmii_irq_clear(struct emac_adapter *adpt, u8 irq_bits)
>   {
>   	struct emac_sgmii *phy = &adpt->phy;
> @@ -288,6 +289,7 @@ static struct sgmii_ops qdf2400_ops = {
>   	.link_change = emac_sgmii_common_link_change,
>   	.reset = emac_sgmii_common_reset,
>   };
> +#endif

This seems wrong.  The SGMII interrupt handler should still be viable on 
a device-tree system.  There is a DT compatibility entry for the qdf2432.

Looks like that most recent patch on net-next broke DT support, when it 
removed these lines:

-	phy->open = emac_sgmii_open;
-	phy->close = emac_sgmii_close;
-	phy->link_up = emac_sgmii_link_up;
-	phy->link_down = emac_sgmii_link_down;

I'll take it look at it next week when I'm back in the office.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
