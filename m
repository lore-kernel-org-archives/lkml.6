Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D360A2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY/7NrM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfBYSzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:55:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40775 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfBYSzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:55:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id q1so11155675wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 10:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=giJy1kMzcY3WLSpkxWjWbbjfE7h0U68/r8WSJhwCy8k=;
        b=dY/7NrM/w6DytL8DulIXio+AbeNzxA9r+ww6UZx/fdLsN8IYWs/zX18pS2a4Gklci8
         NTfFjuI7MZyORcsHedWlvIzuV/SZZTA0EEJJIzxQ64WWoTblIu70Zut3BzbuwV96Lxn1
         ZKt/OepQ9YpSiC39PLYczSFTAGmwKYkAx4f5k243vLMTd306MiykSjXGI+45o4KxYpvr
         nSCe2gvPC1Objtz9sK6S3RI4M3q8G47dlJaCq99BgnC/4B70E6GU+bzkdM2upD3mUQfw
         VJKkj1SetVF7KNi3qyXR8Zbr3NklQ469kytKr3uMSn80Dhb95veKXLeNi/oGc7PArnfA
         i0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=giJy1kMzcY3WLSpkxWjWbbjfE7h0U68/r8WSJhwCy8k=;
        b=ILS5TAJOOS4r2MJf4dbIUFAZew++LSLXd7a0CxhC/KryU7QLn/kIXM+ObLK+wggexa
         qHhX6j0H+vlBj7lk/9NmWuLo1d0pakcazaDCZt4iqgCghgurxZpY/z4XTIKEJd+fq5Ij
         XHWftR9Wz/05kgY6Rcns3WuaSCW6udEpu8CU6BLhHLZJt+odvcPbwfjG0RelSsHZtoMZ
         34V3ijCjhyDXwixEDdrCXK+zboLwKgk6QvCM9bfe2wGWz16ovkHs29dkdajFHr41JMYm
         6lfAktuTql+wUfPjNeWzr9Ck1MYS1q824zA1kSVtI9HH/vYFZSY8cJMe8JQTUHDn9Sib
         +E7g==
X-Gm-Message-State: AHQUAuYSoi+dt67axOR1g1JBUMUqznLzDAb3GXSkG5CgMrb6g7VegoVh
        lqjDpXI4Ba/dzH6QiKD/T/nKTMfI3yd4ezQTOWY=
X-Google-Smtp-Source: AHgI3IY4tfdkdsQoqfagtHyOGx+7Hg5Cf+SOj48lsKY2D0fw2+ZFYIlNLYerItgeTvKcRexWc3z9u6Btu8lO3aXy5SI=
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr13504622wrn.13.1551120933952;
 Mon, 25 Feb 2019 10:55:33 -0800 (PST)
MIME-Version: 1.0
References: <20190222122147.27132-1-andrey.z@gmail.com> <c4fce9a2-2d9c-ad0a-8389-cea795af9f74@kernel.org>
In-Reply-To: <c4fce9a2-2d9c-ad0a-8389-cea795af9f74@kernel.org>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Mon, 25 Feb 2019 19:55:22 +0100
Message-ID: <CAHtQpK4oCoMKKcfH0wNm_QMg5LaQT=GNSMzOz9FbzjBrEF8cAQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: socfpga_defconfig: enable support for large block devices
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dinh,

On Mon, Feb 25, 2019 at 5:35 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> Hi Andrey,
>
> On 2/22/19 6:21 AM, Andrey Zhizhikin wrote:
> > Enable CONFIG_LBDAF, which is required by ext4 fs. This option could
> > hanle both ext3 and ext4, and ex4 requires this option to be enabled,
> > otherwise the filesystem is mounted RO mode.
> >
> > Signed-off-by: Andrey Zhizhikin <andrey.z@gmail.com>
> > ---
> >  arch/arm/configs/socfpga_defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> > index 08d1b3e11d68..b4b387486cd9 100644
> > --- a/arch/arm/configs/socfpga_defconfig
> > +++ b/arch/arm/configs/socfpga_defconfig
> > @@ -21,7 +21,7 @@ CONFIG_NEON=y
> >  CONFIG_OPROFILE=y
> >  CONFIG_MODULES=y
> >  CONFIG_MODULE_UNLOAD=y
> > -# CONFIG_LBDAF is not set
>
> CONFIG_LDBAF is turned on by default for 32-bit. So all you have to do
> is remove this line.

Thanks a lot for clarifications here! I suspected that it was the
case, just needed a confirmation here.
Is it possible we would have this config option enabled for
socfpga_defconfig? If you would agree, then I prepare a separate patch
to have the "CONFIG_LBDAF is not set" removed.

>
> Thanks,
> Dinh

Thanks a lot!

--
Andrey.
