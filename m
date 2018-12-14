Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18556C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FC02070C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko7U3r3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbeLNPuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:50:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44393 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLNPuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:50:25 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so5273335lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 07:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y7IN+qPRLKkRDZ/8uF3lfPKnho+B15SXddj/USwvvnk=;
        b=ko7U3r3wQvM/lLI96p+BBR7dwUnwkPvHSew3fot//hbkkR3M/bIccN3ogOVGKAMTdy
         kv3djeCGwVFB1VJkkkhcwhTm5X5I1wFhY+fCoHpsP8oVzIj1eD72AyAnsvd+ShUs0Fj1
         ElJTgQGFgC5D/ATvirtNVF41yXSRgR1HbeVLluBwQ5xwql8T37f2VilJcpMl3j4zgYId
         uT76onSjGRNRlgtQ6/d4Ks8fWCvkzortEP2EoP1CtIR3C/9CFlJH6rzOl3QynWEIju6x
         uPgLT0P8NbPk8IfXXpdHOjKZluOq3auHdi8QA8UyGaeW9QM6wFLHpiVRxMZWwWnQN9/T
         Gj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y7IN+qPRLKkRDZ/8uF3lfPKnho+B15SXddj/USwvvnk=;
        b=cdZqqTQgwPYUDgO4RlSMosSkY1XYYduuuZ+9VKuWEH44nw7tTb+nyzjOE+qVMBPKz9
         zW8JewjGwUHf1jDV4wHhcZsqZVo47xFgCTimYSxa8a201m8u5pJY8H3eaPVXgyVagvUY
         /N7pn4AH5dfQ3JwvBtK3kPB6P3jRGRjVtkLU8S4nNzAENPJXKd+J0QBz/SKYpFKJIe2W
         7i39EBQMS3+bK1wrPfcgs+mDOaMsyM7/dtDJKzwQGtgMwWN37gPzfNEjXXpCZujYsRoO
         bAFBiYAFKYeWDybbqNd0dKLi5oUK6OfopJVk0wdS8xWOql+7v/ieMC62iZVDfjpNP3Ld
         OL7w==
X-Gm-Message-State: AA+aEWZsw8TJMd1zT65ANT/JmfV4PTn4qj9lEGc6ObW99eDv4G/L/NRA
        HhkHcCfdcswlAU+amzKkjFKrFt+ntnEgKsOD9KBVvG1o
X-Google-Smtp-Source: AFSGD/VWuqtAv3caDhb29XwSuxfyCHvERleeGEc/cR3rTuVdJEVfxFI00V49XApAL1SB+wNAPi0glft5A+eWJa9VOVA=
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr2181132ljd.45.1544802623031;
 Fri, 14 Dec 2018 07:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20181205135247.7964-1-mans@mansr.com> <CANiq72=Xg--8vG0+JLsPykOUfXpo89R2H-pBLuMROnQjMui7qA@mail.gmail.com>
 <yw1xr2evkg8t.fsf@mansr.com> <CANiq72keqco3F=8YDHFqoeBRFsrs1Cbd1aF1owf90Hbncv40mA@mail.gmail.com>
 <yw1xmupikgg1.fsf@mansr.com> <CANiq72nMMB5Hvs1WfonQGx+p-dzF+Qiu5VaH13ro2Aan5paDPQ@mail.gmail.com>
 <yw1xr2ek5moc.fsf@mansr.com>
In-Reply-To: <yw1xr2ek5moc.fsf@mansr.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Dec 2018 16:50:11 +0100
Message-ID: <CANiq72nOvmGbLG0OXvN6n7XYR+cFDsiX+g1xUyhQL56Qq7_3Mw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: charlcd: fix x/y command parsing
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Abel <rabel@robertabel.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 1:15 PM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> wr=
ote:
>
> The bad code from that commit was already completely replaced with the
> new parse_xy() function.

Yes, but this fixes something that was broken for a longer time, so it
is good to be able to tell the range of commits that were broken.

Cheers,
Miguel
