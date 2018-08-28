Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428E7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E0A2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="coaXQsOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E0A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeH2AlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:41:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45189 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeH2AlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:41:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so1211244pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zOIZ7ppnr6nWBNnIut0S60+TEnm109YQUMOXQUkwA+M=;
        b=coaXQsOGdjH4Ra3jLgKqImHMJ0Ee+7wC1U7qb7+geapevGf31C0th3sWCF3efBd2TV
         +61hBM67MVnDAwhEQV/hJFgzFJhza1Gv1IVaop814/XfHBM/FVg7RAuiX7OGD3vEtqgN
         y20EtRPXzT2navo29eaZgBM48b/TS9svoJL+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zOIZ7ppnr6nWBNnIut0S60+TEnm109YQUMOXQUkwA+M=;
        b=gIqnSuJVjFsBteXZgTjTOD6oqULriuDXR/1boAKSSs+f8zZXGZvx886SDZAjNwRN0e
         1knXxCEnkcc1qGNldoe+vVfgCCfQjglRGqjInKZQr4S7jNLTSYeOvP2aqmBGHJhuDvG2
         YvEn0jqe7LFNlcA2LtzrpHjkeyn3SpBTtMfqJkh5vrHAWEsEYLMS43PdQLpRg4SBLZQ1
         f/I/Hx6R1r/46cIXNtYmLbOK51jqQ3IKKhy2leILn/Iv2R7HYebAlC763QRwMfmRfAAQ
         x32jE+pI/ddA+sufk3o0DR0CBx+cGlWOCbeEzNbLvD0nkLk/yKsnOz1FwB9h7WXezxHE
         JAvg==
X-Gm-Message-State: APzg51AUJgJi3TSaOzWuZ0IEEOA0OIUjhykZIxzPs7Qp/VvN3UqRlp31
        qutH5l4kedueXHfGHXyZkzDwbhoMt8Y=
X-Google-Smtp-Source: ANB0VdakbQ7sRjk7kzLxx8VV9qYuXb/M5QQQaYTCBlNoyuUDijp49mAmzblM9/G5fjG+0NvXMAyWqQ==
X-Received: by 2002:a62:b4f:: with SMTP id t76-v6mr2997851pfi.36.1535489271903;
        Tue, 28 Aug 2018 13:47:51 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z11-v6sm7084813pfi.4.2018.08.28.13.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 13:47:51 -0700 (PDT)
Date:   Tue, 28 Aug 2018 13:47:49 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180828204749.GH2523@minitux>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com>
 <20180824101145.GA1510@amd>
 <9bb7ac19-36a6-d11a-6d46-fc65c2026201@gmail.com>
 <20180824201227.GB17146@amd>
 <f5046e2d-9f15-4b7e-083e-e97f7ca0693c@gmail.com>
 <CAMz4kuLubD6v1+zmjuKtBL4geBk4ofBdkMy+v8x0K5g_L0otqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4kuLubD6v1+zmjuKtBL4geBk4ofBdkMy+v8x0K5g_L0otqQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 25 Aug 00:51 PDT 2018, Baolin Wang wrote:

> On 25 August 2018 at 04:44, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> > On 08/24/2018 10:12 PM, Pavel Machek wrote:
> >> On Fri 2018-08-24 21:49:50, Jacek Anaszewski wrote:
> >>> Hi Pavel,
> >>>
> >>> On 08/24/2018 12:11 PM, Pavel Machek wrote:
[..]
> >>> +    if (led_cdev->pattern_set) {
> >>> +            return led_cdev->pattern_set(led_cdev, data->patterns,
> >>> +                                         data->npatterns, data->repeat);
> >>> +    }
> >>
> >> Yeah, that sounds wrong. (Sorry I did not pay enough attention).
> >>
> >> It pattern_set() returns special error code, it should just continue
> >> and use software pattern fallback.
> >
> > And now we can get back to the issue I was concerned about in the
> > email you replied to, i.e. what series of [brightness delta_t] tuples
> > should be written to the pattern file to enable hardware breathing
> > engine.
> 
> OK. So now we've made a consensus to use the software pattern fallback
> if failed to set hardware pattern. How about introduce one interface
> to convert hardware patterns to software patterns if necessary?
> 

I do not agree that a silent fallback mechanism is the way to go here.
There is a enormous difference in power consumption between letting a
dedicated piece of hardware drive a pulse on a LED or using a general
purpose ARM core running at hundreds of MHz.


Note that the most common use case for the driver I'm trying to upstream
is to pulse the LED when you have a notification pending on your Android
device, in which case you want all the CPUs are completely powered down.

Regards,
Bjorn
