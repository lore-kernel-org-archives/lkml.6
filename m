Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82353C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3A2204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z57kS2xC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3A2204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJON3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:29:49 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35687 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbeJON3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:29:49 -0400
Received: by mail-yb1-f194.google.com with SMTP id o63-v6so7056705yba.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 22:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3gvjF6CujWH8Gr/mE/FeoE8qeeUhhgXqAaWnqJeUtI0=;
        b=Z57kS2xC4odmChUX0htviDlUHyqoYAR6EDtw4z3WNlKiskkELNpSoEd82mBWmfUJDt
         A2zKLxaAZKIAz69od+EK98gJlqm+sdh+cCPFjrMob8jA08QEJayx89hqHL81XwUOWiiJ
         o4eCguikaCOrlheRHx9axJIvkm5mNtL9XhmL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3gvjF6CujWH8Gr/mE/FeoE8qeeUhhgXqAaWnqJeUtI0=;
        b=BtcjbtxYPfIYt0a4XRw9+6hx8zlV+jSFU2uS4hcv8FrdRbebh04gXaQVoplD6ncd7d
         xoo3ni4fCchzjHDaMFLrfRHFUtHr/qvEsu1MHYjyO6cFdyQmETsFYUBGNS7/pffOTdnA
         CihQ0Ik1fdMVrAyQpkZk2P8v2K7Rgg3MOASTkNJ6CEcHV+fm/uKPm7PROcb6v+7rZV6U
         /2LSK8qzbctERgqeAOUaAmKqskv2tYdYhGc7iGWBebxdvh83PWnWFG4CmFyWk2V0Q3k1
         0BrPl+2Lz2G5nBhgSimqYpOoy97UP2HWVXougxxvb4iOPRAIYetpsCZcAAirUkk5c801
         HsFg==
X-Gm-Message-State: ABuFfoiaiL+8EgeMgjpPZfRX5yp5H9dpSu64F9VZyAiEHdPJkZ34qoqg
        /bX2K7no//5uH2iLkdv0eiq5Nhh0R3l0XUbUCzJJdA==
X-Google-Smtp-Source: ACcGV63/NDHbi94+H0A0tK+tILpn6VVOcbuGOv5874N2c/AndC3l00Oerd0Ykilg/mLNmOfkz7Z/lBZB4MLudxZ40Yg=
X-Received: by 2002:a25:9709:: with SMTP id d9-v6mr8398466ybo.77.1539582366738;
 Sun, 14 Oct 2018 22:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <c6280818c999449646ec216984f2df9e@sf-tec.de> <CALxhOngwHfFzCGXknF4_CHjD=4LeM8BnrZ+s-p6ZRcJ3G8i_RA@mail.gmail.com>
 <4517632.a0TFakfgol@daneel.sf-tec.de>
In-Reply-To: <4517632.a0TFakfgol@daneel.sf-tec.de>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 15 Oct 2018 11:15:55 +0530
Message-ID: <CALxhOngEBVk771h5X5yV6ye23sPCyhxb=U36oJ6RrSDMB3vbyw@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] parisc: add system call table generation support
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-parisc-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eike,

On Mon, 15 Oct 2018 at 10:47, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
>
> Firoz Khan wrote:
> > Hi Rolf,
> >
> > On Fri, 12 Oct 2018 at 17:37, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > > Firoz Khan wrote:
>
> > > > +prefix="$4"
> > > > +offset="$5"
> > > > +
> > > > +fileguard=_UAPI_ASM_PARISC_`basename "$out" | sed \
> > > > +    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> > > > +    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> > > > +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> > > > +    echo "#ifndef ${fileguard}"
> > > > +    echo "#define ${fileguard}"
> > > > +    echo ""
> > > > +
> > > > +    nxt=0
> > > > +    while read nr abi name entry compat ; do
> > > > +     if [ -z "$offset" ]; then
> > > > +         echo -e "#define __NR_${prefix}${name}\t$nr"
> > >
> > > This mixed indentation with both tabs and spaces is a bit messy.
> >
> > Is this what you suggested?
> > -           echo -e "#define __NR_${prefix}${name}\t$nr"
> > +           echo "#define __NR_${prefix}${name} $nr"
>
> No, this was actually only about the script itself. Looks like your editor has
> tab-width 8 and indentation 4 or so.

Ok. Something is going bad while creating the patch series. That's why this
mixed indentation with both tabs and spaces.Will fix now.

It will be ok to have indentation of 4 character?
https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscalltbl.sh
https://github.com/torvalds/linux/blob/master/arch/arm/tools/syscalltbl.sh

Thanks
Firoz
>
> Eike
