Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeDETAz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:00:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34416 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbeDETAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:00:38 -0400
X-Google-Smtp-Source: AIpwx48obrxD12emAT5RkQMiKaff2ro4eKvIQFievTUy+9xxr6m7aLZ9auN1mWNx7GFyNFJ0pAAHdA==
Subject: Re: [PATCH 07/12] brcmfmac: Convert ALLFFMAC to ether_broadcast_addr
To: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
References: <cover.1522479607.git.joe@perches.com>
 <f60d14eaf9027774cff547b82cfb01d0904f6391.1522479608.git.joe@perches.com>
Cc: Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com,
        netdev@vger.kernel.org
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AC67254.1000007@broadcom.com>
Date: Thu, 5 Apr 2018 21:00:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <f60d14eaf9027774cff547b82cfb01d0904f6391.1522479608.git.joe@perches.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/2018 9:05 AM, Joe Perches wrote:
> Remove the local ALLFFMAC extern array and use the new global instead.

I stumbled upon this one couple of weeks ago. I moved the definition to 
flowring.c although I considered for a moment to pick up the task you 
took here valiantly.

> Miscellanea:
>
> o Convert char *mac to const char *mac as it can't be modified

The real reason is off course that your new global is const and thus mac 
variable need to be const as well to avoid compiler warning.

I have to agree with Kalle regarding the upstream logistics, but for 
what it is worth...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c   | 2 --
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h   | 2 --
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c | 8 ++++----
>   3 files changed, 4 insertions(+), 8 deletions(-)
