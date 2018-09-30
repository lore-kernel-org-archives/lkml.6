Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0DEC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80BC2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNDrYsbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80BC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeI3UP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 16:15:57 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:33830 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbeI3UP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 16:15:56 -0400
Received: by mail-qt1-f169.google.com with SMTP id x23-v6so11404301qtr.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LHULgCPa5CwhgWHBQH0+UIMjduU7sVO8NyOem28rOw=;
        b=qNDrYsbkfBpV35hrozECanL8ZyjINLkHJsXRnCcf8q+IyrgD3AOJmwE4QewaF4j26f
         3+k44tJWC2mR6ZyCcfxUtN8M1ESAwPZ2VYyv0qSzR0f8QMtv85TRpJj4RmUtSMzhsSSl
         ZWYahJt4Bl4XGf+jfmNoz2NJ4PIyzKC436gC2Y2gT3VonX5iRa0cgpNVbDVNjFqi5ALb
         blGGy7cFWLumDyD0UBxzjfuOvol274KdH78G81H16TxMdHLwU4QIn6vKUiP4zNAVIjk3
         qY6I1rn0yFGluA88CUQC+Jt1tGmpgPfeQactF2A/XtB7MJ44P+eKRDFYyLMDLwmGaxXL
         ytXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LHULgCPa5CwhgWHBQH0+UIMjduU7sVO8NyOem28rOw=;
        b=WUwSrSpZO/lcuwww5LxI1v2MDTGMWUZRCqwSDm+VzjxXtPrARbYjgyBiyVExFxcSfT
         +9v4sabOUZe+/TVNzsDJ/1Y2/1f2hq4Qhe8Cr3hGKybEIkiEWMnvV8+suhE+xPaFyNvc
         iiyg7iSI11EZWvF1IqdQHT6Liy6DIdsodRynSLNl+FBXDIXRumqYCYph+DZkLC42O030
         g+r5yaxvlyCIansMShIXBPGrdPHBW4A5Iod59RKfVazA4borBCZBCZnD7B0Q7trOaQyh
         yWgB6yswN5z+hN/oiVzPq+IrvU6qe5siMPiFLHPcxmg4IK4r5XO7TUDWtXDasAMKUsfH
         3jxA==
X-Gm-Message-State: ABuFfojUZtRFqP2cFwmeLFnbp2gXTvcDB3uxJeHVYKn7J89d9B9dx2Xd
        dfDsij2o4LnMVw0c6SW2hgcfRdUIjdzxXm8cJAU=
X-Google-Smtp-Source: ACcGV61E1qv6V9uAv5IEHi3rMOiza5so/vCdirBY/pO+p5mMVHDPehYV9ybA8LeI+z3fVZ92N2laDBmcUrUlllNC39M=
X-Received: by 2002:aed:3c1b:: with SMTP id t27-v6mr1018466qte.226.1538314971189;
 Sun, 30 Sep 2018 06:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180928220131.31075-1-joe@perches.com> <CANiq72=2272s-AWZdp8HCMufpvL_QPNJpiKYOChcWGTDSMGNTg@mail.gmail.com>
In-Reply-To: <CANiq72=2272s-AWZdp8HCMufpvL_QPNJpiKYOChcWGTDSMGNTg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 30 Sep 2018 15:42:40 +0200
Message-ID: <CANiq72kcAKkkAyts0chBiy_u9KqoRpTZ1mMD4+WcOQE25zZMbQ@mail.gmail.com>
Subject: Re: Bad MAINTAINERS pattern in section 'PARALLEL LCD/KEYPAD PANEL DRIVER'
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, willy@haproxy.com,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 1:44 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Sep 29, 2018 at 12:03 AM Joe Perches <joe@perches.com> wrote:
> >
> > Please fix this defect appropriately.
>
> Thanks, will send a PR.
>

Done & merged by Greg.

Cheers,
Miguel
