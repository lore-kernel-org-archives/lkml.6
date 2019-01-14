Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A201C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416B2206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt0NYOck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfANEhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 23:37:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44168 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANEhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 23:37:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so8897979pgr.11;
        Sun, 13 Jan 2019 20:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vnKSlKj1+jfObhbDtjEHQypPYk9jRoUJ4bt3YAwwSvs=;
        b=gt0NYOckq+9Y7skz51vbkRT3v/lpBz5DOyO1MxxM3q/6hnLveUJWGYZB8iqNp80KR0
         dNC4+1V4aYPr2YLX2rpDMhq4IKzCM3dSZbGmxoSvdp4Tg47Jl0WD2nMPhPZ/DzvXq8fH
         1lCfe9wwoMQTbrAHUw9MuZ0m/OqOsN0J7y02THseY7SNMJHxDsrkGXo5yEkEK6vb88r5
         5I2OOgXdl/E3g7MT76N8CwmwmYU3wk593VUCf9GsFCo6AWFLWlTyacThvSCxIKOiTrcc
         y84BJNsIOb1Nggkn6099QnWWVCNl8QWX1XW+JIWEVZS2lZJdTPjVhdsmvXDjX859JZBH
         nC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vnKSlKj1+jfObhbDtjEHQypPYk9jRoUJ4bt3YAwwSvs=;
        b=WlT58rCSWQ0iJLK8EJf7V7zMzV8B93SIMguv5bksXiocdeIt+ixGZBkazKeE2h7TJH
         hVUhPNzRlBAMWJWeYsapt9zYp88vH5nb2ZFOmvNuzjHdb0ButTxumqreQueX9vSb3IHY
         4jbV2H8IvcNfxeO1qpO7WYspvnju4w6Cjc5LsZWRfOmEKnaBWT8gv49+Mr6K7h3BzRzT
         cRGzIM1DSAL77chAjVoYLsIywyV6QfMKO2/iR6TJB57YPYi802owBiCgezCyuMM8NSyK
         +zJtbaYZmyUd2sBv9NSC9RR8vt666AImwEGLmn5OlsV/1pvsrzgq0hS9QhwBVYnozWpB
         dzBw==
X-Gm-Message-State: AJcUukdANnACEYwEiNH9SRQky/6sau7A4yQWrgEmCuNW+KMEDWyBOoRm
        xgbQIaThXEFcIX4yxYBg008=
X-Google-Smtp-Source: ALg8bN508Wsn+VLnprRlOl75OzoHX1lx5wnqfOBIZvh6gAriTI7SYCwbTniYElagk+IOfqPAXQ9BCw==
X-Received: by 2002:a63:d5e:: with SMTP id 30mr21637036pgn.54.1547440656270;
        Sun, 13 Jan 2019 20:37:36 -0800 (PST)
Received: from [192.168.86.203] (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id y84sm156569370pfb.81.2019.01.13.20.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 20:37:35 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] input_event: Provide override for sparc64
From:   Deepa Dinamani <deepa.kernel@gmail.com>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20181229183514.24644-1-deepa.kernel@gmail.com>
Date:   Sun, 13 Jan 2019 20:37:34 -0800
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, davem@davemloft.net, y2038@lists.linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D5DB92B-5CFA-4D92-A578-51ADDAE94A0E@gmail.com>
References: <20181229183514.24644-1-deepa.kernel@gmail.com>
To:     dmitry.torokhov@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 29, 2018, at 10:35 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrot=
e:
>=20
> The usec part of the timeval is defined as
> __kernel_suseconds_t    tv_usec; /* microseconds */
>=20
> Arnd noticed that sparc64 is the only architecture
> that defines __kernel_suseconds_t as int rather than long.
>=20
> This breaks the current y2038 fix for kernel as we only
> access and define the timeval struct for non-kernel use cases.
> But, this was hidden by an another typo in the use of __KERNEL__
> qualifier.
>=20
> Fix the typo, and provide an override for sparc64.
>=20
> Fixes: 152194fe9c3f ("Input: extend usable life of event timestamps to 210=
6 on 32 bit systems")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
> include/uapi/linux/input.h | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index fb78f6f500f3..ffab958bc512 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -26,13 +26,17 @@
>  */
>=20
> struct input_event {
> -#if (__BITS_PER_LONG !=3D 32 || !defined(__USE_TIME_BITS64)) && !defined(=
__KERNEL)
> +#if (__BITS_PER_LONG !=3D 32 || !defined(__USE_TIME_BITS64)) && !defined(=
__KERNEL__)
>    struct timeval time;
> #define input_event_sec time.tv_sec
> #define input_event_usec time.tv_usec
> #else
>    __kernel_ulong_t __sec;
> +#ifdef CONFIG_SPARC64
> +    unsigned int __usec;
> +#else
>    __kernel_ulong_t __usec;
> +#endif
> #define input_event_sec  __sec
> #define input_event_usec __usec
> #endif
> --=20
> 2.17.1

Ping.


This is required for the proper functioning of the y2038 additions to input e=
vent.

-Deepa=20=
