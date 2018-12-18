Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE6AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3B821841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cWA014dA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeLRIh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:37:56 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41900 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeLRIhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:37:55 -0500
Received: by mail-vk1-f193.google.com with SMTP id t127so3495146vke.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G8+vTGP3sXeYUw9pDEwZA8ohjuWj3lDY3Z0PkVoQRM8=;
        b=cWA014dAUj+zJbxvwo7kjB2WfJrF5fZLmYUjRt2W6BFfUKGqXecKbav5o3+xLc1DcK
         IdIN2Q1ZWYNUSKB/s91PgtVAYhGYrbJ48u3G4dhdeN3a+eQdmRSsRBh1weR/+2dPtZPv
         Adi0T/3B72Lu19ursQ0LFFMN881J67uYO151o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G8+vTGP3sXeYUw9pDEwZA8ohjuWj3lDY3Z0PkVoQRM8=;
        b=KO/z+Ja8N0Dd3AMHt5jR0411EEeaaPPYJmyV4PYMZT34MOH61SYL6kkE5IJFgLikvp
         nsYFSWu2L+fDY6bZq1AcevUAOCphkNOz91s3Sri8rSnvAydxw23UMkGPvcdpdUb3nUGb
         NOd/jZqMcYyhdVlYW9jT4db7XMUeovHBv+ois8AS2aQEgEMdHBu0kXP4V9UJ+mjDY/ni
         wgqimVttopQcW2JKy/Vk5DRB0iOJfKVrslVV3lPU/w5uNb6/yWTBSi/++6XqcaTuW9Fz
         uO+VRlJ+vUxfx19ZkYJEygikqfd98ugedCxlJG/YWmt0SZ8zzSnAaZ0z0omB6//eKWDT
         N6BA==
X-Gm-Message-State: AA+aEWb0C0klh36wbjnrS1j5+sllWBI4SSr+tIyzfPyaDnHn2RSlqKDw
        Y84P+mxhVB7l1Pw2HdELxPK3NFTGqIWZfdBjJRgvog==
X-Google-Smtp-Source: AFSGD/WfEHA/V5ZNYRywdTk92+WpGTgPCMERR8lfmP7cl6LeuBt9OcvtU2sn/92dZsvqp/xDfbGoLKf6YTQOrHG+zKA=
X-Received: by 2002:a1f:1c2:: with SMTP id 185mr5257262vkb.57.1545122274043;
 Tue, 18 Dec 2018 00:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20181206040540.84632-1-cychiang@chromium.org> <20181214122156.GT4497@dell>
 <20181214122245.GU4497@dell>
In-Reply-To: <20181214122245.GU4497@dell>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 18 Dec 2018 16:37:27 +0800
Message-ID: <CAFv8Nw+RbzKrjE1tsgxdRntXKWp9XVq8hbP7MZ3mZ=a2rMyG2Q@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: cros_ec: Add commands to control codec
To:     Lee Jones <lee.jones@linaro.org>, bleung@chromium.org,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>,
        scollyer@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Benson, Guenter, Scott

On Fri, Dec 14, 2018 at 8:22 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 14 Dec 2018, Lee Jones wrote:
>
> > On Thu, 06 Dec 2018, Cheng-Yi Chiang wrote:
> >
> > > Add EC host commands to control codec on EC.
> > >
> > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > ---
> > >  V2 fixed the wrong ancestor issue so the patch can be applied cleanl=
y on mfd tree.
> > >  Codec driver that uses these commands will be sent separately.
> > >  Thanks!
> > >
> > >  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++=
++
> > >  1 file changed, 94 insertions(+)
> >
> > Would be good to have this reviewed by some more Chrome people.
>
> See this for reference:
>
>   https://lore.kernel.org/patchwork/patch/1024985/

Hi Benson and Guenter,
Could you please review this patch ?
The corresponding implementation at EC side by Scott is at
https://chromium-review.googlesource.com/c/chromiumos/platform/ec/+/1356185

Thanks a lot!

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
