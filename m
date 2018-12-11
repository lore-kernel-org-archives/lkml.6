Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8BEC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8869F20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8869F20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeLKMb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:31:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55268 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKMb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:31:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so2026625wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 04:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V8JgRKBv3feQhW/yWFzfp76o+gDk0wIw3rRajjK3/s4=;
        b=qcByI2sXkOsM9s3BU+7i+Sm5aWjqRMMxIHvDMFM9ROcvnggy04QXHQzvJL9RLF4uqx
         bAKSIQFsDbtAdOzjbij/FOTKeHuFEVo19gzaPuZuB7mWD76smbFg0t+yKQNXx1QN5lXl
         2twzgSd5fghHyzZF/x70SACbKqAqC56ZDzcRUL0v2gBBBnfV1TlO3DvfwID6kES5TRy6
         y2y387tZE2MJKm/Zd1wFtRw32BlCz2Y6cyP3A8kXvvBII2iCAGS7vpkDe54ffIvQE+y5
         iy3c/kwPPT3ouEuegCeqXnb7FhUlEg16BGZo+YSDne1fBYeYY68OToS3i/vJPpIz4dj9
         lodw==
X-Gm-Message-State: AA+aEWbL81lN9JwOB4qE2Fn7GrNaBGA8onBtj9micqujY4gXJYak019I
        x4Rdr7rPki6Rl5BGiSLEmSj39g==
X-Google-Smtp-Source: AFSGD/XXElTClyYQ5Qr2gz835nrH0tlNZMEPblP0od4If4iwPGB8a1E2YmERiUwEw20bod9R3Ivi4w==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr2007819wmf.17.1544531514271;
        Tue, 11 Dec 2018 04:31:54 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id e19sm28458072wrc.25.2018.12.11.04.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 04:31:53 -0800 (PST)
Subject: Re: [PATCH 1/3] staging: rtl8723bs: change semaphores to completions
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
References: <20181210214032.1441224-1-arnd@arndb.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ec878b0a-9974-91f8-06e3-b6ce9da05834@redhat.com>
Date:   Tue, 11 Dec 2018 13:31:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210214032.1441224-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for the patches.

On 10-12-18 22:40, Arnd Bergmann wrote:
> This driver uses many semaphores, most of them are equivalent to
> completions. The other copies of this driver got moved over to
> completions a while ago, so do the same here.
> 
> In this usage scenario, the two are equivalent, so the behavior
> should not change.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

