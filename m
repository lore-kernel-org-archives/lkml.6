Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeFALe0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:34:26 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34109 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeFALeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:34:25 -0400
X-Google-Smtp-Source: ADUXVKJQPTgFzIPDRH3eR1fItSvtj1BwaDaNkAdSHqY6Ti9K38OHOssktK4vZLYhdqcICj8K0pYHHO/uRFyMLkDHbEU=
MIME-Version: 1.0
In-Reply-To: <1527765086-19873-22-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com> <1527765086-19873-22-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 14:34:23 +0300
Message-ID: <CAHp75VeM8+pWEx=XNOGAb=Fdh+rh3WOn2i4m7ObhcVdcXKVa3A@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] sparc64: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 2:11 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.

> @@ -512,10 +512,9 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
>                                 break;
>                         }
>                 }

It seems previous loop also can be replaced.

> -               for (i = 0; i < ARRAY_SIZE(crypto_hwcaps); i++) {
> -                       if (!strcmp(prop, crypto_hwcaps[i]))
> -                               caps |= HWCAP_SPARC_CRYPTO;
> -               }
> +               i = match_string(crypto_hwcaps, ARRAY_SIZE(crypto_hwcaps), prop);
> +               if (i >= 0)
> +                       caps |= HWCAP_SPARC_CRYPTO;
>
>                 plen = strlen(prop) + 1;
>                 prop += plen;
> --
> 1.7.12.4
>



-- 
With Best Regards,
Andy Shevchenko
