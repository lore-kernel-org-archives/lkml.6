Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1547173-1528101593-2-4681550828374308979
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528101592; b=VvY277opY27GoBPgXNfu3F7Rd4AOXrklzC/hxE48yoylsplY8a
    FkxTcBF1wkVY2lKcpBQO0SNq/WrVPKWLl8Sy6QSEjyhMktn4i41x2ehN3zpcNmrG
    cPU5y1Ar7TGRe43Fzqs4vg/MzxeWCEHW6qy7Mm9Dvr0GNdKDzkTghO1NxpRuU3Vc
    vX4e4DQ9xu5a6beqHXx6S2cW/AmJzN3tKjPzpWZQDHatg/BxUdksrCnU2edK94a1
    w0SoBKaxBL7EG/37RwXFQXQr9JgIe8GeqPBGknpuXOa/U0Q7xak18GYpGfad7Mmx
    CvKQRlP+FWqmYg5yzKU3SL5RbfdJpJUQgxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528101592; bh=p11ew4Z2KUJReQPlAUfcDVGkvi0oNhvr0RXRRphdcX
    w=; b=TfKBQ/P9A2OV2GThtphRYIb2SQo5evtPDViW58tcWEyDIyPC5k19Hfzapt
    vrcpnfep+x5rjnWClfyxjjixucYHXQ2ybq4KIjfMP5ElyH1Pg2ddnzqynp8szSt1
    mzRW6zgwwFtA+p8C786hBFAXeZK42y6jpsneU7m+Oh6NdihAGtoHaJvSETPs39uU
    1WyMKmUMyrUNaD+2PaaadE/tRyVw+1680YRjrPQq/BDen2hPGVpMGxR8/EUCwXLr
    Jgc53mmKaqvnIQrOL8o48h0MIVEBmf4mGw6hOvGHQFKEg3QC3k8DHvvTKut9CTxq
    +CEuMJfIlUvEPYIMQHT2W7LvSjwg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=CmU5ih7s
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=E4IU5V/8;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=CmU5ih7s
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=E4IU5V/8;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP3J6Nfu8vMDdX0QL2Ue5hHcnU0cyoTFYkErWNG4NtiSbGQx9nWBBlW3/GPI5Xrc6TV6cowXIOW4kPsqMBRxNXMPWr7NeDaVcl3I/DKgO/J+LnjGL173
    Lio6oE9kWBTC60JzVt33msJXiIfahc77bLd41s6ygAZYXHmc/IYEiVreUBWCxelTkN2sPNic7f4BXX5f0WqryRCymzk6I6BgwyhNo2tJ0b6dkFP5uPtvQzBS
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=A0OSUOIckAAW7BvkuqsA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeFDIjt (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 04:39:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36698 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeFDIjt (ORCPT
        <rfc822;linux-next@vger.kernel.org>); Mon, 4 Jun 2018 04:39:49 -0400
X-Google-Smtp-Source: ADUXVKLOm2hpjWeUTxc1wg5SqY5abUSNRD/OhHmAcT3rWO4TIcQFO6c3cEyZht8/z0qnfNXKTZJDiisYY5HEKsAsqig=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2h1WZ=Jg4MAHoyCt_YLNRCCBG-JRUfy2qZpQ6trRHesg@mail.gmail.com>
References: <20180531084037.2f8b4c1e@canb.auug.org.au> <CAK7LNAQjVCPwfJ-opUkW3+XTM0uk9PSo3XiyGwCAMKkK05WnxA@mail.gmail.com>
 <CAGXu5jK8OSJXT5eGK=J0msL9kc+fjOxFUyv=5NYbOH8savc5Xw@mail.gmail.com>
 <CAGXu5jKb9f7Or9z3eBzAUci2teE6ULVjkuqv00O_j3VuowwbJw@mail.gmail.com>
 <CAK7LNASYTVNque5kgq7FnyOSjX4byBsWhfB-0Jy9Fp0ZmpuqYA@mail.gmail.com>
 <CAGXu5jK8F_R-CAt8h92ZG51s5eSnV+6FASLmYCWWgRX_2_m8zA@mail.gmail.com> <CAK8P3a2h1WZ=Jg4MAHoyCt_YLNRCCBG-JRUfy2qZpQ6trRHesg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 4 Jun 2018 10:39:46 +0200
X-Google-Sender-Auth: zjxQ-CQkpIllGx5TizNckSWOGhY
Message-ID: <CAK8P3a0K_=dHfsJOkFd5DWMs6i6bxm+2vRbYAc3UEr1bYpNb5g@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the kbuild tree
To: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Jun 2, 2018 at 10:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> I ran into the same thing indepently and bisected it (which led me to
> arrive at this thread).
> One additional bit of information I have is that this happens with all
> versions of
> gcc-7 for me, but not gcc-6.3 or older.
>
> Another finding was the particular instance I noticed:
>
> fs/ext4/inode.c: In function 'ext4_inode_csum':
> fs/ext4/inode.c:83:1: warning: the frame size of 1688 bytes is larger
> than 500 bytes [-Wframe-larger-than=]
>
> comes from inlining the same function multiple times; ext4_inode_csum()
> repeatedly calls ext4_chksum(), which has a struct on the stack. Apparently
> this normally only takes up stack space only once, but when initializing it
> to zero, each instance takes an additional two CRYPTO_MINALIGN bytes
> of stack space (the size of the locally defined structure).

Two more things:

* I believe we still want to leave
  CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL depending on
  !COMPILE_TEST indefinitely. The reason is that it effectively turns off
  -Wmaybe-uninitialized warnings by initializing all structures, so we would
  miss those warnings in allmodconfig builds otherwise. Obviously
  that shouldn't stop of from fixing the excessive stack usage.

* Here is the full list of instances in which a function stack usage grows
   beyond the warning limit with CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
   enabled, after several hundred randconfig builds on arm32/arm64/x86:

drivers/media/dvb-core/dvb_frontend.c: In function 'dvb_frontend_handle_ioctl':
drivers/media/dvb-core/dvb_frontend.c:2647:1: error: the frame size of
1032 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
fs/ext4/super.c: In function 'ext4_group_desc_csum':
fs/ext4/super.c:2306:1: error: the frame size of 1160 bytes is larger
than 1024 bytes [-Werror=frame-larger-than=]
fs/ext4/xattr.c: In function 'ext4_xattr_block_csum':
fs/ext4/xattr.c:147:1: error: the frame size of 1168 bytes is larger
than 1024 bytes [-Werror=frame-larger-than=]
fs/f2fs/inode.c: In function 'f2fs_inode_chksum':
fs/f2fs/inode.c:156:1: error: the frame size of 1424 bytes is larger
than 1024 bytes [-Werror=frame-larger-than=]
net/bluetooth/l2cap_core.c: In function 'l2cap_recv_frame':
net/bluetooth/l2cap_core.c:6976:1: error: the frame size of 2240 bytes
is larger than 2048 bytes [-Werror=frame-larger-than=]
drivers/media/i2c/soc_camera/ov9740.c: In function 'ov9740_set_res':
drivers/media/i2c/soc_camera/ov9740.c:668:1: error: the frame size of
2768 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

I did not see the brcmsmac warning on my builds though, so presumably there are
some others as well.

     Arnd
