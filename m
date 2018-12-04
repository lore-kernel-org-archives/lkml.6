Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A278CC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C972151B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A29bj2gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C972151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeLDBq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:46:57 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35963 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeLDBq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:46:56 -0500
Received: by mail-ua1-f65.google.com with SMTP id j3so5198208uap.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 17:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OFhhXwoR5xQKUc88wWoeoxttHr9egdOaBhNaHhQIGoQ=;
        b=A29bj2gm7/uud0YsyDnUC/5iP/EkSTVhiEgELXkmZFqvSWv2+3qNLhRicAA7otnyM4
         2c19U9V7SJcyjqYoP870yHIF6Lj6IR/uCp+JbjH1uutpY9tNe0OzsdixeqcuNmzt7e6t
         NL6g3S8hFGz7FZlZzjQNj4OFtF9HheiIBNT+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OFhhXwoR5xQKUc88wWoeoxttHr9egdOaBhNaHhQIGoQ=;
        b=toUSYV6Ixoh4BSJu7HDDIV4W0wQ1fIyFkm3vI1cPMCwwXJ98f6i84pTitHkfIrjJYy
         fAEgqp+Q2RdzTsVlE8a71mivLn1rHePNCcCRdfHNwkWZbJ0+DEIGcJzYymO08JaodHgK
         Tp3M89wPKaMeDpdd2DavBwy2q8EyzTGOdfOeucd1zi3SbZNMsIY/qiV7/x41FWRb+ONX
         VTf/jfLnM4xQiECv2MCYC+jq7W85RbC8kfgGFFB6xklAOPIBGMtL5+WN7f8JvBuesSX6
         MZGyS6/2Tr9uP6plNOz0pAH/RtgqhzO0V/xJZiGarpB5ei3qLc08WFxc4jiDr64XuqUY
         yNMg==
X-Gm-Message-State: AA+aEWaY+piLEqqqY3Qxz8WncMMyNTYx8DGvh7ExVLAbLA4nd6rTxyfw
        AXJxm6YS4qhrj7oTEX/+/7SWMJpYl7Fonfw2rhnpxdXEKiGkWQ==
X-Google-Smtp-Source: AFSGD/XuuvnCE6wj0y8D7GmAseFTGIJj7BpiipCOTX4s1nWGHaG6SsAfsrob4aEQxZJVSsztXNWyTIg4YTy56aETR9Q=
X-Received: by 2002:ab0:164a:: with SMTP id l10mr8579880uae.48.1543888014419;
 Mon, 03 Dec 2018 17:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20181127120041.90759-1-cychiang@chromium.org> <20181128093411.GC4272@dell>
 <20181203111919.GL26661@dell>
In-Reply-To: <20181203111919.GL26661@dell>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Tue, 4 Dec 2018 09:46:27 +0800
Message-ID: <CAFv8NwLEQ7EUSTRfAf42w2BY0aEPi_pjcMkPzzCNb=17pfzQXw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mfd: cros_ec: Add commands to control codec
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>,
        tzungbi@chromium.org, rohitkr@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 7:19 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 28 Nov 2018, Lee Jones wrote:
>
> > On Tue, 27 Nov 2018, Cheng-Yi Chiang wrote:
> >
> > > Add EC host commands to control codec on EC.
> > >
> > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > ---
> > >  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++=
++
> > >  1 file changed, 94 insertions(+)
> >
> > Applied, thanks.
>
> Turns out that this does not actually apply.
>
> What is it based on?

Hi Lee,
I am sorry about that!
The patch series was based on Mark Brown's tree (
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git )
for-next branch.
I will rebase it on upstream master branch in v2 when I address other
comments in codec driver.
Thanks!

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
