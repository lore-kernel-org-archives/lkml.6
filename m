Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-869579-1527531556-2-3386162916919976914
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527531555; b=bhv5NZ3uWCjUE5s8S+Fvzea5ny/dZBTNUV/kDnuvofPtb9ryP3
    UtNSzYycnzkwS6AnNEsdiHzCye/Dhwa76yS+CJKMvGqXJIjWEa8NLrH4wJdunNMS
    i9YxvqNQ/duc/E8fXOXp5QP0gi0T898K3y/Tx9lNKHXfFtWZs714DevGMem3ornB
    PBVIAdb0XF6P5m/ms4T6LD3sH4Sz12Mq7Iq6lF7fbaHKNq2kjaK/wZws/AGJunAv
    ihl5cU0v68UIOasTPEAUhvIFCzDdXmYlCX2C6b2Uc40YtbdrUYy/6EbO6DEeXxOx
    adzx6W6kAKFxvKPGB+j/qBUGG7LEJazyl4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527531555; bh=Hp6G4ue5VJ2MXnu/iAdHep2mcnZTEa5Q0ObON3zxoX
    Q=; b=WTjfU20mv1EgYsxBvzT1IcqUQIOfnpafpuaig7zdJ+EZG48lI0LV44AntD
    Enqei2HB90GDWbGsD5OcVTdJ3Q+Zq1myKh//008U3HHOi2c57VIzleoeBu6wVEBc
    pM/cjjU0Xd2tntyujO+rnXeH6riZWV9/NKyS6AN9lznmF3mvGIbaRM+qrhM2Zfpd
    FcJEhgZepWP1qlYCJ9E4iM71hSg2EiSvkFfn+jEweon3C/pnDh+J4Q/9DK8sfLi9
    6t3DD/K8Dpd7bcYvnOtbtJqpnhzOE7Kf24oUSupjq0IF8cW5JKn23a1UCl47d6cw
    PEZewS7CymGM42o8kO2ekv1G9wuQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=intel-com.20150623.gappssmtp.com
    header.i=@intel-com.20150623.gappssmtp.com header.b=fZN42u89
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=rXrJuIpW;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=intel-com.20150623.gappssmtp.com
      header.i=@intel-com.20150623.gappssmtp.com header.b=fZN42u89
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=rXrJuIpW;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBl+/urrdg6gFlsSM9yIvWuv3xz8LK22/MJmlv86RQ1cDLKUbWF2fscNIZ/fIC1JcbtFBmU92qGk8Z+hXqdiy0uYRi2gNvXz2bDMBIJUkX18AmSD2UDl
    IwHE6TggElKOP+vSRRD/LD1cTf0D212sfaEKKmfaJ4X2cF1dmC1LjRhRB2Vps1OBsWjNzwroEnQ9jmNSV/2DtXlByrQLgDkMxxpoAZbSYEA+b9wIsB79e3fY
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Fxe5kMnbqmakDqzvHmkA:9 a=QEXdDO2ut3YA:10 a=N8N-558xWu8A:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932763AbeE1STB (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 14:19:01 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34525 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932488AbeE1SS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 May 2018 14:18:59 -0400
X-Google-Smtp-Source: AB8JxZq44kxP9hZYjzBKeTaWGsEn/e/oElI7CHR/sd7D1+Y4lYH6NnZYf+uA3OntKo3/C0K7DRUC4SKUHODjbJP+Lxo=
MIME-Version: 1.0
In-Reply-To: <20180528153834.2268557-1-arnd@arndb.de>
References: <20180528153834.2268557-1-arnd@arndb.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 28 May 2018 11:18:58 -0700
Message-ID: <CAPcyv4gpMhBaUdy=UY9M0-2QomycGZCo+K6o+Dzjdc4jmPjrkg@mail.gmail.com>
Subject: Re: [PATCH] dm: writecache: add DAX dependency
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        Shaohua Li <shli@kernel.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 28, 2018 at 8:38 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The new dm-writecache driver inconditionally uses the dax
> subsystem, leading to link errors in some configurations:
>
> drivers/md/dm-writecache.o: In function `writecache_ctr':
> dm-writecache.c:(.text+0x1fdc): undefined reference to `dax_read_lock'
> dm-writecache.c:(.text+0x2004): undefined reference to `dax_direct_access'
> dm-writecache.c:(.text+0x21cc): undefined reference to `dax_read_unlock'
>
> It seems wrong to require DAX in order to build the writecache
> driver, but that at least avoids randconfig build errors.
>
> Fixes: bb15b431d650 ("dm: add writecache target")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/md/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 852c7ebe2902..f8ecf2da1edf 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -338,6 +338,7 @@ config DM_CACHE_SMQ
>  config DM_WRITECACHE
>         tristate "Writecache target"
>         depends on BLK_DEV_DM
> +       depends on DAX

This should probably be depends on DAX && DAX_DRIVER as we at least
need pmem or dcssblk enabled to provide a dax capable block device for
DM to claim.
