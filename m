Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C903C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220E320855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRPLpN3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220E320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeKJBZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:25:33 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:38255 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeKJBZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:25:32 -0500
Received: by mail-lf1-f43.google.com with SMTP id p86so1651130lfg.5;
        Fri, 09 Nov 2018 07:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MCGdmgOTNUkLb6qv90dOeywT5o76S1FgeXUUFEyhBCk=;
        b=cRPLpN3/+gKIRhIlyg01IwHoH2E16TdcXnf3YRRArSxriy6nPiuVrguHAnq0036RI6
         JJuP0zBxgLo/5jVYxaVS5YmAi3A/bQ4X+xK9ljZkJ2mDvy/HE7xSN38FO0tB7iq4rcyM
         zzDNgnvPDNWNPgwhkZonc8IvROdI3BgOi2zAKPmEBAvYsSe4AInRbCFcAPG7qzoQNejA
         rN6l1Z3go8DMm100aLK5GCor2baz6h/gcmvU3BYeHf3WCWxMx3qhK4VJWswi5IH4/B13
         1h8ayuw5ljAAA2//+odefA6IDTv4jtSQl2NBlbovH1XRivbCoJVLwmKgl7vApWIoHSdm
         gu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MCGdmgOTNUkLb6qv90dOeywT5o76S1FgeXUUFEyhBCk=;
        b=beSq98t0oUei2280awNRCS5i15J7GSF7MwPzB45znVCZvIm70xH+BDqNJoi4LGkqrD
         i8+YdBVJMwkCJVb1hyqFTyg/A1vBPwGH3wCmXfWvf5RqyMX64U/FEShiFfSYD/tNE3w1
         PYRwVBWyriO92vzsppyJKkmpvB8W8pDnU6MChjOhkH6bbPWG+/pkT68NjlpOAJ0oPdPh
         2g62qZClHz6YuimLYbnwcTSoUzVN1vQg87fs4xSTAu6Cb3dM58WWGkzk5t9JX0p4c0+v
         PYnBObn91qWFEqGpGGXBs2DyYjDuNsPX1GBjRvBqWOWCcGnu8MaF66fUPQWxt42k51b4
         fPhg==
X-Gm-Message-State: AGRZ1gKwArzAY3FUSZ6RpCOQIzedMUTZC/HcwjgjieK8QkfmTihgxgyr
        p0sMAUPI0pAC2+kigFyW+YfWPy9+O3XVV0OWlQk=
X-Google-Smtp-Source: AJdET5cMVu88oyWA+G6kC653Jd8RuAm5Dy/W7zgwJaBek/eBROh+SCVS3uTAO1aKaeedS4EUmgR2W0/sx0nqmAkZx7Q=
X-Received: by 2002:a19:c4cc:: with SMTP id u195mr5452831lff.141.1541778264168;
 Fri, 09 Nov 2018 07:44:24 -0800 (PST)
MIME-Version: 1.0
References: <CAAGb-1fPZsJRqa4C3zDiatqE2sPAV8m-pGBoG+z=3nAd+Koj-A@mail.gmail.com>
 <CA+res+SDaTwjkKQpnREP1dW8XmtQsk7NGLj=heYGbGeL3Dr-OQ@mail.gmail.com> <CAAGb-1eLHwRy2L5tp+skWdV5zJ7jfCwTe-1UnJq_n5yjQfdJug@mail.gmail.com>
In-Reply-To: <CAAGb-1eLHwRy2L5tp+skWdV5zJ7jfCwTe-1UnJq_n5yjQfdJug@mail.gmail.com>
From:   Jack Wang <jack.wang.usish@gmail.com>
Date:   Fri, 9 Nov 2018 16:44:12 +0100
Message-ID: <CA+res+QuZKrWN=CPafoxF+nB1HaDygbcoiDcY3-Q=EkwBXedfw@mail.gmail.com>
Subject: Re: BUG: aio/direct-io data corruption in 4.7
To:     shapiro.gregory@gmail.com
Cc:     hch@infradead.org, jnicklin@blockbridge.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregory.shapiro@kaminario.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Shapiro <shapiro.gregory@gmail.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=
=886=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8812:31=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Hi Jack,
> I tested it in 4.9.102 and I checked the latest code from elixir
> (versions 4.19 and 4.20) and the error in code is still present there.
> More on the scenario and the bug:
> I experienced data corruption in my application (nvme based storage).
> The issue was caused because of faulty hardware, but the real problem
> is I got a correct number of bytes in io_getevents thus couldn't
> recognize it correctly the error.
> Looking at the /var/log/messages and  I saw the following errors in
> time of coruption:
Thanks for the info, Gregory.

I noticed guys from Amazon pushing the fix to upstream:
https://lore.kernel.org/patchwork/patch/1008443/
I hope it will be in upstream soon.


Regards,
Jack Wang
