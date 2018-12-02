Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58252C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D2B20834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="y+kXdlDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D2B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbeLBTH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 14:07:28 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37825 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbeLBTH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 14:07:27 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so5504003iti.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 11:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCXOD3Q6bZZ7YgdVWFVLKxYAwxM+uYb/UnG6cIzFbD8=;
        b=y+kXdlDNDzR5xK+OYHPEEerfXhAyr+q/zMTHT816T+UIUGaoc03PQTgmPLoCIhdoNo
         4oAoW3zr8RSIU5OLlblMwUSB2KOQfgMKnZTmFtpebtSzomtuYoZN6vIcekqc/0dtAi4B
         7e4kQz/TtX62/wzeqYFH7dAmbPbgljHLBUJUhpYP5QNgtLKklyzlhA4E4AyjqSIe37hA
         UksRiVI4eJ8zWRjdaUilalLNT86RAClIH5obUZl3opl3wPKOuZEy6bMimL342jShiiGJ
         0C0m9ETQtMxkgyOWmPTN/V8x2Wn/wIoolkZmkSNesrIfvLlPBC0FtlE3OO5UmCcCAm7+
         sN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCXOD3Q6bZZ7YgdVWFVLKxYAwxM+uYb/UnG6cIzFbD8=;
        b=D2lpV3bN+COuV/MfEGMJ4zPw+u1OlseEYcEMg9q5Z0+v9dQkibrksxJdVypRNTt2WQ
         WTjL828055qK35FLoGo3dbQtnRbo5/OUidz54fEiV1Oeb/IP6Fykl/ik3q+T2P7iMkTU
         FlqGPHxnqmPVkz6klSijpNRIwZYLHtCkH1i6Waw0zCOw/tNOe5g0XNjYoE1x2PjC1QNv
         5J2fdy6iKprJpluVZ2hZYFn5/SvfiNpPuu/ublG4W1JeloErR/9+t4w5ILfQ+b4KhRqQ
         PBimF/rvptVWFwu/Hz4S9m4q5zmQnfO6JoR/dy4UBxZ4pDWVazASqvUYp/Fn/gsUGM35
         2LrQ==
X-Gm-Message-State: AA+aEWbNExzMp2KKEsVuYuazx5QmQ6dAHcB8vW72vgqtJN2UoBPXrJ+T
        WAFN/x16stIqY6qXP1Kblu0tpp9eRMgX9spf/GWV0Se0Lug=
X-Google-Smtp-Source: AFSGD/Ww9DR6/k/f3XYFdjVhPdUFermxxASJoig1tHqVLng0FoTc1EAASsONOacQWzlGb1HFuNOnTIheimwS1Ouj0f8=
X-Received: by 2002:a02:88cf:: with SMTP id b15mr12554776jak.10.1543777644781;
 Sun, 02 Dec 2018 11:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20181128175324.163202-1-lkundrak@v3.sk> <20181128175324.163202-20-lkundrak@v3.sk>
 <20181130234205.nejqtrsvwtocpq2t@localhost> <20181201131036.GB31631@amd>
In-Reply-To: <20181201131036.GB31631@amd>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 2 Dec 2018 11:07:13 -0800
Message-ID: <CAOesGMhX0VdqjsAFRZmG2Y7ExRwzdLG61wcYKm7EdM9E7ZRxkg@mail.gmail.com>
Subject: Re: [PATCH v4 19/20] USB: phy-mv-usb: use phy-pxa-usb
To:     Pavel Machek <pavel@ucw.cz>
Cc:     balbi@kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        James Cameron <quozl@laptop.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 5:10 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2018-11-30 15:42:05, Olof Johansson wrote:
> > On Wed, Nov 28, 2018 at 06:53:23PM +0100, Lubomir Rintel wrote:
> > > Use a proper PHY driver, instead of hooks to a board support package.
> > >
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > Tested-by: Pavel Machek <pavel@ucw.cz>
> >
> > These should have an ack from the USB PHY maintainer before we apply them.
> > I don't see him cc:d on these patches though (Felipe)?
>
> I put him into cc now.
>
> USB PHY LAYER
> M:      Felipe Balbi <balbi@kernel.org>
> L:      linux-usb@vger.kernel.org
> T:      git
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
> S:      Maintained
> F:      drivers/usb/phy/
>
> I guess linux-usb list should be cc-ed, too...

Yeah, and depending on how his mail subscriptions work, he might just
get the above email and not the patch.

Lubo, I suggest resending the remaining patches and making sure that
the maintainers are on cc (and the corresponding lists). If you ask
for their ack instead of to pick up the patch, we can merge it through
our tree.


-Olof
