Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A721BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6F920875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="fZ9CInNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6F920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbeGXItf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:49:35 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38897 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388405AbeGXItf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:49:35 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so2408971itb.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=woYC26y4lMjyBG6aZzCjVKPuNioBMWUIx01f0d0c7FU=;
        b=fZ9CInNcw2qTJeHWPPyqQvQAaRS6g1/IKkou2TmxwEdY8ycgxJasDae4ffgPggEWJZ
         neEW2+uytDYoT1WKCZ+K7tJk1Wc/PU+Eavqbk+zViMsWK1CY9AQojrPd+USiWHdKbTxO
         fGTHjwBa04LcQ719Bson1kgENkh2BvNLYyvt7vazMveqX9GxPYUGw33tAvwm1L46iHPS
         Y2Q+ft0XhXY+YKIDatO7LVHDmfj/l+AK93Ery2v680cHY0v6gPbfR/Qzp+MDFPNyEJ3d
         4/yFzuxid7ht1pqkvqw78Lpi/mrxH3HgnlWLN1k795eLcnqiJdI26Ul3cOcrKRapudFv
         4mdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=woYC26y4lMjyBG6aZzCjVKPuNioBMWUIx01f0d0c7FU=;
        b=I8wjj7qK1ZmNYZhn3APG2u1rYuDQuDJLv10k/3QmYSOe9jkDBS1+lYBIuuqA8HKU+a
         fDPr3L9MIYKmSFPQnkkD6IdDyQLr1fJH00GPrETpUpNJnOtttZzTExyvsw+QsnBuyYcY
         PU7M1y4Z0oxLjsU8mLJuuiV5xrOobrb7nZIq0rGJ6SXmgZCEVTa+YcrUmZz0zzjbynUZ
         f87ssD9rDxuEMffhsSLqYif9O0KIvlFSvyZIsGowOwBKTKwDiJutkOowY2j+us9KgUgI
         G4RCc+pJvIRkYO76kyjnc9yeHkNXD40FGOZNLYPrXJGARbj5+vsi7+ljrnsCwYMnjuPI
         5tYQ==
X-Gm-Message-State: AOUpUlF/lj4kJ2BCWilxiGrFy+XRFrZrij2q2xW66gPwmXW59DPEbziz
        PvDWTzhH5KOnje+G0A6JKR/lDumW5CyUswhIV+3tKQ==
X-Google-Smtp-Source: AAOMgpeUxl2OnAOyI4+f1myWRhAcQR9HSlhYrzuPOmV9XbK+PiXeAx3DxA8M+EU89UDpSDg9IUFsJ+XyQQGTsomURAc=
X-Received: by 2002:a24:7bd4:: with SMTP id q203-v6mr1673489itc.123.1532418265924;
 Tue, 24 Jul 2018 00:44:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:bb58:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 00:44:25
 -0700 (PDT)
In-Reply-To: <20180723111251.x2cam6bcuglr4hhz@linux-8ccs>
References: <20180716122125.175792-1-maco@android.com> <20180716122125.175792-3-maco@android.com>
 <20180719163208.5xvrafugpcbhh7kj@linux-8ccs> <CAB0TPYFVSWtJ6RPRUZ1bpS-rBaV7YyPR-4B2Ogxs+FNAbiScNw@mail.gmail.com>
 <20180720144916.fyqpmrtgt23sax6n@linux-8ccs> <CAB0TPYFQvkTsMvfJCTSFSJAoCbmOUJz7mCQGoORs6nRcC3Fhdg@mail.gmail.com>
 <20180723111251.x2cam6bcuglr4hhz@linux-8ccs>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 24 Jul 2018 09:44:25 +0200
Message-ID: <CAB0TPYHu2tDuefRCfdUd_A8XqRQ_ym811ua-Cu3C=xUPnyHTGw@mail.gmail.com>
Subject: Re: [PATCH 2/6] module: add support for symbol namespaces.
To:     Jessica Yu <jeyu@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        USB list <linux-usb@vger.kernel.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        linux-scsi@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Iliyan Malchev <malchev@google.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 1:12 PM, Jessica Yu <jeyu@kernel.org> wrote:
> IMO I don't think we should bend over backwards to accommodate
> out-of-tree modules - modifying the module loader to recognize even
> more special sections to accommodate these OOT modules would be where
> we'd draw the line I think.

I agree with you, I really don't like making the module loader more
complex (which is why I didn't opt to create separate sections in the
first place), and in the end this change will in some ways benefit
out-of-tree drivers too, even though it will be a bit painful now.

> I think going forward I would prefer to have export namespaces to be a
> normal and regular part of kernel API (as in, we shouldn't require a
> new option for it), and that the warnings for 1-2 cycles are courteous
> enough - but anyone with stronger opinions about this should speak up.

That aligns with how I think about this; if we want this to be a
standard thing in the kernel, we should at some point enforce it,
because it's pretty easy to ignore the warning. The good thing is that
it's not a big on/off switch, but subsystem maintainers can just
introduce namespaces when it makes sense.

Thanks,
Martijn

>
> Thanks,
>
> Jessica
