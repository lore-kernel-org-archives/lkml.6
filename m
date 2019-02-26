Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84C9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BADE21850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfBZVEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:04:35 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40535 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbfBZVEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 16:04:35 -0500
Received: by mail-ed1-f67.google.com with SMTP id 10so12013547eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 13:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ss6GvNvX46+3xM09pft1Xg0MyJvBSB7g2CZsBGNz6Zs=;
        b=GBFuHDnaY0SQHcWWAo+elYFZ8GlnRMUDGtblDoQIyCM+l6X2pKofkV97TdbILjv3Wo
         h8xg9QWRYepmV29ooMuY0v47qrYmp6Zv/IlICKN+zAI6eU+H2cyR88BQBzbFewKv3/jC
         5ffcG7N4xss028h2eK5JPxqwGmEAmjV07XSxyp4rVh2JQH50c3RphuN5bkoQ7OBX1k1M
         ixchGhD3d9v5hn4dowap3vOvHK+ZKdRZu975oARjvAr1aViGGh3v5t8vVwiiUnt9Zaix
         H6/fhoqVvxMbERlHy+WgabRIyUKLivfQEJz8TCIqekFXU2p3Czr23v4B8lb4k8VbqZXv
         IkGg==
X-Gm-Message-State: AHQUAuYm478udTCht2wT1FbQKjbtucm8HE6S7W/6s0GACuRSfPesNlbb
        leDdyTTJe95AUhYeHae/cYssYg==
X-Google-Smtp-Source: AHgI3IY1Y4XA6zRQRHmF3hVjjZrpbhRWoINQT2e0AODkfpzTt8Elso16TjuhHF/qP6woEI+mU+T4wA==
X-Received: by 2002:a17:906:350a:: with SMTP id r10mr166887eja.110.1551215073251;
        Tue, 26 Feb 2019 13:04:33 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s24sm2305173edd.23.2019.02.26.13.04.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 13:04:32 -0800 (PST)
Subject: Re: [PATCH] virt: vbox: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20190226192317.GA23656@embeddedor>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0e90b0f5-41a3-1a46-daca-1f3f02b1c903@redhat.com>
Date:   Tue, 26 Feb 2019 22:04:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226192317.GA23656@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26-02-19 20:23, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/virt/vboxguest/vboxguest_core.c: In function ‘vbg_core_ioctl’:
> drivers/virt/vboxguest/vboxguest_core.c:1486:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     f32bit = true;
>     ~~~~~~~^~~~~~
> drivers/virt/vboxguest/vboxguest_core.c:1489:2: note: here
>    case VBG_IOCTL_HGCM_CALL(0):
>    ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thank you the patch, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/virt/vboxguest/vboxguest_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
> index 1475ed5ffcde..df7d09409efe 100644
> --- a/drivers/virt/vboxguest/vboxguest_core.c
> +++ b/drivers/virt/vboxguest/vboxguest_core.c
> @@ -1484,8 +1484,8 @@ int vbg_core_ioctl(struct vbg_session *session, unsigned int req, void *data)
>   #ifdef CONFIG_COMPAT
>   	case VBG_IOCTL_HGCM_CALL_32(0):
>   		f32bit = true;
> -		/* Fall through */
>   #endif
> +		/* Fall through */
>   	case VBG_IOCTL_HGCM_CALL(0):
>   		return vbg_ioctl_hgcm_call(gdev, session, f32bit, data);
>   	case VBG_IOCTL_LOG(0):
> 
