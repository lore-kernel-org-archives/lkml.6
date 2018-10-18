Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0798ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78AB2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e5qoWcpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78AB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeJRPPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:15:25 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37932 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeJRPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:15:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id 204-v6so18146384qkd.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 00:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FyuFzcEQH2PI2Z1BPcQ0AM/syJ5Q+StfzBsWc9otInk=;
        b=e5qoWcpLq3QTglkiubqBlBlczLWIrid3yBKj03nFvGZgfC8a3S1/RaFGn36OUh69t3
         DTS5Tb9YY0K4nwu1YWV4Uk6vFZ6TKr4V23HNd6j+SUXqKKRBjYWzhWMG1FjnKqcTlU1Q
         6ldfRqD8YncDrORItC94ZzgTGzHW01S7TXuQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyuFzcEQH2PI2Z1BPcQ0AM/syJ5Q+StfzBsWc9otInk=;
        b=Vgeh2rluSCdG9hH81g5lAwblu/RhpfrGJQOumfd1sESukcBR3jyT/7hzffpf5780I0
         4z1/YWRMV9ahtO2BnEwoc6jQ5Df2+xZ7RBtUMT7xCfKybs02xARfcfkAMiZY9f8cxVAw
         a6R+72aHcNFn+woX1HDTWYo2K6BYYPiwts5wEx3HoJhurGIyvdtgtFusSXpO9sS2H6/Q
         PGks4enCfRHztR6S8O7QkP7B1KtgyLkiwHmBmD0Nt0EGNy0N+D/wF1zTkQv9lFh0Jouk
         EX7E0rjj5od8V/i3pSxRmaRTATByFliqRRTdVOuC4a1SZ8ID9HlGV1SfLOXjM9PLKpEE
         eYog==
X-Gm-Message-State: ABuFfohNfGk/eJbPKPlH+zF4d/YxaSwo0k5g5O2J+Wv5LHpdjam1JcEE
        Ora4EIVuYCPaF1357MRgJJuoOPPHZ0psnCZieJwOFQ==
X-Google-Smtp-Source: ACcGV62a3zQjYeDkJ48pZHNeBaVPQlkLFCj5WSrDZz2Q+1khz+hH0UDdc7P6qneQbr7dhTVbom3gmPI1Ae0jpBEoNn0=
X-Received: by 2002:a37:e21a:: with SMTP id g26-v6mr27082141qki.330.1539846947855;
 Thu, 18 Oct 2018 00:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1539755947-27014-4-git-send-email-suganath-prabu.subramani@broadcom.com> <CAHp75Vf2HMj-DBU7TPEM2=g=XdzksnMgCvzCU6BQa9W8XJmPKQ@mail.gmail.com>
In-Reply-To: <CAHp75Vf2HMj-DBU7TPEM2=g=XdzksnMgCvzCU6BQa9W8XJmPKQ@mail.gmail.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Thu, 18 Oct 2018 12:46:29 +0530
Message-ID: <CA+RiK66upf=E-LWSknA-xK4G=y+2OiqT1zUpvQAJ=aYz1yWHtw@mail.gmail.com>
Subject: Re: [v5 3/4] mpt3sas:Fix driver modifying persistent data.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     helgaas@kernel.org, lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, Oliver <oohall@gmail.com>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 1:54 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Oct 17, 2018 at 8:59 AM Suganath Prabu
> <suganath-prabu.subramani@broadcom.com> wrote:
> >
> > * If EEDPTagMode field in manufacturing page11 is set,
> > unset it. This is needed to fix a hardware bug
> > in SAS3/SAS2 cards, So, skipping EEDPTagMode changes
> > in Manufacturing page11 for SAS35 controllers.
> >
> > * Fix driver modifying NVRAM/persistent data in
> > Manufacturing page11 along with current copy. Driver should
> > change only current copy of Manufacturing page11.
>
> > -       if (ioc->manu_pg11.EEDPTagMode == 0) {
> > +       if ((!ioc->is_gen35_ioc) && (ioc->manu_pg11.EEDPTagMode == 0)) {
>
> No need to have parens.
>
Yes, We ll remove parentheses in v6 patch set.
Thanks,
>
> --
> With Best Regards,
> Andy Shevchenko
