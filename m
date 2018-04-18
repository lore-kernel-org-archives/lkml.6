Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4089077-1524038956-2-18436238043100794175
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524038955; b=II6+gTieh1ElWVq5y8+o5yYGMA8sVwdEF7RKHJLNc13MXhB09+
    uHZsULU/cDviYV2Z952jXDM8XNfF0AkCe8/vzmQ9bOC2Ak9fiQhdNA+x1FMKnTpE
    ud5PE+unM9S5MkA1ltHThc+XObaxcD0XaO98wO3mRT6OURu0V5t8lBNMv33bvq1J
    s3vYdN9/e8M2YYBo3U+hnhxQNNv01vdqHE5t8iS8Y7SKkWhgVYp3lG425iGWBb4g
    sXo+isEoL9GYRF4kkuMw/XeFCxaH2qyBSLQs6A+uJ2BPtPdrW/rdZ9x7ylax0t1s
    LZbjVtQz+J11iaJiuw8WGiGS/KuB5EjMNexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524038955; bh=VJvapKa5mvJWH3kjjKPVt3xvpKl5hb24ZkA/dqY7Sc
    k=; b=oI7hzlKUnB+qJ49vDROvJshXKWAoGNHXV+Nj0ekhkAaR/WAJIKTKT4eW0E
    PxeXuo1TYRY28gG76V2PEJAVUS3yH8vJqXv0l4Nnvzr/W2A5u8C2wYaRwpUK4/Hi
    wxdXxugoYEeMQbDvvTw9Y8wF4Mpst/soOHcPs7rWA6ZK9bRTnXokJztChpmxPnri
    9357h/e8mVMRGNF4X1AdhDYTzKf20zCwdIykPBINhjh1slrhMSHul14mHduyk648
    t62EG811wkv9H5DEjc9H541aeNclJU1G/G66WlsiDraR0gtFMfgStKcddp/krgdJ
    dB1mqVodPWoM5V2UBytQe0lEZhPA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ija7uAGm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PzLoEhji;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ija7uAGm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PzLoEhji;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFKz9Srge8m0x60x3gZfxPenOaOIXOSWAZ/c0S00pSwrOYtcYsq68MF6Z1z7x58X1V+D/L9IeoJ1uVI3QmsBMTZYgaUxoWsmnh3hh6g5yU3kD971aSRM
    wiWtcZmfS/yIWe3uG6VWcH64PdFU7nNipGmRtF3AK0SAZQkLF4hMU0KIzbpuzQEwEAq2BH3nZ65TPPjVNqA1K56/SNoAhzCDMXQTffm2gVjla8AT+qMFXdRh
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8981fWPbAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8
    a=tBb2bbeoAAAA:8 a=06aRxZmsPo5UEvz0Q-cA:9 a=QEXdDO2ut3YA:10
    a=o72u2rHnfW5qNJ_4I8LD:22 a=AjGcO6oz07-iQ99wixmX:22 a=Oj-tNtZlA1e06AYgeCfH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbeDRIIc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 04:08:32 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:40119 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbeDRII3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Apr 2018 04:08:29 -0400
X-Google-Smtp-Source: AIpwx4/jCUzAp58nopLBZCdE0TDqWMkwDQUINqrniaDuz6O/1UV6cXJIl7PjpEtSnzzE3TZjU2VOI6TX1hJzGnrF/As=
MIME-Version: 1.0
In-Reply-To: <ed5a2015ecd360746ab52e8d3f5e8b6f5e1568fa.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au> <ed5a2015ecd360746ab52e8d3f5e8b6f5e1568fa.1523493475.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Apr 2018 10:08:27 +0200
X-Google-Sender-Auth: TDby0hRDiZkShtVv8ABXWn8M-is
Message-ID: <CAMuHMdUHFdjk-XMRDn7rx6iDjJYaxYDGAwfn8u-zKiBdCX+Jww@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] m68k/mac: Fix SWIM memory resource end address
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <lvivier@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Finn,

On Thu, Apr 12, 2018 at 2:50 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The resource size is 0x2000 == end - start + 1.
> Therefore end == start + 0x2000 - 1.
>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: stable@vger.kernel.org # v4.14+
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Acked-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied and queued for v4.18.

> --- a/arch/m68k/mac/config.c
> +++ b/arch/m68k/mac/config.c
> @@ -1011,7 +1011,7 @@ int __init mac_platform_init(void)
>                 struct resource swim_rsrc = {
>                         .flags = IORESOURCE_MEM,
>                         .start = (resource_size_t)swim_base,
> -                       .end   = (resource_size_t)swim_base + 0x2000,
> +                       .end   = (resource_size_t)swim_base + 0x1FFF,

BTW, probably you want to change swim_base from u8 * to phys_addr_t, one day.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
