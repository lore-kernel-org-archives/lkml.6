Return-Path: <marcus.wolf@smarthome-wolf.de>
X-Google-Smtp-Source: AG47ELtAtz1E2XkGGK1IlF2C1EihFsyudW3QUwfCzWmXtkUomgLeXtWs1Qj9UUQWfszRIkawVqd8
ARC-Seal: i=1; a=rsa-sha256; t=1521800560; cv=none;
        d=google.com; s=arc-20160816;
        b=Ho+7ZZ6QuD5ePLz0V7aVUjC7hzgX3Zr0eb9XKdxTLhONgSsW5VQndiY5+DQ6701fm6
         aqx11hsiFtxAF5LHHlboO9BFmp/q54Xf5ON/QEVOkOh5MARXnirhNhTyfyzSO4QdyMI4
         0AhpP+Reg5VAPdhNP277qF7iei4l8xesaEGn0kZQpYMK09v5HvVR28GOJOSFYfOeo+JC
         ojBgshYCFqPvDTN2u9YM6L3j1H/XTzw7G7XqwkE6+qKQLIXcjdFBNlLzqipoYh+ISbwN
         aaADjZub3CsTOSGitjbHl1j+HXyxs3os/udE/GNGGkVmaMCWY158o+jeVFQN86AIQUgs
         yDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=j9LK30LelhN87v3ss/OT3h31slG9u3PlMi6QUrKKVtI=;
        b=AkVTtBblFj4BCVABp7UA6h/VodNpLEjw8tzv3wVNs25zP+yuh/Qw1C0JjgHwpG4vMI
         2Cj9bbolnlwj2r/zgkxDMrZLffMoiY1IzJ0VVf+y5DFGhtW1SS+vo+sPd8WhxRV8+htq
         2jGKX3roLfZHGQuHW8ktW27ftQNGs1/QaFjAd0U5m+jtNpXiyB5ceeTI8wyQgBMvHdJ6
         XSM7oRsiqbhT5o/zizluQ3hGR+s64sriJpvK1uSOzCly+lLIXaxm+vYhd0rha1rxIdj6
         XVa8XJxwFYvkFG8OXeW33iMYMCo33n8pGXhMxjElOs91aHz0cvcuIlADxosJEqd5It2p
         JAVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 85.13.155.146 is neither permitted nor denied by best guess record for domain of marcus.wolf@smarthome-wolf.de) smtp.mailfrom=marcus.wolf@smarthome-wolf.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 85.13.155.146 is neither permitted nor denied by best guess record for domain of marcus.wolf@smarthome-wolf.de) smtp.mailfrom=marcus.wolf@smarthome-wolf.de
Subject: Re: [PATCH] staging: pi433: add descriptions for mutex locks
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Simon_Sandstr=c3=b6m?= <simon@nikanor.nu>,
 Marcus Wolf <linux@Wolf-Entwicklungen.de>, =?UTF-8?Q?Luca_S=c3=b6the?=
 <luca@acul.me>, Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 Michael Panzlaff <michael.panzlaff@fau.de>, Derek Robson
 <robsonde@gmail.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20180323094725.4904-1-Valentin.Vidic@CARNet.hr>
From: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Message-ID: <d263c605-f652-fe24-2034-c699f2d27693@smarthome-wolf.de>
Date: Fri, 23 Mar 2018 11:22:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323094725.4904-1-Valentin.Vidic@CARNet.hr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595721331728718925?=
X-GMAIL-MSGID: =?utf-8?q?1595723545133715774?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Valentin,

could you please decribe in short words, why you think, that hte lock
isn't obsolete?

I wasn't sure, but close to remove the lock. That's why I putted the
comment.

Thanks,

Marcus

Am 23.03.2018 um 10:47 schrieb Valentin Vidic:
> Removes TODO for tx_fifo_lock as tx_fifo is modified from
> both pi433_tx_thread and pi433_write.
> 
> Fixes checkpatch warning:
> 
>   CHECK: struct mutex definition without comment
> 
> Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
> ---
>  drivers/staging/pi433/pi433_if.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index d1e0ddbc79ce..f6f106a3ff8e 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -87,7 +87,7 @@ struct pi433_device {
>  
>  	/* tx related values */
>  	STRUCT_KFIFO_REC_1(MSG_FIFO_SIZE) tx_fifo;
> -	struct mutex		tx_fifo_lock; // TODO: check, whether necessary or obsolete
> +	struct mutex		tx_fifo_lock; /* serialize access to tx_fifo */
>  	struct task_struct	*tx_task_struct;
>  	wait_queue_head_t	tx_wait_queue;
>  	u8			free_in_fifo;
> @@ -100,7 +100,7 @@ struct pi433_device {
>  	u32			rx_bytes_to_drop;
>  	u32			rx_bytes_dropped;
>  	unsigned int		rx_position;
> -	struct mutex		rx_lock;
> +	struct mutex		rx_lock; /* serialize read requests */
>  	wait_queue_head_t	rx_wait_queue;
>  
>  	/* fifo wait queue */
> 

-- 
Smarthome-Wolf UG (haftungsbeschränkt)
Helene-Lange-Weg 23
80637 München
Amtsgericht München, HRB 223529
Umastzsteuer-ID: DE304719911
Geschäftsführer: Marcus Wolf
