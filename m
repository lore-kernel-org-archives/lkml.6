Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25757C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48D721928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ApGBR02A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389972AbeLUT0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:26:01 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:45570 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeLUT0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:26:01 -0500
Received: by mail-lf1-f43.google.com with SMTP id b20so4634778lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbVPioklnrOZ9q2JoEyS4aAJN0QpxdEcLEvRni2WRgI=;
        b=ApGBR02AGWWaNYXpNXdi8cQqZRQeLfXir0p3iLe1LLkli8MjzVRJrAOdTP2JQRzbw0
         8FZMbVxq5gQjZd8PBpwr7NB/z+CtgzDORXjZxz/h12lK7fk3d3EykN90JTW+YP8dgqEX
         TWSJFIJeJym+4DJbMDnS13FtfeX/xEyGhPy6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbVPioklnrOZ9q2JoEyS4aAJN0QpxdEcLEvRni2WRgI=;
        b=rxmue3PYgSlBy7yJ1PVzGmHtrTQ6PRQ1Ii6rG4diXH9/bE2V648+TNilNwij9AqnXb
         8Ztx4FMKLABcQutOdVUeIvMGFsTz5a604j9IreLbgRa57i1we7O629PgbGVekqRRt2mu
         U6bnsfvNDi+Am1Mz45dIA4mtBWydhztek1097RR5FTnNLvCvg/hu0mpAHqrEkqtPMiP9
         WQ1PqIXjihF5kgH4hiinCNFpk51G/C9KjqlDO29fMj10x3fJgNdskF7VExClRcA09CaM
         qgeANAVRYj72HnECPFFRFI8EPDsOmBbnW0w7NCMntLlUmzytOQF3RiqFC7nZNHxlIqjS
         JyIw==
X-Gm-Message-State: AA+aEWa9g5km2404tscwq480RKD9dvFpF2X+nAODqNoTInouSmrNH/J8
        PJlzktNH2Uoat0X2iuK3FGrphdrdyvU=
X-Google-Smtp-Source: AFSGD/XNhjpU0GR1B1VpmhD4TbY1SDr1oOjJ4er/ghB0zbALDazm9+9rrWAGG6jAoutT4fi/fgFjnQ==
X-Received: by 2002:a19:c70a:: with SMTP id x10mr2133635lff.88.1545420358825;
        Fri, 21 Dec 2018 11:25:58 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 4-v6sm4717539ljw.84.2018.12.21.11.25.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:25:57 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id c16so4652889lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:25:57 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr2211898lfa.135.1545420357336;
 Fri, 21 Dec 2018 11:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20181221083226.GI23332@shao2-debian>
In-Reply-To: <20181221083226.GI23332@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Dec 2018 11:25:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=whM09ZxdrrN-o3k1JOAn0keF5aXtPAcEYiukn7kW7yp2g@mail.gmail.com>
Message-ID: <CAHk-=whM09ZxdrrN-o3k1JOAn0keF5aXtPAcEYiukn7kW7yp2g@mail.gmail.com>
Subject: Re: [LKP] [bochs] df2052cc92: WARNING:at_drivers/gpu/drm/drm_mode_config.c:#drm_mode_config_cleanup
To:     rong.a.chen@intel.com
Cc:     peter@lekensteyn.nl, kraxel@redhat.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 12:32 AM kernel test robot
<rong.a.chen@intel.com> wrote:
>
> FYI, we noticed commit df2052cc9221 ("bochs: convert to
> drm_fb_helper_fbdev_setup/teardown") caused
>
> [  487.591733] WARNING: CPU: 0 PID: 1 at drivers/gpu/drm/drm_mode_config.c:478 drm_mode_config_cleanup+0x270/0x290

Ok, this is apparently just a leak for what appears to be a not
particularly interesting error case, but the warning is new to 4.20
(*) so it would be nice to have somebody look at it.

That commit is supposed to fix a leak, but there's apparently
something still there.

Daniel, Peter, Gerd?

                       Linus

(*) the *problem* is probably not new, it's just now exposed by the
switch to drm_mode_config_cleanup().
