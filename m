Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DB1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E89C204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqyzkMxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E89C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937793AbeFSOXK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:23:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45919 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937442AbeFSOXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:23:09 -0400
Received: by mail-lf0-f65.google.com with SMTP id a13-v6so10347973lfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zc3RMfH5zzJ2srkeaz/HSjQtUFMFf2I4LvTtVRyzEYk=;
        b=CqyzkMxWdwAs1BIgH8VQ9A6ekU0fY/ixDK7NpQI9p5PR0g0MAZvjom+1wyyO9aeXs4
         MKSbc2R97Gopk4OUsiAm0NEBRIek+34K6rMNqekRKlDTPbq6ZIs8zdV4Vi3tB/4OZIQX
         ikCKKfAJLXJuj3kM0lBRDlvAKPRYKtcLtM2PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zc3RMfH5zzJ2srkeaz/HSjQtUFMFf2I4LvTtVRyzEYk=;
        b=TfxDkjEc+IyUBmThMgVXUGFhpd/jH5mmqMCR9imXUpPSrH2NeMI/476jGxtz50IbN1
         Moz6A8vlWjTN2TspLUrUO5gTCwxpAdVES3+gJeoidBGI2l1KVAuFYFjnlISjorpjK8zM
         bzpv4Ksw0KQwNJ0o726DRtJwUReqq8BQgS03VlMTQ+PvR9x5w6BlqjIh23XIZOqk+da+
         iLPYX31BJdCDwSjAJ5HZoRgzegxIQeznpViHRdlf1tShNf4CXTnwPG26AUBOVVThnzmN
         CoUCaptamusd7r+wRM+qFS74YetcA0cFPUy7feoz50h0iULAaaoJXtPl6duC+zLQpRBl
         jpEg==
X-Gm-Message-State: APt69E32Zcu2VyM6pqGRx2WLgHoAjw2ctezczKpEtSWS8yyf8P04wUEB
        H7ZcLNe1zA8ZD8SQLdzmdEg0CQ==
X-Google-Smtp-Source: ADUXVKJWkT6cxBfHrLXojkZ0fpxyJ2gYvQMfPI2w8By203vFpTYn9Tyfeb5qGnSAS2F2VRQ5Ke6lww==
X-Received: by 2002:a19:5459:: with SMTP id i86-v6mr10149565lfb.34.1529418187817;
        Tue, 19 Jun 2018 07:23:07 -0700 (PDT)
Received: from jax.urgonet (h-84-45.A175.priv.bahnhof.se. [79.136.84.45])
        by smtp.gmail.com with ESMTPSA id w4-v6sm3198966ljj.58.2018.06.19.07.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 07:23:07 -0700 (PDT)
Date:   Tue, 19 Jun 2018 16:23:05 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Joakim Bech <joakim.bech@linaro.org>,
        Volodymyr Babchuk <vlad.babchuk@gmail.com>,
        tiger-yu99 <tigeryu99@hotmail.com>,
        David Wang <david.wang@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tee: replace getnstimeofday64() with
 ktime_get_real_ts64()
Message-ID: <20180619142304.GA12933@jax.urgonet>
References: <20180618142511.3598193-1-arnd@arndb.de>
 <20180619133741.GA9537@jax.urgonet>
 <CAK8P3a2Hydhi1Hu3_Dm-arMGOT-Xz1yShwwcRKav44WjGmG4wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Hydhi1Hu3_Dm-arMGOT-Xz1yShwwcRKav44WjGmG4wQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 04:05:38PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 19, 2018 at 3:37 PM, Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> > On Mon, Jun 18, 2018 at 04:24:56PM +0200, Arnd Bergmann wrote:
> >> The two do the same thing, but we want to have a consistent
> >> naming in the kernel.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  drivers/tee/optee/rpc.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> >> index 41aea12e2bcc..b45c73dd37a5 100644
> >> --- a/drivers/tee/optee/rpc.c
> >> +++ b/drivers/tee/optee/rpc.c
> >> @@ -48,7 +48,7 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
> >>                       OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT)
> >>               goto bad;
> >>
> >> -     getnstimeofday64(&ts);
> >> +     ktime_get_real_ts64(&ts);
> >>       arg->params[0].u.value.a = ts.tv_sec;
> >>       arg->params[0].u.value.b = ts.tv_nsec;
> >>
> >> --
> >> 2.9.0
> >>
> >
> > Looks good.
> >
> > Acked-by: Jens Wiklander <jens.wiklander@linaro.org>
> 
> Thanks for the review. Can you pick it up in your tree?

OK, I'll pick it up.

Thanks,
Jens
