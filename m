Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7B7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0735620827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toKVsIfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfAHNk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:40:58 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38659 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfAHNk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:40:57 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so4253471ede.5;
        Tue, 08 Jan 2019 05:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQvU4StewlMdRRuTTmzDqtU8OB+g3yj+Mb1ASOZhQFE=;
        b=toKVsIfVZujvPkG6SiJt0ajqlLPysKriQXAlYKeJYTPlRYBCrrqUiwno5MJY7E0io7
         Omsr+syD9U2lVEXp6uDlPDxP8+Ak+heUpsOTpG2PERWp+qb4c+DyKZE7WKkzf142bvVO
         F3eWAAqtvac3STUwm1AM5M5FD1CgDzpisM7w56H/20z56mbSm1HUaIyBonUUMV+As8kO
         E44TfdXvxcUKmqzO9Dxh5csgQx0pFoAOpLDksSs4nOhkE3VuNeD2mlpY+vy36rTr38aa
         Im08rFOn7NLpxpvwk0t4wOaMu9OWP6dcTYjK1CJrvDPT9K4N1nVDlPuVat/hwjvDL9hy
         AMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQvU4StewlMdRRuTTmzDqtU8OB+g3yj+Mb1ASOZhQFE=;
        b=JYvp4m13YjnraHZ0Ie2QKEcJ4MLBGMyiLi3/eR7dkblSDj71K1Yji/5EeZ2SDVYgrQ
         OvaEFTjGi7komcXB8ouVJAZL7np7E0yzjB9TUGvgvku/J2+tVBTjZehT84PiDknoVOZx
         aO/2vfHVLs2+GMvwgf45hxatngeUpUmP99bkS1+SO6RerizRNE30MoLRHrJ+E890KKq1
         140zFLQgk6M2uyLDdu4byz5ntsc/Gkm9rEZ54dexKtdk1a2epAcCfwE8CpOhdYPVqWFC
         ihBfbOj1f57h6/KSpm3YJbLWOjkQjqZTasjMfZmx0ypPZZdbd6ePt8nSiE1JWzwWr35c
         c55w==
X-Gm-Message-State: AJcUukduPZPcBdcJ/1Ih81C2ajHY5OMlpkOaPTwRa/ccko8nTmHSWbiP
        qNNVax7TVVGmkfnCRPnca7A/m/ObT5H/nAL8G7g=
X-Google-Smtp-Source: ALg8bN7+tRKpuDH5I+LTWZukeOLJH4Iw12yMQwG3U0rs+W/Zo1MPcFf/oG0VjihtdSP4aW6VYBAtYr7F5gnVFqm3mGk=
X-Received: by 2002:a50:bdc8:: with SMTP id z8mr2117146edh.46.1546954854953;
 Tue, 08 Jan 2019 05:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20190108032657.8331-1-deepa.kernel@gmail.com> <20190108032657.8331-8-deepa.kernel@gmail.com>
In-Reply-To: <20190108032657.8331-8-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 8 Jan 2019 08:40:18 -0500
Message-ID: <CAF=yD-Jy7kyNtae7QpHgn6kJtmmYCngNdzF3K5DqVJBTHOUfqA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] socket: Add SO_TIMESTAMPING_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Chris Zankel <chris@zankel.net>, fenghua.yu@intel.com,
        rth@twiddle.net, Thomas Gleixner <tglx@linutronix.de>,
        ubraun@linux.ibm.com, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 10:29 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> Add SO_TIMESTAMPING_NEW variant of socket timestamp options.
> This is the y2038 safe versions of the SO_TIMESTAMPING_OLD
> for all architectures.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: chris@zankel.net
> Cc: fenghua.yu@intel.com
> Cc: rth@twiddle.net
> Cc: tglx@linutronix.de
> Cc: ubraun@linux.ibm.com
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: sparclinux@vger.kernel.org
> ---

> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -106,20 +106,22 @@
>  #define SO_TIMESTAMPNS_OLD       0x0021
>  #define SO_TIMESTAMPING_OLD      0x0023
>
> -#define SO_TIMESTAMP_NEW         0x0040
> -#define SO_TIMESTAMPNS_NEW       0x0041
> +#define SO_TIMESTAMP_NEW         0x0041
> +#define SO_TIMESTAMPNS_NEW       0x0042
> +#define SO_TIMESTAMPING_NEW      0x0043

nit: unnecessary? perhaps need to get indentation consistent
immediately in the previous patch in this series that introduces
SO_TIMESTAMP_NEW
