Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4A8B3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01083208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="n7qPIQYf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KUYwuNCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01083208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964823AbeFMVJt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:09:49 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38983 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936004AbeFMVJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:09:18 -0400
Received: by mail-ua0-f195.google.com with SMTP id n4-v6so2696223uad.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UI2DsCAFjHALGW9Tj8zBs2VmiSnfQ2KTFzKAeeNs8fc=;
        b=n7qPIQYf5+b2v8xUstKaumo4y3eiHcPXP0DjyZkQblCJMmYO/1cg1336V8clxneCF6
         qb2daxS4UYDdjlOwch30N29ucr/gW9dm+x4wUtmFSGymcBMwOObSz5xZeqAeKvVZkJZ1
         Z9ZJXvBcVpJv1ihQGi3WdFdRAstLSECe36e3eh8W742OGN5FdbEn8CYhRuX58KRJB4aA
         05BURLWEXu1ZTyQ4OdnsN8sfqqfBLf8SaIEgqCAppvAvoXyakZ+Ih/kVCizsa5HLoBLM
         3ayQjdp5RVQMgTLWBUiuLSghjrOs/7ovRnNXEDmWo90g6/A/ToELlaZMYMNYyNkMs3O2
         8tpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UI2DsCAFjHALGW9Tj8zBs2VmiSnfQ2KTFzKAeeNs8fc=;
        b=KUYwuNCjorzL0rFJ4OrIWQxM2sv+o5MbHN5BOBDPp1I6r2KKrdRYERmAH0+qtLtrWc
         xRH9QT6e9+rmCi/Nqcs/BnvB4+Ch3b8zxaVWPTJ7m99DaVVVPGcaOYRNdQien2GgWGzD
         oLXkzdAqXcRsRh3gqEcWiMfqvFANIwowJ/uZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UI2DsCAFjHALGW9Tj8zBs2VmiSnfQ2KTFzKAeeNs8fc=;
        b=m0GbiaDuLOMgECbgqKJqFQcVD9+NGBCGUKrJH2o6vCmxLja4oR6Hc/cLTIuJqgiqZc
         9sYIkSJbl/MZg4gmkPKOGCGXi2RPmYSc1/F4MOPQIhPho7vKE1OubgVSIsQuyx+2zUea
         c5ks9PcvoLe4kW/HwX18rCReiHe/UZUxvWxsSlPM8wyzAQAHikkYuf3fOqBF8faC7xnj
         8KNyzw09CejvWM9KKGmOVVBhNo3urTNfsXLAeDMy9V8kJQlbjMoErqU3Qa5lVsvsDyjE
         M+/WthsyFuXeWAZ5CxzPkn/gZSrnonuFQbsf37U5jP3cjc94SFFmCsEHi9pCA0NfS9PA
         eupw==
X-Gm-Message-State: APt69E1nHooCB/z9LmprphAtcd1BUbUxVwJSR4qXsD1WAr+6YlsA/tP9
        Up/13SUwg7TZBPEEa/ZKXKOhUn72OfPmRqdUvD8HLQ==
X-Google-Smtp-Source: ADUXVKJK7SyBXQEM7j5aknD4zcZVl9z4rcJV8E3kvTMOSlBueHzPLmeijsp7R8awL5emIplAc3voGeMnowXLRsn3I50=
X-Received: by 2002:ab0:17d2:: with SMTP id p18-v6mr4198307uaf.121.1528924157661;
 Wed, 13 Jun 2018 14:09:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 14:09:16
 -0700 (PDT)
In-Reply-To: <1528737949-17495-5-git-send-email-rplsssn@codeaurora.org>
References: <1528737949-17495-1-git-send-email-rplsssn@codeaurora.org> <1528737949-17495-5-git-send-email-rplsssn@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Jun 2018 14:09:16 -0700
X-Google-Sender-Auth: G8itjI7I13WpGYOmRRG6-h2Ldoc
Message-ID: <CAD=FV=ULcTE14gNYFA4hWpViDd6srXztvjbVTO7vBOKKMuEdSA@mail.gmail.com>
Subject: Re: [PATCH v10 04/10] drivers: qcom: rpmh: add RPMH helper functions
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 11, 2018 at 10:25 AM, Raju P L S S S N
<rplsssn@codeaurora.org> wrote:
> +void rpmh_tx_done(const struct tcs_request *msg, int r)
> +{
> +       struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
> +                                                   msg);
> +       struct completion *compl = rpm_msg->completion;
> +
> +       rpm_msg->err = r;
> +
> +       if (r)
> +               dev_err(rpm_msg->dev, "RPMH TX fail in msg addr=%#x, err=%d\n",
> +                       rpm_msg->msg.cmds[0].addr, r);
> +
> +       /* Signal the blocking thread we are done */
> +       if (compl)
> +               complete(compl);
> +}
> +EXPORT_SYMBOL(rpmh_tx_done);

You're back to too many EXPORT_SYMBOL's again.  Just use this rule of thumb:

* If it's static, no EXPORT_SYMBOL.

* If the prototype is in "rpmh-internal.h", no EXPORT_SYMBOL.

* If the prototype is in "rpmh.h", then yes EXPORT_SYMBOL.

In the case of rpmh_tx_done: the protype is in rpmh-internal.h


To fix, squash in crosreview.com/1099841


-Doug
