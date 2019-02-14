Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA652C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9437120818
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZPyoCZ19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbfBNLzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:55:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43210 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfBNLzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:55:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id n71so9970621ota.10;
        Thu, 14 Feb 2019 03:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ijwIqkm31NgSc8dER2qwk1CVvGn9BvR9uPp22vgMmY=;
        b=ZPyoCZ19hTslq5ab0bRNPSHt5LTj+BbpidrB0n9kXEQJQtUwr9CDOJg0k8ZmKuu5lu
         xCUriZ6Umo6vubPsUZC58SyAFyx0CqETb4qxyZFJL/HWe0z4QGaPsZef3JGOmofcp2Od
         XUOiAEIxYBW15vxm/0gef3rc/j3fF1IhSdHfI8OV6N7qHs8Yi3q1Czx8/r1+ytss2yRP
         0hE4z7FAfhlT1RvcG975tvjHd4gsBjBQJzd6LaTJfywzRtVoKkv4dSH5IeZ5dbfwkITN
         tJoWt2JZawzdSezXtQROj0c7DtbbqUlmUpDfO55E22CYJEKiYhgf3chfZFb39M52AfC1
         YMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ijwIqkm31NgSc8dER2qwk1CVvGn9BvR9uPp22vgMmY=;
        b=OehbiZKYG9+R+cSLPAULSkzsw8EpwgFlan2rOZlu0DQGpvOYxfCDwz1XiQ96ITVCfX
         xDc/cZS0IBZrxPbr0/eLeOBZxQPKBMLPIMW7mUZQe2yGVSKJcAyAcKeslIWCb8CTSrLp
         ibobxY7J5Jgnkp2wbSVwQbbFJjR0NwbtCj8qKVLyh/V5/BMTti3pfFtVJbIqZ92abq8O
         +46Z8X6Pa7kvrzoH0UMHEOkL8pqb9b2SllnckXCCFtE75UXuDorNVpn8LibSLDPRp8Lg
         l5bo3sdcqv3q3z8hMrPXCzwYazV744l5/I1K3RINNqAUEi0gXQHxyBQYbDct0+2JKwF6
         diNw==
X-Gm-Message-State: AHQUAuZOP6NDZ+mhdNvHRq/OzswQh4W/bDc1Dnb8cnXbrKRlhpCOU2AW
        ezd7jlKEU0edT3i/VBsxdNiQJpMYg8vw/uCf3V/2E5T/
X-Google-Smtp-Source: AHgI3Iah60qyMyKOErWDSKX/GK8gecuk8TULHoaAbqi0AkdeLGKa7JGEnkvIb1/9uKFPhvJ94TkNUU22zYpWQ+QFkT8=
X-Received: by 2002:aca:720c:: with SMTP id p12mr2099973oic.15.1550145353861;
 Thu, 14 Feb 2019 03:55:53 -0800 (PST)
MIME-Version: 1.0
References: <20190214220338.7241bdc5@canb.auug.org.au>
In-Reply-To: <20190214220338.7241bdc5@canb.auug.org.au>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 14 Feb 2019 12:55:42 +0100
Message-ID: <CAFBinCCTbn0zMQqTzk2RvELCRBX1=Vf1QuY54Kp+BKc+sOmKHQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Hi Linus,

On Thu, Feb 14, 2019 at 12:03 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Linus,
>
> In commit
>
>   a5a0bbca16cd ("pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins")
>
> Fixes tag
>
>   Fixes: 0fefcb6 ("pinctrl: Add support for Meson8b")
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
this is my fault - sorry about that.

Linus, do you want me to re-send the patch or do you want to change
the referenced SHA1 to 0fefcb6876d0d6 ?
I'm fine either way, please let me know what's easiest for you.


Regards
Martin
