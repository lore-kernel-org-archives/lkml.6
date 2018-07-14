Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6DBECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B2720873
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/frFBAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B2720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbeGNI1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 04:27:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46204 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeGNI1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 04:27:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so15062377ljj.13;
        Sat, 14 Jul 2018 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8dBqgIw3IGOKyVrI6iiQA/aQKEQlL4oYpGBnyqwbGLg=;
        b=U/frFBAuOf43uOvqL7OgtDGtFLenPR2TX6luFSoRdXlGhLOSUIAi6cJobZ9+uY+cxD
         trnh4z0Ed2XVppf66sFTCWh7aEj5+Ag9ze7QXgS2zeJUVGUUgtp/QVJKIIBwcmN+ufSD
         OgfgoXM5gyysQSq0IQ0NxpukKqXKCwRY4Udjef3vehYn2vn/pkmzo1DwuFqKnW7OmNel
         46l45JFpi1P0EJ42EkVT4dN61xgF9p51R3HUwuij1NEl+rF/zoHBjqIjmW6blFgAwfb8
         xEvbELYGhnMJvv6z1maO+1eCe4ZwldHf/EuMU9er4qlGBH6rIa8KnYaZGN2XEugSW0ih
         Y0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8dBqgIw3IGOKyVrI6iiQA/aQKEQlL4oYpGBnyqwbGLg=;
        b=kiz2fY7ffvHc0Yco27eC7d/HMBgaCEmOpTSm4JcOdkDsYAcx67FF/B7PRnShlJrGhf
         YXqFxglGOGHaOr/B5R3SICYiv+dyPZLf5xKfVF9cnWKu6qC6FN7ny530CgaYbKqgeZ+t
         SDezQOOtj0gWzyo2VKzz9eayuVUqzlz5AwiKFrfmFvUrqOv2lKKuvQQKlYnS2OcqCjDF
         2BdUaeTaiM+NnQAszKKnYU4eb+YIgFaPyIq+d8sZLARi/046JjEGgreQULFsSNzVnewz
         tfgKZ4W3ktMxto6RlPmpNRCXMnnMhXuLYDXETEkQqneNVENUWXKH4IF0nEHi+NXyj96d
         XrUg==
X-Gm-Message-State: AOUpUlHF4sNiHet4tD6ijtwWxr3ttW3JI+rv5VvW8xo1hCyh9dwtsxhq
        TvIBENKBacd11+KBatdBHEk=
X-Google-Smtp-Source: AAOMgpcco2IJ6RfFmnHTidSDyEe2rYOWO1H4oZX2U+dj8mMTPZfo2GsbMtyb9Tlj8jwofLC9x5FAbg==
X-Received: by 2002:a2e:291c:: with SMTP id u28-v6mr5099660lje.70.1531555760212;
        Sat, 14 Jul 2018 01:09:20 -0700 (PDT)
Received: from gmail.com (c-2ec26dfb-74736162.cust.telenor.se. [46.194.109.251])
        by smtp.gmail.com with ESMTPSA id 66-v6sm3830174lfq.73.2018.07.14.01.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 01:09:19 -0700 (PDT)
Date:   Sat, 14 Jul 2018 10:09:20 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] Input: pxrc - fix leak of usb_device
Message-ID: <20180714080920.GA15123@gmail.com>
References: <1531512477-31981-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531512477-31981-1-git-send-email-khoroshilov@ispras.ru>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

Good catch!

On Fri, Jul 13, 2018 at 11:07:57PM +0300, Alexey Khoroshilov wrote:
> pxrc_probe() calls usb_get_dev(), but there is no usb_put_dev()
> anywhere in the driver.
> 
> The patch adds one to error handling code and to pxrc_disconnect().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

> ---
>  drivers/input/joystick/pxrc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
> index 07a0dbd3ced2..0a31de63ac8e 100644
> --- a/drivers/input/joystick/pxrc.c
> +++ b/drivers/input/joystick/pxrc.c
> @@ -221,6 +221,7 @@ static int pxrc_probe(struct usb_interface *intf,
>  	usb_free_urb(pxrc->urb);
>  
>  error:
> +	usb_put_dev(pxrc->udev);
>  	return retval;
>  }
>  
> @@ -229,6 +230,7 @@ static void pxrc_disconnect(struct usb_interface *intf)
>  	struct pxrc *pxrc = usb_get_intfdata(intf);
>  
>  	usb_free_urb(pxrc->urb);
> +	usb_put_dev(pxrc->udev);
>  	usb_set_intfdata(intf, NULL);
>  }
>  
> -- 
> 2.7.4
> 
