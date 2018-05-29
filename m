Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2266183-1527606827-2-14677858893034030557
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527606826; b=IBJkIRHymzBV50kNEu4ekIfD1/BMQMinkA+UrXP6I+UCM+n7x3
    rhyZAPSuMgplQKRoIYE81OKYgQQFXWsi3pGJNpX7DCjOSehai89olUj8TVRrMwlU
    /1rzkamERHun3odztBtgSJ1F8Hyl29Qss8PFSiPt1yElVx1NEeKOfzY5C8R1J2Zz
    6nNbrR0T8BB8qdhZ/nnPd6jfed/wBLD9fxq5i6pLLEYNCocWwVVm37+QdqlfDPyU
    /rUi582J11d9UFkT2LYyB39NZvhnz8mIgwibY2l/vhLugjZIt7dur91SfBap05I5
    sHSim9MlNVN4HNrma7/mfADT8wcYE0VqVWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527606826; bh=8J+2rft2CzIo6m/1AGCMZ96cW0Xf5EYv6fCskTnqyZ
    M=; b=lPlKsL1BVEAOIhZhFu68g+GXsX0LAIPTJKH81kMP/JYuBBelTFeO/zBjLy
    +MaPUK9WE1u60FWp2MqhOICBblDLXtSH+FPMPwABJnWJIMpln9Rwv1eB4BITaIpv
    +BJD5zx1vWfBe0c4jkq5PWKJLIS8Pmp6jJNpdweFIsbe2MZn6lvNVH3CYxdgareY
    5Xeu6qnWB1umeh/uJ4RPUCX6sbxTTV8wjNWP6x5iOaPu3/acF7ZhDYYRUNMXrAxk
    nTybVRc7Cj+5P85JAnJBcvp0YTU9L6IKkkcSmscPB5uzB9cz2n3ctXeR6QTc0BYP
    xCGf4LsCGYni6byFieevsYCkbRZw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=Zho6J8b0 header.a=rsa-sha256
    header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=rrYwoBtK;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=Zho6J8b0 header.a=rsa-sha256
      header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=rrYwoBtK;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHtMDwFC1MMrssCXK2DNMffIjUzzuP09WYvzZ+yGjiRMs/UQ2jLMag0N3dxHiBh5O4IW5CDqbHqzZGsIBD9Dz8tu+IoFvKhxIs0izajWdmRIs28nMl//
    tIIXvoZGwp1sOL2JndWxVoTywfmbvHx1d+BXypnurgb01w9Pxy0AvHZrBKD4N8AsYoX+nNQfPAPTtzNW/XV/7ULJRFK1EvLyZm6y6r2Zp9T4gNFXaWTYQGR5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=r3nPLSDzUwAA:10 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=yuyb_D4x1VDfwy4ZTIwA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936802AbeE2PNm (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 11:13:42 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46309 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935702AbeE2PNh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 11:13:37 -0400
X-Google-Smtp-Source: ADUXVKJpd6a/vLw4zQ6HN5/N1oIDDJF8OvWHl49uVp4d2CwFQgEZSoM5z/WQkJcXGLNoKOToJ2kzvM/QnqLgA+ye81o=
MIME-Version: 1.0
In-Reply-To: <20180529144339.16538-28-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-28-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 29 May 2018 18:13:35 +0300
Message-ID: <CAOQ4uxgbj0x+zMn47PiF819+kFE9Byos-KVGiGp7Mp=Gc0N8Wg@mail.gmail.com>
Subject: Re: [PATCH 27/39] ovl: obsolete "check_copy_up" module option
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 5:43 PM, Miklos Szeredi <mszeredi@redhat.com> wrote:
> This was provided for debugging the ro/rw inconsistecy.  The inconsitency
> is now gone so this option is obsolete.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/copy_up.c | 30 +++++++-----------------------
>  1 file changed, 7 insertions(+), 23 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index ddaddb4ce4c3..e675e8349e71 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -25,35 +25,20 @@
>
>  #define OVL_COPY_UP_CHUNK_SIZE (1 << 20)
>
> -static bool __read_mostly ovl_check_copy_up;
> -module_param_named(check_copy_up, ovl_check_copy_up, bool,
> -                  S_IWUSR | S_IRUGO);
> -MODULE_PARM_DESC(ovl_check_copy_up,
> -                "Warn on copy-up when causing process also has a R/O fd open");
> -
> -static int ovl_check_fd(const void *data, struct file *f, unsigned int fd)
> +static int ovl_ccup_set(const char *buf, const struct kernel_param *param)
>  {
> -       const struct dentry *dentry = data;
> -
> -       if (file_inode(f) == d_inode(dentry))
> -               pr_warn_ratelimited("overlayfs: Warning: Copying up %pD, but open R/O on fd %u which will cease to be coherent [pid=%d %s]\n",
> -                                   f, fd, current->pid, current->comm);
> +       WARN(1, "overlayfs: \"check_copy_up\" module option is obsolete\n");

I was under the impression that user controlled input should not be generating
WARNings... did you mean pr_warm?

Thanks,
Amir.
