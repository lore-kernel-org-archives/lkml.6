Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56186C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC8D208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpSnXujV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC8D208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389692AbeGJSfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:35:55 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38769 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388610AbeGJSfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:35:53 -0400
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so44551606oie.5;
        Tue, 10 Jul 2018 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QYGK0kuB0wVEuUExpTeilIaQmMao5iumJuYgYq1ZZow=;
        b=GpSnXujV1nPwPlLNkXtew25jg7BxtRD3nZ8OTEGhgPJk0mobxP8IbSILDGZMnFxhgU
         nSpEydlsuyQa/UUaynrA6pGrDVFwsSFQAYpoDQmiZocF99673U/ZV5GKDprv1w1CHlev
         YYzatpcWZwOJ6nCm5niSmufTzBxJwtAiruGDi40EIKOxP3qwcXM4OhUw8dD6ZsAnmA9F
         gNMQHY8eaaRbGdffwcsji1bA71TOVV9zlnHJByzgRhbPNeZR93QbZREWL1hjgGsFNmCx
         Ghv+DEFBHOGupgPaoJdoyarrBgRxhfljjmgflBIjvUaQS+7uhkoG2zYeiZVpypftEbvr
         98EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QYGK0kuB0wVEuUExpTeilIaQmMao5iumJuYgYq1ZZow=;
        b=H7YVGqHvAn9SUcWwtfZyjfBzOop5hoqO5sflwNLetjNgXmMMsiD4GR/aZ0X9AIvKPE
         4GXi37QnIaMwmHoiGBl8Ix7+jQuU3gxxz9+YE1qRvDD9YZjD5p9ib9nQ46l8Nt9SfqMd
         qOTmFaKMmWMDGxudDKwq1dRh5F6b8F4E+iKPozhi7moef0/BVrs/Bs6MBihzi2vG7+iT
         GBFeVsrQbWF0P0Q+Y7548am2hc6S/fN988YPtoNhcwkF5fMjg52XJUjliOq+yVgv1izj
         12o1ndhhsWJIPEdzo2naGq2kUpe65mIXLfiL8V4X5jd7rWlhE5P9/kIoUHs45Mo4eGIE
         UPgg==
X-Gm-Message-State: AOUpUlEvlWSp18t0swq/dt9B2CSbqz+53GUpESr0GnIq9TLCNN7pkaoV
        zm2Ss0pL8JMB2yEiUtDs1NuLcp6y91DBLEecM5wjp6+L
X-Google-Smtp-Source: AAOMgpct8X/ZXCr7SJLE7EsPO3qdfOpoPzaYv0lfXzcNMjBYVwuDv1z/sv0QCDm/s8wsc8xRAXE4yf5Ft+JaEMP1H6k=
X-Received: by 2002:aca:6141:: with SMTP id v62-v6mr6370040oib.240.1531243728252;
 Tue, 10 Jul 2018 10:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5jQCfP1Z0oTBz_V0QkFwFqtJgekUMD2HZR=qA2oWxPvZrzsQ@mail.gmail.com>
 <20180603184955.zrowxp4y3ij66y5n@eaf> <20180608152557.GB11958@amd>
 <CAE5jQCeCOK5zoH4KbyP+hiMKp4MpkjJN1efzquoXCfPPXoj9Nw@mail.gmail.com> <20180709203455.fbmx45ehrsj6yjzr@eaf>
In-Reply-To: <20180709203455.fbmx45ehrsj6yjzr@eaf>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Tue, 10 Jul 2018 20:28:37 +0300
Message-ID: <CAE5jQCd0dD2jcNLGXK0N1g6TOfNfruyTV-7R6Eh1v65bkoqi1g@mail.gmail.com>
Subject: Re: Mounting corrupted HFS+ causes kernel NULL pointer dereference
To:     "Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>
Cc:     pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you,

When applied this single patch on v4.18-rc4 and performed "echo >
/mnt/xyz" on hfsplus_16mb_hang image, I get about 14 pairs of lines

hfsplus: unable to mark blocks free: error -5
hfsplus: can't free extent

Then `echo` exits with "No space left on device" error. Then it
permits to perform `rm /mnt/xyz` and on `echo > /mnt/1` it responds
with no space left on device (but file *is* created and is cattable).
I don't know what is safer, but now it doesn't deadlock. :) Maybe it
is even worth to remount FS r/o, I don't know. (Please excuse me for
speculations)

Thanks,
Anatoly

=D0=BF=D0=BD, 9 =D0=B8=D1=8E=D0=BB. 2018 =D0=B3. =D0=B2 23:35, Ernesto A. F=
ern=C3=A1ndez
<ernesto.mnd.fernandez@gmail.com>:
>
> On Tue, Jun 12, 2018 at 09:43:26PM +0300, Anatoly Trosinenko wrote:
> > And when I mount hfsplus_16mb_hang and perform `echo > /mnt/xyz`, it ha=
ngs.
>
> I just sent you a patch for this final report. Let me know if it works
> for you.
