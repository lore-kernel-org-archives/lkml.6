Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A556C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C5420881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C5420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeIMKlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:41:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37706 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeIMKlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:41:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11-v6so4690478wmc.2;
        Wed, 12 Sep 2018 22:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=k81wSs4DpY6ODd3gjWXbDXYqvtnxpgf6RF444p/6UNI=;
        b=ikP5eOPdnaXc0+FBjB0hHYjXjq56zAPN7JfxE4pERODnUkoyv2WX8tRk/xv1Xu+Fmr
         jdF/50C8J6vixV7Wd+XQthG9YpbGtWYxx7JmwfxTK7oioohZDKD7Og/EaEf8htjHhkOK
         Q0qwn/98kVGu9qAJP2s/EO25IsO+HpsRygcL7y/htD/j+djreKavG5fhEdm5UkGCV2e/
         FnQFrE6TinsrWKUcnx2CKO1zAyS/jgczdgTeTwcPqOzcJ9/ZQTajMGQ0Xk4rVNIhO3qm
         i8La7DwW80AnVf2woAjSnGhjgaL7TmXBkCv0TfrTR/VHWI2eEYHUaWBE6gELajMN6Kx9
         a9BQ==
X-Gm-Message-State: APzg51B6ATM7zo06+4+vBkkbm5SN7u6jx2wc9ng65dwyrxHYqJOoba2o
        V2fdajp91rL0KhWSJzkDi5x1MJrn
X-Google-Smtp-Source: ANB0VdbxAsV7j+xA8JADU25sbWR4BvLeo0rAt1cu9eZW12M7+txC3H445zBoziWjArqkad9DvSG8bA==
X-Received: by 2002:a1c:be06:: with SMTP id o6-v6mr4135889wmf.65.1536816829314;
        Wed, 12 Sep 2018 22:33:49 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::70f? ([2a01:4240:2e27:ad85:aaaa::70f])
        by smtp.gmail.com with ESMTPSA id w3-v6sm3561768wrn.16.2018.09.12.22.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 22:33:48 -0700 (PDT)
Subject: Re: [PATCH] tty: max3100: Fix oops while 'cat
 /proc/tty/driver/ttyMAX'
To:     chen.lin5@zte.com.cn, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <201809131038370132780@zte.com.cn>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c2c4a6e5-2c5b-7c7c-1390-146186e7e1b3@suse.cz>
Date:   Thu, 13 Sep 2018 07:33:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201809131038370132780@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/2018, 04:38 AM, chen.lin5@zte.com.cn wrote:
> Before wq 's->workqueue' be initialized in function 'max3100_startup',
> 
> 'cat /proc/tty/driver/ttyMAX' will cause oops.
> 
> 
> Oops: Kernel access of bad area, sig: 11 [#1]
> 
> ...
> 
> NIP [c0049070] __queue_work+0x24/0x268
> 
> LR [c0049308] queue_work_on+0x54/0x70
> 
> Call Trace:
> 
> [db44dba0] [c0049308] queue_work_on+0x54/0x70
> 
> [db44dbb0] [c036befc] max3100_get_mctrl+0x18/0x40
> 
> [db44dbc0] [c03614a4] uart_proc_show+0xfc/0x448
> 
> [db44dc40] [c0111aa8] seq_read+0x198/0x514
> 
> [db44dc90] [c01436e4] proc_reg_read+0x58/0x94
> 
> [db44dca0] [c00ee804] do_iter_read+0x190/0x1e0
> 
> [db44dcc0] [c00f0040] vfs_readv+0x58/0x7c
> 
> [db44dd40] [c011a2f4] default_file_splice_read+0x160/0x27c
> 
> [db44de30] [c0119f74] splice_direct_to_actor+0xec/0x23c
> 
> [db44de80] [c011a158] do_splice_direct+0x94/0xd0
> 
> [db44dec0] [c00eeee8] do_sendfile+0x1e0/0x380
> 
> [db44df10] [c00f0424] sys_sendfile64+0xc0/0xd4
> 
> [db44df40] [c000e260] ret_from_syscall+0x0/0x3c
> 
> 
> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
> 
> ---
> 
>  drivers/tty/serial/max3100.c | 3 ++-
> 
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> 
> index 371569a..0429c2d 100644
> 
> --- a/drivers/tty/serial/max3100.c
> 
> +++ b/drivers/tty/serial/max3100.c
> 
> @@ -391,7 +391,8 @@ static unsigned int max3100_get_mctrl(struct
> uart_port *port)
> 
>         dev_dbg(&s->spi->dev, "%s\n", __func__);
> 
> 
>         /* may not be truly up-to-date */
> 
> -       max3100_dowork(s);
> 
> +       if (s->workqueue)
> 
> +               max3100_dowork(s);

This does not look right in the sense of races (shutdown can kill the
workqueue right after the if. Or even before the if, as s->workqueue =
NULL is only after destroy_workqueue in max3100_shutdown).

If get_mctrl needs the queue, it shall not be created and destroyed ad hoc.

>         /* always assert DCD and DSR since these lines are not wired */
> 
>         return (s->cts ? TIOCM_CTS : 0) | TIOCM_DSR | TIOCM_CAR;
> 
>  }

thanks,
-- 
js
suse labs
