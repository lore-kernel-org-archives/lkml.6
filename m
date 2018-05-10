Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966160AbeEJOig (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:38:36 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:18680 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935679AbeEJOid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:38:33 -0400
X-ME-Helo: [192.168.1.12]
X-ME-Date: Thu, 10 May 2018 16:38:32 +0200
X-ME-IP: 86.244.116.1
Subject: Re: [PATCH] net: aquantia: Fix an error handling path in
 'aq_pci_probe()'
To: Igor Russkikh <igor.russkikh@aquantia.com>, davem@davemloft.net,
        pavel.belous@aquantia.com, weiyongjun1@huawei.com,
        dan.carpenter@oracle.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel,gmane.linux.network,gmane.linux.kernel.janitors
References: <20180508063947.11317-1-christophe.jaillet@wanadoo.fr>
 <a784ae7f-cd9c-4141-f862-0c01f61d0200@aquantia.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <2369a016-547d-65e1-9ba7-9a6d16cda41a@wanadoo.fr>
Date: Thu, 10 May 2018 16:38:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a784ae7f-cd9c-4141-f862-0c01f61d0200@aquantia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08/05/2018 à 09:19, Igor Russkikh a écrit :
>
> This was just submitted yesterday and is already accepted in netdev by David:
>
> http://patchwork.ozlabs.org/patch/909746/
>
> Thanks!
>
> BR, Igor
>
Patch timing is sometimes surprising!

Not sure at all if it can be an issue, but I also noted that the order 
of 'pci_release_regions()' and 'free_netdev()' is in reverse
order in the 'aq_pci_remove()' function.
I don't know if done on purpose and/or needed, so I've left it as-is.

CJ
