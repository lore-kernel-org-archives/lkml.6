Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD3FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E060320660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pq5THSfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E060320660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeLAJt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:49:29 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34333 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeLAJt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:49:29 -0500
Received: by mail-io1-f65.google.com with SMTP id f6so5856422iob.1;
        Fri, 30 Nov 2018 14:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38HsbcsWCRn31MQZ2qzfd3KyH+glqhAaLPK2Upw2PVs=;
        b=pq5THSfs8jJowstASwjUu4FLqjpYE1kf0MJs8Mz8CSEFHtq2Cbd8GDFHpWCWuiKk9N
         gnfizNUKdO+fFjDPhC/wRhXrcW9wPmXsvVwDh1V/cyG0sDWGeyIjdoRZcP/yPChLGDgW
         FjzV36MjFrimB7/V7ySQ/M1KpYIcfr1/9UCd87MSfLr1zkYmxZsoZw3bjHm9/kHWMwPK
         rp56gI4DkxPVfY4RNsCusDWhRTDgB4Y7opjDKj8BEQ56uH+66lcir6unsSIC8/KnsHTf
         T3+96G3dtYHomrs8FpyzqXg1pYlE/1TUV07c1lZcc2cmOcIb0hhP6Bq8AQSwcl22ebjO
         musg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38HsbcsWCRn31MQZ2qzfd3KyH+glqhAaLPK2Upw2PVs=;
        b=lFoaWg0SDPtrdOdEZaxlZIzxl1uhZIUPozwqxD5vSP4i8HbWS2FHMMzWyw/PelDn3/
         3o3KGyKy7sYSXa59YikFiGO3mQPxmcrMrTyrM1Lbme1ylechF8JF/kfzdvFG+K2DE/IU
         8rxrdxuc18a7S/748A7NtjYZ3Fw0u5fEno1v60gNWXSiSAx4ARL/SnOBmylt32c4pRgZ
         xGd98zbT7zv4yA0n9SEOvGLfjZyrtiKVMESv3blLPAaNk5+pNW+7WApri95dGFIMNxBK
         /8VofJepzV7w/r8acz1s2gelels6zETdIQAiwleyNoDhrpgkHSfuqjXzow9rne24X2qA
         g87Q==
X-Gm-Message-State: AA+aEWYPw1cnqUgo4VQZ2Q6U4ccTvKh8+MdhOnEAAqhGQtmULbwcNwaY
        T4U8YeS4cbG3qAJjGcsi45/DtHAJaxAts8a8XM/wWrqm
X-Google-Smtp-Source: AFSGD/WUGIx95VDCczWNGc4w+57rH9NjQtjcGhHEbW9MKL0UPpmQepdzx0MZN4SB90cr6xRqP8BLZ400+MxU3I3+GCc=
X-Received: by 2002:a6b:8b4e:: with SMTP id n75mr5744555iod.184.1543617519188;
 Fri, 30 Nov 2018 14:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-3-deepa.kernel@gmail.com> <CAF=yD-KfxXK=Ta=+a8UYMcmUYzN=UokotfzSno2-xi=JeS6=0g@mail.gmail.com>
In-Reply-To: <CAF=yD-KfxXK=Ta=+a8UYMcmUYzN=UokotfzSno2-xi=JeS6=0g@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 30 Nov 2018 14:38:27 -0800
Message-ID: <CABeXuvr7M4z6-7qsnBZqnXQEcGxfgVddGmsoV=iLwA-n=S5VkQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] sockopt: Rename SO_TIMESTAMP* to SO_TIMESTAMP*_OLD
To:     willemdebruijn.kernel@gmail.com
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Helge Deller <deller@gmx.de>,
        David Howells <dhowells@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ralf Baechle <ralf@linux-mips.org>, rth@twiddle.net,
        linux-afs@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-rdma@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 7:59 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Sat, Nov 24, 2018 at 3:58 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > SO_TIMESTAMP, SO_TIMESTAMPNS and SO_TIMESTAMPING options, the
> > way they are currently defined, are not y2038 safe.
> > Subsequent patches in the series add new y2038 safe versions
> > of these options which provide 64 bit timestamps on all
> > architectures uniformly.
> > Hence, rename existing options with OLD tag suffixes.
>
> Why do the existing interfaces have to be renamed when new interfaces are added?

Existing options need to be renamed because of the macro below:

#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? \
            SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)

SO_TIMESTAMP is now dependent on size of time_t because of the libc flag.

-Deepa
