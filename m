Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844A7C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA692080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="We/i6ryV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA692080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeJaAoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:44:12 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36065 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbeJaAoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:44:11 -0400
Received: by mail-ua1-f68.google.com with SMTP id w19so4667259uaj.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lY3qh/y6H2uPpcsadtL27CmpydoR1RntDCew5HITJgk=;
        b=We/i6ryVS9tKcBGAlVEa0UdXxKF/qfNC5D0udNiEMG4BAU0QJskasD3azOXk4o/N/a
         EICtGsRLetXUPbODfYV0imoqK6I2QElxWed2kEN0SK5PLPlitCOmCqb3CLTDbH5htVXC
         MHa2uyLcnRwDqloNObb+t4eoNEdlwr5N5s8WKCnMKp1fy9uci+D9b1jOZ0rFx0XJGW9Z
         jHNiXxui8UXlzdjme/mVxDSrfxWJXt3BqoIkJgDmExECh5xlWdAbWmnIGUWBtL4Z6JJR
         YBKdkawpfq7LWN4D6eTNkhmTUkkzvUK+hKPlXyCScv8Sj45gp6DfeGOWXT3vst9X27/Q
         B3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lY3qh/y6H2uPpcsadtL27CmpydoR1RntDCew5HITJgk=;
        b=aMxpNHE1Mk9V2UfyyTKHhzOlL0EE8NuxbWDsilYRj7fvNzt7xQA1M1CKoonVoOwGtv
         koJXFOG4zivlgIrQruyolwhOl0NK9s+rN6NmQ+v38vvsq+Q8KgwgZs8XiZbq5oJ8r/Uh
         bRLxDYsT2FHybuUfvLKQU2kFPCZWd07NFcNgbWGO3YK1eEMomBZa5za+b9KSsJM/5yfN
         9Y4Zdyb8TYiAgO4sZmCMWX4fQENJAvVWMt7k+Vs/BuqdwR2nX2AqOWFbWZEA6V57JybU
         T6JH4J5s9mvr+6L/raYC+LKTwYbCE9U0BYtDTFfDdQ8DeYC10bWwi+8VP+arIUOUdCpK
         lk6g==
X-Gm-Message-State: AGRZ1gKf6Z2FOmmxpur/aaz+f/J9i9GVR4++GEnDkshahugD2PKPH89S
        rH0Mnthq4q7zF+c1MmrarWZ+kfVJ0JiOqO8iW4Y=
X-Google-Smtp-Source: AJdET5dkrqdk+caJskfUUBLK91UNsKBqTbZVte/HtHsmzKrsFjfmyXRGSG3BGk6JwlUMGdJMUVWXpGW6DqAAbMc9oyA=
X-Received: by 2002:ab0:70b4:: with SMTP id q20mr1724892ual.24.1540914610888;
 Tue, 30 Oct 2018 08:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181025183739.9375-1-robert.foss@collabora.com>
 <20181025183739.9375-3-robert.foss@collabora.com> <20181030061127.hp4n2scw5f3j2rqq@sirius.home.kraxel.org>
 <CACvgo50MK1jU0jKMCfZJQSaSmpQ8mmYj1=4GP2NQvM_DHOaW-Q@mail.gmail.com> <20181030135242.doccralyqaqzshyx@sirius.home.kraxel.org>
In-Reply-To: <20181030135242.doccralyqaqzshyx@sirius.home.kraxel.org>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 30 Oct 2018 15:48:54 +0000
Message-ID: <CACvgo52+D_zYnNbMgCnAWZFO2dXZYbGz628pD34VY99VU8ERGA@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/virtio: add uapi for in and out explicit fences
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Robert Foss <robert.foss@collabora.com>,
        David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018 at 13:52, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Oct 30, 2018 at 11:31:04AM +0000, Emil Velikov wrote:
> > HI Gerd,
> >
> > On Tue, 30 Oct 2018 at 06:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > >   Hi,
> > >
> > > > The execbuffer IOCTL is now read-write to allow the userspace to read the
> > > > out-fence.
> > >
> > > >  #define DRM_IOCTL_VIRTGPU_EXECBUFFER \
> > > > -     DRM_IOW(DRM_COMMAND_BASE + DRM_VIRTGPU_EXECBUFFER,\
> > > > +     DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_EXECBUFFER,\
> > > >               struct drm_virtgpu_execbuffer)
> > >
> > > That changes the ioctl number and breaks the userspace api.
> > >
> > Have you looked at the drm_ioctl() implementation? AFAICT it
> > explicitly caters for this kind of changes.
>
> Looking ...
>
> The direction bits are not used to lookup the ioctl functions,
> so it should work indeed.
>
Nice, thanks for confirming.

> Series doesn't apply to drm-misc-next and needs a rebase.
>
Might be nicer to address that alongside any feedback. Otherwise it'll
be spamming people just for the sake of rebasing.

If i find some time I'll post some comments later on today.

HTH
Emil
