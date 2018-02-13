Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965715AbeBMTxg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:53:36 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:50905 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965651AbeBMTxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:53:35 -0500
Subject: Re: [PATCH] ARC: Don't check presense of Timer1 in SMP builds
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180213193504.28671-1-abrodkin@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <8a595f83-150c-443c-8aa6-b850877d841f@synopsys.com>
Date: Tue, 13 Feb 2018 11:53:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213193504.28671-1-abrodkin@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.10.161.84]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2018 11:35 AM, Alexey Brodkin wrote:
> In case of SMP we use GFRC from ARconnect and Timer1 is left
> untouched. Still with that check in place we're panicing if Timer1
> is missing in current hardware which is quite unexpected.
>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> ---
>   arch/arc/kernel/setup.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
> index cf97f7d88934..1142d76a7e8f 100644
> --- a/arch/arc/kernel/setup.c
> +++ b/arch/arc/kernel/setup.c
> @@ -391,8 +391,10 @@ static void arc_chk_core_config(void)
>   	if (!cpu->extn.timer0)
>   		panic("Timer0 is not present!\n");
>   
> +#ifndef CONFIG_SMP
>   	if (!cpu->extn.timer1)
>   		panic("Timer1 is not present!\n");
> +#endif

Curious, you have a config w/o TIMER1, so is this a fallout of recent discussions !

-Vineet
