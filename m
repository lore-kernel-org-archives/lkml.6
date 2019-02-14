Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F91C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA14222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dpildr1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437180AbfBNHNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:13:44 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33425 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731752AbfBNHNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:13:44 -0500
Received: by mail-vk1-f195.google.com with SMTP id d201so1176785vka.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 23:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=obC8XUFC/omwmNLuvSMPxvu4+DEnayxyH/No9CtLai8=;
        b=Dpildr1sE+WONyIhA+QwPCsJJrvL9CDaCGWyAtruaBThjtDxCB4Qg5tr76gCKlt+gF
         KjPXLRv3KHybl91+74vbSB5SrdAOCE33s7frTlGXD56ohSTV6g1gHlWeRUPULxg9K2xE
         hWfQ0Xf3gT4zQvynXCSyUsAj9O9nIsRZOkPWWyWzmEs4O8/0LTyLMHQe2gwG0zJhrZra
         O7SwJnjAA2VOCAiPkYQNguKFx9ZYE+Rj9XdL3bExz5Z48Z0cbRKkzG/PuyyqVyLrtQt7
         eOjMxj8RGPiYzYiYvtUt123ces679lA9iXo7RAcdeR/Gpb2lhz/VYFF5lB2mVY0slNti
         YDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obC8XUFC/omwmNLuvSMPxvu4+DEnayxyH/No9CtLai8=;
        b=DhU2qHTPxoqn9Bf2XpIeUI6NLAEfJX4+DKizWznGlZIDmxjl931dXX39gwTz3mA76S
         Om8SeRhuzsHFqB9R0oBOaO86Eca0PUJOW5Zz3ghtFUI9HXeKkBkJXkSUe9Q+TftB7rrp
         TagI9DpOfhdaHhexqe1yi7h13Ppw7fQW1diPS1nrdY+dKa0A/S6FoRYhpv3tsuHHmL9d
         H+hTHsKLOBetHaDdFIPOUIWLMG9M8TwuqAODKUOmjZdgCazz6xL9RkSnoXNmGeaC9yCj
         m9GkR9kAbHezJUC/UG/Cn7sF+2IoFone10mLes0wwEuvKqqyOA2K42tJfm5+4qUZftV+
         IbKA==
X-Gm-Message-State: AHQUAuZfwMhzoCyBNhQY0tjK3Bmd2KV5zpv3LEb85KIUStSwhpgXPZVu
        rb93FH1BkL/7TCoFDkwY+fCyryMLkhFACaQqYzc=
X-Google-Smtp-Source: AHgI3IYXD0uRAypPWGcjehU3noPyWBQdzRBqgMeTNjnt5Fg2A0TGzX6kgj3DRbVZAV4yz562P+XsXdBj2HI0Y5NMJ6k=
X-Received: by 2002:a1f:9ec9:: with SMTP id h192mr1206303vke.68.1550128422817;
 Wed, 13 Feb 2019 23:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20190211151751.12336-1-oded.gabbay@gmail.com> <20190214071114.GA21381@kroah.com>
In-Reply-To: <20190214071114.GA21381@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 14 Feb 2019 09:13:16 +0200
Message-ID: <CAFCwf12VaYSpCtqyYsTGp2TZDJiJ4bYc4egrRY6mdzaceO_5Cw@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Habana Labs kernel driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Olof Johansson <olof@lixom.net>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 9:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 11, 2019 at 05:17:36PM +0200, Oded Gabbay wrote:
> > Hello,
> > This is v4 of the Habana Labs kernel driver patch-set. It contains fixes
> > according to reviews done on v3, mainly for the command buffer, sysfs and MMU
> > patches. In addition, patch 2/15 was reduced in size from 4.3MB to 1.4MB.
> >
> > The patch-set is rebased on v5.0-rc6.
> >
> > Link to v3 cover letter: https://lkml.org/lkml/2019/2/4/1033
> >
> > Link to v2 cover letter: https://lkml.org/lkml/2019/1/30/1003
> >
> > Link to v1 cover letter: https://lwn.net/Articles/777342/
> >
> > I would appricate any feedback, question and/or review.
>
> There's been some 0-day bot feedback on some of these patches now that I
> put them in my -testing branch.  So I'm going to drop the patch series
> from there now and wait for a v5 of the series that hopefully will have
> those issues fixed :)
>
> thanks,
>
> greg k-h

Sure, np.
Thanks,
Oded
