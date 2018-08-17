Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DD0C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91602187B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA1uJuP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91602187B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeHQODE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:03:04 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38815 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeHQODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:03:04 -0400
Received: by mail-qt0-f196.google.com with SMTP id w26-v6so8257818qto.5;
        Fri, 17 Aug 2018 04:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7Q4Q9LfabpjHNNloxt0k3A3eZ5+foGVErDM8NRE+MI4=;
        b=VA1uJuP6lOHXut7RGTifY6BOwVHq+C6Uj8I8h7c8SZ/iCTOMysIrBotCNL6/77W5IO
         wdNiGEtZLG7VRHQlhoY9Eqky2LG6811HKAnMtLn6o5Q15ThmMLuaxKa0gRZbxWg6BUMp
         gzYckSWaPOXsC9/j2cRot/XSKLYqx91+ULSVIn3qMxRcV/xGyttb6wzEKkAB24zC6uu3
         g1M7wa3qBSAiS7PeYODtVGRQrjV+jQfvLLRv//sUoADjlKmg9xoFqqno34zsz7h+uKog
         ufTZHtQEJcdVZRSRJgWZOpLGN51SshJb6ued4Ic+Kp6MonqGjQcvQpcVGL3zzEGKRP1R
         VauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7Q4Q9LfabpjHNNloxt0k3A3eZ5+foGVErDM8NRE+MI4=;
        b=ShoXwMBpGjYO9Ac7ZpeVaXThPwl5Fh+3sQ1nFSHEcFucnPdx01AGUEVsMsYh1zdxGU
         dRJEWwDVN0ua7Pz+cqzbQV/YXEb2NLSKuwJfvFiNsr+6QZLOr46V9U03OiI6bMqP6f6a
         H/Wj/s4gjKlHu6S2wBD1Ngec0BXQVH8tbAXZgEb9AIp0+/o73amN6PU1vXQt/VALaRCc
         aJtel3a+U1vuBXst01UzTWJcB4mrUCAK2TXn7j04YJhKeqz94gi01cqlGSirhnYQvCn9
         efgs4sDW23MyEQQ7fnobcnXEGmZZln6rmR3MMDo+hPi3SAFF/sTzMQtiT4/bVIYBmx7F
         V3Bw==
X-Gm-Message-State: AOUpUlF1PKCHZAZ4LWX3oOes/e8/flPU5+O0hQZmR28Uv6iXssbG/fa6
        IbiMesRX8uFOGmU5jtHUmfZpvK4/kICOP06DSuw=
X-Google-Smtp-Source: AA+uWPwU4uZ7eeloTrwcCvkdGTG7VtAkfzAaL1IdSl/Pl7t2b0so46zMC4dsdLNSxtbXdSbfCTWzNLpKTqPc8rrKiyc=
X-Received: by 2002:ac8:4312:: with SMTP id z18-v6mr33646559qtm.295.1534503602679;
 Fri, 17 Aug 2018 04:00:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9c4a:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 04:00:02
 -0700 (PDT)
In-Reply-To: <aee82dc5-cc0f-0698-04a8-a5857fce9791@infradead.org>
References: <aee82dc5-cc0f-0698-04a8-a5857fce9791@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Aug 2018 14:00:02 +0300
Message-ID: <CAHp75Vch70rk+zZ2wv=qjPzEDhAnqRBwBuDEU3x40=+fVZhF1g@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: fix intel_punit_ipc.c build errors
To:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 7:12 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix build errors by #including <linux/io.h>.
>
> ../drivers/platform/x86/intel_punit_ipc.c: In function 'ipc_read_status':
> ../drivers/platform/x86/intel_punit_ipc.c:55:2: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]
>   return readl(ipcdev->base[type][BASE_IFACE]);
> ../drivers/platform/x86/intel_punit_ipc.c: In function 'ipc_write_cmd':
> ../drivers/platform/x86/intel_punit_ipc.c:60:2: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
>   writel(cmd, ipcdev->base[type][BASE_IFACE]);
>

Thanks, pushed to our for-next queue, with Fixes tag appended.

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Zha Qipeng <qipeng.zha@intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> ---
> Found in linux-next but applies to current mainline also.
>
>  drivers/platform/x86/intel_punit_ipc.c |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20180815.orig/drivers/platform/x86/intel_punit_ipc.c
> +++ linux-next-20180815/drivers/platform/x86/intel_punit_ipc.c
> @@ -18,6 +18,7 @@
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <asm/intel_punit_ipc.h>
>
>
>



-- 
With Best Regards,
Andy Shevchenko
