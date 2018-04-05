Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeDEI5b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 04:57:31 -0400
Received: from gateway30.websitewelcome.com ([192.185.192.34]:12891 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751236AbeDEI53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 04:57:29 -0400
Subject: Re: [PATCH v2] Bluetooth: Remove VLA usage in aes_cmac
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20180321010527.GA16616@embeddedor.com>
 <3BD15121-532A-45E2-B62E-1008C0289500@holtmann.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <2af25866-4e8a-7f9c-9298-e45abfab20c7@embeddedor.com>
Date: Thu, 5 Apr 2018 03:35:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3BD15121-532A-45E2-B62E-1008C0289500@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f40NA-002Hsp-PR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.54.187]:53528
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 04/05/2018 02:23 AM, Marcel Holtmann wrote:

> so I took this patch back out of bluetooth-next before sending the pull request. I think the discussion on how to fix SHASH_DESC_ON_STACK macro needs to complete first. Once that has concluded we can revisit if this patch is still needed or if another solution has been found. Same as with WiFi, these are not just one-shot calls where a memory allocation doesn’t matter. We need this for random address resolution and thus there can be many of the aes_cmac calls when seeing neighboring devices.
> 

Yeah. I agree.

Based on Herbert's response to the discussion about SHASH_DESC_ON_STACK 
https://lkml.org/lkml/2018/3/27/300

it seems it is feasible to fix that macro very easily. I will follow up 
on this.

By the way, what is you opinion on replacing crypto_shash_descsize(ctx) 
with PAGE_SIZE / 8 in SHASH_DESC_ON_STACK?

Does it work for you?

Thanks
--
Gustavo
