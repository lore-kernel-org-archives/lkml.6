Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbeE1JwW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:52:22 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43085 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754200AbeE1JwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:52:19 -0400
X-Google-Smtp-Source: ADUXVKIVp3IGe8GaoaZIR3Dl5/AsWqpjfQFOLHXw+ly9Ss56Ag3lU2En2j9H7ffTvIQj5LXNdezOOA==
Subject: Re: [PATCH] brcmfmac: stop watchdog before detach and free everything
To: Michael Trimarchi <michael@amarulasolutions.com>
References: <1527493857-2220-1-git-send-email-michael@amarulasolutions.com>
Cc: Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Ian Molton <ian@mnementh.co.uk>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5B0BD13D.8000809@broadcom.com>
Date: Mon, 28 May 2018 11:51:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1527493857-2220-1-git-send-email-michael@amarulasolutions.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/2018 9:50 AM, Michael Trimarchi wrote:
> Watchdog need to be stopped in brcmf_sdio_remove to avoid
> i
> The system is going down NOW!
> [ 1348.110759] Unable to handle kernel NULL pointer dereference at virtual address 000002f8
> Sent SIGTERM to all processes
> [ 1348.121412] Mem abort info:
> [ 1348.126962]   ESR = 0x96000004
> [ 1348.130023]   Exception class = DABT (current EL), IL = 32 bits
> [ 1348.135948]   SET = 0, FnV = 0
> [ 1348.138997]   EA = 0, S1PTW = 0
> [ 1348.142154] Data abort info:
> [ 1348.145045]   ISV = 0, ISS = 0x00000004
> [ 1348.148884]   CM = 0, WnR = 0
> [ 1348.151861] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
> [ 1348.158475] [00000000000002f8] pgd=0000000000000000
> [ 1348.163364] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [ 1348.168927] Modules linked in: ipv6
> [ 1348.172421] CPU: 3 PID: 1421 Comm: brcmf_wdog/mmc0 Not tainted 4.17.0-rc5-next-20180517 #18
> [ 1348.180757] Hardware name: Amarula A64-Relic (DT)
> [ 1348.185455] pstate: 60000005 (nZCv daif -PAN -UAO)
> [ 1348.190251] pc : brcmf_sdiod_freezer_count+0x0/0x20
> [ 1348.195124] lr : brcmf_sdio_watchdog_thread+0x64/0x290

Hi Michael,

Thanks for the patch. In normal scenario the callstack looks like this:

brcmf_sdio_remove()
	-> brcmf_detach()
		-> brcmf_bus_stop()
			-> brcmf_sdio_bus_stop()

In brcmf_sdio_bus_stop() the watchdog is terminated. So in what scenario 
did you encounter this null pointer deref?

Regards,
Arend
