Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416D8ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5010208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snQHQ6ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5010208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeJRLda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:33:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33896 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbeJRLda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:33:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id l6-v6so31508377wrt.1;
        Wed, 17 Oct 2018 20:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WoASbx7i2cNXEiBHTRZ8+mHDH9g0Ys4mmr9WSZ92We0=;
        b=snQHQ6ri/6GySt5UPWgMoeKhPaWSrHG6DTF0sB7Cyl/BWIiRoO/LGBL4fzpJagA6e+
         /jEjIjPfpUjqxgBcf2LM/RN8ZpUEEQ5zLrCCR7Pu2Vn4PvBxPc7i/00DZwZTUa4z2kN2
         KfQtZDd2MJs/aECTIAbyxwA9dzA3DAhQneIxDhiwuvA8Kl8+2qLxZFg++qFLEZK8nQ/r
         sH6UVR4l6pkWabxGM7zfeblu2qUU/3CEcKOuLUxEP/zHloqjHbWbFT8RAUWTs5HFcwaz
         v8lbonZpnb4nVNCU+v+H1x4aVNr4TiYnsOf9IIx/twpHBo6IkWYMj/SyuRKqZ1h/3uXz
         Siow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WoASbx7i2cNXEiBHTRZ8+mHDH9g0Ys4mmr9WSZ92We0=;
        b=sS+hmV1aQr9JzB4OGXfYHsiZkYx/3Oi1voHIID4VefEhhXtMLc62yu+AniQNreNRUf
         hr6IbC5JGFGWf4d9vXIBRqBuF/XA0oWkhlUDbt5Jx6pnxQ0g5ZdY1PM3WNsROM2+QCjg
         y6r+Uwci9M5jpv4lMm5yn3h2hNtv9Mlwurw3LV9+TExMYnQy/2sjXI1jYncl2inGLL/U
         93dIVzBrjrn21/toX8tZj3nUfFOTaWIVDbp6QBGUocKUDmcJ/kTt6LIkm9Zgvg04GTrR
         Cp91DZgU9Fu1askrzOvLAUmr2BB8BJSGO/MaDbteXNTzyUCMwVjDHbyTyi0Nb5UEhgxz
         bFZQ==
X-Gm-Message-State: ABuFfogTumiRZdJoV4EhfhLXYpkC5zwjWcQOijv3q5PsAVQPaFAm50gH
        PIRW7jbRN1ePakokFjW+9zI=
X-Google-Smtp-Source: ACcGV60pC5by20xxC3a7Acm6tNqz5p+iEU52uOat47Oi6OkOSzoFAHx1ujIv/u71kOEo9u6qWpjQ2w==
X-Received: by 2002:adf:e681:: with SMTP id r1-v6mr12580117wrm.294.1539833678559;
        Wed, 17 Oct 2018 20:34:38 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t3-v6sm17472522wru.47.2018.10.17.20.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 20:34:37 -0700 (PDT)
Date:   Wed, 17 Oct 2018 20:34:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     isdn@linux-pingi.de, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] isdn: hfc_{pci,sx}: Avoid empty body if statements and
 use proper register accessors
Message-ID: <20181018033435.GA2734@flashbox>
References: <20181017180657.9410-1-natechancellor@gmail.com>
 <CAK7LNARjwZr2NPNE9aGnzQv-uUWjf1=A+kX3pjALqYfsWORv5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARjwZr2NPNE9aGnzQv-uUWjf1=A+kX3pjALqYfsWORv5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:23:37PM +0900, Masahiro Yamada wrote:
> Hi Nathan,
> 
> On Thu, Oct 18, 2018 at 3:09 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > drivers/isdn/hisax/hfc_pci.c:131:34: error: if statement has empty body
> > [-Werror,-Wempty-body]
> >         if (Read_hfc(cs, HFCPCI_INT_S1));
> >                                         ^
> > drivers/isdn/hisax/hfc_pci.c:131:34: note: put the semicolon on a
> > separate line to silence this warning
> >
> > Use the format found in drivers/isdn/hardware/mISDN/hfcpci.c of casting
> > the return of Read_hfc to void, instead of using an empty if statement.
> >
> > While we're at it, Masahiro Yamada pointed out that {Read,Write}_hfc
> > should be using a standard access method in hfc_pci.h. Use the one found
> > in drivers/isdn/hardware/mISDN/hfc_pci.h.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/66
> > Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/isdn/hisax/hfc_pci.c | 6 +++---
> >  drivers/isdn/hisax/hfc_pci.h | 4 ++--
> >  drivers/isdn/hisax/hfc_sx.c  | 6 +++---
> >  3 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
> > index 8e5b03161b2f..a63b9155b697 100644
> > --- a/drivers/isdn/hisax/hfc_pci.c
> > +++ b/drivers/isdn/hisax/hfc_pci.c
> > @@ -128,7 +128,7 @@ reset_hfcpci(struct IsdnCardState *cs)
> >         Write_hfc(cs, HFCPCI_INT_M1, cs->hw.hfcpci.int_m1);
> >
> >         /* Clear already pending ints */
> > -       if (Read_hfc(cs, HFCPCI_INT_S1));
> > +       (void) Read_hfc(cs, HFCPCI_INT_S1);
> 
> 
> 
> Why is this '(void)' necessary?
> 

It's not. I never tested without it since last time I tried to remove
the if statement, GCC complained at me but that was before the readb
change like you suggested.

I will go ahead and send a v2 with that cleaned up.

> I see no warning without it.
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

Thanks for the review!
Nathan
