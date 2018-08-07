Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6DFC4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1855C21A5D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8SQgH2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1855C21A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbeHGDlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:41:49 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:40845 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbeHGDlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:41:49 -0400
Received: by mail-yb0-f195.google.com with SMTP id n10-v6so1750779ybd.7;
        Mon, 06 Aug 2018 18:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ghjjBp1holAGWxiGByMcWt7tNQ6jPhx4t90CCe8oI68=;
        b=o8SQgH2WmKEhwF0Z7c7P5v/KqMzzvvZhp9uYZgOdsH7QYnWp8kte53ndk5COVSjCUm
         W356VdG2+D+ufpIQEz9e5G0erkgPZC3xskhoacjyqkP1CbL/Wmjl1nVBFFNh0jmbmySa
         Keh71kamAdrdav2VsjY4F7GMYVHqWdJaHccRfCFuPZxaOZUng/MTPDLkB7mp54llDTxp
         OHOz0Ei72OOSIoUmPGuDexTcM6bVuAEoICMfO6fX9EkCTE684QE7l4B6mCqXhyBfnt7k
         +vRBQQMA1XfnecpNv1hU1dbAPV1iHplCzUQt7uLjpVvIpI1sokbjyKmtT3jMYWiI4NJ0
         d3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ghjjBp1holAGWxiGByMcWt7tNQ6jPhx4t90CCe8oI68=;
        b=uEg04uAHJMa05hDwubmRHpURzBc587+hStl4Bm3VhUh/mK5W7ZDFoe+Va6lzcHdfWG
         nV4b0cbiI5OY8b3O8sK1YXR38FO+2lJrET3bHueGy1W15CdeapgR7sAnGFrJZ49oR5hH
         LnAUetweksRcuigzG1eWEsXsfCi3EfoYBAYijKnLLuMPcR4r++PU/YWWHxjchfGJR2/o
         mazWLiVumJkQUnvY32nHVV9LmraHzoHDyRsPhxk8sKZtb5l1ho9pumcndS+x6huMSH9d
         qjPenoUFamcBerbabSY+J1OS8LdMvVXWu4UOwO3/gw1quXrUOwhNppWcXDEg4+1n3iBo
         Mx8w==
X-Gm-Message-State: AOUpUlHSnivUuX7a2miPXiWYgk/olqtzjC6Bs2RLBZ8Gam9AHNipDTp6
        rYqhWsl6PcgFd9Y5W4BMfJIcdbgcP4p9q6G7Pow=
X-Google-Smtp-Source: AAOMgpfF3+rWUqM6y/6n/yVJYJGo+r3W48m0nkyih7o3WxXkZJsMmDtndZlXGmP/P0jki5arWJlPg9SWWNnribtf/jg=
X-Received: by 2002:a25:8385:: with SMTP id t5-v6mr8783642ybk.71.1533605399540;
 Mon, 06 Aug 2018 18:29:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:37d1:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 18:29:59 -0700 (PDT)
In-Reply-To: <CAHStOZ5VaOiOQhi7vG0Q9R7gF+LHvZim1qsEUJanZkFoXqgwDA@mail.gmail.com>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-4-maxi.jourdan@wanadoo.fr> <CALecT5hgk+Wuh4-UWY29NNoEz-47Fx3pSjve8raCd3hRMzXE5w@mail.gmail.com>
 <CAHStOZ5VaOiOQhi7vG0Q9R7gF+LHvZim1qsEUJanZkFoXqgwDA@mail.gmail.com>
From:   Yixun Lan <yixun.lan@gmail.com>
Date:   Tue, 7 Aug 2018 09:29:59 +0800
Message-ID: <CALecT5jp2Z9A8=ZciXQW5AD29TQY_6A-GW92swRiYx-sCV-LhA@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM64: dts: meson-gx: add dmcbus and canvas nodes.
To:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Cc:     devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Maxime:

On Sun, Aug 5, 2018 at 4:02 AM, Maxime Jourdan <maxi.jourdan@wanadoo.fr> wrote:
>>> +                       sysctrl_DMC: system-controller@0 {
>>> +                               compatible = "amlogic,meson-gx-dmc-sysctrl", "syscon", "simple-mfd";
>>
>> we'd like to drop 'meson-' prefix, so better using "amlogic,gx-dmc-sysctrl",
>> please take a look at the discussion here [1]
>>
>> [1] https://lkml.kernel.org/r/7hk1prmg4w.fsf@baylibre.com
>>
>
> On that subject, should I remove the meson keyword from dts only, or
> from everything ?
>
remove the 'meson-' from dts is enough..

> e.g use amlogic_canvas_* symbols instead of meson_canvas_*, name the
> source file "amlogic-canvas.c", etc. ?
>
Actually, I'd suggest to keep using meson_canvas_* in the code for the
consistency,
unless Kevin or Jerome/Neil has something to say?

Yixun
