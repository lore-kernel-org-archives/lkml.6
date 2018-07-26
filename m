Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36889C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F102020673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F102020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbeGZRFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:05:54 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42360 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbeGZRFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:05:54 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so2010520qto.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 08:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:mime-version
         :content-transfer-encoding;
        bh=DaUc0CnMHyUHUjTM1XaqHFeFITiww0qjy34eeiO9JjA=;
        b=ii9Z2Xk+ToNaHnKWIWOLdSM62OSauODy/LSa68PsBAU9daySkcxzrHSfjbIxbcBwrD
         mAL5ct85CDMCL+mZg+1RMFrc9WX4sEBKvYJcblYzJ5tRwLOF3TOZ6W+AU4ppNTnGoIvf
         h115xkFvxwshcO0pgaMoymEKV0tJmnpg4AalTNrvuYM2ggyEPDjCqOeq9LNbyTYkNhlr
         VLb7nVBuysJ8g6+Bp3+CMRkuzLWhLaEQ8qfJbTjTf9ePdp4lmdomyXu4afd0mBQoU3Jo
         aO9sNYMEjHPqEyNd0OZ6sD7Of0Ywv82TUa45eYhHZuteoTfngWFUELImJkeGte33dS4v
         5hPw==
X-Gm-Message-State: AOUpUlGvX4+hQUWlTKZohNHaS+HrhVi25Yz8wq4dg6uOgLqFSe7NKtEg
        pqZAeDLpp/gSuQFscJCBXMV5Mw==
X-Google-Smtp-Source: AAOMgpd624bTjkj5Qj+Uc7oxtSXOhDu6/W09Q6RIOXvLujeXDQa7dRiDO4aWRf+a4ZiNF5k4RjY0zw==
X-Received: by 2002:ac8:96b:: with SMTP id z40-v6mr2390816qth.362.1532620108326;
        Thu, 26 Jul 2018 08:48:28 -0700 (PDT)
Received: from whitewolf.lyude.net (pool-72-74-165-95.bstnma.fios.verizon.net. [72.74.165.95])
        by smtp.gmail.com with ESMTPSA id z14-v6sm757608qti.83.2018.07.26.08.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 08:48:27 -0700 (PDT)
Message-ID: <a0e04475abd7f0128b6180805490b7decb4f9c02.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: Set DRIVER_ATOMIC cap earlier to fix
 debugfs
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     bskeggs@redhat.com, stable@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 26 Jul 2018 11:48:26 -0400
In-Reply-To: <20180726151202.GE27305@kroah.com>
References: <153227752119282@kroah.com>
         <20180723171322.9677-1-lyude@redhat.com> <20180726151202.GE27305@kroah.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-26 at 17:12 +0200, Greg KH wrote:
> On Mon, Jul 23, 2018 at 01:13:20PM -0400, Lyude Paul wrote:
> > commit eb493fbc150f4a28151ae1ee84f24395989f3600 upstream
> > 
> > Currently nouveau doesn't actually expose the state debugfs file that's
> > usually provided for any modesetting driver that supports atomic, even
> > if nouveau is loaded with atomic=1. This is due to the fact that the
> > standard debugfs files that DRM creates for atomic drivers is called
> > when drm_get_pci_dev() is called from nouveau_drm.c. This happens well
> > before we've initialized the display core, which is currently
> > responsible for setting the DRIVER_ATOMIC cap.
> > 
> > So, move the atomic option into nouveau_drm.c and just add the
> > DRIVER_ATOMIC cap whenever it's enabled on the kernel commandline. This
> > shouldn't cause any actual issues, as the atomic ioctl will still fail
> > as expected even if the display core doesn't disable it until later in
> > the init sequence. This also provides the added benefit of being able to
> > use the state debugfs file to check the current display state even if
> > clients aren't allowed to modify it through anything other than the
> > legacy ioctls.
> > 
> > Additionally, disable the DRIVER_ATOMIC cap in nv04's display core, as
> > this was already disabled there previously.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/dispnv04/disp.c | 3 +++
> >  drivers/gpu/drm/nouveau/nouveau_drm.c   | 7 +++++++
> >  drivers/gpu/drm/nouveau/nv50_display.c  | 6 ------
> >  3 files changed, 10 insertions(+), 6 deletions(-)
> 
> Please give me a hint as to what kernel versions you want the patches to
> be applied to, otherwise I just have to guess :)
will note for the future, sorry about that!
> 
> thanks,
> 
> greg k-h

