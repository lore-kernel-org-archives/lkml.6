Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rUPuNFNBGVuaawAAmS7hNA
	; Thu, 07 Jun 2018 14:30:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B146A608D2; Thu,  7 Jun 2018 14:30:44 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBopdLZZ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EC9006063F;
	Thu,  7 Jun 2018 14:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC9006063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933798AbeFGOak (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:30:40 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40110 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933768AbeFGOaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:30:23 -0400
Received: by mail-qt0-f194.google.com with SMTP id q6-v6so10028147qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5bUYUqpMgW4l68gibDz5KOj6FkpoOroYTO0xGnF7t30=;
        b=BBopdLZZxs5Kb1sHfPYPXECQ8sZJAhPn7QizAJKH/RWEwTfM+mARJrCjd+G81JYyFX
         DCrkPZjOcNjyvpn1Mvy0TxhtdRmyRq/tKqLwiUnJA3/J6j31g3rB3vELG8SrtMn5weqh
         Gb4YGs+FjOYfvoVBlcmn0+0WxZV/v/bQCl8J7EHhn6jCTHRiQ2RtM8QzeVHuO/0auBt8
         b5vIA9C5Gbo0WyiNrBguSC5wNB/olsehle0ElqkNDGG1JnVfA68T8vfI7O3jcwwaFeK8
         eEnajPZ4GGo9e5Ra3X5iBemEsUFScHC3MU/62h46HT56lRMKn0IBKQoEFl2fzGu7xic9
         /zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5bUYUqpMgW4l68gibDz5KOj6FkpoOroYTO0xGnF7t30=;
        b=Mls8rdyhTRDnW71e3n2rVKh3WN89hVqzGnVTSp+dPTpzGHcFkHXUqJOMrW0v9Qlt9b
         yxDPV8nKIYsFl5bCrV0/3NMpC7hOL55VoQ6Psp3wiwo1pBKxhMCvVzYrEAwhezt5i+gb
         DAh53lEYHVdtGCmhv+6oCvzRIcvQOE58v+Iof0TbkzA4iKM4uKCZ7S/i8cFTchgNu0XA
         t0919leYcpgFb5S7JoSqjHIvLjoGPxt6NnavIA9nC85Qt+1hU2qLQSSvfTURnHBaA1mD
         TjHyxPdnPKRNsRHuMHlzr34lm87XzZApWVssXtBC4xTiKH2UHEEFFA5S9usGlMLV9Mq4
         LXtw==
X-Gm-Message-State: APt69E0MqXlvUTry8FJluriQ3qVFcGC7OYUJdUTqSGjtGvzopF1emxeo
        t/+5obwfJXZ9Hd6eblZJN12yYKc6EVPqBuzZ5l4=
X-Google-Smtp-Source: ADUXVKKB9F6Kla7iQhqpkqw5treKaIkQqzigSEEfwdN8bqjNJFSaOQlh3x8ijvJ/aMD+mQwChtQ8STsFCfnrWfLa3LM=
X-Received: by 2002:ac8:1692:: with SMTP id r18-v6mr1922426qtj.206.1528381823269;
 Thu, 07 Jun 2018 07:30:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:4716:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 07:30:02 -0700 (PDT)
In-Reply-To: <20180607142209.5w5uitasnq4jfs7h@gmail.com>
References: <20180607142209.5w5uitasnq4jfs7h@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 7 Jun 2018 16:30:02 +0200
Message-ID: <CANiq72k1aov6OM-RDJo_xCZmO+vD1Sn2gwHPiG1hz_yYVo5Ong@mail.gmail.com>
Subject: Re: [GIT PULL] auxdisplay for v4.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Robert Abel <rabel@robertabel.eu>, Sean Young <sean@mess.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Jun 7, 2018 at 4:22 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> The following changes since commit 0adb32858b0bddf4ada5f364a84ed60b196dbcda:
>
>   Linux 4.16 (2018-04-01 14:20:27 -0700)
>
> are available in the git repository at:
>
>   https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v4.18-rc1
>
> for you to fetch changes up to 351f683b9823a3d1bffb6e2e3f381601aa0b2671:
>
>   auxdisplay: Replace licenses with SPDX identifiers (2018-04-12 19:02:45 +0200)

This pull request is an identical one to the one sent for v4.17-rc1 --
which was rejected because it was quite late in the merge window.
Please pull -- thanks!

Cheers,
Miguel Ojeda

>
> ----------------------------------------------------------------
> Mostly small fixes and cleanups, plus a non-trivial fix for charlcd
>
>   - charlcd: fixes and cleanups
>     From Robert Abel and Sean Young
>
>   - Kconfig fixes
>     From Randy Dunlap, Corentin Labbe and Ulf Magnusson
>
>   - cfag12864bfb: const cleanup
>     From Gustavo A. R. Silva
>
>   - Docs/licenses/warnings cleanups
>
> ----------------------------------------------------------------
> Corentin Labbe (1):
>       auxdisplay: img-ascii-lcd: fix typo on select SYSCON/MFD_SYSCON
>
> Gustavo A. R. Silva (1):
>       auxdisplay: cfag12864bfb: constify fb_fix_screeninfo and fb_var_screeninfo structures
>
> Miguel Ojeda (5):
>       Doc: misc-devices: move lcd-panel-cgram.txt to auxdisplay/
>       MAINTAINERS: auxdisplay: remove obsolete webpages
>       auxdisplay: arm-charlcd: Fix struct charlcd doc line
>       auxdisplay: charlcd: Fix and clean up handling of x/y commands
>       auxdisplay: Replace licenses with SPDX identifiers
>
> Randy Dunlap (2):
>       auxdisplay: fix broken menu
>       auxdisplay: make PANEL a menuconfig
>
> Robert Abel (4):
>       auxdisplay: charlcd: use null character instead of zero literal to terminate strings
>       auxdisplay: charlcd: replace octal literal with form-feed escape sequence
>       auxdisplay: charlcd: fix two-line command ^[[LN not marked as processed
>       auxdisplay: charlcd: fix hex literal ranges for graphics command
>
> Sean Young (1):
>       auxdisplay: charlcd: no need to call charlcd_gotoxy() if nothing changes
>
> Ulf Magnusson (1):
>       auxdisplay: img-ascii-lcd: kconfig: Remove MIPS_SEAD3 reference
>
>  .../lcd-panel-cgram.txt                            |   0
>  MAINTAINERS                                        |   8 --
>  drivers/auxdisplay/Kconfig                         |  16 +--
>  drivers/auxdisplay/arm-charlcd.c                   |   4 +-
>  drivers/auxdisplay/cfag12864b.c                    |  16 +--
>  drivers/auxdisplay/cfag12864bfb.c                  |  20 +---
>  drivers/auxdisplay/charlcd.c                       | 119 +++++++++++++++------
>  drivers/auxdisplay/hd44780.c                       |   6 +-
>  drivers/auxdisplay/ht16k33.c                       |  10 +-
>  drivers/auxdisplay/ks0108.c                        |  16 +--
>  drivers/auxdisplay/panel.c                         |   6 +-
>  include/linux/cfag12864b.h                         |  16 +--
>  include/linux/ks0108.h                             |  16 +--
>  samples/auxdisplay/cfag12864b-example.c            |  16 +--
>  14 files changed, 111 insertions(+), 158 deletions(-)
>  rename Documentation/{misc-devices => auxdisplay}/lcd-panel-cgram.txt (100%)
