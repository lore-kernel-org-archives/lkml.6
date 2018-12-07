Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3BDC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB6F20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="hqpPqDzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB6F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeLGJNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:13:52 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33136 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLGJNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:13:52 -0500
Received: by mail-ua1-f68.google.com with SMTP id t8so1176518uap.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAcpySsLS/JXAnQ48LkEPMhUJBbpeQRkaIuAxxQNyTI=;
        b=hqpPqDzWI1H1H3pD9OXNKN7/yDNuXwa5w1nIRpRWhrbLnqhqaLXlEUSytt+ImxAntT
         ETDboTIIGZBzfDwwyaIyfKJ6DcpOjV3DtotLjq0ZqmE0BxV8vDaAQQrjdIDbxO24C81k
         srTWP7RCCXOTLvl0gR1mwrtuO5/SkkXRtwgCpZ+zSIIa6E3oH+dIrWRmk1OKUIU57ZHb
         g18gc2HQwjXi2BiQaR6pN3sfoKiO+kS/WNDxJE8c5jhQIHQupuy9kbREydfApaoFeQRN
         xZNuz2XInNrOGJy6nxKUu4lcH1Fk2iLW8J3zOSjvV9aXnSSzYYy8YD4w/dUHbCjPcVKt
         dRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAcpySsLS/JXAnQ48LkEPMhUJBbpeQRkaIuAxxQNyTI=;
        b=g1d9pXjrNub/yv3y1cRml6r5eoMPaPvBF4cOI3jVwlaP+lyR6gUMBwut+UbduK73Ro
         +RdDv72FWg3RAA9Xt7ODBpLBhWv+HBpT0IpcLV40dIo7R0yW1aPNZ3hbHRs2XDylBlCf
         G4Qd+BCwXUz4h9DeeDBtr+AP03pRUybkcDrgCqZElVC0tccamOksux5LGiXIC/dDwoQo
         KJ2l8QzVy13VYrX4ysWfe4P1jB93Bz1Cai5TUDKfsA0UAQGz3jEVV7i2vSYz+99mnwCe
         ZdgFaBuHc4rOW+vJwrCPryHN8J1souvR82Q4A8ct8ouMahW1W1CfCvCFp311J0yNIPHi
         fJGw==
X-Gm-Message-State: AA+aEWYYYvICrrdom7dJRsH0f1K5WgM5B3waW4+QkUaSl2KlcSwiY+uR
        Qxmn7vrp98KURjhq2FYR9RlaCCmPjoONxBiI/Ed57Q==
X-Google-Smtp-Source: AFSGD/VZ+Ui+1zNdN76BTMbHrC9x5l6aFdWspU76VtWrtrYzSS7e7SXLe1SR7bCWyVFNfXMVpGyY3yWBVbTvsgEqcMg=
X-Received: by 2002:ab0:4802:: with SMTP id b2mr589392uad.47.1544174031160;
 Fri, 07 Dec 2018 01:13:51 -0800 (PST)
MIME-Version: 1.0
References: <CAPpJ_eez=1ie2B8rA=GeW+hx7kQU0wBAhW3XCBX3zGPW+kXDZA@mail.gmail.com>
 <20181206084554.4728-1-jian-hong@endlessm.com> <20181206084554.4728-3-jian-hong@endlessm.com>
 <6FAB7C47BCF00940BB0999A99BE3547A18420211@RTITMBSV02.realtek.com.tw>
 <CAPpJ_ed36NyopArw98qhkstAm=L9A4=xiLPaa2ju0+qMR0tE9Q@mail.gmail.com> <6FAB7C47BCF00940BB0999A99BE3547A1842025B@RTITMBSV02.realtek.com.tw>
In-Reply-To: <6FAB7C47BCF00940BB0999A99BE3547A1842025B@RTITMBSV02.realtek.com.tw>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Fri, 7 Dec 2018 17:13:14 +0800
Message-ID: <CAPpJ_edVC+zgVrh3TwOL3NsM_6yeq-P0sgmX0L-5OE-QFDN3Zg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ALSA: hda/realtek: Enable audio jacks of ASUS
 UX533FD with ALC294
To:     Kailang Yang <kailang@realtek.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>, josh@wtmec.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Jian Hong,
>
> I call our agent guy @ WTMEC.
> Please modify as bellowing then test again.
> Remove EAPD control by hidden.
> If this modify patch was pass audio test, please regenerate patch to Takashi.
> If this patch will solve the speaker no sound issue, I think the model name maybe could rename to ALC294_FIXUP_ASUS_SPK.
> Because it doesn't relate with Noise.
>
> > +       [ALC294_FIXUP_ASUS_SPK_NOISE] = {
> > +               .type = HDA_FIXUP_VERBS,
> > +               .v.verbs = (const struct hda_verb[]) {
> > +                       { 0x20, AC_VERB_SET_COEF_INDEX, 0x40 },
> > +                       { 0x20, AC_VERB_SET_PROC_COEF, 0x8800 },
> > +                       { }
> > +               },
> > +               .chained = true,
> > +               .chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
> > +       },
> >  };
>

Thanks for the help!
I have tried the new verbs, and they work on the laptops.
I am going to send the new patches.

Regards,
Jian-Hong Pan
