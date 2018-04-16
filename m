Return-Path: <SRS0=bVZU=HF=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AIpwx4+bQICSJpshTnkTGA3f9xg4syGsfYxj5KdurVG6OEU7pFgphJU2rIcGDr8O6n6supwsytOa
ARC-Seal: i=1; a=rsa-sha256; t=1523885087; cv=none;
        d=google.com; s=arc-20160816;
        b=WH4avVmEmWaA/DpahyURNlo2bgxMxfuBRXnLMdmIfZ10/G5YI5pcI7Qgnav1hKnCEL
         NAkIxcKPvz6/oA7QlUlaO4O7aTiaNGYEKiKtx/GiNDpwEAvVS1HLYiFeFz6KM12mKvwz
         XNEzXNBHdkBEWWnPHWNKcUZ5ktH7VLYnr9AT5orUSjpm7KBUD0HvvYHZd6aUl9ezRslB
         OM8XeTkB6Q7/pucA/+oUmJMQyU5okV5vjER/qiHh3TTxc4wAFvZ03YsZ7KQjLRrqmS2d
         Cvy9IlJFr+CH7z1SfOIS1vR+eHXLM1HdYFh+7cN5fCizABSN8Zs+kl/zxEokzhIvl0Vq
         tfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=dz3b3cJn+ah0OcQSmgtsGwCAYR1btuquVDwzhsyCx4M=;
        b=nKTnqPpcCosTjZ9gQvpyptk09/OanYHeEAbs5ftgUmHJZS6SOo+pf4SAOT3u4bLzM2
         L/MbEAEOTBqgW593dowWuAn3CgiOIJmPsKxc5pp3SuByyEVHtcVEVaAm3iB+6ltAfFha
         1EVDW5HiVPTaJUYdVrtVqA3bdi/fOiKuNI7Mv3FdofwJNtQ8TN2QMvObGcz+E6w6PCUT
         sUGNVopeeAUMdOUqQoL4SgoiXlBb0ko5hVSa2lYWVQI+ptfMsX0pUq2vsolgtL3E4dNh
         FfdX4/AmroOXEtfL/6zj9c0lyZ9GazJ1CX8AXxZD0QwndntR0HKv/IU123dkzgfO5ZcX
         bmuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=bvzu=hf=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=bVZU=HF=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=bvzu=hf=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=bVZU=HF=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761B02177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 09:24:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ahbong Chang <cwahbong@google.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, Todd Poynor <toddpoynor@google.com>, Philippe
 Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH] trace: add missing forward declaration
Message-ID: <20180416092444.05ec6434@gandalf.local.home>
In-Reply-To: <20180416023626.139915-1-cwahbong@google.com>
References: <20180416023626.139915-1-cwahbong@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597868580333311001?=
X-GMAIL-MSGID: =?utf-8?q?1597909330185991490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 10:36:25 +0800
Ahbong Chang <cwahbong@google.com> wrote:

> Without this forward declaration compile may fail if this header is
> included only for registering other probe event without struct
> pool_workqueue.
> 

Is this for new work or is there a config which this fails with today?

-- Steve

> Signed-off-by: Ahbong Chang <cwahbong@google.com>
> Reviewed-by: Todd Poynor <toddpoynor@google.com>
> ---
>  include/trace/events/workqueue.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
> index 2f057a494d93..9a761bc6a251 100644
> --- a/include/trace/events/workqueue.h
> +++ b/include/trace/events/workqueue.h
> @@ -25,6 +25,8 @@ DECLARE_EVENT_CLASS(workqueue_work,
>  	TP_printk("work struct %p", __entry->work)
>  );
>  
> +struct pool_workqueue;
> +
>  /**
>   * workqueue_queue_work - called when a work gets queued
>   * @req_cpu:	the requested cpu
