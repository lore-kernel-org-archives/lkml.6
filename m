Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1CEC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C4620837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drqDRSZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C4620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeLGO2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:28:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35945 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeLGO2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:28:22 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so3735728ljk.3;
        Fri, 07 Dec 2018 06:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDdOjpAPwWKSPtAjRmShBLWG8Y0kGpVxVT6IbQS1EiQ=;
        b=drqDRSZjrQh2hL20O81187NsBBmASzNtj9XBjs8xe0wLRISUDKdu24X3vc5sTAuNsw
         5/C4SpFKRqjGbWqx9AqdwwBSM1DGNq/8mgkOgTLVArmNryN9I1z0NhaHfQvlz0/0nn1H
         6yFHyXVfLyIgInYCaIYHo0N1l5VCI1dibpJ9Ez2Pge9nKjFVJEfnhqh/mpevmGJ850OH
         yhgCmr10NA5ZV8Qrich7pvumZP5YEM6JF3mLWQ6AFf9XYPTr3xA2pvxEsv4RSK5F1AMu
         d6UKlsV0UNIrcy1uHnHUbJuGe8yV3XmgpwzzaRpsRp3A+CoO7aA7XlEWli0dKCODPlW0
         kuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDdOjpAPwWKSPtAjRmShBLWG8Y0kGpVxVT6IbQS1EiQ=;
        b=eELjDqXY44LPqsDQMeQbR6Grpv70Yifv3LEMBo6oB1hUu3cPc66qXXsMVaqh3BaGhg
         /Aad/B1+sDG5cmOhNY+ddNuEcL+OhZPCxZl3cyQYrLf9w3TinWwMp3/tHnBbpLoEy0sv
         GQG4o6EK77ZQiuLM05l92gpcHGsa3XqKwCcP5oxl3qu5Gy1iBgM+WYOsKkdl7KxggHTZ
         +7AZzMXJ5rFIcKOxwJClLHic4KFjEF/a+pOHsKdUsSccBo0Q1Zb7KPrR07pLBqqNFO6V
         95E2N4NMyV+AwlOLnsqeBkQp8o5ke6OVW8lP0e4fFbdvtKFvELKlaGkXZY9xbfJe1LSe
         zSzQ==
X-Gm-Message-State: AA+aEWZqoMOxSQUO1FnptXWRMk0WcgwAqO1Uq+8FM2tCeMyJL4pi3N2I
        XfcmfioD3Y+Jw7b5C1MoLSXCPZS+nEP51wPs6Hk=
X-Google-Smtp-Source: AFSGD/U/6ExysO772ldKxG7x4N2GLWowBfBs+oS2Zvr/evZGM8qJjPpFNurlD5sOdR8IzzTnajfSKyGGIJ9QkXr/m9I=
X-Received: by 2002:a2e:9556:: with SMTP id t22-v6mr1650481ljh.36.1544192899898;
 Fri, 07 Dec 2018 06:28:19 -0800 (PST)
MIME-Version: 1.0
References: <20181205230336.GA23462@jelly> <82d624a7-349b-c706-cda9-81a22f2473e0@ginzinger.com>
 <CAN+gG=FVvUFcYYcBnaOaj-YRQCgu4-FYFuJGccHhK+u31EjuvQ@mail.gmail.com>
 <20181206224605.GA27899@jelly> <20181206225619.GA34001@dtor-ws>
In-Reply-To: <20181206225619.GA34001@dtor-ws>
From:   Benjamin Tissoires <benjamin.tissoires@gmail.com>
Date:   Fri, 7 Dec 2018 15:28:07 +0100
Message-ID: <CAN+gG=ErkuyRNprp0b7i93pqPH2J4Tz1KTyVJTLTmBWJV2NeVg@mail.gmail.com>
Subject: Re: [PATCH] Input: restore EV_ABS ABS_RESERVED
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Peter Hutterer <peter.hutterer@who-t.net>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 11:56 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Dec 07, 2018 at 08:46:05AM +1000, Peter Hutterer wrote:
> > On Thu, Dec 06, 2018 at 10:24:11AM +0100, Benjamin Tissoires wrote:
> > > On Thu, Dec 6, 2018 at 9:36 AM Martin Kepplinger
> > > <martin.kepplinger@ginzinger.com> wrote:
> > > >
> > > > On 06.12.18 00:03, Peter Hutterer wrote:
> > > > > ABS_RESERVED was added in d9ca1c990a7 and accidentally removed as part of
> > > > > ffe0e7cf290f5c9 when the high-resolution scrolling code was removed.
> > > > >
> > > > > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> > > >
> > > > Reviewed-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > >
> > > Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >
> > > Dmitry, I do not think this one will conflict with the high res wheel
> > > patches, so I think it should be safe to take it through your tree.
> > > If you think it'll be an issue, I can also take it through the HID one.
> >
> > fwiw, patch was made on top of v4.20-rc5, so it shouldn't conflict.
>
> My tree is behind that ;) so I would actually prefer if Benjamin/Jiri
> would take it through their tree with my:
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>

OK, thanks Dmitry.

Jiri, I have pushed this in for-4.20/upstream-fixes.

I think the branch has enough now to justify a PR towards Linus.
I believe https://patchwork.kernel.org/patch/10693337/ would be a good
material too, but OTOH, this only happens when the device fails at
probing, so maybe not so urgent.

Cheers,
Benjamin


> Thanks.
>
> --
> Dmitry
