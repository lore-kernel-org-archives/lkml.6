Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88589C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5344021473
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="buGM/GmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfARSgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:36:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37444 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfARSgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:36:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so11920150edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 10:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CItWeHWWByxFWnGXRb6MFu2ErIkEjXZGbtdNjlnB0LE=;
        b=buGM/GmJBy8BLI71MYPJ2FgJqBKpkCGgBHOSiq0L0NBXwPZ8Neq2JAYUOccKx8Y0BG
         r+eMPxaf2zX+7/T2Q5AFtxQNJV7JQlulj67oAJMvhvVIu7VLSSIAHOclmm3641HXfCob
         6GWbKBOu7BXOy86OBDPMAWdUfVP0U+BOAW/iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CItWeHWWByxFWnGXRb6MFu2ErIkEjXZGbtdNjlnB0LE=;
        b=TSmbTq1AnsKJLywu8LGKsQBQraDggyQtj5Ph7YLHbZimRpf5H5/0wvPrxuVJIIwqP6
         2t2v9fVdhTBv0gpdrykY4QTAqmS14dMX5aa34Y71NsB+oR8RDmahlBry6AIm1izDjiSw
         W78QA4egvfEqePvEOWkk8roP0orHGt6HQjB+xcG0huLDsjXc7Fo/m7AXMAizSkLPY2r1
         CBxZ6TaE5J+pzyd4k+s1+yke7/uBVYTaZa9kdw9hNsjGvNpiFaPE/SWuQAebia02PkyN
         rDe640b6b9OhRntDaG5VJiKyXZy5g71OGQnD5Gnipy0zL3PHdU5Mfx4FGp5wwC6qkutz
         4ywA==
X-Gm-Message-State: AJcUukcjqXcZRlRSkjOOn3psgE46+k7tO8SOMwu02bWC8xEyHJ3rjzgH
        NUB7pBvyIgAOFct687q9rwToxIfty7g=
X-Google-Smtp-Source: ALg8bN4tCv9vKxFIaA1aOWP7rk80SG1JEgeIboVcJGEitHWmIXHTcFFW2Z+6/RxQ/HDCfE3SPjyQ1g==
X-Received: by 2002:a50:d085:: with SMTP id v5mr16767661edd.61.1547836564364;
        Fri, 18 Jan 2019 10:36:04 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 24sm7445999eds.97.2019.01.18.10.36.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 10:36:03 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id o10so11865226edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 10:36:02 -0800 (PST)
X-Received: by 2002:a50:d2d6:: with SMTP id q22mr17241088edg.121.1547836561897;
 Fri, 18 Jan 2019 10:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20180524192141.20323-1-ramon.fried@gmail.com> <20180529042047.GE2259@tuxbook-pro>
 <e554b7e525554d49d193ff1f8ca51359@codeaurora.org>
In-Reply-To: <e554b7e525554d49d193ff1f8ca51359@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 18 Jan 2019 10:35:50 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNMS1n+zBDPi4zbyDYjuEs4n-oFH2QfytvzRpnbK5-_ZQ@mail.gmail.com>
Message-ID: <CA+ASDXNMS1n+zBDPi4zbyDYjuEs4n-oFH2QfytvzRpnbK5-_ZQ@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom_q6v5: don't auto boot remote processor
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ramon Fried <ramon.fried@gmail.com>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:04 PM Sibi Sankar <sibis@codeaurora.org> wrote:
> On 2018-05-29 09:50, Bjorn Andersson wrote:
> > On Thu 24 May 12:21 PDT 2018, Ramon Fried wrote:

Whoa, bringing up a 7-month old patch? Nice.

> >> Sometimes that rmtfs userspace module is not brought
> >> up fast enough and the modem crashes.
> >> disabling automated boot in the driver and triggering
> >> the boot from user-space sovles the problem.
> >>
> >> Signed-off-by: Ramon Fried <ramon.fried@gmail.com>
> >
> > Thanks for your patch Ramon. While this nudges the behavior to make
> > things work slightly better I think we need to describe the explicit
> > dependency between the mss firmware and the existence of rmtfs.
> >
> > As our remoteprocs are essentially always-on I would prefer that they
> > start "automatically" and not through use of the sysfs interface.
> >
> > But we're at the point where this is a real problem on 410, 820 and
> > 845,
> > so we have to come up with some way to tie these pieces together. If
> > your patch suits that solution I will happily take it.
> >
> > Regards,
> > Bjorn
>
> After experimenting with in kernel solutions for
> three revisions and observing problems on graceful
> shutdown usecase,

What exactly were the problems again? e.g., what were the deficiencies
with having the remoteproc device listen for the REMOTEFS_QMI_SVC_ID
service again? Sorry, but I sort of dropped off on reviewing that
stuff, and now I see this. I'd mildly prefer something that is
actually automatic, but if I'm missing some aspects, I'd like to hear
that. (And, I'd like to see them explained in the commit message, if
this is ever to be merged.)

> switching to controlling the
> remoteproc mss through rmtfs seems to solve all
> the known issues.

How so? It explicitly does NOT help at all if RMTFS crashes.
Because...who's going to stop the modem in that case? (It works if you
automatically respawn a new RMTFS daemon, to toggle the modem. But
that's kind of cheating, and you can do that anyway, even without this
patch.) On the contrary, your patch *would* resolve that, since the
modem would notice when the RMTFS server goes away, and it would stop
itself.

> https://patchwork.kernel.org/patch/10662395/
>
> we should probably get this merged in, now that
> we are planning to start/stop mss through
> rmtfs.

Sorry, who's planning to stop mss through rmtfs? Did I miss something?

Brian
