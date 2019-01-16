Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDEDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD132205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="NypyKvzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405121AbfAPQGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:06:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44554 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfAPQGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:06:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so8072736otl.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YlIWZmVGXJWKstiOqHMWX/nqKp+ebREy8X1FPWuXkdQ=;
        b=NypyKvzX21NYYTZW6Uhrb7uhgjYcNhYmh4guVbKdBeDEnR7XIUJDDF0VBs+0YybHgC
         MbGgo1E2vNo6afYo+pHCdLLwxJnq2LDOgLKgRSfpB1Pq9417Bo+1MXIyEERKKRfVzOvq
         3c+Vc2QQMpIgA5j/V2PLE1ICej2NK5+b+TmBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YlIWZmVGXJWKstiOqHMWX/nqKp+ebREy8X1FPWuXkdQ=;
        b=fDBI/gWZvwTlHpPVL510ik1nVB14gdtKEfhChq+QLC9wIMtRkbWfZMGzzm3HqPY8Nj
         EmKA/8/ESTVIFgtSVqSibnswC/2FL5DIUvJR+EHLCK3nWtwVq0wiFJVBnWz/4Y2N3Z2U
         XyVG8puk4V0LV1N496UI17wj292TW/K7H2hFDdF57EqG9izvUW907CzG1FQ7wD+83j9P
         sn7Oq0iMU3oiv8qAzdOGpwFPJoj2DIimQBH3lBC9DryiGe1lsVHN+M6o7nk1aK+eJPq4
         Z73j//mWcBACFXQPaFWmJCR1x5a0HaccoG7qFW3tGOKrOtY74A8bZgVddsAjLfttVogI
         nP1Q==
X-Gm-Message-State: AJcUukdPhFAGjrOb7hi8/D07CWlus+84YC7BVTMyWCXyETJdDPLmBm7l
        9r/RecFeurDueq0zDUzOehcqNCU+qNOcWA==
X-Google-Smtp-Source: ALg8bN7dlKlqPQNjaYvAhj2WZnv255dygNrzxEdUkNklkX3H5YOc+LzXqX22NVHo1KpNMpnyte3gcg==
X-Received: by 2002:aca:c003:: with SMTP id q3mr4935499oif.119.1547654765523;
        Wed, 16 Jan 2019 08:06:05 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id a201sm3077049oii.27.2019.01.16.08.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 08:06:04 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id e12so8117470otl.5;
        Wed, 16 Jan 2019 08:06:04 -0800 (PST)
X-Received: by 2002:a9d:2248:: with SMTP id o66mr6282632ota.61.1547654763939;
 Wed, 16 Jan 2019 08:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
 <20190116142458.19542-1-starnight@g.ncu.edu.tw> <20190116143337.GF5265@nanopsycho>
 <3b11ea71-ab65-11b3-2ee1-46f9a9fa145d@suse.de>
In-Reply-To: <3b11ea71-ab65-11b3-2ee1-46f9a9fa145d@suse.de>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Thu, 17 Jan 2019 00:06:14 +0800
X-Gmail-Original-Message-ID: <CAC=mGzh9ArNPYF0yALggPTMRdU1QQ7Vg7m9fKf5C1Rh01xv2Qw@mail.gmail.com>
Message-ID: <CAC=mGzh9ArNPYF0yALggPTMRdU1QQ7Vg7m9fKf5C1Rh01xv2Qw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] net: lorawan: Refine the coding style
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas F=C3=A4rber <afaerber@suse.de> =E6=96=BC 2019=E5=B9=B41=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:07=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Am 16.01.19 um 15:33 schrieb Jiri Pirko:
> > Wed, Jan 16, 2019 at 03:24:54PM CET, starnight@g.ncu.edu.tw wrote:
> >> Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> >> ---
> >
> > Patches like this are in general frowned upon. Do one change in one
> > patch. Put some patch description.
>
> This patch simply shouldn't have gone to netdev and LKML, as it is a
> fixup against a non-stable tree (missing "lora-next"). Once squashed, it
> doesn't matter whether it once had a verbose explanation or not. And I
> prefer to not mix style and functional changes.

Uh!  I see.

Regards,
Jian-Hong Pan

> I simply was too impatient to wait for more respins before being able to
> base work on it. ;)
