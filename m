Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81629C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3522320645
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRAptCEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3522320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeIYOi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:38:28 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:38948 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeIYOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:38:28 -0400
Received: by mail-qt1-f177.google.com with SMTP id c25-v6so6710201qtp.6;
        Tue, 25 Sep 2018 01:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUO1EDA2Yfpi673kMvZLaTO05hqpysbA3mCOUcICaN0=;
        b=fRAptCEGHXdFbJAY1ytw+fJLKLRufz/jVwYlqZ1lsp7E/N4ZnGoEyIhT15BoKxjhyM
         s2BdSqSpHOfv3i6k/3MWvDAecNBylW9Oob30EfZ6GW8L5n37pP6MRJVDWKhPDVICr/cf
         /r15j0kZBeI9h3mtVEX4MecRlTgvx1FGiU01ICkMrA6K3CW75zgKaBtOKQjV3egmelrL
         +tSDWBMP0Hntdw5o/u3MV7nYVvE3Dx+1llU1HQ5NGWc0+66WPfiSbuhOGs4dX4gvB8TC
         iKWUq6jcmxPsh7a5maARW1KkCIlLUCg17Au81QXhoQA8u3+OVk5urTISUjfwf6SxIfSZ
         9eHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUO1EDA2Yfpi673kMvZLaTO05hqpysbA3mCOUcICaN0=;
        b=g5kloS9JV01QWYFV/CZi9JfIi+87ibGQErKvnurLn1vyvNo/Nw7PEkdOsq7DoBrXMb
         k7kI61drixNL2xmg0HKFNXFMVBgm9JinuCYL72TkaB10ap88UcEtoyofSIybucXuwN0P
         0Q/Q78XtfwrPiDvybImkBzfOAmPiTAL2izh1pZxAEH6uwVABx4Kc9MKTBBZd0sjAPnYr
         lzrCBd0UMUMBOSsvgYBStWbKfGhOivdWJNaG2zBHpkBc3AIQUhXo8vcRcCvxNORWKdVr
         6yCZFfljRZIve/sy1hdZC9xnqAAVVppfy/OffneLwo7VxetjTKu+boO58b/5qjjcWXeH
         rL3A==
X-Gm-Message-State: ABuFfojFMzMUUvtefqP4vY3iV7z4gdxA5KvEskhkUWJ24iKBGNmObgsy
        nQzzKRX9SxbTwJWZQkkkG3yBRWjGpJJOyv+oVMs=
X-Google-Smtp-Source: ACcGV62NljpCAr3cCGLzexuBwqCnKBmZVhpo0PBMiYwLV9aFl312+F7EKJD2Hufff1Y33qRnJTAz4rm6yI8qeSzox1Y=
X-Received: by 2002:a0c:81b0:: with SMTP id 45-v6mr1950001qvd.7.1537864321811;
 Tue, 25 Sep 2018 01:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180913223143.12664-1-rajatja@google.com> <CAHp75VcVkp6i_4oNVJvzde13MwaRQge91mvZF2aXgneZC9nzWg@mail.gmail.com>
 <CACK8Z6FhJhhfgk1zPMv5M0oRwz=o75YOKFmU+4Wx-X9-prPnKA@mail.gmail.com>
 <CACK8Z6GeZ+2uRsRDPfdd=i+WrdQwQgEBvEyDxQuKLygXqPp4dw@mail.gmail.com>
 <CACK8Z6FLPVSJpPuAXZsqHV2rY2zy3L-Fvd=QPn=+Ynp3aHyhaQ@mail.gmail.com>
 <20180924135935.GP15943@smile.fi.intel.com> <70D28D5DAE32E9429B09AA8B7C84AC472C0000CB@BGSMSX106.gar.corp.intel.com>
 <CACK8Z6Ej=BVThT8gSHCNZadXbLpzqKe6TmLYGkeBMmJBby1n-g@mail.gmail.com>
 <CAHp75VdyOAzHDNr4L6Onj=Qgu2DfQxPy-j_jo2HXfyukCZRePg@mail.gmail.com> <CACK8Z6E_gnMJN+djsbA0wPmtm=GT+cGfAeFoqP=rxeeVSYHnpg@mail.gmail.com>
In-Reply-To: <CACK8Z6E_gnMJN+djsbA0wPmtm=GT+cGfAeFoqP=rxeeVSYHnpg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 Sep 2018 11:31:50 +0300
Message-ID: <CAHp75VfUo9qd=bq48nEZGk9wRV-MyYSBCdoe60J2-cuygDf0AQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: icelake: Fix the resource number for community-4/5
To:     Rajat Jain <rajatja@google.com>
Cc:     subrata.banik@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>, aamir.bohra@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:32 AM Rajat Jain <rajatja@google.com> wrote:
> On Mon, Sep 24, 2018 at 2:09 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Sep 24, 2018 at 8:04 PM Rajat Jain <rajatja@google.com> wrote:
> > > On Mon, Sep 24, 2018 at 7:54 AM Banik, Subrata <subrata.banik@intel.com> wrote:

> > > > First of all, this is pre-production chip, so, I don't think there is a bug in the driver (yet) discovered.
> > > >
> > > > Looking to the above ASL code I may conclude that is definitely is *not* from our reference BIOS.
> > > > I have checked two versions of it and found that in both we have the following mapping:
> > > > for LP variant: there are only 4 communities are exported for H variant: there are only 5 communities are exported
> > > >
> > > > So, I guess the problem is in ASL code you provided. It simple should not export that community at all.
> > > >
> > > > In case you need to do so, there are ways:
> > > >  - contact Intel and ask for a change in reference BIOS
> > > >  - acquire another ACPI ID for the case, or, perhaps use special constants like
> > > >    _HRV for that purpose (also need to contact Intel while doing that)

> > > Andy, can you please let us know in what order are the resources laid
> > > out in your reference BIOS for the case when it exports 5 communities
> > > (i.e. community-0-2, 4-5)?
> >
> > We have no hardware with such PCH to answer to this question. LP
> > version exports only 4 communities and order of them as per existing
> > driver.
>
> Got it, thanks. From your response earlier:
>
> > Looking to the above ASL code I may conclude that is definitely is *not* from our reference BIOS.
> > I have checked two versions of it and found that in both we have the following mapping:
> > for LP variant: there are only 4 communities are exported
> > for H variant: there are only 5 communities are exported
>
> 1) Do you know or recall, the order of communities in ACPI in the H
> variant? Of course, this is a request for help for getting the info.

I can't say anything about hardware I didn't see.
Even if BIOS code has something, it's not fully guaranteed that in
production it will be same. Better to ask Intel BIOS team for the
details.

> 2) Trying to understand how would the kernel support both LP and H
> variant. Is it the assumption that the H variant will have a different
> ACPI ID than the LP variant  (i.e. not "INT3455")? Because it will
> also have the same problem that we are seeing I think.

Yes, definitely they have different IDs. You may consult with
pinctrl-cannonlake.c driver (better from latest possible kernel
version like v4.19-rc5) to see how it's implemented.
Moreover, LP and H variants have different pin lists inside
communities, so, they can't be substituted and one may consider them
as different IPs.

-- 
With Best Regards,
Andy Shevchenko