The entire series looks good to me and I've also given it
a quick test run on a tablet with a rtl8723bs wifi chip:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>   drivers/staging/rtl8723bs/core/rtw_cmd.c      | 20 ++++++++---------
>   drivers/staging/rtl8723bs/core/rtw_mlme.c     |  2 --
>   drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  4 ++--
>   drivers/staging/rtl8723bs/core/rtw_xmit.c     |  8 +++----
>   .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  4 ++--
>   .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    | 22 ++++++++-----------
>   drivers/staging/rtl8723bs/hal/sdio_ops.c      |  2 +-
>   drivers/staging/rtl8723bs/include/rtw_cmd.h   |  7 +++---
>   drivers/staging/rtl8723bs/include/rtw_xmit.h  |  9 ++++----
>   drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  6 ++---
>   drivers/staging/rtl8723bs/os_dep/xmit_linux.c |  2 +-
>   11 files changed, 39 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index 830be63391b7..3d206c33eafa 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -166,10 +166,8 @@ sint	_rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
>   {
>   	sint res = _SUCCESS;
>   
> -	sema_init(&(pcmdpriv->cmd_queue_sema), 0);
> -	/* sema_init(&(pcmdpriv->cmd_done_sema), 0); */
> -	sema_init(&(pcmdpriv->terminate_cmdthread_sema), 0);
> -
> +	init_completion(&pcmdpriv->cmd_queue_comp);
> +	init_completion(&pcmdpriv->terminate_cmdthread_comp);
>   
>   	_rtw_init_queue(&(pcmdpriv->cmd_queue));
>   
> @@ -369,7 +367,7 @@ u32 rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
>   	res = _rtw_enqueue_cmd(&pcmdpriv->cmd_queue, cmd_obj);
>   
>   	if (res == _SUCCESS)
> -		up(&pcmdpriv->cmd_queue_sema);
> +		complete(&pcmdpriv->cmd_queue_comp);
>   
>   exit:
>   	return res;
> @@ -410,8 +408,8 @@ void rtw_stop_cmd_thread(struct adapter *adapter)
>   		atomic_read(&(adapter->cmdpriv.cmdthd_running)) == true &&
>   		adapter->cmdpriv.stop_req == 0) {
>   		adapter->cmdpriv.stop_req = 1;
> -		up(&adapter->cmdpriv.cmd_queue_sema);
> -		down(&adapter->cmdpriv.terminate_cmdthread_sema);
> +		complete(&adapter->cmdpriv.cmd_queue_comp);
> +		wait_for_completion(&adapter->cmdpriv.terminate_cmdthread_comp);
>   	}
>   }
>   
> @@ -435,13 +433,13 @@ int rtw_cmd_thread(void *context)
>   
>   	pcmdpriv->stop_req = 0;
>   	atomic_set(&(pcmdpriv->cmdthd_running), true);
> -	up(&pcmdpriv->terminate_cmdthread_sema);
> +	complete(&pcmdpriv->terminate_cmdthread_comp);
>   
>   	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("start r871x rtw_cmd_thread !!!!\n"));
>   
>   	while (1) {
> -		if (down_interruptible(&pcmdpriv->cmd_queue_sema)) {
> -			DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" down_interruptible(&pcmdpriv->cmd_queue_sema) return != 0, break\n", FUNC_ADPT_ARG(padapter));
> +		if (wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp)) {
> +			DBG_871X_LEVEL(_drv_always_, FUNC_ADPT_FMT" wait_for_completion_interruptible(&pcmdpriv->cmd_queue_comp) return != 0, break\n", FUNC_ADPT_ARG(padapter));
>   			break;
>   		}
>   
> @@ -581,7 +579,7 @@ int rtw_cmd_thread(void *context)
>   		rtw_free_cmd_obj(pcmd);
>   	} while (1);
>   
> -	up(&pcmdpriv->terminate_cmdthread_sema);
> +	complete(&pcmdpriv->terminate_cmdthread_comp);
>   	atomic_set(&(pcmdpriv->cmdthd_running), false);
>   
>   	thread_exit();
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 4c5d5cf9dfe0..81505f3bce8b 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -2373,8 +2373,6 @@ sint rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, s
>   
>   		INIT_LIST_HEAD(&pcmd->list);
>   
> -		/* sema_init(&(pcmd->cmd_sem), 0); */
> -
>   		res = rtw_enqueue_cmd(pcmdpriv, pcmd);
>   	} else{
>   		setkey_hdl(adapter, (u8 *)psetkeyparm);
> diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> index 59a667753266..a0d8fbeecf9b 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> @@ -745,10 +745,10 @@ void cpwm_int_hdl(
>   
>   	if (pwrpriv->cpwm >= PS_STATE_S2) {
>   		if (pwrpriv->alives & CMD_ALIVE)
> -			up(&padapter->cmdpriv.cmd_queue_sema);
> +			complete(&padapter->cmdpriv.cmd_queue_comp);
>   
>   		if (pwrpriv->alives & XMIT_ALIVE)
> -			up(&padapter->xmitpriv.xmit_sema);
> +			complete(&padapter->xmitpriv.xmit_comp);
>   	}
>   
>   	up(&pwrpriv->lock);
> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> index 729fd37f440b..fdfa4b3c4c10 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> @@ -45,8 +45,8 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>   
>   	spin_lock_init(&pxmitpriv->lock);
>   	spin_lock_init(&pxmitpriv->lock_sctx);
> -	sema_init(&pxmitpriv->xmit_sema, 0);
> -	sema_init(&pxmitpriv->terminate_xmitthread_sema, 0);
> +	init_completion(&pxmitpriv->xmit_comp);
> +	init_completion(&pxmitpriv->terminate_xmitthread_comp);
>   
>   	/*
>   	Please insert all the queue initializaiton using _rtw_init_queue below
> @@ -2879,7 +2879,7 @@ void enqueue_pending_xmitbuf(
>   	list_add_tail(&pxmitbuf->list, get_list_head(pqueue));
>   	spin_unlock_bh(&pqueue->lock);
>   
> -	up(&(pri_adapter->xmitpriv.xmit_sema));
> +	complete(&(pri_adapter->xmitpriv.xmit_comp));
>   }
>   
>   void enqueue_pending_xmitbuf_to_head(
> @@ -2998,7 +2998,7 @@ int rtw_xmit_thread(void *context)
>   		flush_signals_thread();
>   	} while (_SUCCESS == err);
>   
> -	up(&padapter->xmitpriv.terminate_xmitthread_sema);
> +	complete(&padapter->xmitpriv.terminate_xmitthread_comp);
>   
>   	thread_exit();
>   }
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> index c7e55618b9a8..85fd12cca4ae 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> @@ -4502,8 +4502,8 @@ void rtl8723b_stop_thread(struct adapter *padapter)
>   
>   	/*  stop xmit_buf_thread */
>   	if (xmitpriv->SdioXmitThread) {
> -		up(&xmitpriv->SdioXmitSema);
> -		down(&xmitpriv->SdioXmitTerminateSema);
> +		complete(&xmitpriv->SdioXmitStart);
> +		wait_for_completion(&xmitpriv->SdioXmitTerminate);
>   		xmitpriv->SdioXmitThread = NULL;
>   	}
>   #endif
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> index 10b3f9733bad..69c4db5b5b0c 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> @@ -148,7 +148,7 @@ s32 rtl8723bs_xmit_buf_handler(struct adapter *padapter)
>   
>   	pxmitpriv = &padapter->xmitpriv;
>   
> -	if (down_interruptible(&pxmitpriv->xmit_sema)) {
> +	if (wait_for_completion_interruptible(&pxmitpriv->xmit_comp)) {
>   		DBG_871X_LEVEL(_drv_emerg_, "%s: down SdioXmitBufSema fail!\n", __func__);
>   		return _FAIL;
>   	}
> @@ -312,7 +312,7 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
>   						DBG_871X_LEVEL(_drv_err_, "%s: xmit_buf is not enough!\n", __func__);
>   #endif
>   						err = -2;
> -						up(&(pxmitpriv->xmit_sema));
> +						complete(&(pxmitpriv->xmit_comp));
>   						break;
>   					}
>   					k = 0;
> @@ -420,8 +420,8 @@ static s32 rtl8723bs_xmit_handler(struct adapter *padapter)
>   
>   	pxmitpriv = &padapter->xmitpriv;
>   
> -	if (down_interruptible(&pxmitpriv->SdioXmitSema)) {
> -		DBG_871X_LEVEL(_drv_emerg_, "%s: down sema fail!\n", __func__);
> +	if (wait_for_completion_interruptible(&pxmitpriv->SdioXmitStart)) {
> +		DBG_871X_LEVEL(_drv_emerg_, "%s: SdioXmitStart fail!\n", __func__);
>   		return _FAIL;
>   	}
>   
> @@ -490,10 +490,6 @@ int rtl8723bs_xmit_thread(void *context)
>   
>   	DBG_871X("start "FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
>   
> -	/*  For now, no one would down sema to check thread is running, */
> -	/*  so mark this temporary, Lucas@20130820 */
> -/* 	up(&pxmitpriv->SdioXmitTerminateSema); */
> -
>   	do {
>   		ret = rtl8723bs_xmit_handler(padapter);
>   		if (signal_pending(current)) {
> @@ -501,7 +497,7 @@ int rtl8723bs_xmit_thread(void *context)
>   		}
>   	} while (_SUCCESS == ret);
>   
> -	up(&pxmitpriv->SdioXmitTerminateSema);
> +	complete(&pxmitpriv->SdioXmitTerminate);
>   
>   	RT_TRACE(_module_hal_xmit_c_, _drv_notice_, ("-%s\n", __func__));
>   
> @@ -590,7 +586,7 @@ s32 rtl8723bs_hal_xmit(
>   		return true;
>   	}
>   
> -	up(&pxmitpriv->SdioXmitSema);
> +	complete(&pxmitpriv->SdioXmitStart);
>   
>   	return false;
>   }
> @@ -611,7 +607,7 @@ s32	rtl8723bs_hal_xmitframe_enqueue(
>   #ifdef CONFIG_SDIO_TX_TASKLET
>   		tasklet_hi_schedule(&pxmitpriv->xmit_tasklet);
>   #else
> -		up(&pxmitpriv->SdioXmitSema);
> +		complete(&pxmitpriv->SdioXmitStart);
>   #endif
>   	}
>   
> @@ -634,8 +630,8 @@ s32 rtl8723bs_init_xmit_priv(struct adapter *padapter)
>   	phal = GET_HAL_DATA(padapter);
>   
>   	spin_lock_init(&phal->SdioTxFIFOFreePageLock);
> -	sema_init(&xmitpriv->SdioXmitSema, 0);
> -	sema_init(&xmitpriv->SdioXmitTerminateSema, 0);
> +	init_completion(&xmitpriv->SdioXmitStart);
> +	init_completion(&xmitpriv->SdioXmitTerminate);
>   
>   	return _SUCCESS;
>   }
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> index d6b93e1f78d8..3fee34484577 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> @@ -1023,7 +1023,7 @@ void sd_int_dpc(struct adapter *adapter)
>   		u8 freepage[4];
>   
>   		_sdio_local_read(adapter, SDIO_REG_FREE_TXPG, 4, freepage);
> -		up(&(adapter->xmitpriv.xmit_sema));
> +		complete(&(adapter->xmitpriv.xmit_comp));
>   	}
>   
>   	if (hal->sdio_hisr & SDIO_HISR_CPWM1) {
> diff --git a/drivers/staging/rtl8723bs/include/rtw_cmd.h b/drivers/staging/rtl8723bs/include/rtw_cmd.h
> index 7dc5bf050839..299b55538788 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_cmd.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_cmd.h
> @@ -7,6 +7,7 @@
>   #ifndef __RTW_CMD_H_
>   #define __RTW_CMD_H_
>   
> +#include <linux/completion.h>
>   
>   #define C2H_MEM_SZ (16*1024)
>   
> @@ -27,7 +28,6 @@
>   		u8 *rsp;
>   		u32 rspsz;
>   		struct submit_ctx *sctx;
> -		/* _sema		cmd_sem; */
>   		struct list_head	list;
>   	};
>   
> @@ -38,9 +38,8 @@
>   	};
>   
>   	struct cmd_priv {
> -		_sema	cmd_queue_sema;
> -		/* _sema	cmd_done_sema; */
> -		_sema	terminate_cmdthread_sema;
> +		struct completion cmd_queue_comp;
> +		struct completion terminate_cmdthread_comp;
>   		struct __queue	cmd_queue;
>   		u8 cmd_seq;
>   		u8 *cmd_buf;	/* shall be non-paged, and 4 bytes aligned */
> diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
> index a75b668d09a6..1b38b9182b31 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
> @@ -7,6 +7,7 @@
>   #ifndef _RTW_XMIT_H_
>   #define _RTW_XMIT_H_
>   
> +#include <linux/completion.h>
>   
>   #define MAX_XMITBUF_SZ	(20480)	/*  20k */
>   
> @@ -364,8 +365,8 @@ struct	xmit_priv {
>   
>   	_lock	lock;
>   
> -	_sema	xmit_sema;
> -	_sema	terminate_xmitthread_sema;
> +	struct completion xmit_comp;
> +	struct completion terminate_xmitthread_comp;
>   
>   	/* struct __queue	blk_strms[MAX_NUMBLKS]; */
>   	struct __queue	be_pending;
> @@ -419,8 +420,8 @@ struct	xmit_priv {
>   	struct tasklet_struct xmit_tasklet;
>   #else
>   	void *SdioXmitThread;
> -	_sema		SdioXmitSema;
> -	_sema		SdioXmitTerminateSema;
> +	struct completion SdioXmitStart;
> +	struct completion SdioXmitTerminate;
>   #endif /* CONFIG_SDIO_TX_TASKLET */
>   
>   	struct __queue free_xmitbuf_queue;
> diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> index 181642358e3f..143e3f9b31aa 100644
> --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> @@ -585,7 +585,7 @@ u32 rtw_start_drv_threads(struct adapter *padapter)
>   	if (IS_ERR(padapter->cmdThread))
>   		_status = _FAIL;
>   	else
> -		down(&padapter->cmdpriv.terminate_cmdthread_sema); /* wait for cmd_thread to run */
> +		wait_for_completion(&padapter->cmdpriv.terminate_cmdthread_comp); /* wait for cmd_thread to run */
>   
>   	rtw_hal_start_thread(padapter);
>   	return _status;
> @@ -598,8 +598,8 @@ void rtw_stop_drv_threads (struct adapter *padapter)
>   	rtw_stop_cmd_thread(padapter);
>   
>   	/*  Below is to termindate tx_thread... */
> -	up(&padapter->xmitpriv.xmit_sema);
> -	down(&padapter->xmitpriv.terminate_xmitthread_sema);
> +	complete(&padapter->xmitpriv.xmit_comp);
> +	wait_for_completion(&padapter->xmitpriv.terminate_xmitthread_comp);
>   	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("\n drv_halt: rtw_xmit_thread can be terminated !\n"));
>   
>   	rtw_hal_stop_thread(padapter);
> diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> index 2cf903c66854..4e4e565d991c 100644
> --- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> @@ -101,7 +101,7 @@ void rtw_os_xmit_schedule(struct adapter *padapter)
>   		return;
>   
>   	if (!list_empty(&padapter->xmitpriv.pending_xmitbuf_queue.queue))
> -		up(&pri_adapter->xmitpriv.xmit_sema);
> +		complete(&pri_adapter->xmitpriv.xmit_comp);
>   }
>   
>   static void rtw_check_xmit_resource(struct adapter *padapter, _pkt *pkt)
> 
