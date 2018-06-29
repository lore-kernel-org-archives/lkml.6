Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816B0C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE97023E52
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="flfrN2ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE97023E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936554AbeF2NZG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:25:06 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32982 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbeF2NZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:25:05 -0400
Received: by mail-oi0-f68.google.com with SMTP id c6-v6so8447884oiy.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1EiuS+zVyu+ve38XQf6QCRdv87sOiPfgqM2BlE3Fy6E=;
        b=flfrN2epIc5ibKXaO8QlZK6jEw71sNKUgJsW0Z21Dlg4wlJTu5Eu6ZMiKugwxbc2Go
         wk1PC+8to0Ur9pSgPq8LmElq5brBJQPq77/vyyUu6U32aFbJdQwMaD6VeFX3iwKOTu3w
         0JbSna4gBBSYGr/ygu7vhEPcXq8IcX0eKgyts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1EiuS+zVyu+ve38XQf6QCRdv87sOiPfgqM2BlE3Fy6E=;
        b=ZqcjWI4DAjk8aqcrcewN3Ah65rVYwpkd25RbY/MUEB/F63E/CNSlAnU0sv6LnPFM1q
         UY/lfdov/CiSgdbYOsly62UFfM1XwOAqzrX6kgf4EFh96mm4xs8gaPADRJ/BOVBJDyzw
         eqBbvP4Fu/laPj2I1JXyO0r0nHZXDeHM0CtTa27LmIMUzNrwRCSzsP14+FTgFathve5F
         0aMfzyJ0R2kXLRmdg4Ds+xY0UFwUMFkc0ZCdQNdWRfR5IiKhNgsBbrZvCJ93aQzQuIGm
         3dbzOM/0K9ZWHqyTHHHJWEVOsYbHTZPOEo9AoETPyfGnggooaqQLF78KX4h9xy1UbDg6
         OJ6g==
X-Gm-Message-State: APt69E1MyLA0mQsLPVrTGjMu7KoDvgwGMUlGRegSWrg0XVIqvdiLSa5K
        badDcGhyscuJeFDGyCTodPuCycDqB9SvJhOq+Yo3HQ==
X-Google-Smtp-Source: AAOMgpczj622rfAVaDEFzKMpq7LtDjcefDzcCwjC+mNY5Q6BqLMVwL0doRmIulNO+ftNK3Xoi9+QjM3NG0MzUz3Iw6U=
X-Received: by 2002:aca:a8c7:: with SMTP id r190-v6mr3072017oie.357.1530278704926;
 Fri, 29 Jun 2018 06:25:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:192d:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 06:25:04
 -0700 (PDT)
In-Reply-To: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
References: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 29 Jun 2018 15:25:04 +0200
Message-ID: <CA+M3ks4=3nqibkcBv_KAKjV3WKNh9JBDH6vByHd312GOZB9TeA@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Remove debugfs from sti display driver
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Vincent Abriou <vincent.abriou@st.com>
Cc:     dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping on this serie,

Thanks

Benjamin

2018-06-05 15:54 GMT+02:00 Benjamin Gaignard <benjamin.gaignard@linaro.org>=
:
> Thanks to the various atomic_print_state hooks in drm structure all
> custom debugfs code could be remove from sti driver (~ -330 lines).
>
> This patchset does two addtion in drm core:
> - printing normalized zpos of each plane
> - add "atomic_print" hook in encoder structure to be able to dump encoder=
s
>   at the same time than the others elements
>
> All other patches are implemeting the various hooks in sti driver.
>
> Benjamin Gaignard (7):
>   drm: print plane state normalized zpos value
>   drm: add hook to print encoder status
>   drm: sti: make planes use atomic_print_state instead of debugfs
>   drm: sti: make connectors use atomic_print_state instead of debugfs
>   drm: sti: make crtc use atomic_print_state instead of debugfs
>   drm: sti: make encoders use atomic_print_state instead of debugfs
>   drm: sti: remove the last call to debugfs
>
>  drivers/gpu/drm/drm_atomic.c         |  16 +++
>  drivers/gpu/drm/sti/sti_compositor.c |  16 ---
>  drivers/gpu/drm/sti/sti_compositor.h |   3 -
>  drivers/gpu/drm/sti/sti_crtc.c       |  17 +--
>  drivers/gpu/drm/sti/sti_cursor.c     |  65 ++++--------
>  drivers/gpu/drm/sti/sti_drv.c        |  50 ---------
>  drivers/gpu/drm/sti/sti_dvo.c        |  60 +++--------
>  drivers/gpu/drm/sti/sti_gdp.c        | 196 +++++++++++------------------=
------
>  drivers/gpu/drm/sti/sti_hda.c        |  75 ++++----------
>  drivers/gpu/drm/sti/sti_hdmi.c       | 132 ++++++++++-------------
>  drivers/gpu/drm/sti/sti_hqvdp.c      | 149 +++++++++++---------------
>  drivers/gpu/drm/sti/sti_mixer.c      |  89 +++++-----------
>  drivers/gpu/drm/sti/sti_mixer.h      |   3 +-
>  drivers/gpu/drm/sti/sti_tvout.c      | 162 +++++++++++------------------
>  drivers/gpu/drm/sti/sti_vid.c        |  60 ++++-------
>  drivers/gpu/drm/sti/sti_vid.h        |   2 +-
>  include/drm/drm_encoder.h            |  12 +++
>  17 files changed, 386 insertions(+), 721 deletions(-)
>
> --
> 2.15.0
>



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
