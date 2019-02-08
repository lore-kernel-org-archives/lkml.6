Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1545C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A09220857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtztAlK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfBHOFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:05:25 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34898 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfBHOFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:05:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id z19so1924913otm.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GL/Alh1lDywdeJWgvazb+gjf2Y4E35xtAOJnscymkWw=;
        b=mtztAlK3rm7ZcYPLroUP/zodu5osb0++aUxSdX9MIm9Ee/qbR/jmE0Va9/qycVVNZ2
         JZEQTN/cZQC+5vG3CVaxmT5dhTGn95ryt1l5+ugj4fTS5Anxm2nIqOr9thfzmnBhup3v
         ESOcOYjYbwQq3Oi2Chs7vTtdAjcUQ3DUhbb1/bWqQJCvq1TdOonIsy5frSd0PlFaNza9
         3bDhrxyHyMELuKwbaUI6MF5/KWT7XNWc10g/MSCBzjKYDjlMUI97hTDC4ZDPPTdMEXNi
         MwdQU1izvgSSDQ+uDbSpVy/hXt3iWJw2aR7mypj/jiAGrVHliF4Qhk116XX8DMwiq9TJ
         nRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GL/Alh1lDywdeJWgvazb+gjf2Y4E35xtAOJnscymkWw=;
        b=Xm98dim/8FNUiqimgpIEtyOEbpM4Abt2LOzxnwxFK2LlI+Lw37Zq19IGvVfE5RBHoN
         1rwmni35L+Dfty48iW7wnMqcv/qKhiKxBaECUNeUmVKJqF3ruFVOXF6AV9odrTSSWTBK
         UThnvkpSitL1AcHreT7hZAti7grz22fhb+PfYnUQrq3/O0pSdk6PG0ae2PWVpZXsQ4fp
         NkFzkb1zfbLHzuo/UE2HjwC7juU0EfVtSaLrjVDCw9gx9CrQOLo2MebpZsC28nrg9w9t
         g/kU2c9xTV+9msDiBTpDbCwYoqrkT9TUitXRKe0fk1O+BB0OTAjBlqRq4mk/s+VXPoeU
         FnjQ==
X-Gm-Message-State: AHQUAuZZk2bcsXW2B5crcliKn7kHALnXPGxSnycQOFaumDeWZrJdWB1A
        bTAgFCYa+yXPDAyNrlI8xeRW/MD+1LoUMnbPW08=
X-Google-Smtp-Source: AHgI3IbAT2qKnMEi6WaCQ4qEVrgcZWHRBLIU+hhNZoCWsNa10It4mJsyjOLag6asgVGs3v/M17nIo0/xBII+ldgnrss=
X-Received: by 2002:a9d:d21:: with SMTP id 30mr13228419oti.245.1549634722441;
 Fri, 08 Feb 2019 06:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20190124201251.15159-1-TheSven73@googlemail.com>
 <CAGngYiWFU-VnG=ODLWaUf0yp69qaU2GSd9exdHvyi6Ko1ib9qw@mail.gmail.com> <20190208121916.GE23483@kroah.com>
In-Reply-To: <20190208121916.GE23483@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 8 Feb 2019 09:05:11 -0500
Message-ID: <CAGngYiVVNitd5SDLah-kxP69W6XHYHOQrOz=DnevuGnqoHD7HA@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] Add Fieldbus subsystem + support HMS Profinet card
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 7:19 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> I would like to see other people review and put their "name" on the
> patchset either with a "reviewed-by:" or "ack" or something.

That's what I would love to see too !

And I agree with you that a patchset like this needs more review.
Probably a lot more. Especially the fieldbus userspace interface.

The question is: how can I generate interest? Other than starting
an advertising campaign or spamming developers :)

I guess this is one of the ways a patch can die: lack of interest
by the wider community?
