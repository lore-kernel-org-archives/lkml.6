Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D085BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984BB217FB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/hG229k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbeLPLDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 06:03:03 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:54263 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbeLPLDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 06:03:03 -0500
Received: by mail-wm1-f47.google.com with SMTP id y1so9563487wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 03:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4Je/9rgdraqoDqK3UaRE18XtGDmYmrmQ0lJguis4Ha4=;
        b=g/hG229kTSTInWE3qEbwEsG17gsYFvsTP5tl67DD3U8ZOEw7J7z0wXUeXjUvUp4Y8F
         0i1pINK72eqlXb47p4CVbtzHpY5J8l5jzFWnGxGqOJMoJZJ5RSfKrU72vcdF+taVXNd5
         gYOMdeQTgFoZ4hYL8dgoLnsua96F/dAj7pce0rzAxeCyR/vB1AEOq4Wfdb1dMp6CUpAR
         X4Rb8zTyjVetWk+8o5Ui9aLahGtvbJ+9gTzFAVnjr3jdVkxYrkj+Vp6XtQ2MJr2TSf6w
         ZEoKC1dEVCDoqnkpcAOXyVNVTk6YLzXXCrZ6OUBMpFsLsKApmG6NhrTfHGsLH2nhalWT
         CMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4Je/9rgdraqoDqK3UaRE18XtGDmYmrmQ0lJguis4Ha4=;
        b=ADaV0ZCZ/A3EtQVuV1MAqO5qukthaTKSC4cS7eTSpkpgMariI+8to17a+cwZp+VSmV
         n0Jr9fa7deT0PE/rCZ+o31xLlMUcFgt0TLEE+EPRkEE19yrftxgxAYyI354rmht3aUJt
         yAYe88bXuvnDyKJsQF6oFWF4CJXOMe/3aHAX3EvOnKESxopUlR7do5mq89c1dGd8w+1G
         bDJhkWVbYd6DyXDYnVyrFLcc5yNz2phjovr1QkhAg5QPt7uha8CA5vrler3knI8PjJ2J
         g/hDp946ot/ckJaw/yGE1J58dzTYuBPDtUfS1NyHoTzJFz3KXcN9b3fjOy43mbdgV0EK
         qgtQ==
X-Gm-Message-State: AA+aEWZxmMDjl52EABy2MrXRrxNumvCfHSfnwrCsCUUEBzoR1Wo8Kt28
        zUUDR1wqxMyjQA1HGybYQq2Bgk28ahsf6hHECi8=
X-Google-Smtp-Source: AFSGD/VRgdsKu3aUie44FJEahd7/dNPKXVOmyuVLNmAemBZD8oQZk2eDGiF1zgaQkEfyNB+/QtNX7b5aL1jPHLRJN4I=
X-Received: by 2002:a1c:5545:: with SMTP id j66mr6461315wmb.15.1544958181136;
 Sun, 16 Dec 2018 03:03:01 -0800 (PST)
MIME-Version: 1.0
References: <CACna6ryhfaOFS4qjZoLjJqcu5LQd05_jDndL5+GpADTHhu3_7Q@mail.gmail.com>
 <20181216000510.GC6693@zn.tnic> <bac495ca-ccfd-3551-97ca-1444a391fa40@gmail.com>
 <20181216100645.GB815@zn.tnic> <CACna6rynZtBC8YiGOD_YkwobvUsYxRqzsqwG0fNjs-LL+K2Oig@mail.gmail.com>
 <20181216104453.GD815@zn.tnic>
In-Reply-To: <20181216104453.GD815@zn.tnic>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Sun, 16 Dec 2018 12:02:49 +0100
Message-ID: <CACna6ryc2QacKUeSBH5ZVGazOR0-jTeNi7fhm9hGpaXtRJLD+w@mail.gmail.com>
Subject: Re: Problem with late AMD microcode reload/feedback
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2018 at 11:44, Borislav Petkov <bp@alien8.de> wrote:
> On Sun, Dec 16, 2018 at 11:26:29AM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> > Debugging CPU errors.
>
> I told you that this issue is being worked on and there will be a fix
> of sorts at some point. Don't try any funky business of downgrading the
> microcode and maybe break your boxes in the process. Just ignore the MCE
> - it is harmless! - until there's a fix.
>
> Ok?

OK, if you say so, I'll try not to panic seeing those errors repeating
over and over.

I know such issues may take months or years to get fixed, so I was
trying to do some hacking on my own. I'll try some patience :)

--=20
Rafa=C5=82
