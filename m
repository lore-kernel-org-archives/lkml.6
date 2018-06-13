Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DC76BC07D5C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856782086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBdvgo1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856782086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933600AbeFMCvE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 22:51:04 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34791 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932697AbeFMCvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 22:51:02 -0400
Received: by mail-ot0-f194.google.com with SMTP id r18-v6so1276690otk.1;
        Tue, 12 Jun 2018 19:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muzq9Bq1otCH2GDqfPCVa6DMMCB87kzly/WHra9HY5w=;
        b=NBdvgo1SNeaa1R/BecrjzyY3nHv6f9NLIU/UOjthYmFnB34FQkB/oSULf7Y9cIoPu+
         uUXIZhBzT4uRGbzuAq+qZjwxXDA/Je6E7PI/rVKs0H8jwIPBLhRG/EIzvftTL4i9ogg4
         m24f2MbQJ5J6te+rR1+X2EfeIo4AjTwPkNIZn0UpCOs11JsHV+/UlM/rp77HJB8FRehL
         MmjDJuBz32amCGYQ8vpuHF5wNZQ6nxWlSEGLkmKpeOn1OPOt/AyFsN27+xOz/YvrPxLC
         HMqTwTwIPLfla19f73VIxaKKEdQ2C310hkeSek3UY+UKMaoCISSPQKMGn599sWEpfJXu
         bewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muzq9Bq1otCH2GDqfPCVa6DMMCB87kzly/WHra9HY5w=;
        b=E5QAIAjAt7QwKG80WtxtMhMo/XaPy0pr+LkKD7Ho28/YQ1tFdNknijNhbi3Q0x2Bdu
         xVS64YizrO87U3AH7MbAnYSM6M7S0ymBYUVxChvd118Zk2jhz/oAiReXtfM2QZGEwXL9
         ArMyT37M6XYK6XAAde8bBjOSGL8Fh6gmdYLbmyPBA6VNhlphtVWuvu7EB8YSJQ3aFXKz
         5Up5yWrmcuvzSuEvuXVwyExWVJD1VZxaTwaPpbQ68h4aNUGD0XaoPUimsMPoR61CNEUS
         sFh7hu60urIz2EBYUdZb6hFBlX2ivx3mnr8+2QPmNsNPZLUxSqzU1X92FdTfFccLbnv0
         Szjg==
X-Gm-Message-State: APt69E1sZn8leFyvEK+7ZteZuDj3quqKKDyhZ42qnnBsmeU/kP0rrrhH
        k6zjzLSkPdULKZXTYijUhZyPJmPo6kUDRfhXec0=
X-Google-Smtp-Source: ADUXVKJkwWY8NmLdq/EJIXGcZKM0E4VLHfSkXtM0U585kfddguAv6v7sa/flgOyY4b/ljK5rjBbwK3dB2e08jQ9JeJI=
X-Received: by 2002:a9d:caf:: with SMTP id b44-v6mr1884892otb.270.1528858261962;
 Tue, 12 Jun 2018 19:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
 <CA+55aFwvE5G7MV7AV4naAXdbFoszc4JNKEj_QtYqpLFfa2RXtA@mail.gmail.com> <CA+55aFza9udpsCY=_YuBoshgVoXSce-Ja-nsqRbm5eJ6MgXK1g@mail.gmail.com>
In-Reply-To: <CA+55aFza9udpsCY=_YuBoshgVoXSce-Ja-nsqRbm5eJ6MgXK1g@mail.gmail.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 13 Jun 2018 10:50:58 +0800
Message-ID: <CANRm+Cx194zWU0TwoiCaiTy+3tuHp4Ki1mk2VUfv5-z00j23jA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, kvm <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 at 10:42, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jun 12, 2018 at 7:18 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The attached patch _may_ be the right thing to do. It's not pretty.
>
> .. and when I decided to actually do some minimal kvm testing with
> that patch, I notice that we've apparently broken kvm entirely during
> this merge window, and I just get
>
>   Error: KVM_CREATE_VM ioctl
>   Warning: Failed init: kvm__init
>
> when doing lkvm run.
>
> Bisecting. But that's unrelated to the recent kvm build breakage.

Yeah, it happens before the KVM GIT PULL on Linus's tree, you will see
the warning above unless you lauch the guest w/ root user, maybe other
subsystems' modifications break something.

Regards,
Wanpeng Li
