Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423DDC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E802321A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eZ3eLUmM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZIqoU0U7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E802321A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbeHGBHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:07:13 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:46937 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733047AbeHGBHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:07:13 -0400
Received: by mail-ua0-f193.google.com with SMTP id u11-v6so14024315uan.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 15:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OGXmGGJ3oL48yUXxik6xnUQso7zOpUgzw1FOdJMIusY=;
        b=eZ3eLUmMf1S/QUKsdgHTx4lsBPdCtz5OhIuxLh4AWIs9fFncFUFjmVJn6E+T0k0D4Z
         oJlbVhJ3OXQnrMz8Zql3UCPtxTXkoYxvDQFlUwwKWzqL57/lGBwCvMETA/yeDE6svG1C
         nWuNLrH1tms39iAeip5yq0QilAUch6ztHPmd+1tBZE0OPXYI+znHIJ1R2PXtjMwL+scl
         1qZHfvaEK+t+7475Vtk6dFniCk+vi9soSGpOl9v9hkT2GcEOaoQmuPhE3FMvLdaX1u3d
         LVgi0dYIUbtc3qFJd1aJKl3YErWlGkZysCQuq2yx84m3Utmfqd1sLLgQUW4VqYlnC5w/
         1rqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OGXmGGJ3oL48yUXxik6xnUQso7zOpUgzw1FOdJMIusY=;
        b=ZIqoU0U7hIh/+buJLuB12s3GDGY0KkEFufwy7u36GS7Qwz6AE1AKetA7OHfb1OtgEe
         Q7cX2ghL2dA27yLcpRKMcYQN+glxxxvhso2kXsv+Jh/OacgFvbjmyXJo0okMW3br1iPx
         pXIKnJOaM0L8wq8ZRTGegc68Egculvz8e4iLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=OGXmGGJ3oL48yUXxik6xnUQso7zOpUgzw1FOdJMIusY=;
        b=nNEHspFdthQcG5tbrOZ/Y9yRf6CSboOjRwVTHL7i3JY8SI+zi8TJkxz0vVClqrT2Ih
         TyNDyTRa+9lZTxWoV1zCE91z/xlSTCWECFoMYtkUJFkmmswda17DStzw61ySqrQ58bFD
         IZqpgxQRIWao3Twk1DyeiViDS9HsMKRU1efp/z0qhJlEtgzOxjywaFtnZfIFKYHxDq3A
         9nKUrZNfzAe9s/6mE3Ngyzw2YfzwyA4zl21f5diNZgqO7N6myo+ZD2zsSDXWvxdWdtZA
         vFmYu7sOARa9HVZ2FUWtSqizTLiKirqsZd3bcjI3+8LN7RvWKe0ouWQDpmILT/4FxvuC
         PbEg==
X-Gm-Message-State: AOUpUlH0OJZ8bIWM9YTUUqxfW7+L0rox8mWrTHlB9Tlq+yzMPAevZI7R
        JFB8e5o5ZK6xVA81vm5wq7+ep09W/N6QlYoYHOKkzw==
X-Google-Smtp-Source: AAOMgpfN4Vl2z3xN6Zbb/oM9HYzr/dYWWm1rRcUafhxjwgnFw/lUvNN3hGmyR4SOVI5jz55luew11Z/ynrs9LXHki7g=
X-Received: by 2002:a1f:3653:: with SMTP id d80-v6mr10482606vka.79.1533596154553;
 Mon, 06 Aug 2018 15:55:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 15:55:53 -0700 (PDT)
In-Reply-To: <20180726183922.GA4402@hector.mosconeconnections.com>
References: <cover.1531531808.git.collinsd@codeaurora.org> <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
 <20180724145755.GF13268@sirena.org.uk> <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
 <20180724152514.GJ13268@sirena.org.uk> <CAD=FV=WHJcAoR7Y_uhi7_GbVzy6K8FnovVFVRz8js0REONox=w@mail.gmail.com>
 <20180724165942.GP13268@sirena.org.uk> <20180726183922.GA4402@hector.mosconeconnections.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Aug 2018 15:55:53 -0700
