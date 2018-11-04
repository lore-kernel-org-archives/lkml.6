Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FB1C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 05:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FDA204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 05:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvKZ+URj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FDA204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeKDOO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 09:14:26 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36730 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeKDOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 09:14:25 -0500
Received: by mail-io1-f68.google.com with SMTP id o19-v6so4195487iod.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 22:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDksw7T0BTkSVAKMkG1MELtengX48KktyCyu2Mer3x4=;
        b=RvKZ+URjhPiLV+lySA18Pnq/LPbfcWDMmlzySnalPJXYTvBK2VUsBid9i08UWx0xh8
         oo1oiQs9BEd3gQ1yVUEepal5q08nQhQon65mQAi0tOG+pstpAhVK5Aep1puxuqrEpJmF
         UsLXtaVlTxgIcsnCHY6SfQZMhbqIFT0zAQCOjVisvj0MbC9LhmMO8kn0ZvuJiNe0A4ph
         sjO2Q8J8YJwAKt9UUUK5KsiMd/Lif+BNcwnNeLq4peCtQW+FIdc1F8NiiZ6TnzOW9BqX
         3yWabx9IZS45z9P71mHBSW4MHfAt3wBFl4WLmfitDAtW5NFI+OhyMGzP+9pDV40qZDNI
         Z7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDksw7T0BTkSVAKMkG1MELtengX48KktyCyu2Mer3x4=;
        b=RnyuczVCZZzkItg4rRVGhhkpNo99WK5AmF/xhG2emhe/omYuOCtgkSLWjP+5HjlDPb
         +5v0viBWGtyizRi70ATtcNQcCOd7w1ip/zrnWFmPIn4FsJvgI1lGVorFmHYa8ZMKKzBa
         rWESVAFVG2x49cP52hnrBqLtS/ji224olEYzAedUEOL1v63ixNcfErL+prkAMgWEyh3S
         etSp8uATjo6VoNI2y+O/I7YtQVcuaTHnwnJLoTr6rUzJhcYMT9mg76mjwq+twKAo7aF/
         +mBiqS7FuRq02hjnvDiKh4KVdOOj3VDi0HGJPAWWwmeAAMM8MSOZI/dnONbXuiAm5WYe
         3kPA==
X-Gm-Message-State: AGRZ1gJvNnH42zJjiOkTNNXRz+hjfnFnIzxqA3XFouZmcyjLVbSqTfB5
        q2uv3FapUDeIOm43sW+DLc4bH7UrwlRzhbBbyZyx6A==
X-Google-Smtp-Source: AJdET5d1Q+BrumkuwLyaYH7sBMEaWko4pdFniDgCzenu1/o30gTgQkZJhWn9ufnSkYt7bixZ51qHScAZiarHob+UDds=
X-Received: by 2002:a6b:b3c6:: with SMTP id c189-v6mr14618971iof.23.1541307647102;
 Sat, 03 Nov 2018 22:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181010174923.GA29921@connor-Z97X-Gaming-7> <s5hmur3pzg2.wl-tiwai@suse.de>
 <CA+5PVA5xQvz+NftESMLUNY=5vR+A1x76sL64eXCR-KPqi6G+gg@mail.gmail.com> <CAM8Agx38RCN5xUPwV-YP0JyMtxNj9tveou4fHCDK1zyvE0a+Tg@mail.gmail.com>
In-Reply-To: <CAM8Agx38RCN5xUPwV-YP0JyMtxNj9tveou4fHCDK1zyvE0a+Tg@mail.gmail.com>
From:   Connor McAdams <conmanx360@gmail.com>
Date:   Sun, 4 Nov 2018 01:00:35 -0400
Message-ID: <CAM8Agx1VK3QNV52RmiSsrD8042oFRKZg-w6WFa7SPfebVa4hQQ@mail.gmail.com>
Subject: Re: [GIT PULL] Additional firmware files for CA0132 HD-audio codec
To:     jwboyer@kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, linux-firmware@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, just got a response from the guy at Creative. He said they'll
try to sort it out this week. Just a heads up. :)
On Wed, Oct 24, 2018 at 12:22 PM Connor McAdams <conmanx360@gmail.com> wrote:
>
> Understood. I will see what I can do. I already had them contact
> Takashi, but I will ask if they're willing to give a sign-off. If
> they're having trouble, is it okay to have them contact you Josh?
>
> Let me know.
> On Wed, Oct 24, 2018 at 9:44 AM Josh Boyer <jwboyer@kernel.org> wrote:
> >
> > On Wed, Oct 24, 2018 at 3:37 AM Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Wed, 10 Oct 2018 19:49:23 +0200,
> > > Connor McAdams wrote:
> > > >
> > > > The following changes since commit c6b6265d718d118e28e1ce8f91769aa886b54c94:
> > > >
> > > >   Merge tag 'iwlwifi-fw-2018-10-03' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware (2018-10-08 09:23:53 -0400)
> > > >
> > > > are available in the git repository at:
> > > >
> > > >   git@github.com:Conmanx360/linux-firmware.git
> > > >
> > > > for you to fetch changes up to cd8899323352e772c5989230f35b1c494e0ab196:
> > > >
> > > >   linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec (2018-10-09 14:41:12 -0400)
> > > >
> > > > ----------------------------------------------------------------
> > > > These are additional firmware files for CA0132 based sound cards.
> > > >
> > > > Creative has given me permission through email to send these to the
> > > > linux-firmware repository under the same license as the previous ca0132
> > > > firmware. I asked my contact if they would sign-off on it, but they said
> > > > to go ahead and submit it and that if there was any issue to contact
> > > > them.
> > > >
> > > > If you need to contact them, or if there's more info needed, let me know
> > > > and I can get see what I can do.
> >
> > I'd really like to see a Sign-off from someone at Creative.  It's not
> > that I don't trust your word that they agreed to it, but we have
> > nothing to go back and verify they actually agreed to allow this to be
> > redistributable, etc.
> >
> > josh
> >
> > > > ----------------------------------------------------------------
> > > > Connor McAdams (1):
> > > >       linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec
> > > >
> > > >  WHENCE            |   2 ++
> > > >  ctefx-desktop.bin | Bin 0 -> 655856 bytes
> > > >  ctefx-r3di.bin    | Bin 0 -> 655816 bytes
> > > >  3 files changed, 2 insertions(+)
> > > >  create mode 100644 ctefx-desktop.bin
> > > >  create mode 100644 ctefx-r3di.bin
> > >
> > > Please can anyone take a look at this pull request?
> > >
> > > It's mandatory for the CA0132-based cards that are now supported
> > > better in the upstream kernel tree.
> > >
> > >
> > > Thanks!
> > >
> > > Takashi
