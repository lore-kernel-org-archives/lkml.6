Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB5EC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435DE2075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="uqh2iraC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435DE2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJHViM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:38:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33835 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJHViL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:38:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id j17-v6so8785663lja.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jaGjnXcdvN8daa/3PbDv9zHsmJ6YZMBAaIYodxABeZg=;
        b=uqh2iraCt0Olc+gC5NC/t03L7F/umuyT2IM741pQqBesATvBmuepNM3wrcnenoxzA/
         7pNa0HV1q1YRv5QVnarFOpfC413wHXghQG6Li+ZWq5gr1d3seb19dDrwhD2TS89hYJmt
         xUoAHT/V3OS3LiGC4o+c/RIW9oxB2Zvz9eskdk3qpVsUIYSs3RrNSu3Wl3B9Ju1hk4qj
         FpsnCpJ3mtt6Vy3sorpdknHREr4WBVINN5n84bS1uR/GXWU67Ev0r6FqKJbtVUIMpPBt
         UyFscsOIuovyS9fieYFxCgRSSvb2JxwdU6mZdsy/tL1JJCkkr8eamW29kcaG1WQYaIA7
         Rl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jaGjnXcdvN8daa/3PbDv9zHsmJ6YZMBAaIYodxABeZg=;
        b=UJQvpsPyEd0iUZ9gI6/dM7QpjstA0pqb54b1ANMK/cIZ82b7A3ub1ZN7YtVl/m4NNQ
         SfyXVbP8MT78ua6V2nrBrKPj7ee7vBzvy+ig2PzhT1uNjTSsQJyp8GpSSWQIXwpr1Qep
         b7SEFB8vAAnZriVpfm5hEJzlmo3MMXUZhCjVupvGINKI7GNErNlm31bvN+0PO2mm4s14
         bs/nthxOjKK3gfsd3192elcargBkGryf4qMcSO5JaQ9ZtYhfQQYLF7AIlI/fskDjV1jc
         tIVX3fm1J4cTxznV4Gh4ohPO3zO82oqeFoq1FQGxYS8sNCXEq8zJrnvWihQTYqenwNGi
         xGPA==
X-Gm-Message-State: ABuFfojMvMJ9wsxhePMNkVUMAxDJhFehnas+50shsYFfmX36XgagPSrT
        LQFiKQs9/mAnbzcpzXGeO5Mu8OYu3gdz+slWSBih
X-Google-Smtp-Source: ACcGV63IKLlhzzOtrBPiqxN9Gnpm2JTqnuIHjDT/bABdFuvd0QgrNGWcrEMUbJOQPuYzxrVrNLkB1l960X7mZl2VZc4=
X-Received: by 2002:a2e:2c15:: with SMTP id s21-v6mr14667075ljs.162.1539008770629;
 Mon, 08 Oct 2018 07:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181002005505.6112-1-keescook@chromium.org> <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <CAGXu5jKqSZ5LhQ_HwbA9-_DAg3efNzWfLjpxO_rurBgUZ-nnAA@mail.gmail.com>
 <583a703e-18af-a1b2-dfc9-62a2a3384825@tycho.nsa.gov> <CAGXu5jLmQQd4e=B3YsiEoRVih2m889ia2tnzu5r8bqcms2sOqQ@mail.gmail.com>
 <638db305-cfef-4391-90bf-458f50c4612f@canonical.com>
In-Reply-To: <638db305-cfef-4391-90bf-458f50c4612f@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Oct 2018 10:25:59 -0400
Message-ID: <CAHC9VhSgy2UXB4q0qLr-qeRwqiO=Zm9mpJdUDWdvtRM17JUhbg@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     john.johansen@canonical.com, keescook@chromium.org,
        casey@schaufler-ca.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>,
        Golden_Miller83@protonmail.ch, penguin-kernel@i-love.sakura.ne.jp,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 1:38 AM John Johansen
<john.johansen@canonical.com> wrote:
> On 10/03/2018 10:26 AM, Kees Cook wrote:

...

> > Either a distro builds a very specific subset of LSMs, or they build
> > in all LSMs (for the user to choose from). In both cases, they set an
> > explicit order, which defines which exclusive LSM get selected.
>
> and when lsm stacking lands, that exlusive LSM goes away.

FWIW, I still believe in my earlier statements supporting explicitly
enabling LSM stacking via Kconfig.

-- 
paul moore
www.paul-moore.com
