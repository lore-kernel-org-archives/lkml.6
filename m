Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF44C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EDC208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544792105;
	bh=fgJ/73XZUvz2WXzFnQcQv+Jzrsn04XArvh1JIuKERkY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Syw4kvCfBgoLxFM5+NRdGkUz6qmWOtSTNrzDFSIo57eNYXPxtFRhY2+LxEyVOr/eZ
	 STu3oXiO6AgAaolW/yaM4OiEQuISnUXayM31W7d5oqumiW8g9hS41sTLJTJQBCd3bm
	 v4C9MNHVOaOW0iwkoJRcZbOAtjYPFgC/aaDCO93s=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EDC208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbeLNMzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:55:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLNMzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:55:03 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86712208E7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 12:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544792102;
        bh=fgJ/73XZUvz2WXzFnQcQv+Jzrsn04XArvh1JIuKERkY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ti0eLBXB0Sw5pI0NcWM7jcb03PJvhfm5I6RsLMkicMPxpmGWD84wmkiTHRABeH337
         tGFH8sKtq6bYjvsuMeIqWsBNfTGP3F7052SAZO4iR/BqbHF2GSGaeQ/8F6d1AMMC6g
         q0Ju3InJ1BA5FizxVte30rrXRQH66+boEolGQzfs=
Received: by mail-qk1-f181.google.com with SMTP id y16so3140763qki.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:55:02 -0800 (PST)
X-Gm-Message-State: AA+aEWZVUOEUc933Dcn2jQhoZmanTUzKa6TyISuXJVAUNwXOllmU9/Rz
        X/y0gLBaxWXF5XrKyaXLcS2IKZX9gQvKFGJprdQ=
X-Google-Smtp-Source: AFSGD/XQbXgE/lHmFpCRW7+ZaicRJOnrIi5GN0z/2SOVwtwEKDv8B0NJSGDBN4jXee+Sh4e22PkKclJ7S75s03KCF7I=
X-Received: by 2002:a37:bb82:: with SMTP id l124mr1785360qkf.188.1544792101760;
 Fri, 14 Dec 2018 04:55:01 -0800 (PST)
MIME-Version: 1.0
References: <20181010174923.GA29921@connor-Z97X-Gaming-7> <s5hmur3pzg2.wl-tiwai@suse.de>
 <CA+5PVA5xQvz+NftESMLUNY=5vR+A1x76sL64eXCR-KPqi6G+gg@mail.gmail.com>
 <CAM8Agx38RCN5xUPwV-YP0JyMtxNj9tveou4fHCDK1zyvE0a+Tg@mail.gmail.com>
 <CAM8Agx1VK3QNV52RmiSsrD8042oFRKZg-w6WFa7SPfebVa4hQQ@mail.gmail.com> <CAM8Agx2KYOZK97J7yiM9JvNF1bxiAKNtA_YDegtLMVAYiWKEXQ@mail.gmail.com>
In-Reply-To: <CAM8Agx2KYOZK97J7yiM9JvNF1bxiAKNtA_YDegtLMVAYiWKEXQ@mail.gmail.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Fri, 14 Dec 2018 07:54:50 -0500
X-Gmail-Original-Message-ID: <CA+5PVA7BNyoFK8CDxr+oDA7Von201qFxejbsEQi+CgeOo0xzxA@mail.gmail.com>
Message-ID: <CA+5PVA7BNyoFK8CDxr+oDA7Von201qFxejbsEQi+CgeOo0xzxA@mail.gmail.com>
Subject: Re: [GIT PULL] Additional firmware files for CA0132 HD-audio codec
To:     Connor McAdams <conmanx360@gmail.com>
Cc:     jwboyer@kernel.org, Takashi Iwai <tiwai@suse.de>,
        Linux Firmware <linux-firmware@kernel.org>,
        alsa-devel@alsa-project.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 2:49 PM Connor McAdams <conmanx360@gmail.com> wrote:
