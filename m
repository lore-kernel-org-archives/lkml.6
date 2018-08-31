Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB0BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E212054F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fq5qLJ03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E212054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeHaUJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:09:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37182 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeHaUJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:09:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so5800784wmc.2;
        Fri, 31 Aug 2018 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3kXYkLRuWQss7TYqX729+PafjBFNZFYwim8AH1ssZZA=;
        b=Fq5qLJ03D9wOGlWhfXA7hp13SJYlWzKCxnvByz072qzHBkjf4jYLK2jMX0XzHhe8zb
         mpo4ZijHEuSVnPkvQGbvJ7Krr9ge1jbkA2iq20mE9xrsRsCh45mPRHmY/8kK7/1lYura
         ZwVWmF9fyS0K1AteQGafFSMTzKEvCk7Esw5btR/dt2B+CRtD53Wx6bKLO/Y+0CJp/+7f
         MtbdrDkshOhYJCkcsFBqNxtoKrBql2AivaXbXH2uF3P+uThGr5DyCuTjOqnfwJkzeki8
         Jagm+LW4+movWSTKMeeAAqyG9WXy9fXi6t+WQqNChTu3KUMLQCLeD32VCkohAn5s7+9p
         fGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kXYkLRuWQss7TYqX729+PafjBFNZFYwim8AH1ssZZA=;
        b=lWH8H55pSTvhKrfoWdVUzzR67xz2YohEkfi8abbsn/N3kb+vPA1KZLBAHS1zRXs05b
         mQDCBHHskTmEkSvwLBHE0vODTvz69/ppJNuO0ey+tiCSS97r9qFRoE9XjJC+g9/v9wVG
         YyWW+elS8koNb3BVJIlqWYVCPIPdEzQ8Zs/5vUpJgE74bIo4x2wXwQMDsA2WrNIYE4Xo
         djs0wWlOx0g6/+MmQ1VVieLpbrG5WAXTwAV1RyijcrXO6Gj4SKyoDF6mMIGC9oYld9lC
         b3raVrT8j/eV/PNC9yNLkMO5dahpMp94uryC+PGvcxUs9ciOZmpePHR/FZgcqIM3XZzv
         5b5g==
X-Gm-Message-State: APzg51D02zNK5wVOeBJk931UkaaMvkQYqUFQuSFNzTKBYImLZwM/uPnJ
        VKaBtUIGLolOxDOs5ojuz3W6Rnl2DyOVf+VOh7I=
X-Google-Smtp-Source: ANB0VdaUgahrzFNkie/VwojKI9qwIQ1pDUNWC9B4alyvXi/Gkr05gqZb6dW7nOAflp5bftdPB4HCdTpdbvtTs5n/lNI=
X-Received: by 2002:a1c:b5d3:: with SMTP id e202-v6mr4824896wmf.23.1535731259103;
 Fri, 31 Aug 2018 09:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
 <CA+sq2Cc1CSKmuEjKt8psR7Zyv9PzLkN10hzy8mrai136SF4-qA@mail.gmail.com>
 <CAK8P3a2CMcYg6vMmRAc4N80BpFwczGiPnaLNCDZYXCsRydtPQw@mail.gmail.com>
 <CA+sq2Ce3ew0X+RMm7fQ+iUZF0HKptzBr1dBk3NuRL8o82wBTjg@mail.gmail.com>
 <CAK8P3a1oeOFVYc2xH+KO1gV0m9utHziGpNtQLAEv-RBxKkB7Og@mail.gmail.com>
 <CA+sq2CfAvasZoNmnNQadhdsEz-eyXQPBtXbDmvt1nM0DQsm+8g@mail.gmail.com> <CAK8P3a0wdXRmZOw+yyws00GU=xYAFkGm81xKTF3-DjNmjjZH5g@mail.gmail.com>
In-Reply-To: <CAK8P3a0wdXRmZOw+yyws00GU=xYAFkGm81xKTF3-DjNmjjZH5g@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Fri, 31 Aug 2018 21:30:47 +0530
Message-ID: <CA+sq2CfL-eBWPcu1H9UkvKuL4kPeKnL1qkiG0tLZa_GW8LEqXA@mail.gmail.com>
Subject: Re: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, olof@lixom.net,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 7:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Aug 30, 2018 at 7:55 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > On Thu, Aug 30, 2018 at 7:37 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Aug 28, 2018 at 3:10 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > > Ok, I think I understand the PF/VF distinction now. One (to me)
> > > surprising aspect here is that you not just have one physical function
> > > that you can use to assign resources to multiple virtual functions,
> > > but also a second level of virtualization that is used to assign
> > > resources to "physical functions" that are less physical than the
> > > name suggests.
> >
> > Yes, PF is just for name sake, on-boot there is no difference between
> > PFs/VFs as such.
> > PF0 has privilege access to assign resources to all PFs and their VFs.
> > This admin function driver loads for PF0.
>
> ok
>
> > > The part that I have not grasped yet is what the split between
> > > the CGX and the AF is for, how they relate to one another, and
> > > what the software abstraction for the two is going to be.
> >
> > In HW, CGX is a separate PCI device which handles the serdes and
> > physical ethernet interface.
> > Ethernet driver in drivers/net/ethernet can only communicate to
> > admin function driver since they share a mailbox memory.
> > So we had to bind both CGX and admin function drivers to almost work as one,
> > inorder to provide relavent info to ethernet drivers. That's why we
> > have many functions
> > from CGX driver which AF uses.
> >
> > eg: Firmware gets to know about a physical interface status change,
> > which CGX driver gets
> > to know and it uses AF's mailbox communication to inform ethernet
> > driver about the event.
>
> Would it make sense then to combine the CGX driver and the AF
> driver into a single module? It sounds like you can never really
> use one without the other anyway, and that would make it easier
> to have a sensible abstraction to user space.
>
>       Arnd

Thanks for the suggestion, that does makes sense.
Actually i did thought about it, but i was skeptical if it would be
acceptable to make
a single module out of drivers registering for two different PCI devices.

Will wait for few more days for more feedback from anyone and port v2 series.

Sunil.
