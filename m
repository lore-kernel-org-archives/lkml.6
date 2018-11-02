Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D99AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039FA2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039FA2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeKCEvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:51:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40056 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKCEvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:51:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id z12-v6so2700361edp.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 12:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ut/jOW4uhtY9MvBWsMxrATOHKM0BQWVtcqpClVVjSFg=;
        b=PcSLt5OkpXzfmhoUma4b5U53oEGDU35X4stxl6gzmgYpJvlxnAOArTGlOZQ5V64L5U
         Blh4Va2Cil2xFUO+kn5FW1gZRxg+c+toB5X9wHIMvJhqMVuFh+ez7KfAeRLfFCgzS3AZ
         YAl3hJ4/2Nyb2C4nwy/jWq2XApgky1h9GAwIyQQxNGBHMavwK08X7iQfDvIyiFk9uJcn
         hy4iuRflomQz+5EnyruaJ9/0MnH+dd65356FsCQF9sFCkgx1h6ZluCymmFtT2iK4KO3N
         FmZDYKdiOs5UVs8LBM0oxrlUF/jhkwlCJ3+BJpDhqpFZidWHp7HLv08UDDhmyKOHs+9P
         3xWw==
X-Gm-Message-State: AGRZ1gKgr10A3uyYrUUf4cuvhlXzQeCPIMqMkUwwOFuALrGUCjZAh/Jc
        YwJruPiYgTif/FWqpUcSEfI4JNhvVk8=
X-Google-Smtp-Source: AJdET5cqGyFMv8o5hrb+tWVnWXvIkWhkyCWRTJTQpRClVnHeVMUqo9a7o7bZQhmFZ9Pyhv9Yj+yxDA==
X-Received: by 2002:a17:906:31db:: with SMTP id f27-v6mr7355288ejf.186.1541187786778;
        Fri, 02 Nov 2018 12:43:06 -0700 (PDT)
Received: from dhcp-44-202.space.revspace.nl ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id a4-v6sm3076399edk.15.2018.11.02.12.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 12:43:06 -0700 (PDT)
Subject: Re: [PATCH] vbox: fix link error with 'gcc -Og'
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20181102153905.1732199-1-arnd@arndb.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <143892a9-1382-4f49-95e2-4da3316dfe9f@redhat.com>
Date:   Fri, 2 Nov 2018 20:43:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102153905.1732199-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/2/18 4:38 PM, Arnd Bergmann wrote:
> With the new CONFIG_CC_OPTIMIZE_FOR_DEBUGGING option, we get a link
> error in the vboxguest driver, when that fails to optimize out the
> call to the compat handler:
> 
> drivers/virt/vboxguest/vboxguest_core.o: In function `vbg_ioctl_hgcm_call':
> vboxguest_core.c:(.text+0x1f6e): undefined reference to `vbg_hgcm_call32'
> 
> Another compile-time check documents better what we want and avoids
> the error.
> 
> Acked-by: Randy Dunlap<rdunlap@infradead.org>
> Tested-by: Randy Dunlap<rdunlap@infradead.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you, looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/virt/vboxguest/vboxguest_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
> index 3093655c7b92..1475ed5ffcde 100644
> --- a/drivers/virt/vboxguest/vboxguest_core.c
> +++ b/drivers/virt/vboxguest/vboxguest_core.c
> @@ -1312,7 +1312,7 @@ static int vbg_ioctl_hgcm_call(struct vbg_dev *gdev,
>   		return -EINVAL;
>   	}
>   
> -	if (f32bit)
> +	if (IS_ENABLED(CONFIG_COMPAT) && f32bit)
>   		ret = vbg_hgcm_call32(gdev, client_id,
>   				      call->function, call->timeout_ms,
>   				      VBG_IOCTL_HGCM_CALL_PARMS32(call),
> 
