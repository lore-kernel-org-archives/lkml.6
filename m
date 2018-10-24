Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD21ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A902075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/1wgF1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A902075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJYAvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:51:10 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37041 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYAvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:51:09 -0400
Received: by mail-it1-f194.google.com with SMTP id e74-v6so7347183ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAFRMkuLMN48PhSi//eQAD6i8u2OA4Pfrc//Gox/ihQ=;
        b=b/1wgF1rM2Yt1N4UC7/520Qji5Qor+A/24BlT5OawqgX7/jHE6v661QwExmzGgeRS1
         7h7u21Rk5HaC87uZ/BgiViUtQ7hCUzDiFPMJcLXs4BOnHveIetOMopQPtifClIhuDHOI
         a/ibxY0g8/aPHPlJ8oyY0DF89FH5TgPbyXZrgDRCkd20TbnmhkItrSu2fu5hKm5rPU+y
         veVdZug1kKBIHD1CfSaDa34Cu4Oks9o6je8NItfqn+SQ3MMF2xm0LSBQIKTP0cy0HMEx
         XUnZxCdC0EaN3nFbS3p/uxNyRerGd4q2T96v36/gP++uDAmszFWj6UcatePWAPNR6bq8
         pHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAFRMkuLMN48PhSi//eQAD6i8u2OA4Pfrc//Gox/ihQ=;
        b=hWqeoQXtjPtVRRuM+a0qb4eCarRoxjHTSaQuOoBWkJyatXeHocv6/gV0KpDcmnWNwS
         cOOeP+swRAq95m4wkT9oF7Ztm9AUR8rQRNEvhB3X2arfUGQIGXdsYS5oIXZjb++1Yug/
         eU+futNl7K2y1XSjcu0lLNDUzHHjueZMpXQ7/tVs3dLe+8j9IHNqm1n71Jo2BCOlpKxK
         lFt+04rvE3TVK7sksulHIgIvClqcN38otgyEhr6Q9ylWFPZo6HVtPmEXtH1epj7Q05BB
         rH8n+Lbfknk+lr3ujtML1XFogjYcbQND8cz1gP3N2XioxWW9TUPRpBxJvBfoawMZ6hJ9
         Auxg==
X-Gm-Message-State: AGRZ1gJ7Y3YK729SLCJCIa4+WXnRCx5NiCi4Sh5IyDu/w0sCH0TZBQ/t
        ZD2w5fK7VPvoWUaH7gkxrh0XJlNNTKIc51eqL8I=
X-Google-Smtp-Source: AJdET5dhFf4+/PZQt3pxt3EfvxjEETmLJWw0FlDentWEG4evrwEfHY6PDD924vGa6SAKIyTnkhUrZ5Dq1mq68AoP424=
X-Received: by 2002:a24:e16:: with SMTP id 22-v6mr2209534ite.65.1540398146689;
 Wed, 24 Oct 2018 09:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181010174923.GA29921@connor-Z97X-Gaming-7> <s5hmur3pzg2.wl-tiwai@suse.de>
 <CA+5PVA5xQvz+NftESMLUNY=5vR+A1x76sL64eXCR-KPqi6G+gg@mail.gmail.com>
In-Reply-To: <CA+5PVA5xQvz+NftESMLUNY=5vR+A1x76sL64eXCR-KPqi6G+gg@mail.gmail.com>
From:   Connor McAdams <conmanx360@gmail.com>
Date:   Wed, 24 Oct 2018 12:22:13 -0400
Message-ID: <CAM8Agx38RCN5xUPwV-YP0JyMtxNj9tveou4fHCDK1zyvE0a+Tg@mail.gmail.com>
Subject: Re: [GIT PULL] Additional firmware files for CA0132 HD-audio codec
To:     jwboyer@kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, linux-firmware@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Understood. I will see what I can do. I already had them contact
Takashi, but I will ask if they're willing to give a sign-off. If
they're having trouble, is it okay to have them contact you Josh?

Let me know.
On Wed, Oct 24, 2018 at 9:44 AM Josh Boyer <jwboyer@kernel.org> wrote:
>
> On Wed, Oct 24, 2018 at 3:37 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Wed, 10 Oct 2018 19:49:23 +0200,
> > Connor McAdams wrote:
> > >
> > > The following changes since commit c6b6265d718d118e28e1ce8f91769aa886b54c94:
> > >
> > >   Merge tag 'iwlwifi-fw-2018-10-03' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware (2018-10-08 09:23:53 -0400)
> > >
> > > are available in the git repository at:
> > >
> > >   git@github.com:Conmanx360/linux-firmware.git
> > >
> > > for you to fetch changes up to cd8899323352e772c5989230f35b1c494e0ab196:
> > >
> > >   linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec (2018-10-09 14:41:12 -0400)
> > >
> > > ----------------------------------------------------------------
> > > These are additional firmware files for CA0132 based sound cards.
> > >
> > > Creative has given me permission through email to send these to the
> > > linux-firmware repository under the same license as the previous ca0132
> > > firmware. I asked my contact if they would sign-off on it, but they said
> > > to go ahead and submit it and that if there was any issue to contact
> > > them.
> > >
> > > If you need to contact them, or if there's more info needed, let me know
> > > and I can get see what I can do.
>
> I'd really like to see a Sign-off from someone at Creative.  It's not
> that I don't trust your word that they agreed to it, but we have
> nothing to go back and verify they actually agreed to allow this to be
> redistributable, etc.
>
> josh
>
> > > ----------------------------------------------------------------
> > > Connor McAdams (1):
> > >       linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec
> > >
> > >  WHENCE            |   2 ++
> > >  ctefx-desktop.bin | Bin 0 -> 655856 bytes
> > >  ctefx-r3di.bin    | Bin 0 -> 655816 bytes
> > >  3 files changed, 2 insertions(+)
> > >  create mode 100644 ctefx-desktop.bin
> > >  create mode 100644 ctefx-r3di.bin
> >
> > Please can anyone take a look at this pull request?
> >
> > It's mandatory for the CA0132-based cards that are now supported
> > better in the upstream kernel tree.
> >
> >
> > Thanks!
> >
> > Takashi