X-Google-Sender-Auth: UvszxfidTzAPk48WUdSdW3b7MwQ
Message-ID: <CAD=FV=VJN4vj9eU7wzPV8=WC_+MgRPYx1smF+FUmfDiP3uuTqw@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
To:     Mark Brown <broonie@kernel.org>, Andy Gross <andy.gross@linaro.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On Thu, Jul 26, 2018 at 11:39 AM, Andy Gross <andy.gross@linaro.org> wrote:
> + olof
>
> On Tue, Jul 24, 2018 at 05:59:42PM +0100, Mark Brown wrote:
>> On Tue, Jul 24, 2018 at 08:43:46AM -0700, Doug Anderson wrote:
>> > On Tue, Jul 24, 2018 at 8:25 AM, Mark Brown <broonie@kernel.org> wrote:
>>
>> > > There was also some other thing called command DB as well which was a
>> > > separate series.  Ideally there'd be a branch I could pull as there's a
>> > > build dependency on rpmh so I can't apply until the code has landed in
>> > > my tree, don't know what command DB is exactly.
>>
>> > Yup.  That one landed in May and is already in mainline Linux.  Refer
>> > to commit 312416d9171a ("drivers: qcom: add command DB driver").
>>
>> That's good at least - the cover letter said it was still under review,
>> guess it just hadn't been updated.
>>
>> > Adding Andy to this thread (I guess he wasn't on it?).  Hopefully he
>> > can provide you with the branch.
>>
> Mark,
>
> The arm-soc guys merged the Qualcomm pull requests.  So you can just use my
> qcom-drivers-for-4.19 tag.  That won't change at this point.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
> qcom-drivers-for-4.19

Did Andy's idea of using the above tag work for you?  It appears that
there are a few patches you don't need there, but it shouldn't hurt to
pick them up too I think?  Here's what I see:

---

$ git log --oneline linux/master..qcom-drivers-for-4.19
78ee559d7fc6 (tag: qcom-drivers-for-4.19) soc: qcom: rmtfs-mem: fix
memleak in probe error paths
4da3b0452bc6 soc: qcom: llc-slice: Add missing MODULE_LICENSE()
6c805adf17d4 drivers: qcom: rpmh: fix unwanted error check for get_tcs_of_type()
efa1c257b3fc drivers: qcom: rpmh-rsc: fix the loop index check in
get_req_from_tcs
a0b1561f8461 firmware: qcom: scm: add a dummy qcom_scm_assign_mem()
fdd102b52cfd drivers: qcom: rpmh-rsc: Check cmd_db_ready() to help children
2de4b8d33eab drivers: qcom: rpmh-rsc: allow active requests from wake TCS
c8790cb6da58 drivers: qcom: rpmh: add support for batch RPMH request
564b5e24ccd4 drivers: qcom: rpmh: allow requests to be sent asynchronously
600513dfeef3 drivers: qcom: rpmh: cache sleep/wake state requests
9a3afcfbc0cc drivers: qcom: rpmh-rsc: allow invalidation of sleep/wake TCS
fa460e453a83 drivers: qcom: rpmh-rsc: write sleep/wake requests to TCS
c1038456b02b drivers: qcom: rpmh: add RPMH helper functions
fc087fe5a45e drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
2e4690a09fca dt-bindings: introduce RPMH RSC bindings for Qualcomm SoCs
658628e7ef78 drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs
a3134fb09e0b drivers: soc: Add LLCC driver
7e5700ae64f6 dt-bindings: Documentation for qcom, llcc
0b65c59e3a54 soc: qcom: smem: Correct check for global partition

---

It seems like it's too late to land RPMh-regulator for 4.19, so I
guess we'll have to aim for 4.20.  I'm not sure if that means you're
going to want to wait until 4.20-rc1 comes out to use as a base before
thinking about landing RPMh-regulator?  If so then I guess we've got
~3 weeks before something could land and we could start landing device
tree bits using RPMh-regulator.  If that's the plan then we'll
probably just start landing things in the Chrome OS tree now and suck
up the extra work of trying to resolve differences later...

Thanks!

-Doug
