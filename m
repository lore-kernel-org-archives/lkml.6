Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67E4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 16:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5247A20833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 16:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSJzkQZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5247A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeIIV0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 17:26:34 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39931 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeIIV0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 17:26:34 -0400
Received: by mail-qt0-f195.google.com with SMTP id o15-v6so21566302qtk.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=teplfoyci6H+fiE2v6RpuxjZr1X1VSlWvuqpdcye00g=;
        b=uSJzkQZCMMpK+c5DJm0z99XZVbK2TKoVUNt4ru7l7mxgM4vlKHTg0vpRmuTcz3zT4V
         9/V+ojf939P6cXTUNR5fp0RLJyj2mXDCd9LbP62FRujKZlpx3bpMquCvYid00Rq3u9NY
         qrmCZZWKbagq/KGBAfyqUx6xfMxtl7n9hV2xUsUSBo34hYzSaOlVHiHDLrKuwjtegZdk
         CMaWYw6g22MkDCQJ1ty55VbROy3JM/wMftY5+vHowYZTe1ExcaIH7i7bUhnSMuPHopGj
         ATsOnYS9VXt2NcfDfon7uAA8LGn7rShb9zz/4Pd5NP/G3bnQqaKXq+WZu5jWSmjlE5vv
         TrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=teplfoyci6H+fiE2v6RpuxjZr1X1VSlWvuqpdcye00g=;
        b=jChjhRD+XmH0Wim6F+qesY3NfwsvknfHaO6UpoX/5LVFPH+3Ekz6spYa3vgH6u/u1v
         aX+g5lDrwsNg233/z1cYFcvoSVNXrY+FWkDJr7B/aMtrgp91zkFrQL+rnixlrGXyipqm
         ehHnCINSr9zziW+IRG4oGn0vskw+uTpw333gtrFl2T3HMSzaV0AdaKL37oADVo7LKLDY
         bE4viU+6l5yWD/pZSzrXyYnmloEfgi//t1VpodSrtELRf6N34KBnSvCl0D6GvwmW5R9H
         6+0fst7UTGCDSuJiSjrCqQhZycvq1g2qQOP9/F2uP9tA6oP7lwko5xb1V18MXYHWK+ds
         XqdA==
X-Gm-Message-State: APzg51BkqRLUHwL/4B8fOhY5U7drAEqEKoYf2dqObznIyo6WWTcpA1bE
        DnBWb2xZO97AGo8GSSchWo6BR8zoxma6KnuNRIQ=
X-Google-Smtp-Source: ANB0VdbqT0/5L8weVed7hmeOwnvdp1fAkzxVvbVb2oKWPzeNj93WG1Is2DWEQogOD+AQmJmvVDBhKycVCci7VcGweD0=
X-Received: by 2002:ac8:350f:: with SMTP id y15-v6mr13234825qtb.241.1536510981743;
 Sun, 09 Sep 2018 09:36:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 09:36:01 -0700 (PDT)
In-Reply-To: <20180909160601.GA3873@zn.tnic>
References: <20180908190553.GA4573@gmail.com> <20180909093611.GA4614@zn.tnic>
 <CANiq72=RbankDmDSmD+jtvAFArGG-orMSayooGCAEa73_aOAuw@mail.gmail.com> <20180909160601.GA3873@zn.tnic>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 9 Sep 2018 18:36:01 +0200
Message-ID: <CANiq72mXK8EGt7x4EVgU6H0ve9c-wGWuV06=TUfLbzB89_qYeQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/sched/core.c: Avoid unused variable on non-SMP configs
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On Sun, Sep 9, 2018 at 6:06 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Sun, Sep 09, 2018 at 04:48:19PM +0200, Miguel Ojeda wrote:
>> Indeed. But note that the attribute needs to be written before the
>> variable name so that it applies to both variables (or write it twice)
>
> It warns only about 'steal' - not the other one.

No, you get a different warning depending on whether you have enabled
CONFIG_PARAVIRT_TIME_ACCOUNTING or CONFIG_IRQ_TIME_ACCOUNTING.

In other words, !SMP && IRQ warns about "steal", while !SMP &&
PARAVIRT warns about "irq_delta" (the example warning I posted is for
this last case).

Cheers,
Miguel
