Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C580C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7022B21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfAWRLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:11:42 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.120]:29221 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbfAWRLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:11:42 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 7F7827EC2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 11:11:41 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mM3xgvMRT4FKpmM3xgJz1F; Wed, 23 Jan 2019 11:11:41 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=49070 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmM3x-000EWe-4D; Wed, 23 Jan 2019 11:11:41 -0600
Subject: Re: [PATCH net-next] intel: Mark expected switch fall-throughs
To:     jeffrey.t.kirsher@intel.com,
        "David S. Miller" <davem@davemloft.net>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190123074849.GA24230@embeddedor>
 <e356e64d3267bbca1cfa0373b7ce965edaf159bd.camel@intel.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Message-ID: <368769c1-bb6c-b137-14c4-ef0ade488c2e@embeddedor.com>
Date:   Wed, 23 Jan 2019 11:11:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e356e64d3267bbca1cfa0373b7ce965edaf159bd.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmM3x-000EWe-4D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:49070
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrey,

On 1/23/19 11:04 AM, Jeff Kirsher wrote:
> On Wed, 2019-01-23 at 01:48 -0600, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> This patch fixes the following warnings:
>>
>> drivers/net/ethernet/intel/igb/e1000_82575.c:636:6: warning: this
>> statement may fall through [-Wimplicit-fallthrough=]
>> drivers/net/ethernet/intel/igb/igb_main.c:6710:6: warning: this
>> statement may fall through [-Wimplicit-fallthrough=]
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:237:3: warning: this
>> statement may fall through [-Wimplicit-fallthrough=]
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enabling
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  drivers/net/ethernet/intel/i40e/i40e_xsk.c   | 3 ++-
>>  drivers/net/ethernet/intel/igb/e1000_82575.c | 2 +-
>>  drivers/net/ethernet/intel/igb/igb_main.c    | 2 +-
>>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> NAK on the igb changes.  There is already a "fall through" code comment
> which is fine, adding a hyphen does not make the comment any more
> readable.
> 

Those comments are not fine. They trigger the warnings I mention in the
commit log. With this patch such warnings are fixed.

Notice that warning level 3 was used: -Wimplicit-fallthrough=3

Thanks
--
Gustavo