>
> Okay... So, my contact at Creative gave me an email as the 'sign-off
> party' for firmware submission. As far as I'm aware, sign-offs also
> need names attached, correct? So I'll ask for that. However, they
> still want me to send it.
>
> Will that be okay? Would you be more comfortable if I get you in
> contact with someone at Creative,Josh?

It is common for someone to sign-off on a patch, but have someone else
send it.  Having their Signed-off-by: <person> in the commit log is
OK.

josh

>
> I apologize for being kind of difficult, I'm doing what I can. Let me
> know what I need to do, and I'll do my best.
>
> Thanks,
> Connor.
> On Sun, Nov 4, 2018 at 1:00 AM Connor McAdams <conmanx360@gmail.com> wrote:
> >
> > Okay, just got a response from the guy at Creative. He said they'll
> > try to sort it out this week. Just a heads up. :)
> > On Wed, Oct 24, 2018 at 12:22 PM Connor McAdams <conmanx360@gmail.com> wrote:
> > >
> > > Understood. I will see what I can do. I already had them contact
> > > Takashi, but I will ask if they're willing to give a sign-off. If
> > > they're having trouble, is it okay to have them contact you Josh?
> > >
> > > Let me know.
> > > On Wed, Oct 24, 2018 at 9:44 AM Josh Boyer <jwboyer@kernel.org> wrote:
> > > >
> > > > On Wed, Oct 24, 2018 at 3:37 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > >
> > > > > On Wed, 10 Oct 2018 19:49:23 +0200,
> > > > > Connor McAdams wrote:
> > > > > >
> > > > > > The following changes since commit c6b6265d718d118e28e1ce8f91769aa886b54c94:
> > > > > >
> > > > > >   Merge tag 'iwlwifi-fw-2018-10-03' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware (2018-10-08 09:23:53 -0400)
> > > > > >
> > > > > > are available in the git repository at:
> > > > > >
> > > > > >   git@github.com:Conmanx360/linux-firmware.git
> > > > > >
> > > > > > for you to fetch changes up to cd8899323352e772c5989230f35b1c494e0ab196:
> > > > > >
> > > > > >   linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec (2018-10-09 14:41:12 -0400)
> > > > > >
> > > > > > ----------------------------------------------------------------
> > > > > > These are additional firmware files for CA0132 based sound cards.
> > > > > >
> > > > > > Creative has given me permission through email to send these to the
> > > > > > linux-firmware repository under the same license as the previous ca0132
> > > > > > firmware. I asked my contact if they would sign-off on it, but they said
> > > > > > to go ahead and submit it and that if there was any issue to contact
> > > > > > them.
> > > > > >
> > > > > > If you need to contact them, or if there's more info needed, let me know
> > > > > > and I can get see what I can do.
> > > >
> > > > I'd really like to see a Sign-off from someone at Creative.  It's not
> > > > that I don't trust your word that they agreed to it, but we have
> > > > nothing to go back and verify they actually agreed to allow this to be
> > > > redistributable, etc.
> > > >
> > > > josh
> > > >
> > > > > > ----------------------------------------------------------------
> > > > > > Connor McAdams (1):
> > > > > >       linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec
> > > > > >
> > > > > >  WHENCE            |   2 ++
> > > > > >  ctefx-desktop.bin | Bin 0 -> 655856 bytes
> > > > > >  ctefx-r3di.bin    | Bin 0 -> 655816 bytes
> > > > > >  3 files changed, 2 insertions(+)
> > > > > >  create mode 100644 ctefx-desktop.bin
> > > > > >  create mode 100644 ctefx-r3di.bin
> > > > >
> > > > > Please can anyone take a look at this pull request?
> > > > >
> > > > > It's mandatory for the CA0132-based cards that are now supported
> > > > > better in the upstream kernel tree.
> > > > >
> > > > >
> > > > > Thanks!
> > > > >
> > > > > Takashi
